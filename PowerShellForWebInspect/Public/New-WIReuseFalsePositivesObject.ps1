function New-WIReuseFalsePositivesObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter]
        [string[]]$ScanIds
    )
    begin
    {
        Write-Verbose "New-WIReuseFalsePositivesObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{}

        switch ($psboundparameters.keys) {
            'scanIds' { $body.scanIds = $ScanIds }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.ReuseFalsePositivesObject
    }
}
