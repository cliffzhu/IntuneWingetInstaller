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
 if (test-path -Path "$env:SystemRoot\logs\SharewareInstall"){"The folder exists."}else {mkdir "$env:SystemRoot\logs\SharewareInstall"}
 $nativeAppFilePath = Get-ChildItem "$env:ProgramFiles\WindowsApps" -Recurse -File | Where-Object name -like winget.exe | Select-Object -ExpandProperty fullname | Select-Object -Last 1
 if($nativeAppFilePath.length -lt 10){
 $nativeAppFilePath = Get-ChildItem "${env:ProgramW6432}\WindowsApps" -Recurse -File | Where-Object name -like winget.exe | Select-Object -ExpandProperty fullname | Select-Object -Last 1
}
 if($nativeAppFilePath.length -lt 10){
     "Winget.exe Not Found" | Out-File "$env:SystemRoot\logs\SharewareInstall\ShareWareInstallation-error.log" -append
     Write-Error -Message "Winget not found." -Category OperationStopped
     exit}
switch ($Action){
    "install"{
    try{$response = &"$nativeAppFilePath" install $appname -s $appsource --accept-source-agreements --accept-package-agreements --force}
    catch{
        "Error happened during installation $appname." | Out-File "$env:SystemRoot\logs\SharewareInstall\ShareWareInstallation-error.log" -append 
        Write-Error -Message "Error happened during installation $appname." -Category OperationStopped
    }}
    "uninstall"{
    try{$response = &"$nativeAppFilePath" uninstall $appname -s $appsource --accept-source-agreements --accept-package-agreements --force}
    catch{
        "Error happened during uninstall $appname." | Out-File "$env:SystemRoot\logs\SharewareInstall\ShareWareInstallation-error.log" -append 
        Write-Error -Message "Error happened during uninstall $appname." -Category OperationStopped
    }}
    "upgrade"{
    try{
        if($appname -eq "all"){
            $response = &"$nativeAppFilePath" upgrade --$appname --silent -s $appsource --accept-source-agreements --accept-package-agreements --force}
        else{
        $response = &"$nativeAppFilePath" upgrade $appname --silent -s $appsource --accept-source-agreements --accept-package-agreements --force}
        }
        catch{
        "Error happened during upgrad $appname." | Out-File "$env:SystemRoot\logs\SharewareInstall\ShareWareInstallation-error.log" -append 
        Write-Error -Message "Error happened during upgrad $appname." -Category OperationStopped
    }}
}

if ($response -like "Successfully installed"){$response | Out-File "$env:SystemRoot\logs\SharewareInstall\$appname.log" -force}else
{$response | Out-File "$env:SystemRoot\logs\SharewareInstall\ShareWareInstallation-error.log" -Append
Write-Error -Message "Error happened during installation." -Category OperationStopped}

