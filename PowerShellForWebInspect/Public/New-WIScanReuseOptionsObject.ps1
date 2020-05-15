function New-WIScanReuseOptionsObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [string]$ScanId,

        [Parameter()]
        [validateset('incremental', 'remediation', 'reuseCrawl')]
        [string]$Mode
    )
    begin
    {
        Write-Verbose "New-WIScanReuseOptionsObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'scanId' { $body.scanId = $ScanId }
            'mode'   { $body.mode = $Mode }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.ScanReuseOptionsObject
    }
}
