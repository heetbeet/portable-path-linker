@echo off
REM *************************************************
REM This is a self-referencing shortcut type of file
REM ************************************************

Setlocal enabledelayedexpansion
CALL "%~dp0scripts\run_in_seperate_cmd.bat" %~n0 %*