function New-WIProxyConfigurationDescriptorObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter]
        [validateset('none', 'standard', 'socks4', 'socks5', 'pacUrl')]
        [string]$ProxyMode,

        [Parameter]
        [string]$ProxyServer,

        [Parameter]
        [int]$ProxyPort,

        [Parameter]
        [string]$ProxyPacUrl,

        [Parameter]
        [validateset('none', 'basic', 'ntlm', 'kerberos', 'digest', 'automatic', 'negotiate')]
        [string]$ProxyAuthType,

        [Parameter]
        [string]$ProxyAuthUsername,

        [Parameter]
        [string]$ProxyAuthPassword,

        [Parameter]
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
