function Remove-WIScan {
    <#
    .SYNOPSIS
        Deletes a specific WebInspect scan.
    .DESCRIPTION
        Deletes a specific WebInspect scan.
    .PARAMETER ScanId
        The id of the scan.
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
        If empty, the value from PS4WI will be used.
    .PARAMETER ForceVerbose
        If specified, don't explicitly remove verbose output from Invoke-RestMethod
        *** WARNING ***
        This will expose your data in verbose output.
    .EXAMPLE
        # Remove (Delete) the scan with id "6a1e8969-bf04-4b35-92a2-83e6c809fa5a"
        Remove-WIScan -Id "6a1e8969-bf04-4b35-92a2-83e6c809fa5a"
    .LINK
        http://localhost:8083/webinspect/swagger/ui/index#!/Scanner/Scanner_DeleteScan
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
        Write-Verbose "Remove-WIScan Bound Parameters: $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {
        Write-Verbose "Send-WIApi -Method Delete -Operation '/scanner/scans/$ScanId'" #$Params
        $Response = Send-WIApi -Method Delete -Operation "/scanner/scans/$ScanId" @Params
    }
    end {
        $Response
    }
}
