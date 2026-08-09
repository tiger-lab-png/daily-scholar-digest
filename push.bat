@echo off
cd /d "%~dp0"

echo ==========================================
echo   Daily Scholar Digest - push to GitHub
echo ==========================================
echo.
echo Folder: %CD%
echo Time:   %date% %time:~0,8%
echo.

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  echo [ERROR] Not a git repo. Run setup.bat first.
  goto end
)

echo --- current status ---
git status --short
echo.

git add -A

git diff --cached --quiet
if not errorlevel 1 (
  echo Nothing changed. Website is already up to date.
  echo.
  echo If you expected an update, the Cowork task may not have
  echo run yet. Check the Scheduled panel in the Claude sidebar.
  goto end
)

echo --- committing ---
git commit -m "Update daily scholar digest"
if errorlevel 1 (
  echo [ERROR] Commit failed.
  goto end
)

echo.
echo --- pushing ---
git push
if errorlevel 1 (
  echo.
  echo [ERROR] Push failed. Common causes:
  echo   1. First time - approve the GitHub login window
  echo   2. No network
  echo   3. Remote not set - check with: git remote -v
  goto end
)

echo.
echo ==========================================
echo   DONE - site updates in 1-2 minutes
echo   https://tiger-lab-png.github.io/daily-scholar-digest/
echo ==========================================

:end
echo.
echo Press any key to close this window.
pause >nul
