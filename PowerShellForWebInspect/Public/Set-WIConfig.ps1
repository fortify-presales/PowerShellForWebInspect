function Set-WIConfig
{
    <#
    .SYNOPSIS
        Set PowerShell for WebInspect module configuration.
    .DESCRIPTION
        Set PowerShell for WebInspect module configuration, and $PS4WI module variable.
        This data is used as the default AuthMethod, Credential and ApiUri for most commands.
        If a command takes either a AuthMethod, Credential or ApiUru, they take precedence.
        WARNING: Use this to store the Credentials on a filesystem at your own risk
                 Only supported on Windows systems, via the DPAPI
    .PARAMETER ApiUri
        Specify the API Uri to use, e.g. http://localhost:8083/webinspect.
    .PARAMETER AuthMethod
        The method of authentication to WebInspect API: None, Basic, Windows, ClientCertificate.
        Default is None.
    .PARAMETER Credential
        A previously created Credential object to be used.
    .PARAMETER Proxy
        Proxy to use with Invoke-RESTMethod.
    .PARAMETER ForceVerbose
        If set to true, we allow verbose output that may include sensitive data
        *** WARNING ***
        If you set this to true, your WebInspect data will be visible as plain text in verbose output
    .PARAMETER Path
        If specified, save config file to this file path.
        Defaults to PS4WI.xml in the user temp folder on Windows, or .ps4wi in the user's home directory on Linux/macOS.
    .EXAMPLE
        # Set the WebInspect Api Url and use Basic authentication
        Set-WIConfig -ApiUrl http://localhost:8083/webinspect -AuthMethod Basic -Credential $Credential
    .FUNCTIONALITY
        WebInspect.
    #>
    [cmdletbinding()]
    param(
        [Parameter()]
        [string]$ApiUri,

        [Parameter()]
        [ValidateSet('None', 'Basic', 'Windows', 'ClientCertificate')]
        [string]$AuthMethod = "None",

        [Parameter()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        $Credential,

        [Parameter()]
        [string]$Proxy,

        [Parameter()]
        [bool]$ForceVerbose,

        [Parameter()]
        [string]$Path = $script:_PS4WIXmlpath
    )

    switch ($PSBoundParameters.Keys)
    {
        'ApiUri'       { $Script:PS4WI.ApiUri = $ApiUri }
        'AuthMethod'   { $Script:PS4WI.AuthMethod = $AuthMethod }
        'Credential'   { $Script:PS4WI.Credential = $Credential }
        'Token'        { $Script:PS4WI.Token = $Token }
        'Proxy'        { $Script:PS4WI.Proxy = $Proxy }
        'ForceVerbose' { $Script:PS4WI.ForceVerbose = $ForceVerbose }
    }

    function encrypt
    {
        param([string]$string)
        if ($String -notlike '' -and (Test-IsWindows)) {
            ConvertTo-SecureString -String $string -AsPlainText -Force
        }
    }

    Write-Verbose "Set-WIConfig Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"

    # Write the global variable and the xml
    $Script:PS4WI |
        Select-Object -Property Proxy,
        @{ l = 'ApiUri'; e = { Encrypt $_.ApiUri } },
        @{ l = 'AuthMethod'; e = { $_.AuthMethod } },
        @{ l = 'Credential'; e = { $_.Credential } },
        ForceVerbose |
        Export-Clixml -Path $Path -force

}
