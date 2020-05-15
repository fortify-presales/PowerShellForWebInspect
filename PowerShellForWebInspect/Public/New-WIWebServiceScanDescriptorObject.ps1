function New-WIWebServiceScanDescriptorObject
{
    [CmdletBinding()]
    [OutputType([System.Collections.Hashtable],[String])]
    param
    (
        [Parameter]
        [string]$WsdName,

        [Parameter]
        [validateset($True, $False)]
        [switch]$InheritWsdProxy,

        [Parameter]
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
