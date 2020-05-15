function New-WIScanSettingsOverrideObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter(Mandatory)]
        [string]$ScanName,

        [Parameter()]
        [string[]]$StartUrls,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.UserAgentDescriptorObject')]
        $UserAgent,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.WebServiceScanDescriptorObject')]
        $WebServiceScan,

        [Parameter()]
        [validateset('crawlOnly', 'auditOnly', 'crawlAndAudit')]
        [string]$CrawlAuditMode,

        [Parameter()]
        [validateset('default', 'thorough', 'moderate', 'quick')]
        [string]$CrawlCoverageMode,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.KnownTechnologyDescriptorObject')]
        $KnownTechnology,

        [Parameter()]
        [int]$SharedThreads,

        [Parameter()]
        [int]$CrawlThreads,

        [Parameter()]
        [int]$AuditThreads,

        [Parameter()]
        [validateset('url', 'macro')]
        [string]$StartOption,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.MacroGenDescriptorObject')]
        $LoginMacroAutoGen,

        [Parameter()]
        [string]$LoginMacro,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.MacroParametersObject')]
        $MacroParameters,


        [Parameter()]
        [string[]]$SmartCredentials,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.ProxyConfigurationDescriptorObject')]
        $Proxy,

        [Parameter()]
        [string[]]$NetworkCredentials,

        [Parameter()]
        [validateset('none', 'basic', 'nTLM', 'kerboros', 'digest', 'automatic', 'negotiate')]
        [string]$NetworkAuthenticationMode,

        [Parameter()]
        [string[]]$AllowedHosts,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.RestEndpointDescriptorObject')]
        [System.Collections.Hashtable[]]
        $RestEndPoints,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.WebFormsValuesDescriptorObject')]
        $WebFormValues,

        [Parameter()]
        [string]$PolicyId,

        [Parameter()]
        [int[]]$CheckIds,

        [Parameter()]
        [validateset($True, $False)]
        [switch]$DontStartScan,

        [Parameter()]
        [validateset('unrestricted', 'self', 'children', 'ancestors')]
        [string]$ScanScope,

        [Parameter()]
        [string[]]$ScopePaths,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.ClientCertificateObject')]
        $ClientCertificate,

        [Parameter()]
        [validateset($True, $False)]
        [switch]$DisableTrafficMonitor
    )
    begin
    {
        $AllMacroParameters = @()
        $AllRestEndPoints = @()
        Write-Verbose "New-WIScanSettingsOverrideObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {
        foreach ($MacroParameter in $MacroParameters) {
            $AllMacroParameters += $MacroParameter
        }
        foreach ($RestEndPoint in $RestEndPoints) {
            $AllRestEndPoints += $RestEndPoint
        }
    }
    end
    {
        $body = @{}

        switch ($psboundparameters.keys) {
            'scanName'                  { $body.scanName = $ScanName }
            'startUrls'                 { $body.startUrls = $StartUrls }
            'userAgent'                 { $body.userAgent = $UserAgent }
            'webServiceScan'            { $body.webServiceScan = $WebServiceScan }
            'crawlAuditMode'            { $body.crawlAuditMode = $CrawlAuditMode }
            'crawlCoverageMode'         { $body.crawlCoverageMode = $CrawlCoverageMode }
            'knownTechnology'           { $body.knownTechnology = $KnownTechnology }
            'sharedThreads'             { $body.sharedThreads = $SharedThreads }
            'crawlThreads'              { $body.crawlThreads = $CrawlThreads }
            'auditThreads'              { $body.auditThreads = $AuditThreads }
            'startOption'               { $body.startOption = $StartOption }
            'loginMacroAutoGen'         { $body.loginMacroAutoGen = $LoginMacroAutoGen }
            'loginMacro'                { $body.loginMacro = $LoginMacro }
            'macroParameters'           { $body.tcMacroParameters = $MacroParameters }
            'workflowMacros'            { $body.workflowMacros = $WorkflowMacros }
            'macroParameters'           { $body.tcMacroParameters = $MacroParameters }
            'smartCredentials'          { $body.smartCredentials = $SmartCredentials }
            'proxy'                     { $body.proxy = $Proxy }
            'networkCredentials'        { $body.networkCredentials = $NetworkCredentials }
            'networkAuthenticationMode' { $body.networkAuthenticationMode = $NetworkAuthenticationMode }
            'allowedHosts '             { $body.allowedHosts = $AllowedHosts }
            'restEndpoints'             { $body.restEndpoints = @($AllRestEndPoints) }
            'webFormValues'             { $body.webFormValues = $WebFormValues }
            'policyId'                  { $body.policyId = $PolicyId }
            'checkIDs'                  { $body.checkIDs = $CheckIds }
            'dontStartScan'{
                if ($DontStartScan) {
                    $body.dontStartScan = $true
                } else {
                    $body.dontStartScan = $false
                }
            }
            'scanScope'                 { $body.scanScope = $ScanScope }
            'scopedPaths'               { $body.scopedPaths = $ScopePaths }
            'clientCertificate'         { $body.clientCertificate = $ClientCertificate }
            'disableTrafficMonitor'{
                if ($DisableTrafficMonitor) {
                    $body.disableTrafficMonitor  = $true
                } else {
                    $body.disableTrafficMonitor  = $false
                }
            }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.ScanSettingsOverrideObject
    }
}
