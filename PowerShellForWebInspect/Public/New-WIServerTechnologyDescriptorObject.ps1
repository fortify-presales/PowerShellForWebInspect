function New-WIServerTechnologyDescriptorObject
{
    <#
    .SYNOPSIS
        Create a new ServerTechnologyDescriptor object.
    .DESCRIPTION
        Create a new PS4WI.ServerTechnologyDescriptor for use in initiating a new scan.
    .PARAMETER Url
        The Url of the server.
    .PARAMETER ServerTypeIds
        List of server type ids.
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [string]$Url,

        [Parameter()]
        [int[]]$ServerTypeIds
    )
    begin
    {
        Write-Verbose "New-WIServerTechnologyDescriptorObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'url'           { $body.url = $Url }
            'serverTypeIDs' { $body.serverTypeIDs  = $ServerTypeIds }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.ServerTechnologyDescriptorObject
    }
}
