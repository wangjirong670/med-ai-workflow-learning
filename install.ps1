#!/usr/bin/env pwsh
# Install from a reviewed checkout: .\install.ps1 -Target "<your-skills-dir>"
# Default: ~/.skills (portable copy; configure your agent to load it).
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
function Write-Info([string]$message) { Write-Host "[install] $message" }
function Get-HomeDir {
    $directory = [Environment]::GetFolderPath("UserProfile")
    if ($directory) { return $directory }
    if ($env:USERPROFILE) { return $env:USERPROFILE }
    throw "Cannot locate user profile; use -Target"
}
function Find-LocalRepo {
    if ($Repo) {
        if (-not (Test-Path -LiteralPath (Join-Path $Repo "skills/$SkillName/SKILL.md"))) {
            throw "Repo does not contain the skill: $Repo"
        }
        return (Resolve-Path -LiteralPath $Repo).Path
    }
    if ($PSScriptRoot -and (Test-Path -LiteralPath (Join-Path $PSScriptRoot "skills/$SkillName/SKILL.md"))) {
        return $PSScriptRoot
    }
    $directory = (Get-Location).Path
    for ($i = 0; $i -lt 8 -and $directory; $i++) {
        if (Test-Path -LiteralPath (Join-Path $directory "skills/$SkillName/SKILL.md")) { return $directory }
        $parent = Split-Path $directory -Parent
        if ($parent -eq $directory) { break }
        $directory = $parent
    }
    throw "No checkout found. Clone the repository, review this script, then run it with -Target."
}
function Get-SkillSource {
    if ($Source) {
        $directory = (Resolve-Path -LiteralPath $Source).Path
    } else {
        $directory = Join-Path (Find-LocalRepo) "skills/$SkillName"
    }
    foreach ($file in @("SKILL.md", "LICENSE", "references/snapshot/MANIFEST.json")) {
        if (-not (Test-Path -LiteralPath (Join-Path $directory $file) -PathType Leaf)) {
            throw "Incomplete package: $file missing from $directory"
        }
    }
    return $directory
}
function Get-CandidateRoots {
    $profileDirectory = Get-HomeDir
    $currentDirectory = (Get-Location).Path
    return @(
        (Join-Path $profileDirectory ".skills"),
        (Join-Path $profileDirectory ".local/share/agent-skills"),
        (Join-Path $profileDirectory ".config/agent-skills"),
        (Join-Path $currentDirectory ".mimocode/skills"),
        (Join-Path $currentDirectory ".claude/skills"),
        (Join-Path $currentDirectory ".cursor/skills"),
        (Join-Path $currentDirectory ".agents/skills"),
        (Join-Path $profileDirectory ".claude/skills"),
        (Join-Path $profileDirectory ".cursor/skills"),
        (Join-Path $profileDirectory ".codex/skills"),
        (Join-Path $profileDirectory ".gemini/skills"),
        (Join-Path $profileDirectory ".agents/skills")
    )
}
function Install-To([string]$destinationRoot, [string]$sourceDirectory) {
    $sourceFull = (Resolve-Path -LiteralPath $sourceDirectory).Path.TrimEnd('\', '/')
    # Resolve-Path does not resolve junction targets in Windows PowerShell 5.
    # Check both sides so a linked source cannot alias an existing installation.
    foreach ($candidate in @($sourceFull, [IO.Path]::GetFullPath($destinationRoot))) {
        $ancestor = $candidate
        while ($ancestor) {
            if (Test-Path -LiteralPath $ancestor) {
                if ((Get-Item -LiteralPath $ancestor -Force).Attributes -band [IO.FileAttributes]::ReparsePoint) {
                    throw "Refusing linked source or destination ancestor: $ancestor"
                }
            }
            $parent = Split-Path $ancestor -Parent
            if ($parent -eq $ancestor) { break }
            $ancestor = $parent
        }
    }
    New-Item -ItemType Directory -Path $destinationRoot -Force | Out-Null
    $rootFull = (Resolve-Path -LiteralPath $destinationRoot).Path.TrimEnd('\', '/')
    $destination = Join-Path $rootFull $SkillName
    $separator = [System.IO.Path]::DirectorySeparatorChar
    $comparison = if ($env:OS -eq "Windows_NT") { [StringComparison]::OrdinalIgnoreCase } else { [StringComparison]::Ordinal }
    if ([string]::Equals($destination, $sourceFull, $comparison)) {
        Write-Info "skip (same as source): $destination"; return
    }
    if ((Test-Path -LiteralPath $destination) -and ((Get-Item -LiteralPath $destination -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) {
        throw "Refusing to replace link: $destination"
    }
    if (($rootFull + $separator).StartsWith($sourceFull + $separator, $comparison) -or
        ($sourceFull + $separator).StartsWith($destination + $separator, $comparison)) {
        throw "Refusing overlapping source and destination: $destination"
    }
    $stage = Join-Path $rootFull (".$SkillName.stage." + [guid]::NewGuid().ToString("n"))
    $backup = Join-Path $rootFull (".$SkillName.backup." + [guid]::NewGuid().ToString("n"))
    $movedPrevious = $false
    try {
        New-Item -ItemType Directory -Path $stage | Out-Null
        Get-ChildItem -LiteralPath $sourceFull -Force | ForEach-Object {
            Copy-Item -LiteralPath $_.FullName -Destination $stage -Recurse -Force
        }
        if (Test-Path -LiteralPath $destination) {
            Move-Item -LiteralPath $destination -Destination $backup
            $movedPrevious = $true
        }
        Move-Item -LiteralPath $stage -Destination $destination
    } catch {
        if ($movedPrevious -and -not (Test-Path -LiteralPath $destination)) {
            try { Move-Item -LiteralPath $backup -Destination $destination }
            catch { Write-Info "Restore failed; previous installation retained at $backup" }
        }
        throw
    } finally {
        if (Test-Path -LiteralPath $stage) { Remove-Item -LiteralPath $stage -Recurse -Force }
    }
    if (Test-Path -LiteralPath $backup) { Remove-Item -LiteralPath $backup -Recurse -Force }
    Write-Info "installed -> $destination"
}
try {
    $sourceDirectory = Get-SkillSource
    if ($Target) { $targets = @($Target) }
    elseif ($All) { $targets = @(Get-CandidateRoots | Select-Object -Unique) }
    else { $targets = @((Join-Path (Get-HomeDir) ".skills")) }
    if ($PrintOnly) {
        Write-Host "Would copy $sourceDirectory ->"
        $targets | ForEach-Object { Write-Host "  $(Join-Path $_ $SkillName)" }
        return
    }
    foreach ($directory in $targets) { Install-To $directory $sourceDirectory }
    Write-Info "Done. Configure your agent to load <target>/$SkillName/SKILL.md; discovery depends on the agent."
} catch {
    Write-Error "[install] FAIL $($_.Exception.Message)"
    exit 1
}
