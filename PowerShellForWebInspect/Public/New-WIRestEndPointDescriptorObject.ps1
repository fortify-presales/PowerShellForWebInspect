function New-WIRestEndPointDescriptorObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter]
        [string]$Method,

        [Parameter]
        [string]$Rule,

        [Parameter]
        [string]$Type,

        [Parameter]
        [string]$Payload
    )
    begin
    {
        Write-Verbose "New-WIRestEndPointDescriptorObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'method'    { $body.method = $Method }
            'rule'      { $body.rule = $Rule }
            'type'      { $body.type = $Type }
            'payload'   { $body.payload = $Payload }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.RestEndPointDescriptorObject
    }
}
