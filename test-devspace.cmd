@ECHO OFF
call ./chmod-plus-x
powershell -command "./src/scripts/devspace/test.ps1"