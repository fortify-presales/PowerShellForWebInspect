function Get-WIPolicies {
    <#
    .SYNOPSIS
        Gets WebInspect SecureBase Policies.
    .DESCRIPTION
        Get a list of all the available policies in the WebInspect database.
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
        # Get all policies
        Get-WIPolicies | Out-GridView
    .LINK
        http://localhost:8083/webinspect/swagger/ui/index#!/SecureBase/SecureBase_GetAllPolicies
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    param (
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
        Write-Verbose "Get-WIPolicies Bound Parameters: $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {
        Write-Verbose "Send-WIApi -Method Get -Operation '/securebase/policy'" #$Params
        $Response = Send-WIApi -Method Get -Operation "/securebase/policy" @Params
    }
    end {
        $Response
    }
}
