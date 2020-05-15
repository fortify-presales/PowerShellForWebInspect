function New-WIServerTechnologyDescriptorObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter]
        [string]$Url,

        [Parameter]
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
