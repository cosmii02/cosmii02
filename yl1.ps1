# Tuvastame PowerShelli versiooni ja salvestame tulemused tekstifaili
Get-Host > "$env:userprofile\Desktop\Ülesanne01.txt"

# Tuvastame ketaste info ja salvestame tulemused tekstifaili lõppu
Get-Disk >> "$env:userprofile\Desktop\Ülesanne01.txt"

# Väljastame faili sisu, et veenduda, et nii versioon kui ketaste info on olemas
Get-Content "$env:userprofile\Desktop\Ülesanne01.txt"
