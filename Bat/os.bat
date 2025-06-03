@echo off
setlocal enabledelayedexpansion

:: Run the GUI and capture output
for /f "tokens=1,2,3 delims=," %%A in ('powershell -ExecutionPolicy Bypass -File get_ip_octets.ps1') do (
    set OCT1=%%A
    set OCT2=%%B
    set OCT3=%%C
)

if not defined OCT1 (
    echo No IP entered. Exiting.
    pause
    exit /b
)

set "IPBASE=%OCT1%.%OCT2%.%OCT3%"

:: Get IP range
for /f "delims=" %%A in ('powershell -command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Enter the START of the IP range (e.g. 1)', 'Start Range')"') do set START=%%A
for /f "delims=" %%A in ('powershell -command "Add-Type -AssemblyName Microsoft.VisualBasic; [Microsoft.VisualBasic.Interaction]::InputBox('Enter the END of the IP range (e.g. 254)', 'End Range')"') do set END=%%A

:: Validate
set /a TEST=START+END >nul 2>&1
if errorlevel 1 (
    echo Invalid range. Exiting.
    pause
    exit /b
)

:: Output CSV
set OUTPUT=systeminfo_results.csv
echo Host Name,OS Name > "%OUTPUT%"

:: Loop and scan
for /l %%i in (%START%,1,%END%) do (
    set "IP=%IPBASE%.%%i"
    echo Checking !IP!...

    systeminfo /s !IP! > tmp.txt 2>nul

    set "HN="
    set "OSN="

    for /f "usebackq tokens=1,* delims=:" %%A in ("tmp.txt") do (
        set "KEY=%%A"
        set "VALUE=%%B"
        set "KEY=!KEY: =!"
        set "VALUE=!VALUE:~1!"

        if /i "!KEY!"=="HostName" set "HN=!VALUE!"
        if /i "!KEY!"=="OSName" set "OSN=!VALUE!"
    )

    del tmp.txt

    if defined HN if defined OSN (
        >>"%OUTPUT%" echo "!HN!","!OSN!"
    )
)

echo Done! Results saved to %OUTPUT%.
pause
