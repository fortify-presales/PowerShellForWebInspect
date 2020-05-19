function New-WIKnownTechnologyDescriptorObject
{
    <#
    .SYNOPSIS
        Create a new KnownTechnologyDescriptorObject.
    .DESCRIPTION
        Create a new PS4WI.KnownTechnologyDescriptorObject for use in initiating a new scan.
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [validateset('none', 'webSpherePortal', 'oracleADFFaces')]
        [string]$Framework,

        [Parameter(Mandatory = $false,
                ValueFromPipeline = $true)]
        [PSTypeName('PS4WI.ServerTechnologyDescriptorObject')]
        $HostsInfo
    )
    begin
    {
        $AllHostsInfos = @()
        Write-Verbose "New-WIKnownTechnologyDescriptorObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {
        foreach ($HostInfo in $HostsInfo) {
            $AllHostsInfos += $HostInfo
        }
    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'framework' { $body.framework = $Framework }
            'hostsInfo' { $body.hostsInfo = @($AllHostsInfos) }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.KnownTechnologyDescriptorObject
    }
}
