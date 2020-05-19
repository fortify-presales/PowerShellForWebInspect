function New-WIReuseFalsePositivesObject
{
    <#
    .SYNOPSIS
        Create a new ReuseFalsePositives object.
    .DESCRIPTION
        Create a new PS4WI.ReuseFalsePositives for use in initiating a new scan.
        Allows you to specify an array of ScanIDs to import the false positives from scans (containing vulnerabilities)
        that were changed to false positives. If those false positives match vulnerabilities detected in this scan,
        the vulnerabilities will be changed to false positives.
    .PARAMETER ScanIds
        Array of ScanIDS to import false positives from.
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
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
