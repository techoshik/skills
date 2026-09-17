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
$LegacySkills = Join-Path $ScriptRoot '.agents/skills'

if (Test-Path -LiteralPath $CanonicalSkills -PathType Container) {
    $SourceSkills = $CanonicalSkills
} elseif (Test-Path -LiteralPath $LegacySkills -PathType Container) {
    $SourceSkills = $LegacySkills
} else {
    throw 'Could not find the Lifecycle skills directory.'
}

$BlockFile = Join-Path $ScriptRoot 'templates/AGENTS.lifecycle.md'

if (-not (Test-Path -LiteralPath $BlockFile -PathType Leaf)) {
    throw "Missing managed AGENTS.md block: $BlockFile"
}

function Install-Project {
    param([string]$Path)

    $ProjectRoot = (Resolve-Path -LiteralPath $Path).Path
    $TargetSkills = Join-Path $ProjectRoot '.agents/skills'
    $AgentsFile = Join-Path $ProjectRoot 'AGENTS.md'

    New-Item -ItemType Directory -Force -Path `
        $TargetSkills, `
        (Join-Path $ProjectRoot 'docs/lifecycle'), `
        (Join-Path $ProjectRoot 'docs/guidelines'), `
        (Join-Path $ProjectRoot 'docs/modules'), `
        (Join-Path $ProjectRoot 'docs/backlog') | Out-Null

    $SameSkillsDirectory = ([System.IO.Path]::GetFullPath($SourceSkills) -eq [System.IO.Path]::GetFullPath($TargetSkills))

    $Installed = 0
    $SkillDirectories = Get-ChildItem -LiteralPath $SourceSkills -Directory -Force |
        Where-Object { $_.Name -like 'lifecycle*' -and (Test-Path (Join-Path $_.FullName 'SKILL.md')) }

    foreach ($SkillDirectory in $SkillDirectories) {
        if (-not $SameSkillsDirectory) {
            $TargetDirectory = Join-Path $TargetSkills $SkillDirectory.Name
            New-Item -ItemType Directory -Force -Path $TargetDirectory | Out-Null

            Get-ChildItem -LiteralPath $SkillDirectory.FullName -Force |
                Copy-Item -Destination $TargetDirectory -Recurse -Force
        }

        $Installed++
    }

    if ($Installed -eq 0) {
        throw "No Lifecycle skills were found in $SourceSkills"
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
    Write-Output 'Ensured docs/lifecycle, docs/guidelines, docs/modules, and docs/backlog exist'
    Write-Output "Updated the managed Lifecycle section in $AgentsFile"
}

foreach ($Path in $ProjectPaths) {
    Install-Project -Path $Path
}

if ($ProjectsFile) {
    Write-Output "Processed $($ProjectPaths.Count) project(s) from $ProjectsFile"
}
