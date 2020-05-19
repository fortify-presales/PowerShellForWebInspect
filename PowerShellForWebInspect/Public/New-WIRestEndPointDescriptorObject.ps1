function New-WIRestEndPointDescriptorObject
{
    <#
    .SYNOPSIS
        Create a new RestEndPointDescriptorObject.
    .DESCRIPTION
        Create a new PS4WI.RestEndPointDescriptorObject for use in initiating a new scan.
    .PARAMETER Method
        The REST endpoint method.
    .PARAMETER Rule
        The REST endpoint rule.
    .PARAMETER Type
        The REST endpoint type.
    .PARAMETER Payload
        The REST endpoint payload.
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [string]$Method,

        [Parameter()]
        [string]$Rule,

        [Parameter()]
        [string]$Type,

        [Parameter()]
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
