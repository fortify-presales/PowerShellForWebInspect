function Remove-SensitiveData
{
    param (
        [parameter(ValueFromPipeline = $True)]
        $InputObject,
        $SensitiveProperties = @('ApiUri', 'AuthMethod', 'Credential'),
        $ForceVerbose = $Script:PS4WI.ForceVerbose
    )
    process {
        if ($ForceVerbose)
        {
            return $InputObject
        }
        if ($InputObject -is [hashtable] -or ($InputObject.Keys.Count -gt 0 -and $InputObject.Values.Count -gt 0))
        {
            $Output = [hashtable]$($InputObject.PSObject.Copy() )
            foreach ($Prop in $SensitiveProperties)
            {
                if ( $InputObject.ContainsKey($Prop))
                {
                    $Output[$Prop] = 'REDACTED'
                }
            }
            $Output
        }
        else
        {
            $InputObject | Select-Object -Property * -ExcludeProperty $SensitiveProperties
        }
    }
}
