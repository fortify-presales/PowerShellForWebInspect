function Export-WIScanDetails {
    <#
    .SYNOPSIS
        Exports a scan's details.
    .DESCRIPTION
        Exports a scan's details in the specified format.
    .PARAMETER ScanId
        The id of the scan to export.
        Required.
    .PARAMETER DetailType
        The type of details to export.
        Required.
    .PARAMETER Format
        The export format to use.
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
        # Export scan vulnerabilities for scan id "ff860346-2978-4f14-bae3-004ff0a535c2" in XML format to file "test.xml"
        Export-WIScanDetails -ScanId ff860346-2978-4f14-bae3-004ff0a535c2 -OutFile test.xml -DetailType Vulnerabilities -Format xml
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
        [validateset('Comments', 'Vulnerabilities', 'Full')]
        [string]$DetailType,

        [Parameter(Mandatory)]
        [validateset('xml', 'txt')]
        [string]$Format,

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
        Write-Verbose "Export-WIScanDetails Bound Parameters: $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
        $Body = @{}
        if ($DetailType) {
            $Body.Add("detailType", $DetailType)
        }
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
