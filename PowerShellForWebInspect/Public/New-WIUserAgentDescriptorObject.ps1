function New-WIUserAgentDescriptorObject
{
    <#
    .SYNOPSIS
        Create a new UserAgentDescriptorObject.
    .DESCRIPTION
        Create a new PS4WI.UserAgentDescriptorObject for use in initiating a new scan.
        Allows you to configure predefined user agent or use custom user agent string
    .PARAMETER Standard
        Standard option to use: firefox, internetexplorer, chrome, iphone, ipad, android, windowsphone, windowsrt, none.
    .PARAMETER Custom
        Custom user agent string.
        If you would like to use custom user agent string then standard should be set to "none".
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [validateset('firefox', 'internetexplorer', 'chrome', 'iphone', 'ipad',
            'android', 'windowsphone', 'windowsrt', 'none')]
        [string]$Standard,

        [Parameter()]
        [string]$Custom
    )
    begin
    {
        Write-Verbose "New-WIUserAgentDescriptorObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'scanId' { $body.scanId = $ScanId }
            'mode'   { $body.mode = $Mode }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.UserAgentDescriptorObject
    }
}
