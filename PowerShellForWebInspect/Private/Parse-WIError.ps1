function Parse-WIError
{
    [CmdletBinding()]
    param (
        # The response object from WI's API.
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [Object]$ResponseObject,

        # The exception from Invoke-RestMethod, if available.
        [Exception]$Exception
    )

    begin {
        $WIErrorData = @{
        # Messages are adapted from WI API documentation

            # TODO: add some more

            # TODO: other messages by error code

            "1000" = @{
                Message = "Authorization failure - has authentication token been created?"
                RecommendedAction = "Please try re-creating a token using Get-WIToken"
            }
        }
    }

    process {
        $ErrorParams = $null
        if ($ResponseObject.ok) {
            # We weren't actually given an error in this case
            Write-Debug "Parse-WIError: Received non-error response, skipping."
            return
        }
        if ($ResponseObject.error) {
            $ErrorParams = $WIErrorData[$ResponseObject.error]
        } elseif ($ResponseObject.errorCode) {
            $ErrorParams = $WIErrorData[$ResponseObject.errorCode]
        }
        if ($ErrorParams -eq $null) {
            $ErrorParams = @{
                Message = "Unknown error received from WI API."
            }
        }
        if ($Exception) {
            $ErrorParams.Exception = $Exception
        }

        Write-Error -ErrorId $ResponseObject.error @ErrorParams
    }

    end {
    }
}
