@echo off
cd /d "%~dp0"

echo ==========================================
echo   Auto-push scheduler installer
echo ==========================================
echo.
echo This creates 3 daily Windows tasks that run push.bat
echo at 08:20, 13:20 and 20:20 - twenty minutes after each
echo Cowork run, leaving time for the files to be written.
echo.
echo Folder: %CD%
echo.

if not exist "push.bat" (
  echo [ERROR] push.bat not found in this folder.
  pause
  exit /b 1
)

if not exist ".git" (
  echo [ERROR] This folder is not a git repo yet.
  echo Run setup.bat first.
  pause
  exit /b 1
)

echo Press any key to install, or close this window to cancel.
pause >nul
echo.

schtasks /create /tn "ScholarDigest-Push-0820" /tr "\"%~dp0push.bat\"" /sc daily /st 08:20 /f
schtasks /create /tn "ScholarDigest-Push-1320" /tr "\"%~dp0push.bat\"" /sc daily /st 13:20 /f
schtasks /create /tn "ScholarDigest-Push-2020" /tr "\"%~dp0push.bat\"" /sc daily /st 20:20 /f

echo.
echo ==========================================
echo   Installed. Verifying:
echo ==========================================
echo.
schtasks /query /tn "ScholarDigest-Push-0820" 2>nul
schtasks /query /tn "ScholarDigest-Push-1320" 2>nul
schtasks /query /tn "ScholarDigest-Push-2020" 2>nul

echo.
echo Done. Nothing else to do from now on.
echo.
echo To run one right now as a test:
echo   schtasks /run /tn "ScholarDigest-Push-1320"
echo.
echo To remove them later:
echo   schtasks /delete /tn "ScholarDigest-Push-0820" /f
echo   schtasks /delete /tn "ScholarDigest-Push-1320" /f
echo   schtasks /delete /tn "ScholarDigest-Push-2020" /f
echo.
pause
