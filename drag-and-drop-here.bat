echo off
cd /d %~dp1
call %~dp0scripts\env.bat
%*
