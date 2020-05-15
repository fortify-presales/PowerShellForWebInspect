# using module .\PowerShellForWebInspect\Class\PowerShellForWebInspect.Class1.psm1
# Above needs to remain the first line to import Classes
# remove the comment when using classes

# requires -Version 2
# Get public and private function definition files.
$Public = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -Recurse -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Recurse -ErrorAction SilentlyContinue )

# Dot source the files
Foreach ($import in @($Public + $Private)) {
    Try {
        . $import.fullname
    }
    Catch {
        Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}

# Create / Read config
$script:_PS4WIXmlpath = Get-WIConfigPath
if(-not (Test-Path -Path $script:_PS4WIXmlpath -ErrorAction SilentlyContinue))
{
    Try
    {
        Write-Warning "Did not find config file $($script:_PS4WIXmlpath), attempting to create"
        [PSCustomObject]@{
            ApiUri = $null
            AuthMethod = "None"
            Credential = $null
            Proxy = $null
            ForceVerbose = $False
        } | Export-Clixml -Path $($script:_PS4WIXmlpath) -Force -ErrorAction Stop
    }
    Catch
    {
        Write-Warning "Failed to create config file $($script:_PS4WIXmlpath): $_"
    }
}

# Initialize the config variable.
Try
{
    # Import the config
    $PS4WI = $null
    $PS4WI = Get-WIConfig -Source PS4WI.xml -ErrorAction Stop
}
Catch
{
    Write-Warning "Error importing PS4WI config: $_"
}

[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
Export-ModuleMember -Function $Public.Basename
