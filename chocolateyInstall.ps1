$packageName = 'terapad'
$version = '1.09'
$url = 'https://tera-net.com/dl/tpad/tpad109.exe'

try {
  $fileName = "${packageName}_${version}"
  $filePath = "$env:TEMP\chocolatey\$packageName"
  $fileFullPath = "$filePath\${fileName}.exe"
  
  $scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
  $ahkFile = "$scriptPath\terapad.ahk"
  
  New-Item $filePath -Force -ItemType Directory
  Get-ChocolateyWebFile $packageName $fileFullPath $url
  
  Start-Process 'AutoHotkey' $ahkFile
  Start-Process $fileFullPath
  
  Wait-Process -Name $fileName
  
  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}