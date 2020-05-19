function New-WIWebFormValuesDescriptorObject
{
    <#
    .SYNOPSIS
        Create a new WebFormValuesDescriptorObject.
    .DESCRIPTION
        Create a new PS4WI.WebFormValuesDescriptorObject for use in initiating a new scan.
    .PARAMETER Enable

    .PARAMETER Name

    .PARAMETER MaxSubmitCount

    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [validateset($True, $False)]
        [switch]$Enable,

        [Parameter()]
        [string]$Name,

        [Parameter()]
        [int]$MaxSubmitCount
    )
    begin
    {
        Write-Verbose "New-WIWebFormValuesDescriptorObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'enable' {
                if ($Enable) {
                    $body.enable = $true
                } else {
                    $body.enable = $false
                }
            }
            'name'              { $body.name = $Name }
            'maxSubmitCount'    { $body.maxSubmitCount = $MaxSubmitCount }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.WebFormValuesDescriptorObject
    }
}
