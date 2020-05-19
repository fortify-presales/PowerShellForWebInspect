function New-WIMacroParameterObject
{
    <#
    .SYNOPSIS
        Create a new MacroParameterObject.
    .DESCRIPTION
        Create a new PS4WI.MacroParameterObject for use in initiating a new scan.
    .PARAMETER Name
        The name of the parameter.
    .PARAMETER Value
        The value of of the parameter.
    .EXAMPLE
        $param1 = New-WIMacroParameterObject -Name "username" -Value "user"
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [string]$Name,

        [Parameter()]
        [string]$Value
    )
    begin
    {
        Write-Verbose "New-WIMacroParameterObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{
            $Name = $Value
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.MacroParameterObject
    }
}
