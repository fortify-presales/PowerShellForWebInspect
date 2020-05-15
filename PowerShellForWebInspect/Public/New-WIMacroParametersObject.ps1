function New-WIMacroParametersObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]$MacroName,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.MacroParameterObject')]
        [System.Collections.Hashtable[]]
        $MacroParameters
    )
    begin
    {
        Write-Verbose "New-WIMacroParametersObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {
        foreach ($MacroParameter in $MacroParameters) {
            $AllMacroParameters += $MacroParameter
        }
    }
    end
    {
        $body = @{
            $MacroName = $AllMacroParameters
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.MacroParametersObject
    }
}
