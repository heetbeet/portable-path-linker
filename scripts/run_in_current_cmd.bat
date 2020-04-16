@echo off
Setlocal enabledelayedexpansion

CALL "%~dp0env.bat"

CALL :GETPATHTOEXE FULLEXECUTABLEPATH %1
CALL :SHIFTARGS OTHERARGS %*

"%FULLEXECUTABLEPATH%" %OTHERARGS%

REM Exit
GOTO :EOF

REM ***********************************************
REM This search and return the path of the executable in:
REM   1. %PORTABLEHOME%\applications\*\  (not recursive)
REM   2. %PATH% (with the portable additions included)
REM ***********************************************
:GETPATHTOEXE
    REM Temporary add all %PORTABLEHOME%\applications\* paths to %PATH%
    set OLDDIR=%CD%
    set OLDPATH=%PATH%
    cd /d "%PORTABLEHOME%\applications"
    CALL :READPATHSFROMCURDIR APPATHS
    set PATH=%PORTPATH%;%APPATHS%;%OLDPATH%

    REM Enforce that %PORTABLEHOME% is not in %PATH%, otherwise 
    REM we end up with a nonterminating dependancy loop
    call :TOUPPER PATH
    call :SETFULLPATH SHORTCUTPATH "%PORTABLEHOME%\"
    call :TOUPPER SHORTCUTPATH

    REM Remove: try once with trailing \
    SET PATH=;%PATH%;
    call SET PATH=%%PATH:;%SHORTCUTPATH%;=;%%
    call SET PATH=%%PATH:;\;=;%%

    REM Remove: try once without trailing \
    SET SHORTCUTPATH=%SHORTCUTPATH:~0,-1%
    SET PATH=;%PATH%;
    call SET PATH=%%PATH:;%SHORTCUTPATH%;=;%%
    call SET PATH=%%PATH:;\;=;%%

    REM use where to find the nearest exe, bat, vbs, etc. executable
    for /F "tokens=*" %%A in ('where %2') do (
        SET TMPVAR=%%A
        GOTO END_GETPATHTOEXELOOP
    )
    :END_GETPATHTOEXELOOP
    
    REM Reset the global parameters and cwd location we messed with
    SET %1=%TMPVAR%
    set PATH=%OLDPATH%
    cd /d %OLDDIR%
    GOTO :EOF

REM ***********************************************
REM Iterate through all the directories in cwd and
REM return them as a ";" seperated list
REM ***********************************************
:READPATHSFROMCURDIR
    SET TMPPATH= 
    for /F "tokens=*" %%A in ('dir /a:d /b') do ( 
        CALL :SETFULLPATH TMPVAR "%%A"
        CALL SET "TMPPATH=%%TMPPATH%%;%%TMPVAR%%"
    )
    REM Substring to remove the first ";"
    SET %1=%TMPPATH:~2%
    SET TMPPATH=
    SET TMPVAR=
    GOTO :EOF

REM ***********************************************
REM Convert relative path to absolute path
REM ***********************************************
:SETFULLPATH
    set %1=%~f2
    GOTO :EOF

REM ***********************************************
REM Remove first arg from the list
REM Input: thisfilename wanttorunexe arg1 arg2 arg3 ...
REM Output: arg1 arg2 arg3 ...
REM ***********************************************    
:SHIFTARGS
    SET RETURNVAR=%1
    SET RESTVAR=
    SET UNIQUEID=3ae38439cf4249ce81753d96da46e9cf6f9e0348aa17123125
    
    REM remove thisfilename
    shift
    REM remove wanttorunexe
    shift

    REM Loop over remaining args and put them in RESTVAR
    :SHIFTLOOP
        REM break if current arg is empty
        SET ISEMPTYTEST=%1%UNIQUEID%
        if %ISEMPTYTEST:~0,50%==%UNIQUEID% goto END_SHIFTLOOP

        REM add arg to RESTVAR
        set RESTVAR=%RESTVAR% %1

        REM remove arg from list
        shift
        goto SHIFTLOOP

    :END_SHIFTLOOP

    SET %RETURNVAR%=%RESTVAR%
    GOTO :EOF

REM ***********************************************
REM Convert a string to upper case. Expensive O(26N)
REM ***********************************************
:TOUPPER
    for %%L IN (^^ A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) DO SET %1=!%1:%%L=%%L!
    GOTO :EOF

:EOF
