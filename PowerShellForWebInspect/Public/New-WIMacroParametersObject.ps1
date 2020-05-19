function New-WIMacroParametersObject
{
    <#
    .SYNOPSIS
        Create a new MacroParametersObject.
    .DESCRIPTION
        Create a new PS4WI.MacroParametersObject for use in initiating a new scan.
    .PARAMETER MacroName
        The name of the macro.
    .PARAMETER MacroParameters
        The parameters and values that will be passed to the macro.
    .EXAMPLE
        New-WIMacroParametersObject -MacroName tcLogin -MacroParameters $macroParams
    .FUNCTIONALITY
        WebInspect
    #>
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
