function New-WIMacroGenDescriptorObject
{
    <#
    .SYNOPSIS
        Create a new MacroGenDescriptorObject.
    .DESCRIPTION
        Create a new PS4WI.MacroGenDescriptorObject for use in initiating a new scan.
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [string]$Username,

        [Parameter()]
        [string]$Password,

        [Parameter()]
        [string]$StartUrl
    )
    begin
    {
        Write-Verbose "New-WIMacroGenDescriptorObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'username' { $body.username = $Username }
            'password' { $body.password = $Password }
            'startUrl' { $body.startUrl = $StartUrl }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.MacroGenDescriptorObject
    }
}
