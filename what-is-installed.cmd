@echo off
setlocal EnableDelayedExpansion
set path=%path%;%~dp0
set u=Microsoft\Windows\CurrentVersion\Uninstall

if "%ProgramFiles(x86)%"=="" (
set sw=HKLM\SOFTWARE
set tokens=7
goto x86 )

:x64
echo 64-BIT APPS:
set sw=HKLM\SOFTWARE
set tokens=7

for /f "tokens=%tokens% delims=\" %%a in ('^
reg query "%sw%\%u%" ^|
grep "CurrentVersion.*Uninstall"') do (
reg query "%sw%\%u%\%%a" /v DisplayName > nul 2>&1
if !errorlevel!==0 (
reg query "%sw%\%u%\%%a" /v DisplayName > nul 2>&1
if !errorlevel!==0 for /f "tokens=*" %%b in ('^
reg query "%sw%\%u%\%%a" /v DisplayName ^|
grep "DisplayName" ^|
sed "s/REG_SZ\|DisplayName//g" ^|
sed "s/^[ \t]*//g"') do if not %%b=="" set name=%%b
reg query "%sw%\%u%\%%a" /v DisplayVersion > nul 2>&1
if !errorlevel!==0 for /f "tokens=*" %%c in ('^
reg query "%sw%\%u%\%%a" /v DisplayVersion ^|
grep "DisplayVersion" ^|
sed "s/REG_SZ\|DisplayVersion//g" ^|
sed "s/^[ \t]*//g"') do if not %%c=="" set version=%%c
echo !name! !version!
))

set sw=HKLM\SOFTWARE\Wow6432Node
set tokens=8
echo.
:x86
echo 32-BIT APPS:
for /f "tokens=%tokens% delims=\" %%a in ('^
reg query "%sw%\%u%" ^|
grep "CurrentVersion.*Uninstall"') do (
reg query "%sw%\%u%\%%a" /v DisplayName > nul 2>&1
if !errorlevel!==0 (
reg query "%sw%\%u%\%%a" /v DisplayName > nul 2>&1
if !errorlevel!==0 for /f "tokens=*" %%b in ('^
reg query "%sw%\%u%\%%a" /v DisplayName ^|
grep "DisplayName" ^|
sed "s/REG_SZ\|DisplayName//g" ^|
sed "s/^[ \t]*//g"') do if not %%b=="" set name=%%b
reg query "%sw%\%u%\%%a" /v DisplayVersion > nul 2>&1
if !errorlevel!==0 for /f "tokens=*" %%c in ('^
reg query "%sw%\%u%\%%a" /v DisplayVersion ^|
grep "DisplayVersion" ^|
sed "s/REG_SZ\|DisplayVersion//g" ^|
sed "s/^[ \t]*//g"') do if not %%c=="" set version=%%c
echo !name! !version!
))

endlocal
pause
