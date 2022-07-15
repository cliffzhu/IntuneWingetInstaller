# IntuneWingetInstaller
It uses Winget.exe to install public released software like Adobe Reader, 7-Zip, VLC player etc for Intune MDM Endpoint Manager

 1. Find the correct application name by "winget search 7-zip". you might find multiple results.
 2. Uploade the Shareware-Installation.intunewin to Intune console as Win32 application
 3. Use installation command as below:
powershell -executionpolicy bypass -file Shareware-Installation.ps1 "install" "7-zip"
 4. Use unistallation command as below:
powershell -executionpolicy bypass -file Shareware-Installation.ps1 "uninstall" "7-zip"
