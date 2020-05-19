function New-WIScanSettingsOverrideObject
{
    <#
    .SYNOPSIS
        Create a new ScanSettingsOverrideObject object.
    .DESCRIPTION
        Create a new PS4WI.ScanSettingsOverrideObject with any custom settings overrides for use in
        initiating a new scan.
    .PARAMETER ScanName
        Any alpha-numeric value, does not need to be unique.
        Required.
    .PARAMETER StartUrls
        A list of valid, fully qualified URLs, including scheme, host and port.
        This field is only used if "StartOption" is "Url".
    .PARAMETER UserAgent
        A UserAgentDescriptorObject which can be used to configure a predefined user agent or use a
        custom user agent string.
    .PARAMETER WebServiceScan
        A WebServiceScanDescriptorObject which can be used to configure a SOAP Web Service Scan.
    .PARAMETER CrawlAuditMode
        The crawl and/or audit mode to use.
    .PARAMETER CrawlCoverageMode
        The crawl coverage mode to use.
    .PARAMETER KnownTechnology
        A KnownTechnologyDescriptorObject to use.
    .PARAMETER SharedThreads
        A number between 1 and 75 indicating the number of shared threads that the crawler and auditor should use
        (default is 1, meaning a single threaded scan). SharedThreads is not compatible with CrawlThreads and
        AuditThreads. If SharedThreads is set, CrawlThreads and AuditThreads will be ignored.
    .PARAMETER CrawlThreads
        A number between 1 and 25 indicating the number of threads that the crawler should use (default is 1).
        SharedThreads is not compatible with CrawlThreads and AuditThreads. If SharedThreads is set, CrawlThreads
        and AuditThreads will be ignored.
    .PARAMETER AuditThreads
        A number between 1 and 50 indicating the number of threads that the auditor should use (default is 10).
        SharedThreads is not compatible with CrawlThreads and AuditThreads. If SharedThreads is set, CrawlThreads
        and AuditThreads will be ignored.
    .PARAMETER StartOption
        The start option to use.
    .PARAMETER LoginMacroAutoGen
        A MacroGenDescriptorObject which can be used to configure automatic login macro generation.
    .PARAMETER LoginMacro
        A webmacro file name.
        This file must exist in the WebInspect scan settings folder on the WebInspect machine.
    .PARAMETER MacroParameters
        A MacroParametersObject which can be used to override parameters defined in TruClient macros.
        The macros must exist in the scan settings and the parameters must exist in the macro.
    .PARAMETER SmartCredentials
        Override the smart credentials defined in a session-based macro. The macro must exist in the scan settings
        and smart credentials must be enabled in the macro.
    .PARAMETER Proxy
        A ProxyConfigurationDescriptorObject to use which defines a proxy server.
    .PARAMETER NetworkCredentials
        Network authentication username and password. Use the NetworkAuthenticationMode setting to specify the
        authentication mode.
    .PARAMETER NetworkAuthenticationMode
        Specifies the network authentication mode when using NetworkCredentials, e..g. "myusername","mypassword"
    .PARAMETER AllowedHosts
        An array of allowed "host:port" entries. Hosts found in "StartUrls" are automatically added to the allowed
        hosts list. Use the special value "*" to add all hosts found in workflow macros, login macros and start
        urls to allowed hosts.
        Caution! This is a convenience feature, and it can cause the scanner to go out of scope.
        Examples: "zero.webappsecurity.com:80", "zero.webappsecurity.com:443", "myhost:8888" or "\*"
    .PARAMETER RestEndPoints
        A RestEndpointDescriptorObject containing the REST end points to use.
    .PARAMETER WebFormValues
        The web form values to use.
    .PARAMETER PolicyId
        An integer representing the policy id OR the GUID representing the policy unique id.
        Use "Get-WIPolicies" for a list of available policies.
    .PARAMETER CheckIds
        An array of check IDs.
        A custom audit policy will be created from this list and used for the scan.
    .PARAMETER DontStartScan
        If this switch is set, the scan will be created but it will remain in the stopped state.
    .PARAMETER ScanScope
        The scope of the scan.
    .PARAMETER ScopedPaths
        Restrict the crawler to specific paths within a web site.
    .PARAMETER ClientCertificate
        Either the location of the client certificate in the Windows certificate store OR the raw client certificate.
    .PARAMETER EnableTrafficMonitor
        If this switch is set, the traffic monitor will be enabled.
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
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
        [switch]$DontStartScan,

        [Parameter()]
        [validateset('unrestricted', 'self', 'children', 'ancestors')]
        [string]$ScanScope,

        [Parameter()]
        [string[]]$ScopedPaths,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.ClientCertificateObject')]
        $ClientCertificate,

        [Parameter()]
        [switch]$EnableTrafficMonitor
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
            'scopedPaths'               { $body.scopedPaths = $ScopedPaths }
            'clientCertificate'         { $body.clientCertificate = $ClientCertificate }
            'enableTrafficMonitor'{
                if ($EnableTrafficMonitor) {
                    $body.disableTrafficMonitor  = $false
                } else {
                    $body.disableTrafficMonitor  = $true
                }
            }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.ScanSettingsOverrideObject
    }
}
