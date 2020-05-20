function Export-WIScan {
    <#
    .SYNOPSIS
        Exports a scan.
    .DESCRIPTION
        Exports a scan in Fortify Project Results (FPR) format.
    .PARAMETER ScanId
        The id of the scan to export.
        Required.
    .PARAMETER OutFile
        The name of the file to export the scan to.
        Required.
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
        # Export a scan for scan id "ff860346-2978-4f14-bae3-004ff0a535c2" in FPR format to file "test.fpr"
        Export-WIScanReport -ScanId ff860346-2978-4f14-bae3-004ff0a535c2 -ReportFormat fpr -OutFile test.fpr
    .LINK
        http://localhost:8083/webinspect/swagger/ui/index#!/Scanner/Scanner_GenerateReport
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ScanId,

        [Parameter(Mandatory)]
        [string]$OutFile,

        [Parameter()]
        [switch]$IsCustom,

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
        Write-Verbose "Export-WIScan Bound Parameters: $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
        $Body = @{}
        $Format = "fpr"
        if ($Body.Count -gt 0) {
            $Params.Add('Body', $Body)
        }
        $Params.Add('OutFile', $OutFile)
    }
    process
    {
        Write-Verbose "Send-WIApi -Method Get -Operation '/scanner/scans/${ScanId}.${Format}'" #$Params
        $Response = Send-WIApi -Method Get -Operation "/scanner/scans/${ScanId}.${Format}" @Params
    }
    end {
        $Response
    }
}
