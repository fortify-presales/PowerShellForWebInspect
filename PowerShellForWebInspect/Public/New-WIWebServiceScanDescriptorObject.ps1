function New-WIWebServiceScanDescriptorObject
{
    <#
    .SYNOPSIS
        Create a new WebServiceScanDescriptorObject.
    .DESCRIPTION
        Create a new PS4WI.WebServiceScanDescriptorObject for use in initiating a new scan.
        Allows to configure SOAP Web Service Scan.
    .PARAMETER WsdName
        Webservice Test Design File name.
    .PARAMETER InheritWsdProxy
        Use Webservice Test Design File proxy settings
    .PARAMETER InheritWsdAuth
        Ue Webservice Test Design File network authentication settings
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter()]
        [string]$WsdName,

        [Parameter()]
        [validateset($True, $False)]
        [switch]$InheritWsdProxy,

        [Parameter()]
        [validateset($True, $False)]
        [switch]$InheritWsdAuth
    )
    begin
    {
        Write-Verbose "New-WIUserAgentDescriptorObject Bound Parameters:  $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {

    }
    end
    {
        $body = @{ }

        switch ($psboundparameters.keys)
        {
            'wsdName' { $body.wsdName  = $WsdName }
            'inheritWsdProxy' {
                if ($InheritWsdProxy) {
                    $body.inheritWsdProxy = $true
                } else {
                    $body.inheritWsdProxy = $false
                }
            }
            'inheritWsdAuth' {
                if ($InheritWsdAuth) {
                    $body.inheritWsdAuth  = $true
                } else {
                    $body.inheritWsdAuth  = $false
                }
            }
        }

        Add-ObjectDetail -InputObject $body -TypeName PS4WI.WebServiceScanDescriptorObject
    }
}
