# IntuneWingetInstaller

Why IntuneWingetInstaller? You don't need to package applications one by one, just use parameters to install what you want.

It uses Winget.exe to install public released software like Adobe Reader, 7-Zip, VLC player etc for Microsoft Intune MDM Endpoint Manager.

 1. Find the correct application name by winget search. For example "winget search 7-zip". you might find multiple results.
 2. Uploade the Shareware-Installation.intunewin to Intune console as Win32 application
 3. Use installation command as below:
powershell -executionpolicy bypass -file Shareware-Installation.ps1 "install" "7-zip"
 4. Use unistallation command as below:
powershell -executionpolicy bypass -file Shareware-Installation.ps1 "uninstall" "7-zip"

**Note:** With Microsoft Windows 10/11 clean OS installation, Winget.exe is not available during OOBE/Enrollment stage so the script might fail. Using the script for on-demand apps or user assigned apps is recommended.
