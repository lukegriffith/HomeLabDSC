
gci $PSScriptRoot\Configurations -Filter *ps1 | ForEach-Object -Process {
    
    . $_.FullName
}