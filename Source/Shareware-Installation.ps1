# Install Winget software script by Cliff Y. Zhu
# 2022-09-07
# Example: powershell -executionpolicy bypass -file Shareware-Installation.ps1 "install" "7-zip"
param(
    [Parameter(Mandatory)]
    [string]$Action,
    [Parameter(Mandatory)]
     [string]$AppName,
     [Parameter()]
     [string]$AppSource = "winget"
 )
 if (test-path -Path "c:\Windows\logs\SharewareInstall"){"The folder exists."}else {mkdir c:\Windows\logs\SharewareInstall}
 $nativeAppFilePath = Get-ChildItem "C:\Program Files\WindowsApps" -Recurse -File | Where-Object name -like winget.exe | Select-Object -ExpandProperty fullname
 if($nativeAppFilePath.length -lt 10){
     "Winget.exe Not Found" | Out-File "c:\Windows\logs\SharewareInstall\ShareWareInstallation-error.log" -append
     Write-Error -Message "Winget not found." -Category OperationStopped
     exit 1}
switch ($Action){
    "install"{
    try{$response = &"$nativeAppFilePath" install $appname -s $appsource --accept-source-agreements --accept-package-agreements}
    catch{
        "Error happened. $nativeAppFilePath" | Out-File "c:\Windows\logs\SharewareInstall\ShareWareInstallation-error.log" -append 
        Write-Error -Message "Error happened during installation." -Category OperationStopped
    }}
    "uninstall"{
    try{$response = &"$nativeAppFilePath" uninstall $appname}
    catch{
        "Error happened. $nativeAppFilePath" | Out-File "c:\Windows\logs\SharewareInstall\ShareWareInstallation-error.log" -append 
        Write-Error -Message "Error happened during installation." -Category OperationStopped
    }}
}

if ($response -like "Successfully installed"){$response | Out-File "c:\Windows\logs\SharewareInstall\$appname.log" -force}else
{$response | Out-File "c:\Windows\logs\SharewareInstall\ShareWareInstallation-error.log" -Append
Write-Error -Message "Error happened during installation." -Category OperationStopped}
