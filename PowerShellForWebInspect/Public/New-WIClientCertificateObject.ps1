function New-WIClientCertificateObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter]
        [string]$StoreName,

        [Parameter]
        [validateset($True, $False)]
        [switch]$IsGlobal,

        [Parameter]
        [string]$SerialNumber,

        [Parameter]
        [string]$Bytes
    )
    begin
    {
        Write-Verbose "New-WIClientCertificateObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'storeName'     { $body.storeName = $StoreName }
            'isGlobal'      {
                if ($IsGlobal) {
                    $body.isGlobal = $true
                } else {
                    $body.isGlobal = $false
                }
            }
            'serialNumber'  { $body.serialNumber  = $SerialNumber }
            'bytes'         { $body.bytes = $Bytes }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.ClientCertificateObject
    }
}
