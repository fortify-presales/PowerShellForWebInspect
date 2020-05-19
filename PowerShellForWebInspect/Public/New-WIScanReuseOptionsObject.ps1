function New-WIScanReuseOptionsObject
{
    <#
    .SYNOPSIS
        Create a new ScanReuseOptionsObject.
    .DESCRIPTION
        Create a new PS4WI.ScanReuseOptionsObject for use in initiating a new scan.
    .PARAMETER ScanId
        A GUID representing an existing scan ID. The scan referenced by the "ReuseScan" parameter is used as a
        baseline.
    .PARAMETER Mode
        The "Mode" parameter determines the manner in which the baseline scan is reused.
    .FUNCTIONALITY
        WebInspect
    #>
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
