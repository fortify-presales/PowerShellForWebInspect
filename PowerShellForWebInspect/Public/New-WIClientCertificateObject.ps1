function New-WIClientCertificateObject
{
    <#
    .SYNOPSIS
        Create a new ClientCertificateObject.
    .DESCRIPTION
        Create a new PS4WI.ClientCertificateObject for use in initiating a new scan.
    .PARAMETER StoreName
        The system store name where the certificate is located.
        The predefined systems stores are: MY, Root, Trust, CA.
    .PARAMETER IsGlobal
        If true, look for "StoreName" in the Local Machine machine hive. Otherwise look for
        "StoreName" in the Current User hive.
    .PARAMETER SerialNumber
        The serial number that uniquely identifies the client certificate.
    .PARAMETER Bytes
        If you want to embed the client certificate, use this field.  the raw client certificate bytes in base64
        encoded format. If this field is set then the values of "IsGlobal", "StoreName" and "SerialNumber"
        are ignored.
        Caution! When using the "Bytes" option, the client certificate is embedded in the scan settings and may be
        visible to other users.
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [string]$StoreName,

        [Parameter()]
        [validateset($True, $False)]
        [switch]$IsGlobal,

        [Parameter()]
        [string]$SerialNumber,

        [Parameter()]
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
