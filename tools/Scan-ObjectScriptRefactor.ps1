param(
    [string]$Root = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path -LiteralPath $Root)) {
    Write-Error "Scan root does not exist: $Root"
}

$classFiles = Get-ChildItem -LiteralPath $Root -Recurse -Filter "*.cls" -File |
    Where-Object { $_.FullName -notmatch "\\\.git\\" }

$findings = New-Object System.Collections.Generic.List[string]

function Add-Matches {
    param(
        [string]$Name,
        [string]$Pattern,
        [object[]]$Files
    )

    if ($Files.Count -eq 0) {
        return
    }

    foreach ($match in Select-String -Path ($Files.FullName) -Pattern $Pattern -AllMatches) {
        $relative = Resolve-Path -LiteralPath $match.Path -Relative
        $findings.Add("$Name`t$relative`:$($match.LineNumber)`t$($match.Line.Trim())")
    }
}

Add-Matches "legacy-target-platform-binding" "target\.GetInvoke\(|Method\s+GetInvoke\s*\(" $classFiles
Add-Matches "legacy-platform-invoke-wrapper" "Engine\.Platform\.PlatformInvoke|InvokeByMethod|IPlatformBindingProvider" $classFiles

$baseTemplate = Join-Path $Root "PHA/COM/BaseBizPush/Engine/Template/BasePushTemplate.cls"
if (Test-Path -LiteralPath $baseTemplate) {
    Add-Matches "legacy-template-orchestration" "Method\s+(ExecuteOne|ExecuteSync|DoInvoke|ExecuteOneSync)\s*\(" @(Get-Item -LiteralPath $baseTemplate)
}

$adapterPath = [regex]::Escape("\Platforms\Adapter\")
$testPath = [regex]::Escape("\Test\")
$soapFiles = $classFiles | Where-Object {
    ($_.FullName -notmatch $adapterPath) -and ($_.FullName -notmatch $testPath)
}
Add-Matches "direct-soap-call-outside-adapter" "##class\(web\.|\.HIPMessageInfo\s*\(" $soapFiles

if ($findings.Count -gt 0) {
    Write-Host "ObjectScript refactor scan failed:" -ForegroundColor Red
    $findings | ForEach-Object { Write-Host $_ }
    exit 1
}

Write-Host "ObjectScript refactor scan passed." -ForegroundColor Green
