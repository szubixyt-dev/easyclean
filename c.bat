@echo off
setlocal EnableDelayedExpansion
set TotalFreed=0

:: Pobierz początkowe wolne miejsce
for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free / 1MB)"') do set FreeBefore=%%a

del /q /f /s "%temp%\*" >nul 2>&1
for /d %%i in ("%temp%\*") do rd /s /q "%%i" >nul 2>&1
del /q /f /s "%tmp%\*" >nul 2>&1
for /d %%i in ("%tmp%\*") do rd /s /q "%%i" >nul 2>&1

for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free / 1MB)"') do set FreeAfter=%%a
set /a Freed=!FreeAfter! - !FreeBefore!
set /a TotalFreed+=!Freed!
cls
echo [1/8]  Wyczyszczono: !Freed! MB
timeout /t 1 /nobreak >nul

set FreeBefore=!FreeAfter!
del /q /f /s "C:\Windows\Temp\*" >nul 2>&1
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" >nul 2>&1

for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free / 1MB)"') do set FreeAfter=%%a
set /a Freed=!FreeAfter! - !FreeBefore!
set /a TotalFreed+=!Freed!
cls
echo [2/8]  Wyczyszczono: !Freed! MB
timeout /t 1 /nobreak >nul

set FreeBefore=!FreeAfter!
del /q /f /s "C:\Windows\Prefetch\*" >nul 2>&1

for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free / 1MB)"') do set FreeAfter=%%a
set /a Freed=!FreeAfter! - !FreeBefore!
set /a TotalFreed+=!Freed!
cls
echo [3/8]  Wyczyszczono: !Freed! MB
timeout /t 1 /nobreak >nul

set FreeBefore=!FreeAfter!
powershell -Command "Start-Process cmd -ArgumentList '/c ipconfig /flushdns' -Verb RunAs -WindowStyle Hidden" >nul 2>&1

for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free / 1MB)"') do set FreeAfter=%%a
set /a Freed=!FreeAfter! - !FreeBefore!
set /a TotalFreed+=!Freed!
cls
echo [4/8]  Wyczyszczono: !Freed! MB
timeout /t 1 /nobreak >nul

set FreeBefore=!FreeAfter!
del /q /f /s "C:\Windows\SoftwareDistribution\Download\*" >nul 2>&1
for /d %%i in ("C:\Windows\SoftwareDistribution\Download\*") do rd /s /q "%%i" >nul 2>&1

for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free / 1MB)"') do set FreeAfter=%%a
set /a Freed=!FreeAfter! - !FreeBefore!
set /a TotalFreed+=!Freed!
cls
echo [5/8]  Wyczyszczono: !Freed! MB
timeout /t 1 /nobreak >nul

set FreeBefore=!FreeAfter!
powershell -Command "Clear-RecycleBin -Force -ErrorAction SilentlyContinue" >nul 2>&1

for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free / 1MB)"') do set FreeAfter=%%a
set /a Freed=!FreeAfter! - !FreeBefore!
set /a TotalFreed+=!Freed!
cls
echo [6/8]  Wyczyszczono: !Freed! MB
timeout /t 1 /nobreak >nul

set FreeBefore=!FreeAfter!
powershell -Command "Start-Process DISM -ArgumentList '/Online /Cleanup-Image /StartComponentCleanup /Quiet' -Verb RunAs -WindowStyle Hidden -Wait" >nul 2>&1

for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free / 1MB)"') do set FreeAfter=%%a
set /a Freed=!FreeAfter! - !FreeBefore!
set /a TotalFreed+=!Freed!
cls
echo [7/8]  Wyczyszczono: !Freed! MB
timeout /t 1 /nobreak >nul

set FreeBefore=!FreeAfter!
powershell -Command "Start-Process cleanmgr -ArgumentList '/sagerun:1' -Verb RunAs -WindowStyle Hidden -Wait" >nul 2>&1

for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive C).Free / 1MB)"') do set FreeAfter=%%a
set /a Freed=!FreeAfter! - !FreeBefore!
set /a TotalFreed+=!Freed!
cls
echo [8/8]  Wyczyszczono: !Freed! MB
timeout /t 1 /nobreak >nul

msg * Czyszczenie skonczone. Wyczyszczono lacznie: !TotalFreed! MB
exit
