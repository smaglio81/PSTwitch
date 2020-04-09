function Get-TwitchLiveStream {
    [CmdletBinding(DefaultParameterSetName = 'Standard')]
    param (
        [Parameter(Mandatory,
            ParameterSetName = 'Standard')]
        $UserName,

        [Parameter(Mandatory,
            ParameterSetName = 'Pipeline',
            ValueFromPipeline,
            ValueFromPipelineByPropertyName)]
        [psobject]
        $InputObject,

        $Token = $global:PSTwitch.Token
    )

    process {

        if ($PSCmdlet.ParameterSetName -eq 'Pipeline') {
            foreach ($user in $InputObject) {
                $streamsUri = "{0}/streams?user_login={1}" -f $global:PSTwitch.Uri, $user.UserName

                $streamsResults = Invoke-RestMethod -Uri $streamsUri -Headers $global:PSTwitch.Headers

                if ($streamsResults.data) {
                    [PSCustomObject]@{
                        UserName    = $streamsResults.data.user_name
                        StreamTitle = $streamsResults.data.title
                        ViewerCount = $streamsResults.data.viewer_count
                        StartedAt   = $streamsResults.data.started_at
                    }
                }
                else {
                    "No Live Stream Available"
                }
            }
        }
        else {
            $streamsUri = "{0}/streams?user_login={1}" -f $global:PSTwitch.Uri, $UserName
            $streamsResults = Invoke-RestMethod -Uri $streamsUri -Headers $global:PSTwitch.Headers

            if ($streamsResults.data) {
                [PSCustomObject]@{
                    UserName    = $streamsResults.data.user_name
                    StreamTitle = $streamsResults.data.title
                    ViewerCount = $streamsResults.data.viewer_count
                    StartedAt   = $streamsResults.data.started_at
                }
            }
            else {
                "No Live Stream Available"
            }
        }
    }
}