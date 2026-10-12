#!/usr/bin/env pwsh
# med-study-knead one-shot installer (Windows / PowerShell 7+)
# Local:   .\install.ps1
# Remote:  irm https://raw.githubusercontent.com/wangjirong670/med-ai-workflow-learning/main/install.ps1 | iex
#
# Installs the skill package into known agent skill roots.

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
$ZipUrl = "$RepoUrl/archive/refs/heads/main.zip"

function Write-Info([string]$msg) { Write-Host "[install] $msg" }
function Write-Ok([string]$msg)   { Write-Host "[install] OK  $msg" -ForegroundColor Green }
function Write-Skip([string]$msg) { Write-Host "[install] --  $msg" -ForegroundColor Yellow }

function Get-DefaultRoots {
    $roots = [System.Collections.Generic.List[string]]::new()
    $homeDir = [Environment]::GetFolderPath("UserProfile")
    if (-not $homeDir) { $homeDir = $env:USERPROFILE }

    # MiMo Desktop global
    $roots.Add((Join-Path $homeDir ".config/mimocode/skills"))
    # Claude Code style
    $roots.Add((Join-Path $homeDir ".claude/skills"))
    # Cursor / generic
    $roots.Add((Join-Path $homeDir ".cursor/skills"))
    return $roots
}

function Find-LocalRepo {
    if ($Repo -and (Test-Path (Join-Path $Repo "skills/$SkillName/SKILL.md"))) {
        return (Resolve-Path $Repo).Path
    }
    # script lives in repo root when cloned
    if ($PSScriptRoot) {
        $cand = $PSScriptRoot
        if (Test-Path (Join-Path $cand "skills/$SkillName/SKILL.md")) {
            return $cand
        }
    }
    # walk up from cwd
    $dir = (Get-Location).Path
    for ($i = 0; $i -lt 6 -and $dir; $i++) {
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
        Write-Info "using local skill from $repoRoot\skills\$SkillName"
        return (Join-Path $repoRoot "skills/$SkillName")
    }
    # download from GitHub
    Write-Info "local repo not found; downloading $ZipUrl"
    $tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("med-study-knead-" + [guid]::NewGuid().ToString("n"))
    New-Item -ItemType Directory -Path $tmp | Out-Null
    $zip = Join-Path $tmp "src.zip"
    Invoke-WebRequest -Uri $ZipUrl -OutFile $zip
    Expand-Archive -Path $zip -DestinationPath $tmp -Force
    $found = Get-ChildItem -Path $tmp -Recurse -Filter "SKILL.md" |
        Where-Object { $_.Directory.Name -eq $SkillName } |
        Select-Object -First 1
    if (-not $found) { throw "downloaded zip has no skills/$SkillName/SKILL.md" }
    return $found.Directory.FullName
}

function Install-To([string]$destRoot) {
    $dest = Join-Path $destRoot $SkillName
    New-Item -ItemType Directory -Path $destRoot -Force | Out-Null
    if (Test-Path $dest) {
        Remove-Item -Recurse -Force $dest
    }
    Copy-Item -Recurse -Force $src $dest
    Write-Ok "installed -> $dest"
}

try {
    $src = Get-SkillSource
    Write-Info "skill source: $src"

    $targets = [System.Collections.Generic.List[string]]::new()
    if ($Target) {
        $targets.Add($Target)
    } else {
        $roots = Get-DefaultRoots
        foreach ($r in $roots) {
            # only auto-install into roots that exist, unless -All or first MiMo path
            $isMimo = $r -like "*mimocode*"
            if ($All -or $isMimo -or (Test-Path $r)) {
                $targets.Add($r)
            } else {
                Write-Skip "skip (missing): $r"
            }
        }
        # project-local MiMo skill root when cwd looks like a project
        $proj = Join-Path (Get-Location).Path ".mimocode/skills"
        if ($All -or (Test-Path (Join-Path (Get-Location).Path ".git")) -or (Test-Path (Join-Path (Get-Location).Path "prompts"))) {
            $targets.Add($proj)
        }
    }

    if ($PrintOnly) {
        Write-Host "Would install $src to:"
        $targets | ForEach-Object { Write-Host "  $_/$SkillName" }
        return
    }

    foreach ($t in $targets | Select-Object -Unique) {
        Install-To $t
    }

    Write-Host ""
    Write-Ok "done. Restart the agent session or open a new chat, then try:"
    Write-Host "  帮我揉一下这页骨伤课业笔记（药学/医学材料）"
    Write-Host "Docs: $RepoUrl/blob/main/skills/README.md"
}
catch {
    Write-Host "[install] FAIL $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
