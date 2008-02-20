@echo off
REM Build script for AsWing
REM written by Oliver "gencha" Salzburg 2008-02-20

set flex_sdk_dir=C:\flex3sdk_b3_121207

if (%flex_sdk_dir%) == (path_to_flex_sdk) goto sdk_missing
if (%flex_sdk_dir%) == () goto sdk_missing

if not exist src\manifest.xml goto manifest_missing

goto make

:manifest_missing
echo You have to run configure.bat first.
goto end

:sdk_missing
echo You have to set the path to the Flex SDK inside "%0.bat".
goto end

:make
echo Making...

if not exist bin md bin
set compc=%flex_sdk_dir%\bin\compc.exe
%compc% -source-path src -output bin\AsWing.swc -namespace http://aswing.org src\manifest.xml -include-namespaces http://aswing.org 


:end
echo Done.