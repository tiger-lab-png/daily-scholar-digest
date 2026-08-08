@echo off
cd /d "%~dp0"

echo ==========================================
echo   Daily Scholar Digest - GitHub setup
echo ==========================================
echo.
echo Working folder:
echo   %CD%
echo.

if not exist "index.html" (
  echo [ERROR] index.html not found here.
  echo Put setup.bat inside the web folder and try again.
  echo.
  pause
  exit /b 1
)

git --version
if errorlevel 1 (
  echo.
  echo [ERROR] git not found.
  echo Install from https://git-scm.com/download/win then run this again.
  echo.
  pause
  exit /b 1
)

echo.
echo Create a PUBLIC repo on GitHub first. Do NOT add a README.
echo Then paste its URL below, for example:
echo   https://github.com/YOURNAME/daily-scholar-digest.git
echo.
set /p REPO="Repo URL: "

if "%REPO%"=="" (
  echo [ERROR] No URL entered.
  pause
  exit /b 1
)

echo.
echo --- clearing stale lock files ---
if exist ".git\HEAD.lock"  del /f /q ".git\HEAD.lock"
if exist ".git\index.lock" del /f /q ".git\index.lock"
if exist ".git\config.lock" del /f /q ".git\config.lock"
if exist ".git\objects\maintenance.lock" del /f /q ".git\objects\maintenance.lock"
if exist ".git\refs\heads\master.lock" del /f /q ".git\refs\heads\master.lock"
if exist ".git\refs\heads\main.lock" del /f /q ".git\refs\heads\main.lock"

echo --- init ---
if not exist ".git" git init

git config user.name "Hung Chi"
git config user.email "dddsss5419@gmail.com"
git config core.autocrlf false

echo --- staging ---
git add -A
if errorlevel 1 goto fail

echo --- commit ---
git commit -m "Update daily scholar digest"

echo --- branch ---
git branch -M main
if errorlevel 1 goto fail

echo --- remote ---
git remote remove origin 2>nul
git remote add origin %REPO%
if errorlevel 1 goto fail

echo.
echo A browser window may open asking you to sign in to GitHub.
echo Just approve it. You do not need to type any token.
echo.
pause

echo --- push ---
git push -u origin main
if errorlevel 1 goto fail

echo.
echo ==========================================
echo   DONE
echo ==========================================
echo.
echo Now on GitHub:
echo   Settings  ^>  Pages
echo   Source: Deploy from a branch
echo   Branch: main   Folder: / (root)
echo   Save
echo.
echo Your site will appear at:
echo   https://YOURNAME.github.io/daily-scholar-digest/
echo.
echo From now on, double-click push.bat to sync.
echo.
pause
exit /b 0

:fail
echo.
echo [FAILED] Something went wrong above. Copy the message and send it to Claude.
echo.
pause
exit /b 1
