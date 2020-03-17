@echo off
cd /d "%~dp0"
CALL "%~dp0env.bat"

mkdir "%PORTABLEHOME%\users"
mkdir "%HOMEPATH%"
mkdir "%HOMEPATH%"\AppData
mkdir "%HOMEPATH%"\AppData\Local
mkdir "%HOMEPATH%"\AppData\Local\Temp

mkdir "%PORTABLEHOME%\Applications"
mkdir "%PORTABLEHOME%\Documents"
mkdir "%PORTABLEHOME%\Downloads"

mkdir "%HOMEPATH%\Pictures"
mkdir "%HOMEPATH%\Videos"
mkdir "%HOMEPATH%\Desktop"

REM sneaky sneaky symbolic links, run in admin to have this luxury
mklink /d "%HOMEPATH%\Downloads" "..\..\Downloads" 
mklink /d "%HOMEPATH%\Documents" "..\..\Documents" 

REM otherwise just dump the dirs there
mkdir "%HOMEPATH%\Downloads"
mkdir "%HOMEPATH%\Documents"
