function Get-WIPolicyDetails {
    <#
    .SYNOPSIS
        Gets WebInspect policy details.
    .DESCRIPTION
        Get the details (checks) of a specific SecureBase policy in the WebInspect database.
    .PARAMETER PolicyId
        The "uniqueId" of the policy.
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
        # Get the details of a specific policy with unique id "7235cf62-ee1a-4045-88f8-898c1735856f"
        Get-WIPolicyDetails -PolicyId "7235cf62-ee1a-4045-88f8-898c1735856f" | Out-GridView
    .EXAMPLE
        # Get the checks for a specific policy
        Get-WIPolicyDetails -PolicyId 7235cf62-ee1a-4045-88f8-898c1735856f | `
            Select-Object -ExpandProperty checks | Out-GridView
    .LINK
        http://localhost:8083/webinspect/swagger/ui/index#!/SecureBase/SecureBase_GetPolicy
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$PolicyId,

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
        Write-Verbose "Get-WIPolicyDetails Bound Parameters: $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {
        Write-Verbose "Send-WIApi -Method Get -Operation '/securebase/policy/$PolicyId'" #$Params
        $Response = Send-WIApi -Method Get -Operation "/securebase/policy/$PolicyId" @Params
    }
    end {
        $Response
    }
}
