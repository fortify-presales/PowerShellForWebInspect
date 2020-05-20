function Send-WIApi {
    <#
    .SYNOPSIS
        Send a request to the Webinspect REST API.
    .DESCRIPTION
        Send a request to the WebInspect REST API.
        This function is used by other PS4WI functions.
        It's a simple wrapper you could use for calls to the WebInspect API.
    .PARAMETER Method
        REST API Method (Get, Post, Put, Delete ...).
        Defaults to Get.
    .PARAMETER Operation
        WebInspect API Operation to call, e.g. /scanner/scans, this will be appended to $ApiUri
    .PARAMETER Body
        Hash table of arguments to send to the WebInspect API.
    .PARAMETER BodyFile
        A File containing the Body to be sent to the WebInspect API.
    .PARAMETER OutFile
        The full path to a file to write the output to.
    .PARAMETER ContentType
        Content Type to send, if not specified defaults to "application/json".
    .PARAMETER ApiUri
        WebInspect API Uri to use, e.g. http://localhost:8083.
        If empty, the value from PS4WI will be used.
    .PARAMETER AuthMethod
        WebInspect API Authentication Method to use.
        If empty, the value from PS4WI will be used.
    .PARAMETER Credential
        A previously created Credential object to be used.
    .PARAMETER Proxy
        Proxy server to use.
        If empty, the value from PS4WI will be used.
    .PARAMETER ForceVerbose
        If specified, don't explicitly remove verbose output from Invoke-RestMethod
        *** WARNING ***
        This will expose your data in verbose output.
    .EXAMPLE
        # Get a list of completed scans with the word "test" in their name
        $Body = @{
            name = test
            status = complete
        }
        Send-WIApi -Operation "/scanner/scans" -Body $Body -ForceVerbose
    .FUNCTIONALITY
        WebInspect.
    #>
    [OutputType([String])]
    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [ValidateSet('Get', 'Post', 'Put', 'Delete', 'Patch')]
        [string]$Method,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Operation,

        [ValidateNotNullOrEmpty()]
        [hashtable]$Body,

        [Parameter(Mandatory=$false)]
        [string]$BodyFile,

        [Parameter(Mandatory=$false)]
        [string]$OutFile,

        [Parameter(Mandatory=$false)]
        [string]$ContentType = 'application/json',

        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            if (-not $_ -and -not $Script:PS4WI.ApiUri) {
                throw 'Please supply a WebInspect Api Uri with Set-WIConfig.'
            } else {
                $true
            }
        })]
        [string]$ApiUri = $Script:PS4WI.ApiUri,

        [Parameter()]
        [ValidateSet('None', 'Basic', 'Windows', 'ClientCertificate')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            if (-not $_ -and -not $Script:PS4WI.AuthMethod) {
                throw 'Please supply a WebInspect AuthMethod with Set-WIConfig.'
            } else {
                $true
            }
        })]
        [string]$AuthMethod = $Script:PS4WI.AuthMethod,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({
            if (-not $_ -and -not $Script:PS4WI.Credential) {
                throw 'Please specify a Credential object or store a Credential object with Set-WIConfig.'
            } else {
                $true
            }
        })]
        $Credential = $Script:PS4WI.Credential,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Proxy = $Script:PS4WI.Proxy,

        [switch]$ForceVerbose = $Script:PS4WI.ForceVerbose

    )
    begin
    {
        $Params = @{
            Uri = "$ApiUri$Operation"
            ErrorAction = 'Stop'
        }
        if (-not $Method) {
            $Method = 'Get'
        }
        if ($Method -eq 'Get') {
            $Params.Add('Method', 'Get')
            $Params.Add('Body', $Body)
        } elseif ($BodyFile) {
            Write-Verbose "BodyFile is $BodyFile"
            $Params.Add('Method', $Method)
            $Params.Add('ContentType', 'application/json')
            $Params.Add('InFile', $BodyFile)
        } else {
            $Params.Add('Method', $Method)
            $Params.Add('ContentType', 'application/json')
            $Params.add('Body', (ConvertTo-Json -Depth 5 $Body))
        }
        if ($OutFile) {
            Write-Verbose "OutFile is $OutFile"
            $Params.Add('OutFile', $OutFile)
        }
        if ($Proxy) {
            $Params['Proxy'] = $Proxy
        }
        if ($ForceVerbose) {
            $Params.Add('Verbose', $True)
            $VerbosePreference = "Continue"
        }
        $Headers = @{
            'Accept' = "application/json"
        }
        if ($AuthMethod -eq "None") {
            Write-Verbose "Using 'None' for Authentication Method"
        } elseif ($AuthMethod -eq "Windows") {
            Write-Verbose "Using 'Windows' (as current user) for Authentication Method"
            $Params.add("UseDefaultCredentials", $true)
        } elseif ($AuthMethod -eq "Basic") {
            if (!$Credential) {
                throw "A Credential object is required for AuthMethod: $AuthMethod"
            }
            $UserName = $Credential.UserName
            Write-Verbose "Using 'Basic' (as $UserName) for Authentication Method"
            $Password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($Credential.Password))
            $CredPair = "$($UserName):$($Password)"
            $EncodedCredentials = [System.Convert]::ToBase64String([System.Text.Encoding]::ASCII.GetBytes($credPair))
            $Headers.Add('Authorization', "Basic $EncodedCredentials")
        } elseif ($AuthMethod -eq "ClientCertificate") {
            Write-Error "ClientCertificate Authentication Method is not yet supported"
            Exit
        } else {
            throw "Unsupported Authentication Method: $AuthMethod"
        }
        Write-Verbose "Send-WIApi Bound Parameters: $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
    }
    process
    {
        $Response = $null
        try
        {
            if ($Body) {
                Write-Verbose "JSON Payload:"
                Write-Verbose (ConvertTo-Json -Depth 4 $Body | % { [regex]::Unescape($_) })
            }
            $Response = Invoke-RestMethod -Headers $Headers @Params
        } catch {
            Write-Error -Exception $_.Exception -Message "WebInspect API call failed: $_"
        }
    }
    end
    {
        if ($Response) {
            Write-Output $Response
        } else {
            Write-Verbose "Response is empty."
        }
    }
}
