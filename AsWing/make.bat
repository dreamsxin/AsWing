@echo off
REM Build script for AsWing
REM written by Oliver "gencha" Salzburg 2008-02-20

set flex_sdk_dir=path_to_flex_sdk

if not (%1) == () set flex_sdk_dir=%1

if (%flex_sdk_dir%) == (path_to_flex_sdk) goto sdk_missing
if (%flex_sdk_dir%) == () goto sdk_missing
if not exist %flex_sdk_dir% goto sdk_missing

if not exist src\manifest.xml goto manifest_missing

goto make

:manifest_missing
echo You have to run configure.bat first.
goto fail

:sdk_missing
echo You have to set the path to the Flex SDK inside "%0.bat".
goto fail

:make
echo Making AsWing...

if not exist bin md bin
set compc=%flex_sdk_dir%\bin\compc.exe
%compc% -source-path src -output bin\AsWing.swc -namespace http://aswing src\manifest.xml -include-namespaces http://aswing 

if not exist bin\AsWing.swc goto fail
goto success

:success
echo Done building AsWing.
goto end

:fail
echo Build of AsWing failed!
goto end

:end