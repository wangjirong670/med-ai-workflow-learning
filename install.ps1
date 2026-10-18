#!/usr/bin/env pwsh
# med-study-knead — generic SKILL.md installer
# Works with any agent that loads a folder named <skill>/SKILL.md.
#
# Local:   .\install.ps1
# Remote:  irm https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/v0.1.0/install.ps1 | iex
#
# Examples:
#   .\install.ps1 -Target "$HOME/.config/myagent/skills"
#   .\install.ps1 -All
#   .\install.ps1 -PrintOnly

[CmdletBinding()]
param(
    [string]$Target,
    [string]$Repo,
    [string]$Source,
    [switch]$All,
    [switch]$PrintOnly
)

$ErrorActionPreference = "Stop"
$SkillName = "med-study-knead"
$RepoUrl = "https://github.com/wangjirong670/med-ai-workflow-learning"
$ZipUrl = "$RepoUrl/archive/refs/tags/v0.1.0.zip"

function Write-Info([string]$msg) { Write-Host "[install] $msg" }
function Write-Ok([string]$msg)   { Write-Host "[install] OK  $msg" -ForegroundColor Green }
function Write-Skip([string]$msg) { Write-Host "[install] --  $msg" -ForegroundColor Yellow }

function Get-HomeDir {
    $d = [Environment]::GetFolderPath("UserProfile")
    if ($d) { return $d }
    return $env:USERPROFILE
}

function Find-LocalRepo {
    if ($Repo -and (Test-Path (Join-Path $Repo "skills/$SkillName/SKILL.md"))) {
        return (Resolve-Path $Repo).Path
    }
    if ($PSScriptRoot -and (Test-Path (Join-Path $PSScriptRoot "skills/$SkillName/SKILL.md"))) {
        return $PSScriptRoot
    }
    $dir = (Get-Location).Path
    for ($i = 0; $i -lt 8 -and $dir; $i++) {
        if (Test-Path (Join-Path $dir "skills/$SkillName/SKILL.md")) { return $dir }
        $parent = Split-Path $dir -Parent
        if ($parent -eq $dir) { break }
        $dir = $parent
    }
    return $null
}

function Get-SkillSource {
    if ($Source) {
        if (-not (Test-Path (Join-Path $Source "SKILL.md"))) {
            throw "Source does not look like a skill folder: $Source"
        }
        return (Resolve-Path $Source).Path
    }
    $repoRoot = Find-LocalRepo
    if ($repoRoot) {
        Write-Info "using local package $repoRoot\skills\$SkillName"
        return (Join-Path $repoRoot "skills/$SkillName")
    }
    Write-Info "no local package; downloading $ZipUrl"
    $tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("med-study-knead-" + [guid]::NewGuid().ToString("n"))
    New-Item -ItemType Directory -Path $tmp | Out-Null
    $zip = Join-Path $tmp "src.zip"
    Invoke-WebRequest -Uri $ZipUrl -OutFile $zip
    Expand-Archive -Path $zip -DestinationPath $tmp -Force
    $found = Get-ChildItem -Path $tmp -Recurse -Filter "SKILL.md" |
        Where-Object { $_.Directory.Name -eq $SkillName } |
        Select-Object -First 1
    if (-not $found) { throw "zip has no skills/$SkillName/SKILL.md" }
    return $found.Directory.FullName
}

# Any agent that stores skills as <root>/<name>/SKILL.md.
# Unknown roots are fine — use -Target. Known names are only probes.
function Get-CandidateRoots {
    $h = Get-HomeDir
    $cwd = (Get-Location).Path
    return @(
        # universal / local package
        (Join-Path $h ".skills"),
        (Join-Path $h ".local/share/agent-skills"),
        (Join-Path $h ".config/agent-skills"),
        # project-local
        (Join-Path $cwd ".mimocode/skills"),
        (Join-Path $cwd ".claude/skills"),
        (Join-Path $cwd ".cursor/skills"),
        (Join-Path $cwd ".agents/skills"),
        (Join-Path $cwd "skills"),
        # user-level agents (only if dir already exists, unless -All)
        (Join-Path $h ".config/mimocode/skills"),
        (Join-Path $h ".claude/skills"),
        (Join-Path $h ".cursor/skills"),
        (Join-Path $h ".codex/skills"),
        (Join-Path $h ".gemini/skills"),
        (Join-Path $h ".agents/skills"),
        (Join-Path $h ".config/continue/skills"),
        (Join-Path $h ".config/skills")
    )
}

function Install-To([string]$destRoot, [string]$src) {
    $dest = Join-Path $destRoot $SkillName
    $srcFull = (Resolve-Path $src).Path.TrimEnd('\', '/')
    $destParent = if (Test-Path $dest) { (Resolve-Path $dest).Path.TrimEnd('\', '/') } else { $dest }
    if ($destParent -eq $srcFull) {
        Write-Skip "skip (same as source): $dest"
        return
    }
    if ($destRoot -eq (Split-Path $srcFull -Parent)) {
        Write-Skip "skip (source tree): $destRoot"
        return
    }
    New-Item -ItemType Directory -Path $destRoot -Force | Out-Null
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    Copy-Item -Recurse -Force $src $dest
    Write-Ok "installed -> $dest"
}

try {
    $src = Get-SkillSource
    Write-Info "skill source: $src"
    Write-Info "format: SKILL.md skill folder (any agent that loads this layout)"

    $targets = [System.Collections.Generic.List[string]]::new()
    if ($Target) {
        $targets.Add($Target)
    } else {
        foreach ($r in Get-CandidateRoots) {
            $exists = Test-Path $r
            $universal = $r -like "*.skills" -or $r -like "*agent-skills*"
            $project = $r -like "*$((Get-Location).Path)*" -or $r -like "*.mimocode*" -or $r -like "*\.claude\skills" -or $r -like "*\.cursor\skills" -or $r -like "*\.agents\skills"
            if ($exists -or $universal -or ($project -and $All)) {
                $targets.Add($r)
            } elseif ($exists) {
                $targets.Add($r)
            } else {
                Write-Skip "skip (absent, use -Target or -All): $r"
            }
        }
        # always drop one portable copy under ~/.skills
        $targets.Add((Join-Path (Get-HomeDir) ".skills"))
        $targets.Add((Join-Path (Get-Location).Path ".mimocode/skills"))
    }

    $targets = $targets | Select-Object -Unique

    if ($PrintOnly) {
        Write-Host "Would copy $src ->"
        $targets | ForEach-Object { Write-Host "  $(Join-Path $_ $SkillName)" }
        return
    }

    foreach ($t in $targets) {
        if ($t) { Install-To $t $src }
    }

    Write-Host ""
    Write-Ok "done. Package is standard: <dir>/$SkillName/SKILL.md"
    Write-Host "Point any SKILL.md-capable agent at one of those folders (or symlink it)."
    Write-Host "New session, then e.g.:  帮我揉一下这页药理课业笔记"
    Write-Host "Docs: $RepoUrl/blob/v0.1.0/skills/README.md"
}
catch {
    Write-Host "[install] FAIL $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
