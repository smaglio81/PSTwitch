# http://stackoverflow.com/questions/1183183/path-of-currently-executing-powershell-script
$root = Split-Path $MyInvocation.MyCommand.Path -Parent;

# grab functions from files (from C:\Chocolatey\chocolateyinstall\helpers\chocolateyInstaller.psm1)
$privateFiles = dir -Path $root\private -Recurse -Include *.ps1 -ErrorAction SilentlyContinue
$publicFiles = dir -Path $root\public -Recurse -Include *.ps1 -ErrorAction SilentlyContinue

if(@($privateFiles).Count -gt 0) { $privateFiles.FullName |% { . $_; } }
if(@($publicFiles).Count -gt 0) { $publicFiles.FullName |% { . $_; } }

$publicFuncs = $publicFiles |% { $_.Name.Substring(0, $_.Name.Length - 4) }
Export-ModuleMember -Function $publicFuncs

# setup namespaced domain variabless
if($global:PSTwitch -eq $null) {
    $global:PSTwitch = @{};
}

$ExecutionContext.SessionState.Module.OnRemove += {
    Remove-Variable -Name PSTwitch -Scope global
}
