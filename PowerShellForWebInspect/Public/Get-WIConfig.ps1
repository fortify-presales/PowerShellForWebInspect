Function Get-WIConfig {
    <#
    .SYNOPSIS
        Get PowerShell For WebInspect module configuration.
    .DESCRIPTION
        Retrieves the PowerShell for WebInspect module configuration from the serialized XML file.
    .PARAMETER Source
        Get the config data from either:
            PS4WI:     the live module variable used for command defaults
            PS4WI.xml: the serialized PS4WI.xml that loads when importing the module
        Defaults to PS4WI.
    .PARAMETER Path
        If specified, read config from this XML file.
        Defaults to PS4WI.xml in the user temp folder on Windows, or .ps4wi in the user's home directory on Linux/macOS.
    .EXAMPLE
        # Retrieve the current configuration
        Get-WIConfig
    .FUNCTIONALITY
        WebInspect.
    #>
    [cmdletbinding(DefaultParameterSetName = 'source')]
    param(
        [parameter(ParameterSetName='source')]
        [ValidateSet("PS4WI","PS4WI.xml")]
        $Source = "PS4WI",

        [parameter(ParameterSetName='path')]
        [parameter(ParameterSetName='source')]
        $Path = $script:_PS4WIXmlpath
    )
    Write-Verbose "Get-WIConfig Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"

    if ($PSCmdlet.ParameterSetName -eq 'source' -and $Source -eq "PS4WI" -and -not $PSBoundParameters.ContainsKey('Path')) {
        $Script:PS4WI
    } else {
        function Decrypt {
            param($String)
            if($String -is [System.Security.SecureString]) {
                [System.Runtime.InteropServices.marshal]::PtrToStringAuto(
                        [System.Runtime.InteropServices.marshal]::SecureStringToBSTR(
                                $string))
            }
        }
        Write-Verbose "Retrieving WebInspect Configuration from $Path"
        Import-Clixml -Path $Path |
                Select-Object -Property Proxy,
                @{l='ApiUri';e={Decrypt $_.ApiUri}},
                @{l='AuthMethod';e={$_.AuthMethod}},
                @{l='Credential';e={$_.Credential}},
                ForceVerbose
    }

}
