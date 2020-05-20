function Export-WIScanReport {
    <#
    .SYNOPSIS
        Generates a report from a scan.
    .DESCRIPTION
        Generates a report from a scan using the WebInspect API and exports the results to a file in the
        specified format.
    .PARAMETER ScanId
        The id of the scan to generate the report for.
        Required.
    .PARAMETER Format
        The format of the exported report.
        Required.
    .PARAMETER ReportType
        The type of report: "issue" or "compliance".
        Required.
    .PARAMETER ReportName
        If the value of ReportType is "compliance", then the value of ReportName must be the name of a compliance
        template. If the value of "reportType" is "issue", then the value of ReportName must the name of a custom
        report OR one of the standard reports. Use Get-WIReports to retrieve the available list.
        Required
    .PARAMETER IsCustom
        Use this switch if the report is a custom report otherwise a standard report is assumed.
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
        Export-WIScanReport -ScanId ff860346-2978-4f14-bae3-004ff0a535c2 -ReportFormat pdf -ReportType issue -ReportName Vulnerabilities -Outfile test.pdf
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
        [validateset('pdf', 'html', 'raw', 'rtf', 'txt', 'excel')]
        [string]$ReportFormat,

        [Parameter()]
        [validateset('issue', 'compliance')]
        [string]$ReportType,

        [Parameter()]
        [string]$ReportName,

        [Parameter(Mandatory)]
        [string]$OutFile,

        [Parameter()]
        [switch]$IsCustom = $false,

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
        Write-Verbose "Export-WIScanReport Bound Parameters: $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
        $Body = @{}
        $Format = "scan"
        if ($ReportType) {
            $Body.Add("reportType", $ReportType)
            $Body.Add("reportFormat", $ReportFormat)
            $Format = $ReportFormat
        }
        if ($ReportName) {
            if (-not $ReportType) {
                throw "If '-ReportName' is specified '-ReportType' must be provided as well"
            }
            $Body.Add("reportName", $ReportName)
            if ($IsCustom) {
                $Body.Add("isCustom", "true")
            } else {
                $Body.Add("isCustom", "false")
            }
        }
        if ($Body.Count -gt 0) {
            $Params.Add('Body', $Body)
        }
        $Params.Add('OutFile', $OutFile)
    }
    process
    {
        Write-Verbose "Send-WIApi -Method Get -Operation '/scanner/reports/${ScanId}.${Format}'" #$Params
        $Response = Send-WIApi -Method Get -Operation "/scanner/reports/${ScanId}.${Format}" @Params
    }
    end {
        $Response
    }
}
