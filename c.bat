@echo off
del /q /f /s "%temp%\*" >nul 2>&1
for /d %%i in ("%temp%\*") do rd /s /q "%%i" >nul 2>&1
del /q /f /s "%tmp%\*" >nul 2>&1
for /d %%i in ("%tmp%\*") do rd /s /q "%%i" >nul 2>&1
cls
echo [1/8]
timeout /t 1 /nobreak >nul

del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" >nul 2>&1
cls
echo [2/8]
timeout /t 1 /nobreak >nul

del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1
cls
echo [3/8]
timeout /t 1 /nobreak >nul

powershell -Command "Start-Process cmd -ArgumentList '/c ipconfig /flushdns' -Verb RunAs -WindowStyle Hidden"
cls
echo [4/8]
timeout /t 1 /nobreak >nul

del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%i in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%i" >nul 2>&1
cls
echo [5/8]
timeout /t 1 /nobreak >nul

powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1
cls
echo [6/8]
timeout /t 1 /nobreak >nul

powershell -Command "Start-Process DISM -ArgumentList '/Online /Cleanup-Image /StartComponentCleanup /Quiet' -Verb RunAs -WindowStyle Hidden -Wait"
cls
echo [7/8]
timeout /t 1 /nobreak >nul

powershell -Command "Start-Process cleanmgr -ArgumentList '/sagerun:1' -Verb RunAs -WindowStyle Hidden -Wait"
cls
echo [8/8]
timeout /t 1 /nobreak >nul

msg * Czyszczenie skonczone
exit
