function Get-WIScans {
    <#
    .SYNOPSIS
        Gets scans from WebInspect API.
    .DESCRIPTION
        Get scans from WebInspect API.
    .PARAMETER Name
        Filter scans by scan name.
        This value is treated as a regular expression.
    .PARAMETER Status
        Filter scans by status.
    .PARAMETER StartsAfter
        Filter scans by start date/time.
        The expected format is YYYY-MM-DDTHH:MM:SS
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
        Default value is the value set by Set-WIConfig
    .EXAMPLE
        # Get all of the scans with status 'Complete' and name 'test'
        Get-WIScans -Status "complete" -Name 'test'
    .LINK
        http://localhost:8083/webinspect/swagger/ui/index#!/Scanner/Scanner_GetScans
    .FUNCTIONALITY
        WebInspect
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Name,

        [Parameter()]
        [ValidateSet('complete', 'running', 'interrupted', 'notRunning', 'unknown')]
        [string]$Status,

        [Parameter()]
        [string]$StartsAfter,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$ApiUri = $Script:PS4WI.ApiUri,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$AuthMethod = $Script:PS4WI.AuthMethod,

        [Parameter()]
        [System.Management.Automation.PSCredential]
        [System.Management.Automation.Credential()]
        [ValidateNotNullOrEmpty()]
        $Credential = $Script:PS4WI.Credential,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$Proxy = $Script:PS4WI.Proxy,

        [switch]$ForceVerbose = $Script:PS4WI.ForceVerbose
    )
    begin
    {
        $Params = @{}
        if ($ApiUri)        { $Params['ApiUri'] = $ApiUri }
        if ($AuthMethod)    { $Params['AuthMethod'] = $AuthMethod }
        if ($Credential)    { $Params['Credential'] = $Credential }
        if ($Proxy)         { $Params['Proxy'] = $Proxy }
        if ($ForceVerbose) {
            $Params.Add('ForceVerbose', $True)
            $VerbosePreference = "Continue"
        }
        Write-Verbose "Get-WIScans Bound Parameters: $( $PSBoundParameters | Remove-SensitiveData | Out-String )"
        $Body = @{}
        if ($Name) {
            $Body.Add("name", $Name)
        }
        if ($Status) {
            $Body.Add("status", $Status)
        }
        if ($StartsAfter) {
            $Body.Add("startsAfter", $StartsAfter)
        }
        if ($Body.Count -gt 0) {
            $Params.Add('Body', $Body)
        }
    }
    process
    {
        Write-Verbose "Send-WIApi -Method Get -Operation '/scanner/scans'" #$Params
        $Response = Send-WIApi -Method Get -Operation "/scanner/scans" @Params
    }
    end {
        $Response
    }
}
