function fortune {
       [System.IO.File]::ReadAllText('C:/fortune.txt') -replace "
", "
" -split "
%
" | Get-Random
}
fortune; echo ''

Set-Location C:\Users\cosmiitest\Desktop

