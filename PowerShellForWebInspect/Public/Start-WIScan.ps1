function Start-WIScan {
    <#
    .SYNOPSIS
        Starts a WebInspect scan.
    .DESCRIPTION
        Starts a currently stopped WebInspect Scan
    .PARAMETER ScanId
        The id of the scan to start.
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
        Default value is the value set by Set-WIConfig
    .PARAMETER ForceVerbose
        Force verbose output.
        Default value is the value set by Set-WIConfig
    .EXAMPLE
        # Starts the scan with id "1cec4067-cb67-42ed-8f00-e5220b5afc04"
        Start-WIScan -ScanId "1cec4067-cb67-42ed-8f00-e5220b5afc04"
    .LINK
        http://localhost:8083/webinspect/swagger/ui/index#!/Scanner/Scanner_PauseOrResumeScan
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ScanId,

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
        Write-Verbose "Start-WIScan Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

        Write-Verbose "Start-WIScan: -Method Post -Operation '/scanners/scans/${ScanId}?action=start"
        $Response = Send-WIApi -Method Post -Operation "/scanner/scans/${ScanId}?action=start" @Params
    }
    end {
        $Response
    }
}
