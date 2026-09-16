[CmdletBinding()]
param(
    [Parameter(Position = 0)]
    [string]$ProjectPath = (Get-Location).Path
)

$ErrorActionPreference = 'Stop'

$ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectRoot = (Resolve-Path -LiteralPath $ProjectPath).Path

$CanonicalSkills = Join-Path $ScriptRoot 'skills'
$LegacySkills = Join-Path $ScriptRoot '.agents/skills'

if (Test-Path -LiteralPath $CanonicalSkills -PathType Container) {
    $SourceSkills = $CanonicalSkills
} elseif (Test-Path -LiteralPath $LegacySkills -PathType Container) {
    $SourceSkills = $LegacySkills
} else {
    throw "Could not find the Lifecycle skills directory."
}

$TargetSkills = Join-Path $ProjectRoot '.agents/skills'
$AgentsFile = Join-Path $ProjectRoot 'AGENTS.md'
$BlockFile = Join-Path $ScriptRoot 'templates/AGENTS.lifecycle.md'

if (-not (Test-Path -LiteralPath $BlockFile -PathType Leaf)) {
    throw "Missing managed AGENTS.md block: $BlockFile"
}

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
Write-Output "Solo developers may add docs/lifecycle/ to the project's .gitignore"
