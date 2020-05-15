function New-WIMacroParameterObject
{
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
