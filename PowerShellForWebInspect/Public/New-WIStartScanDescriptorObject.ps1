function New-WIStartScanDescriptorObject
{
    <#
    .SYNOPSIS
        Create a new StartScanDescriptorObject.
    .DESCRIPTION
        Create a new PS4WI.StartScanDescriptorObject for use in initiating a new scan.
    .PARAMETER SettingsName
        The name of a settings file that exists in the WebInspect scan settings folder.
        Optional overrides (set via "ScanOverrides") provide a way to make changes to certain fields in the
        referenced scan settings file.
    .PARAMETER NewSettingsName
        The new settings name to create.
    .PARAMETER ScanOverrides
        A ScanSettingsOverridesObject containing the settings of the scan.
    .PARAMETER ReuseScan
        A ScanReuseOptionsObject containing a Scan ID to reuse.
    .PARAMETER ReuseFP
        A ReuseFalsePositivesObject containing Scan IDs to import false positives from.
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter(Mandatory = $true)]
        [string]$SettingsName,

        [Parameter(Mandatory = $false)]
        [string]$NewSettingsName,

        [Parameter(Mandatory = $false,
            ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.ScanSettingsOverrideObject')]
        $ScanOverrides,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.ScanReuseOptionsObject')]
        $ReuseScan,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.ReuseFalsePositivesObject')]
        $ReuseFP
    )
    begin
    {
        Write-Verbose "New-WIStartScanDescriptorObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{}

        switch ($psboundparameters.keys) {
            'settingsName'      { $body.settingsName = $SettingsName }
            'newSettingsName'   { $body.newSettingsName = $NewSettingsName }
            'scanOverrides'     { $body.overrides = $ScanOverrides }
            'reuseScan'         { $body.reuseScan = $ReuseScan }
            'reuseFP'           { $body.reuseFP = $ReuseFP }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.StartScanDescriptorObject
    }
}
