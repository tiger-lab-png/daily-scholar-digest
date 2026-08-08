# 把每日學術新聞放上網 — 一次性設定

做完這份設定之後,你在**手機、平板、任何電腦**上打開網址就能讀,也能點播報。
全部免費,不需要付費方案。

---

## 先講一件事

GitHub Pages 的免費方案**只支援公開 repo**。這代表網頁內容任何人都能看到,包含裡面對具名學者的批評段落。

我已經在網頁裡加了 `<meta name="robots" content="noindex, nofollow">`,Google 等搜尋引擎不會主動收錄它。但這只是「請對方不要索引」的禮貌性宣告,**不等於私密** —— 知道網址的人仍然看得到。

如果你之後覺得不妥,有兩個免費的替代方案:
- **Cloudflare Pages**:免費方案支援私人 repo,設定方式類似,網址一樣不公開索引
- 或把 `web/index.html` 裡的「學者視角」「被該期刊接受的關鍵」兩個區塊拿掉再上傳 —— 跟我說一聲我幫你改

---

## 步驟一：裝 Git

到 https://git-scm.com/download/win 下載安裝。一路按下一步即可,預設值就好。

安裝完成後,開啟「命令提示字元」輸入 `git --version`,有版本號就成功了。

> 如果你不想碰命令列,也可以改裝 **GitHub Desktop**(https://desktop.github.com),全圖形介面。裝了它就不需要步驟三的指令,也不需要 `push.bat`。

## 步驟二：建立 GitHub repo

1. 到 https://github.com 註冊或登入(免費帳號即可)
2. 右上角 **+** → **New repository**
3. Repository name 填 `daily-scholar-digest`
4. 選 **Public**(免費 Pages 的必要條件)
5. **不要**勾選 Add a README file
6. 按 **Create repository**

建好後那一頁會顯示你的 repo 網址,長得像:
```
https://github.com/你的帳號/daily-scholar-digest.git
```
把它記下來。

## 步驟三：把這個資料夾接上去

### 最簡單的做法：雙擊 `setup.bat`

直接雙擊這個資料夾裡的 **`setup.bat`**。它會:

1. 自動切換到正確的資料夾(這是最容易出錯的一步,腳本幫你處理掉)
2. 問你要 repo 網址,把步驟二記下的那串貼進去按 Enter
3. 自動完成 init、commit、接上遠端、推送

**第一次 push 時會跳出瀏覽器視窗要你登入 GitHub 授權。** 點一下同意就好,不需要手動輸入或複製任何權杖。Windows 的 Git 憑證管理員會記住,之後不會再問。

### ⚠️ 如果你想自己打指令,一定要先切到正確資料夾

**最常見的災難是在 `C:\Users\你的帳號` 底下執行 `git init`** —— 那會把整個使用者資料夾變成版控目標,`git add -A` 會掃描 AppData 並跳出一堆權限錯誤。

正確做法是在**這個 `web` 資料夾**的空白處按右鍵 → 「Open Git Bash here」(或「在終端中開啟」),確認提示字元顯示的路徑是 `.../每日期刊新聞/web`,再依序貼上:

```bash
git init
git branch -M main
git add -A
git commit -m "第一次上傳"
git remote add origin https://github.com/你的帳號/daily-scholar-digest.git
git push -u origin main
```

每一行開頭都要有 `git`。打 `add -A` 會得到 `command not found`。

### 不小心在家目錄執行了 git init 怎麼辦

開 Git Bash 貼這行:

```bash
rm -rf ~/.git
```

這只刪掉誤建的版控記錄資料夾,**你的檔案完全不受影響**。做完再回到 `web` 資料夾重來即可。

## 步驟四：開啟 GitHub Pages

1. 進到你的 repo 頁面 → 上方 **Settings**
2. 左側選單找到 **Pages**
3. Source 選 **Deploy from a branch**
4. Branch 選 **main**,資料夾選 **/ (root)**
5. 按 **Save**

等一到兩分鐘,同一頁上方會出現你的網址:

```
https://你的帳號.github.io/daily-scholar-digest/
```

**這就是你的網址。** 手機加到主畫面書籤,以後點開就能讀、能聽。

## 步驟五：讓它每天自動更新(選用)

Cowork 的排程每天 08:00、13:00、20:00 會自動更新 `web/index.html`。但「推送到 GitHub」這個動作必須在你的電腦上執行。

**手動版**:每天想同步時,雙擊這個資料夾裡的 `push.bat`。跑完約五秒。

**自動版**:用 Windows 工作排程器設定一次

1. 開始功能表搜尋「工作排程器」並開啟
2. 右側「建立基本工作」
3. 名稱填「每日學術新聞推送」→ 下一步
4. 觸發程序選「每日」→ 下一步 → 開始時間設 **08:20** → 下一步
5. 動作選「啟動程式」→ 下一步
6. 「程式或指令碼」按瀏覽,選這個資料夾裡的 `push.bat` → 下一步 → 完成
7. 完成後在清單裡找到這個工作,按右鍵 → 內容 → 勾選「不論使用者是否登入均執行」與「以最高權限執行」

如果要一天推三次,重複上面步驟建立 13:20 與 20:20 兩個工作即可(排程跑完後留 20 分鐘緩衝)。

---

## 手機上要注意的事

- **播報功能**在 Android Chrome 與 iOS Safari 都能用,但**必須由你點一下播放鍵才會發聲**,這是瀏覽器的安全限制,無法自動播放。
- iPhone 上用的是 Siri 語音,音質通常比 Windows 的本地語音自然。
- 手機鎖屏後語音會停止。想邊走邊聽,請保持螢幕開啟。

## 出問題時

| 狀況 | 處理 |
|---|---|
| `push.bat` 說不是 git repo | 步驟三沒做完,重做一次 |
| 推送失敗跳登入視窗 | 正常,登入授權即可 |
| 網頁 404 | Pages 剛開啟需等一兩分鐘;確認 Branch 選的是 main 與 root |
| 網頁沒更新 | 瀏覽器快取,手機上下拉重新整理或改用無痕視窗 |
| 按播報沒聲音 | 系統缺中文語音,網頁上會有提示;iOS 需先點一下畫面 |
