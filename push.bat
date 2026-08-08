@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo [每日學術新聞] 同步到 GitHub...
echo.

git rev-parse --is-inside-work-tree >nul 2>&1
if errorlevel 1 (
  echo [錯誤] 這個資料夾還沒初始化成 git repo。
  echo         請先照 SETUP-GITHUB.md 的步驟做一次設定。
  pause
  exit /b 1
)

git add -A

git diff --cached --quiet
if not errorlevel 1 (
  echo 沒有變更,不需要推送。
  timeout /t 3 >nul
  exit /b 0
)

for /f "tokens=1-3 delims=/ " %%a in ("%date%") do set D=%%a-%%b-%%c
git commit -m "每日學術新聞更新 %D% %time:~0,5%"
if errorlevel 1 (
  echo [錯誤] commit 失敗。
  pause
  exit /b 1
)

git push
if errorlevel 1 (
  echo.
  echo [錯誤] 推送失敗。常見原因:
  echo   1. 第一次使用,需要在彈出的視窗登入 GitHub 授權
  echo   2. 網路不通
  echo   3. 遠端還沒設定,請執行: git remote -v 檢查
  pause
  exit /b 1
)

echo.
echo 完成。網站約一到兩分鐘後更新。
timeout /t 5 >nul
