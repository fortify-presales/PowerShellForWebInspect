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
    New-WIMacroParameterObject -Name "username" -Value "user"
    New-WIMacroParameterObject -Name "password" -Value "password"
)
$loginMacroParam = New-WIMacroParametersObject -MacroName swaLogin -MacroParameters $macroParams

# Create scan overrides
$scanSettingsOverrides = New-WIScanSettingsOverridesObject -ScanName "My Scan Name" `
    -StartUrls "http://localhost:8881/secure-web-app" -LoginMacro "swaLogin" -MacroParameters $loginMacroParam `
    -PolicyId 1008 # 1008 is "Critical and High" policy

# Create StartScanDescriptor
$startScanDescriptor = New-WIStartScanDescriptorObject -SettingsName "Default" -ScanOverrides $scanSettingsOverrides

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
