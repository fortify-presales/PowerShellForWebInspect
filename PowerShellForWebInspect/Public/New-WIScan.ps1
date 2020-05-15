function New-WIScan {
    <#
    .SYNOPSIS
        Create a New WebInspect scan.
    .DESCRIPTION
        Creates a New WebInspect using the REST API and a previously created
        PS4WI.StartScanDescriptorObject.
    .PARAMETER StartScanDescriptor
        A PS4WI.StartScanDescriptorObject containing the scans's settings.
    .PARAMETR ApiUri
        WebInspect API Uri to use, e.g. http://localhost:8083.
        If empty, the value from PS4WI will be used.
    .PARAMETR AuthMethod
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
        # Create a new scan with "Default" settings
        $startScanDescriptor = New-WIStartScanDescriptorObject -SettingsName "Default"
        New-WIScan -StartScanDescriptor $startScanDescriptor -ForceVerbose
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    param (
        [PSTypeName('PS4WI.StartScanDescriptorObject')]
        [parameter(ParameterSetName = 'StartScanDescriptorObject',
                ValueFromPipeline = $True)]
        [ValidateNotNullOrEmpty()]
        $StartScanDescriptor,

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
        $Params.Add('Body', $StartScanDescriptor)
    }
    process
    {
        Write-Verbose "Start-WIScan: -Method Post -Operation '/scanners/scans"
        $Response = Send-WIApi -Method Post -Operation "/scanner/scans" @Params
    }
    end {
        $Response
    }
}
