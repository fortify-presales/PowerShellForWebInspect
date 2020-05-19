function New-WIProxyConfigurationDescriptorObject
{
    <#
    .SYNOPSIS
        Create a new ProxyConfigurationDescriptorObject.
    .DESCRIPTION
        Create a new PS4WI.ProxyConfigurationDescriptorObject for use in initiating a new scan.
    .PARAMETER ProxyMode
        The mode of the proxy.
    .PARAMETER ProxyServer
        The proxy server hostname or IP address.
    .PARAMETER ProxyPort
        The proxy server port number.
    .PARAMETER ProxyPacUrl
        The proxy server autoconfiguration PAC file URL.
    .PARAMETER ProxyAuthType
        The proxy server authentication type.
    .PARAMETER ProxyAuthUsername
        The proxy authentication username.
    .PARAMETER ProxyAuthPassword
        The proxy authentication password.
    .PARAMETER ProxyBypass
        The bypass proxy semicolon separated list.
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter(Mandatory)]
        [validateset('none', 'standard', 'socks4', 'socks5', 'pacUrl')]
        [string]$ProxyMode,

        [Parameter(Mandatory)]
        [string]$ProxyServer,

        [Parameter(Mandatory)]
        [int]$ProxyPort,

        [Parameter()]
        [string]$ProxyPacUrl,

        [Parameter()]
        [validateset('none', 'basic', 'ntlm', 'kerberos', 'digest', 'automatic', 'negotiate')]
        [string]$ProxyAuthType,

        [Parameter()]
        [string]$ProxyAuthUsername,

        [Parameter()]
        [string]$ProxyAuthPassword,

        [Parameter()]
        [string]$ProxyBypass
    )
    begin
    {
        Write-Verbose "New-WIProxyConfigurationDescriptorObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'proxyMode'         { $body.proxyMode = $ProxyMode }
            'proxyServer'       { $body.proxyServer = $ProxyServer }
            'proxyPort'         { $body.proxyPort = $ProxyPort }
            'proxyPacUrl'       { $body.proxyPacUrl = $ProxyPacUrl }
            'proxyAuthType'     { $body.proxyAuthType = $ProxyAuthType }
            'proxyAuthUsername' { $body.proxyAuthUsername = $ProxyAuthUsername }
            'proxyAuthPassword' { $body.proxyAuthPassword = $ProxyAuthPassword }
            'proxyBypass'       { $body.proxyBypass = $ProxyBypass }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.ProxyConfigurationDescriptorObject
    }
}
