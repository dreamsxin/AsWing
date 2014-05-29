@echo off
REM Build script for GuiBuilderLib
REM written by Oliver "gencha" Salzburg 2008-02-20

set flex_sdk_dir=path_to_flex_sdk

if not (%1) == () set flex_sdk_dir=%1

if (%flex_sdk_dir%) == (path_to_flex_sdk) goto sdk_missing
if (%flex_sdk_dir%) == () goto sdk_missing
if not exist %flex_sdk_dir% goto sdk_missing

if not exist src\manifest.xml goto manifest_missing

if not exist ..\AsWing\bin\AsWing.swc goto build_aswing

goto make

:manifest_missing
echo You have to run configure.bat first.
goto fail

:sdk_missing
echo You have to set the path to the Flex SDK inside "%0.bat".
goto fail

:build_aswing
cd ..
cd aswing
call configure
call make %flex_sdk_dir%
cd ..
cd guibuilderlib

if not exist ..\AsWing\bin\AsWing.swc goto build_aswing_fail
goto make

:build_aswing_fail
echo Building AsWing failed! Can not proceed without AsWing.swc
goto fail

:make
echo Making GuiBuilderLib...

if not exist bin md bin
set compc=%flex_sdk_dir%\bin\compc.exe
%compc% -source-path src -output bin\GuiBuilderLib.swc -namespace http://GuiBuilderLib src\manifest.xml -include-namespaces http://GuiBuilderLib -compiler.include-libraries ..\aswing\bin\aswing.swc

if not exist bin\GuiBuilderLib.swc goto fail
goto success

:success
echo Done building GuiBuilderLib.
goto end

:fail
echo Build of GuiBuilderLib failed!
goto end

:end