function New-WIStartScanDescriptorObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter(Mandatory)]
        [string]$SettingsName,

        [Parameter()]
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
