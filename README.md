## config
```
```
~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
https://www.autohotkey.com/download/1.1/AutoHotkey_1.1.36.02_setup.exe
https://www.autohotkey.com/download/1.1/AutoHotkey_1.1.36.02.zip


## azure tunnel
```bash
# 安裝（會裝到 ~/bin）
curl -sL https://aka.ms/DevTunnelCliInstall | bash

# 讓 PATH 生效（或重新開一個 shell）
source ~/.bashrc   # 或 source ~/.bash_profile

# 確認安裝成功
devtunnel --version

# 登入（會給你一個 device code，去瀏覽器輸入）
devtunnel user login
# 先啟動你的 web 服務（保持在背景或另一個 tab）
# 例如：python -m http.server 8080
# 或你的 node / .NET / 其他服務

# 再開隧道（臨時隧道，關閉後會消失）
devtunnel host -p 8080
```

```ps1
# 安裝
winget install Microsoft.devtunnel

# 登入（用跟 Cloud Shell 同一個 Microsoft 帳號）
devtunnel user login

# 連線（把遠端埠轉發到本機）
devtunnel connect <剛才的tunnel-id>
```
