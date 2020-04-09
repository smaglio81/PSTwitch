function Get-TwitchUser {
    param (
        [string]
        $UserName,

        $Token = $global:PSTwitch.Token
    )

    $usersUri = "{0}/users/?login={1}" -f $global:PSTwitch.Uri, $UserName

    try {
        Invoke-RestMethod -Uri $usersUri -Method Get -Headers $global:PSTwitch.Headers |
            Select-Object -ExpandProperty Data | ForEach-Object {
                [PSCustomObject]@{
                    UserId      = $_.id
                    UserName    = $_.display_name
                    Description = $_.description
                    ViewCount   = $_.view_count
                }
            }
    }
    catch {
        $_
    }
}