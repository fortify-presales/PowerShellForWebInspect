function Get-WIConfigPath
{
    [CmdletBinding()]
    param()

    end
    {
        if (Test-IsWindows)
        {
            Join-Path -Path $env:TEMP -ChildPath "$env:USERNAME-$env:COMPUTERNAME-PS4WI.xml"
        }
        else
        {
            Join-Path -Path $env:HOME -ChildPath '.ps4fod' # Leading . and no file extension to be Unixy.
        }
    }
}
