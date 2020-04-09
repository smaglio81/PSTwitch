function Set-TwitchConfiguration {
    [CmdletBinding()]
    param (
        [string]
        $Token
    )

    $global:PSTwitch.Token = $Token
    $global:PSTwitch.Uri = "https://api.twitch.tv/helix"
    $global:PSTwitch.Headers = @{"Client-ID" = $Token}
}