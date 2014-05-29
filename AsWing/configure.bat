@echo off

REM Build script for AsWing
REM written by Oliver "gencha" Salzburg 2008-02-20

echo Configuring AsWing build environment...

wscript.exe configure.js

echo Done.
echo You can now run make.bat