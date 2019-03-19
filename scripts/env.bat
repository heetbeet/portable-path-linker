@echo off

REM Allowable executables
REM SET PATHEXT=.COM;.EXE;.BAT;.CMD;.VBS;.VBE;.JS;.JSE;.WSF;.WSH;.MSC

REM USERNAME=heetbeet
REM COMPUTERNAME=HEETBEET
set /p USERNAME=<"%~dp0user"
SET COMPUTERNAME=%USERNAME%
CALL :TOUPPER COMPUTERNAME

REM remove the trailing slashes with :~0,-1
CALL :SETFULLPATH SCRIPTHOME "%~dp0"
SET SCRIPTHOME=%SCRIPTHOME:~0,-1%
CALL :SETFULLPATH HOMEDRIVE  "%~d0"
SET HOMEDRIVE=%HOMEDRIVE:~0,-1%

SET SYSTEMDRIVE=%HOMEDRIVE%
CALL :SETFULLPATH PORTABLEHOME "%SCRIPTHOME%\.."
CALL :SETFULLPATH HOMEPATH "%PORTABLEHOME%\users\%USERNAME%"

CALL :SETFULLPATH ALLUSERSPROFILE "%PORTABLEHOME%\users\ProgramData"
CALL :SETFULLPATH ProgramData "%HOMEPATH%\ProgramData"
CALL :SETFULLPATH ProgramFiles "%PORTABLEHOME%\applications"
CALL :SETFULLPATH ProgramFiles(x86) "%PORTABLEHOME%\applications"
CALL :SETFULLPATH CommonProgramFiles "%PORTABLEHOME%\users\Common Files"
CALL :SETFULLPATH CommonProgramFiles(x86) "%PORTABLEHOME%\users\Common Files"
CALL :SETFULLPATH CommonProgramW6432 "%PORTABLEHOME%\users\Common Files"
CALL :SETFULLPATH ProgramW6432 "%PORTABLEHOME%\applications"

CALL :SETFULLPATH APPDATA "%HOMEPATH%\AppData\Roaming"
CALL :SETFULLPATH LOCALAPPDATA "%HOMEPATH%\AppData\Local"
CALL :SETFULLPATH PUBLIC "%HOMEPATH%\Public"
CALL :SETFULLPATH TEMP "%HOMEPATH%\AppData\Local\Temp"
CALL :SETFULLPATH TMP "%HOMEPATH%\AppData\Local\Temp"
CALL :SETFULLPATH USERPROFILE "%HOMEPATH%"

CALL :READPATHSFROMFILE PATHADDITIONS "%SCRIPTHOME%\path"
REM Save the original path just in case
SET ORIGINALPATH=%PATH%
SET PATH=%PATHADDITIONS%;%PATH%

REM Exit
GOTO :EOF

REM ***********************************************
REM Convert relative path to absolute path
REM ***********************************************
:SETFULLPATH
    set %1=%~f2
    GOTO :EOF

REM ***********************************************
REM Initiate a variable as empty string
REM ***********************************************
:INITVAR
    SET %1=
    SET %1>NUL  2>NUL
    GOTO :EOF

REM ***********************************************
REM Read the user-given paths from the file "path"
REM ***********************************************
:READPATHSFROMFILE
    CALL :INITVAR TMPPATH
    for /F "tokens=*" %%A in ('type %2') do ( 
        CALL :SETFULLPATH TMPVAR "%PORTABLEHOME%\%%A"
        CALL SET "TMPPATH=%%TMPPATH%%;%%TMPVAR%%"
    )
    REM Substring to remove the first ";"
    SET %1=%TMPPATH:~1%
    SET TMPPATH=
    SET TMPVAR=
    GOTO :EOF

REM ***********************************************
REM Convert a string to upper case. Expensive O(26N)
REM ***********************************************
:TOUPPER
    for %%L IN (^^ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO SET %1=!%1:%%L=%%L!
    GOTO :EOF

:EOF
