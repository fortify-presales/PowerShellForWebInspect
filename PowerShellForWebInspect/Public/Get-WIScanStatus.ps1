function Get-WIScanStatus {
    <#
    .SYNOPSIS
        Gets the status of a scan.
    .DESCRIPTION
        Get the status of a scans from the WebInspect API.
    .PARAMETER ScanId
        The id of the scan to retrieve.
    .PARAMETER WaitForStatusChange
        If the scan status is Running, wait for the scan status to change and then return the new value.
    .PARAMETER ApiUri
        WebInspect API Uri to use, e.g. http://localhost:8083.
        If empty, the value from PS4WI will be used.
    .PARAMETER AuthMethod
        WebInspect API Authentication Method to use.
        If empty, the value from PS4WI will be used.
    .PARAMETER Credential
        A previously created Credential object to be used.
    .PARAMETER Proxy
        Proxy server to use.
        Default value is the value set by Set-WIConfig.
    .PARAMETER ForceVerbose
        Force verbose output.
        Default value is the value set by Set-WIConfig
    .EXAMPLE
        # Get the status of the scan with id "1cec4067-cb67-42ed-8f00-e5220b5afc04"
        Get-WIScanStatus -ScanId "1cec4067-cb67-42ed-8f00-e5220b5afc04"
    .LINK
        http://localhost:8083/webinspect/swagger/ui/index#!/Scanner/Scanner_GetScanStatus
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ScanId,

        [Parameter()]
        [switch]$WaitForStatusChange,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$ApiUri = $Script:PS4WI.ApiUri,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$AuthMethod = $Script:PS4WI.AuthMethod,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        [ValidateNotNullOrEmpty()]
        $Credential = $Script:PS4WI.Credential,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Proxy = $Script:PS4WI.Proxy,

        [switch]$ForceVerbose = $Script:PS4WI.ForceVerbose
    )
    begin
    {
        $Params = @{}
        if ($ApiUri)        { $Params['ApiUri'] = $ApiUri }
        if ($AuthMethod)    { $Params['AuthMethod'] = $AuthMethod }
        if ($Credential)    { $Params['Credential'] = $Credential }
        if ($Proxy)         { $Params['Proxy'] = $Proxy }
        if ($ForceVerbose) {
            $Params.Add('ForceVerbose', $True)
            $VerbosePreference = "Continue"
        }
        Write-Verbose "Get-WIScanStatus Bound Parameters: $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
        $Body = @{}
        if ($WaitForStatusChange) {
            Write-Host "Waiting for scan status change"
            $Body.Add("action", "waitForStatusChange")
        } else {
            $Body.Add("action", "getCurrentStatus")

        }
        if ($Body.Count -gt 0) {
            $Params.Add('Body', $Body)
        }
    }
    process
    {
        Write-Verbose "Send-WIApi -Method Get -Operation '/scanner/scans/${ScanId}'" #$Params
        $Response = Send-WIApi -Method Get -Operation "/scanner/scans/${ScanId}" @Params
    }
    end {
        $Response
    }
}
