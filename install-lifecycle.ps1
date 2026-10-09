[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$ProjectPath,

    [string]$ProjectsFile
)

$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$DefaultProjectsFile = Join-Path $ScriptRoot '.lifecycle-projects'

if ($ProjectsFile) {
    if (-not [System.IO.Path]::IsPathRooted($ProjectsFile)) {
        $ProjectsFile = Join-Path (Get-Location).Path $ProjectsFile
    }
    if (-not (Test-Path -LiteralPath $ProjectsFile -PathType Leaf)) {
        throw "Projects file does not exist: $ProjectsFile"
    }
    $ProjectsFile = (Resolve-Path -LiteralPath $ProjectsFile).Path
} elseif (-not $ProjectPath) {
    $ProjectsFile = $DefaultProjectsFile
    if (-not (Test-Path -LiteralPath $ProjectsFile -PathType Leaf)) {
        throw "Projects file does not exist: $ProjectsFile. Provide a project path or create .lifecycle-projects at the installer root."
    }
}

if ($ProjectsFile -and $ProjectPath) {
    throw 'Choose one project path or one projects-file option.'
}

if ($ProjectsFile) {
    $ProjectsFileDirectory = Split-Path -Parent $ProjectsFile
    $ProjectPaths = @(
        Get-Content -LiteralPath $ProjectsFile |
            ForEach-Object {
                $ProjectEntry = $_.Trim()
                if ($ProjectEntry -and -not $ProjectEntry.StartsWith('#')) {
                    if (-not [System.IO.Path]::IsPathRooted($ProjectEntry)) {
                        $ProjectEntry = Join-Path $ProjectsFileDirectory $ProjectEntry
                    }
                    $ProjectEntry
                }
            }
    )

    if ($ProjectPaths.Count -eq 0) {
        throw "Projects file contains no project paths: $ProjectsFile"
    }
} else {
    $ProjectPaths = @($ProjectPath)
}

$ExistingProjectPaths = @()
foreach ($Path in $ProjectPaths) {
    if (-not (Test-Path -LiteralPath $Path -PathType Container)) {
        Write-Warning "Skipping missing project directory: $Path"
        continue
    }
    $ExistingProjectPaths += $Path
}

if ($ExistingProjectPaths.Count -eq 0) {
    throw 'No existing project directories were found in the project list.'
}

$ProjectPaths = $ExistingProjectPaths

$CanonicalSkills = Join-Path $ScriptRoot 'skills'
$CanonicalRules = Join-Path $ScriptRoot 'guidelines'
$LegacySkills = Join-Path $ScriptRoot '.agents/skills'
$LegacyRules = Join-Path $ScriptRoot '.agents/guidelines'

if (Test-Path -LiteralPath $CanonicalSkills -PathType Container) {
    $SourceSkills = $CanonicalSkills
    $SourceRules = $CanonicalRules
} elseif (Test-Path -LiteralPath $LegacySkills -PathType Container) {
    $SourceSkills = $LegacySkills
    $SourceRules = $LegacyRules
} else {
    throw 'Could not find the Lifecycle skills directory.'
}

$BlockFile = Join-Path $ScriptRoot 'templates/AGENTS.lifecycle.md'

if (-not (Test-Path -LiteralPath $BlockFile -PathType Leaf)) {
    throw "Missing managed AGENTS.md block: $BlockFile"
}

# Validate managed markers before changing any target project.
function Test-AgentsMarkers {
    param([string]$AgentsFile)
    if (-not (Test-Path -LiteralPath $AgentsFile -PathType Leaf)) { return }
    $State = 0
    $Seen = $false
    foreach ($Line in [System.IO.File]::ReadAllLines($AgentsFile)) {
        if ($Line.Contains('<!-- lifecycle:start -->')) {
            if ($State -ne 0 -or $Seen) { throw "Malformed Lifecycle markers: $AgentsFile" }
            $State = 1
            $Seen = $true
        } elseif ($Line.Contains('<!-- lifecycle:end -->')) {
            if ($State -ne 1) { throw "Malformed Lifecycle markers: $AgentsFile" }
            $State = 2
        }
    }
    if ($State -eq 1) { throw "Incomplete Lifecycle markers: $AgentsFile" }
}

function Get-GuidelineHash {
    param([string]$Text)
    $Hasher = [System.Security.Cryptography.SHA256]::Create()
    try {
        return [BitConverter]::ToString($Hasher.ComputeHash([Text.Encoding]::UTF8.GetBytes($Text))).Replace('-', '').ToLowerInvariant()
    } finally {
        $Hasher.Dispose()
    }
}

function Update-Guideline {
    param([string]$SourceFile, [string]$TargetFile)
    if (Test-Path -LiteralPath $TargetFile) {
        $Item = Get-Item -LiteralPath $TargetFile -Force
        if ($Item.PSIsContainer -or ($Item.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
            Write-Warning "Preserved guideline for review (not a regular file): $TargetFile"
            return
        }
    }
    $Encoding = [Text.UTF8Encoding]::new($false, $true)
    $SourceBody = $Encoding.GetString([IO.File]::ReadAllBytes($SourceFile)).Replace("`r`n", "`n")
    if (-not $SourceBody.EndsWith("`n")) { $SourceBody += "`n" }
    $SourceHash = Get-GuidelineHash -Text $SourceBody
    $Content = ''
    if (Test-Path -LiteralPath $TargetFile -PathType Leaf) {
        try {
            $Content = $Encoding.GetString([IO.File]::ReadAllBytes($TargetFile))
        } catch {
            Write-Warning "Preserved guideline for review (could not read UTF-8 text): $TargetFile"
            return
        }
    }
    $Prefix = ''
    $Suffix = ''
    $Newline = "`n"
    if ($Content.Contains('<!-- lifecycle:guideline:start') -or $Content.Contains('<!-- lifecycle:guideline:end')) {
        $Match = [regex]::Match($Content, '(?s)^(.*)<!-- lifecycle:guideline:start sha256=([0-9a-f]{64}) -->(.*)<!-- lifecycle:guideline:end -->(.*)$')
        if ([regex]::Matches($Content, '<!-- lifecycle:guideline:start').Count -ne 1 -or
            [regex]::Matches($Content, '<!-- lifecycle:guideline:end').Count -ne 1 -or -not $Match.Success) {
            Write-Warning "Preserved guideline for review (malformed section markers): $TargetFile"
            return
        }
        $Prefix = $Match.Groups[1].Value
        $InstalledHash = $Match.Groups[2].Value
        $Body = $Match.Groups[3].Value
        $Suffix = $Match.Groups[4].Value
        if ($Body.StartsWith("`r`n")) { $Newline = "`r`n" }
        if (($Prefix.Length -gt 0 -and -not $Prefix.EndsWith("`n")) -or
            -not $Body.StartsWith($Newline) -or -not $Body.EndsWith("`n") -or
            ($Suffix.Length -gt 0 -and -not $Suffix.StartsWith("`n") -and -not $Suffix.StartsWith("`r`n"))) {
            Write-Warning "Preserved guideline for review (malformed section markers): $TargetFile"
            return
        }
        $Body = $Body.Substring($Newline.Length).Replace("`r`n", "`n")
        if ((Get-GuidelineHash -Text $Body) -ne $InstalledHash) {
            Write-Warning "Preserved guideline for review (manual edits inside Lifecycle section): $TargetFile"
            return
        }
        if ($Body -ceq $SourceBody) { return }
    } else {
        if ($Content.Contains("`r`n")) { $Newline = "`r`n" }
        $Prefix = $Content
        if ($Prefix.Length -gt 0) {
            if (-not $Prefix.EndsWith("`n")) { $Prefix += $Newline }
            $Prefix += $Newline
        }
        $Suffix = $Newline
    }
    $Block = "<!-- lifecycle:guideline:start sha256=$SourceHash -->`n${SourceBody}<!-- lifecycle:guideline:end -->"
    $Block = $Block.Replace("`n", $Newline)
    $TemporaryFile = Join-Path (Split-Path -Parent $TargetFile) ([IO.Path]::GetRandomFileName())
    try {
        [IO.File]::WriteAllText($TemporaryFile, $Prefix + $Block + $Suffix, [Text.UTF8Encoding]::new($false))
        Move-Item -LiteralPath $TemporaryFile -Destination $TargetFile -Force
    } finally {
        if (Test-Path -LiteralPath $TemporaryFile) { Remove-Item -LiteralPath $TemporaryFile -Force }
    }
}

function Install-Project {
    param([string]$Path)

    $ProjectRoot = (Resolve-Path -LiteralPath $Path).Path
    $TargetSkills = Join-Path $ProjectRoot '.agents/skills'
    $TargetRules = Join-Path $ProjectRoot '.agents/guidelines'
    $AgentsFile = Join-Path $ProjectRoot 'AGENTS.md'

    Test-AgentsMarkers -AgentsFile $AgentsFile

    New-Item -ItemType Directory -Force -Path `
        $TargetSkills, `
        $TargetRules, `
        (Join-Path $ProjectRoot 'docs/lifecycle'), `
        (Join-Path $ProjectRoot 'docs/guidelines'), `
        (Join-Path $ProjectRoot 'docs/modules'), `
        (Join-Path $ProjectRoot 'docs/backlog') | Out-Null

    $SameSkillsDirectory = ([System.IO.Path]::GetFullPath($SourceSkills) -eq [System.IO.Path]::GetFullPath($TargetSkills))

    $SkillDirectories = @(Get-ChildItem -LiteralPath $SourceSkills -Directory -Force |
        Where-Object { $_.Name -like 'lifecycle*' -and (Test-Path (Join-Path $_.FullName 'SKILL.md')) }
    )

    if ($SkillDirectories.Count -eq 0) {
        throw "No Lifecycle skills were found in $SourceSkills"
    }

    if (-not $SameSkillsDirectory) {
        # Replace installed Lifecycle skills so removed source files cannot linger.
        Get-ChildItem -LiteralPath $TargetSkills -Directory -Force |
            Where-Object { $_.Name -like 'lifecycle*' -and (Test-Path (Join-Path $_.FullName 'SKILL.md')) } |
            Remove-Item -Recurse -Force
    }

    $Installed = 0

    foreach ($SkillDirectory in $SkillDirectories) {
        if (-not $SameSkillsDirectory) {
            $TargetDirectory = Join-Path $TargetSkills $SkillDirectory.Name
            New-Item -ItemType Directory -Force -Path $TargetDirectory | Out-Null

            Get-ChildItem -LiteralPath $SkillDirectory.FullName -Force |
                Copy-Item -Destination $TargetDirectory -Recurse -Force
        }

        $Installed++
    }

    if (-not $SameSkillsDirectory -and (Test-Path -LiteralPath $SourceRules -PathType Container)) {
        Get-ChildItem -LiteralPath $SourceRules -Filter '*.md' -File -Force | ForEach-Object {
            $TargetFile = Join-Path $TargetRules $_.Name
            Update-Guideline -SourceFile $_.FullName -TargetFile $TargetFile
        }
    }

    $Block = [System.IO.File]::ReadAllText($BlockFile)

    if (-not (Test-Path -LiteralPath $AgentsFile -PathType Leaf)) {
        [System.IO.File]::WriteAllText($AgentsFile, $Block)
    } else {
        $Agents = [System.IO.File]::ReadAllText($AgentsFile)
        $Pattern = '(?s)<!-- lifecycle:start -->.*?<!-- lifecycle:end -->'

        if ([regex]::IsMatch($Agents, $Pattern)) {
            $UpdatedAgents = [regex]::Replace(
                $Agents,
                $Pattern,
                [System.Text.RegularExpressions.MatchEvaluator]{ param($Match) $Block },
                1
            )
        } else {
            $Separator = if ($Agents.EndsWith("`n") -or $Agents.EndsWith("`r")) { '' } else { "`n" }
            $UpdatedAgents = $Agents + $Separator + "`n" + $Block
        }

        [System.IO.File]::WriteAllText($AgentsFile, $UpdatedAgents)
    }

    Write-Output "Installed $Installed Lifecycle skill(s) into $TargetSkills"
    Write-Output "Processed Lifecycle guideline sections in $TargetRules"
    Write-Output 'Ensured docs/lifecycle, docs/guidelines, docs/modules, and docs/backlog exist'
    Write-Output "Updated the managed Lifecycle section in $AgentsFile"
}

foreach ($Path in $ProjectPaths) {
    Test-AgentsMarkers -AgentsFile (Join-Path $Path 'AGENTS.md')
}

foreach ($Path in $ProjectPaths) {
    Install-Project -Path $Path
}

if ($ProjectsFile) {
    Write-Output "Processed $($ProjectPaths.Count) project(s) from $ProjectsFile"
}
