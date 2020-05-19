# WebInspect Scan examples

# Import-Module .\PowerShellForWebInspect\PowerShellForWebInspect.psdl -Force

# Initial setup of API endpoint and (Basic) authentication
#$Credential = Get-Credential
#Set-WIConfig -ApiUri http://localhost:8083/webinspect -AuthMethod Basic -Credential $Credential

#
# Start a new Scan
#

# Create macro parameter overrides
$macroParams = @(
    New-WIMacroParameterObject -Name "startURL" -Value "https://localhost:9443/secure-web-app"
    New-WIMacroParameterObject -Name "username" -Value "user"
    New-WIMacroParameterObject -Name "password" -Value "password"
)
$loginMacroParam = New-WIMacroParametersObject -MacroName swaLogin -MacroParameters $macroParams

# Create scan overrides for basic scan of "https://localhost:9443/secure-web-app"
#$scanSettingsOverrides = New-WIScanSettingsOverrideObject -ScanName "My Scan Name" `
#    -StartUrls "https://localhost:9443/secure-web-app"

# Create scan overrides for basic scan of "https://localhost:9443/secure-web-app", login macro "swaLogin" and
# policy id 1008 (Critical and High)
$scanSettingsOverrides = New-WIScanSettingsOverrideObject -ScanName "My Scan Name" `
    -StartUrls "https://localhost:9443/secure-web-app" `
    -LoginMacro "swaLogin" -MacroParameters $loginMacroParam `
    -PolicyId 1008 # 1008 is "Critical and High" policy

#$scanSettingsOverrides = New-WIScanSettingsOverrideObject -ScanName "My Scan Name" `
#    -StartUrls "https://localhost:9443/secure-web-app" `
#    -LoginMacro "swaLogin" -MacroParameters $loginMacroParam `
#    -EnableTrafficMonitor `
#    -CrawlAuditMode crawlAndAudit -CrawlCoverageMode quick `
#    -ScanScope children -ScopedPaths "https://localhost:9443/secure-web-app" `
#    -DontStartScan -CrawlAuditMode crawlAndAudit -CrawlCoverageMode quick `
#    -PolicyId 1008 # 1008 is "Critical and High" policy

#$reuseScanOptions = New-WIScanReuseOptionsObject -ScanId "df933d69-8353-4deb-a794-c1a6a3852799" -Mode remediation
#$scanSettingsOverrides = New-WIScanSettingsOverrideObject -ScanName "Reuse Scan Name"

# Create StartScanDescriptor
$startScanDescriptor = New-WIStartScanDescriptorObject -SettingsName "Default" `
    -ScanOverrides $scanSettingsOverrides
#    -ReuseScan $reuseScanOptions

# Start the scan
$response = New-WIScan -StartScanDescriptor $startScanDescriptor
if ($response) {
    $scanId = $response.ScanId
    Write-Host "Created new scan with id: $scanId"
}

#Write-Host -NoNewLine 'Press any key to continue...';
#[void][System.Console]::ReadKey($FALSE)

# Get the status of the scan
Write-Host "Getting status of scan with id: $scanId"
$response = Get-WiScanStatus -ScanId $scanId -WaitForStatusChange
if ($response) {
    $scanStatus = $response.ScanStatus
}
Write-Host "Scan status is: $scanStatus"

#Write-Host -NoNewLine 'Press any key to continue...';
#[void][System.Console]::ReadKey($FALSE)
