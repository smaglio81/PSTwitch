function Get-TwitchUserVideo {
    [CmdletBinding()]
    param (
        [string]
        $Id = $null,

        [string]
        $UserId = $null,

        [string]
        $GameId = $null,

        [string]
        $After = $null,

        [string]
        $Before = $null,

        [int]
        [ValidateRange(1,100)]
        $First = 20,

        [ValidateSet("all","day","week","month")]
        [string]
        $Period = "all",

        [ValidateSet("time","trending","views")]
        [string]
        $Sort = "time",

        [ValidateSet("all","upload","archive","highlight")]
        [string]
        $Type = "all",

        $Token = $global:PSTwitch.Token
    )

    if([string]::IsNullOrWhiteSpace($Id) -and [string]::IsNullOrWhiteSpace($UserId) -and [string]::IsNullOrWhiteSpace($GameId)) {
        throw "Atleast one parameter much be provided: Id, UserId, or GameId"
    }

    $uri = "{0}/videos/?" -f $global:PSTwitch.Uri

    $uri = Add-UriQS -Uri $uri -Name "id" -Value $Id
    $uri = Add-UriQS -Uri $uri -Name "user_id" -Value $UserId
    $uri = Add-UriQS -Uri $uri -Name "game_id" -Value $GameId
    $uri = Add-UriQS -Uri $uri -Name "after" -Value $After
    $uri = Add-UriQS -Uri $uri -Name "before" -Value $Before
    $uri = Add-UriQS -Uri $uri -Name "first" -Value $First
    $uri = Add-UriQS -Uri $uri -Name "period" -Value $Period
    $uri = Add-UriQS -Uri $uri -Name "sort" -Value $Sort
    $uri = Add-UriQS -Uri $uri -Name "type" -Value $Type

    try {
        $results = Invoke-RestMethod -Uri $uri -Method Get -Headers $global:PSTwitch.Headers
        
        return $results
    }
    catch {
        $_
    }
}