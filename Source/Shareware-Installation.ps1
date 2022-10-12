# Install Winget software by Cliff Y. Zhu
# 
param(
    [Parameter(Mandatory)]
    [string]$Action,
    [Parameter(Mandatory)]
     [string]$AppName,
     [Parameter()]
     [string]$AppSource = "winget"
 )
 if (test-path -Path "c:\Windows\logs\SharewareInstall"){"The folder exists."}else {mkdir c:\Windows\logs\SharewareInstall}
 $nativeAppFilePath = Get-ChildItem "C:\Program Files\WindowsApps" -Recurse -File | Where-Object name -like winget.exe | Select-Object -ExpandProperty fullname | Select-Object -Last 1
 if($nativeAppFilePath.length -lt 10){
     "Winget.exe Not Found" | Out-File "c:\Windows\logs\SharewareInstall\ShareWareInstallation-error.log" -append
     Write-Error -Message "Winget not found." -Category OperationStopped
     exit}
switch ($Action){
    "install"{
    try{$response = &"$nativeAppFilePath" install $appname -s $appsource --accept-source-agreements --accept-package-agreements --force}
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