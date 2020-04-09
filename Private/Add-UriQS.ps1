function Add-UriQS {
	param(
		[string]
		$Uri,

		[string]
		$Name,

		[string]
		$Value
	)

	if([string]::IsNullOrWhitespace($Name)) { return $Uri; }
	if([string]::IsNullOrWhitespace($Value)) { return $Uri; }

	if($Uri -notmatch "\?") {
		$Uri += "?"
	} else {
		if($Uri.EndsWith("?") -eq $false) {
			$Uri += "&"
		}
	}

	$Uri += "$Name=$Value"
	
	return $Uri
}