function New-WIUserAgentDescriptorObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter]
        [validateset('firefox', 'internetexplorer', 'chrome', 'iphone', 'ipad',
            'android', 'windowsphone', 'windowsrt', 'none')]
        [string]$Standard,

        [Parameter]
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
