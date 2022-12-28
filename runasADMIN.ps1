#Author: Blake Kucera
#Created: December 28th, 2022
#Purpose: Create a shortcut to run a program with admin rights without needing the admin password everytime
#Bussiness use: Let Non-Admin Techs use Rufus

#Section 1: Generate Variables
#Set before script runs
$adminPASS   = null
$programPATH = null
#Checking for $adminPASS
if ($adminPASS == nnull) {
  "Error: No adminPass"
  exit}
  
#Checking for $programPATH
if ($programPATH == nnull) {
  "Error: No programPATH"
  exit}
  
$PCNAME = $env:computername

#FilePaths
$ShortcutPath = "C:\\Users" 


#Sectioin 2: Create Shortcut
#Set Command
$runAsCommand = "runas /user:$PCNAME\Administrator /savecred $programPATH"
#General Form:runas /user:PCNAME\Administrator /savecred <Path>Program.exe


#Allows the shortcut to be ran against the windows shell
$WScriptObj = New-Object -ComObject ("WScript.Shell")

#Creates the shortcut
$shortcut = $WscriptObj.CreateShortcut($runAsCommand)

#Sets where the shortcut will be placed
$shortcut.TargetPath = $ShortcutPath

#Section 3; Save and CleanUp
#makes shortcut perminate
$shortcut.Save()

#create command to delete script from computer
Remove-Item $PSCommandPath -Force
#Taken from SwDevMan81 at https://stackoverflow.com/questions/61754695/powershell-self-remove-after-script-run
