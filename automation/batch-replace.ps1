#!/usr/bin/pwsh
# see ./batch-replace.md for more information
function Replace-Safely {
	[CmdletBinding()]
	param(
		[Parameter()]
		[string] $old
		[string] $new
		[string] $path
	)
	$path = Get-ChildItem -Path Env:\Script-TargetReplaceFile
	cd $path
	git add $path 
	git commit -m "Automatic commit before processing" # if no changes, the commit attempt will be ignored
	((Get-Content -path $path -Raw) -replace $old,$new) | Set-Content -Path $path # Replaces all occurances of "foo" with "bar"
	git add $path
	git commit -m 'Replace ' $old ' with ' $new
}

Replace-Safely -old foo -new bar -path C:\AbsolutePath\To\Notes.md
