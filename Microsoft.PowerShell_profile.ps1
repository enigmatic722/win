$env:TERM = "xterm-256color"
Set-PSReadLineOption -Colors @{"Parameter"="#808080"}
Set-PSReadLineOption -Colors @{"Operator"="#808080"}
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineOption -BellStyle None

# function prompt {  
#     " $([char]27)[38;5;69m$($executionContext.SessionState.Path.CurrentLocation)`r`n$([char]27)[39m> "
# }

if(test-path "$HOME\Documents\PowerShell\dir.ps1") {
    . $HOME\Documents\PowerShell\dir.ps1
}
function re {
    @(
        $Profile.AllUsersAllHosts,
        $Profile.AllUsersCurrentHost,
        $Profile.CurrentUserAllHosts,
        $Profile.CurrentUserCurrentHost
    ) | % {
        if(Test-Path $_){
            Write-Verbose "Running $_"
            . $_
        }
    }
}
function rmCpToBk {
    param (
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string]$path
    )
    process {
        $disk = (get-location).Drive.Name
        $time = (Get-Date).ToString("yyyyMMddHHmmss")
        $files = Get-Item $path
        foreach($src in $files) {
            $basename = $src.Basename
            $ext = $src.Extension

            $target = "$basename.$time$ext"

            if(!$ext -and !($src -is [System.IO.DirectoryInfo])) {
                $target = ".$time.$basename"
            }
            
            if ($disk -eq "C") {$prefix = "~"} else {$prefix = "D:"}
            move-item $src "$prefix/`_recycle/$target" -force
        }
        ll
    }
}
Set-Alias -Name rm -Value rmCpToBk -Option AllScope -Force
function cdrec {
    cd "~/_recycle"
}
function cdred {
    cd "d:/_recycle"
}

Set-PSReadlineOption -EditMode vi
Write-Host -NoNewLine "`e[5 q"
function OnViModeChange {
    if ($args[0] -eq 'Command') {
        Write-Host -NoNewLine "`e[1 q"
    } else {
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
Set-PSReadlineKeyHandler -Chord Ctrl+Oem4 -Function ViCommandMode -ViMode Insert
Set-PSReadLineKeyHandler -Chord Ctrl+Oem4 -ViMode Command -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
	[Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar()
}
# Set-PSReadLineKeyHandler -Key 'ctrl+[' -Function ViCommandMode -ViMode Insert
# Set-PSReadLineKeyHandler -Key 'ctrl+[' -Function ViCommandMode -ViMode Command
# Set-PSReadlineKeyHandler -Chord alt+l -Function ViCommandMode
Set-PSReadlineKeyHandler -Key ctrl+d -Function ViExit
Set-PSReadLineKeyHandler -Key 'v' -Function CaptureScreen -ViMode Command
Set-PSReadLineKeyHandler -Key 'V' -Function SelectAll -ViMode Command

Set-PSReadLineKeyHandler -Key 'alt+l' -Function ForwardWord  -ViMode Insert
Set-PSReadLineKeyHandler -Key 'alt+h' -Function BackwardWord -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+r' -Function Redo -ViMode Command

Set-PSReadLineKeyHandler -Key 'ctrl+l' -Function ForwardChar  -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+h' -Function BackwardChar -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+j' -Function NextHistory -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+k' -Function PreviousHistory -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+l' -Function ForwardChar   -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+h' -Function BackwardChar  -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+j' -Function NextHistory     -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+k' -Function PreviousHistory -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+a' -Function BeginningOfLine -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+e' -Function EndOfLine -ViMode Insert

Set-PSReadLineKeyHandler -Key 'ctrl+n' -Function NextHistory -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+p' -Function PreviousHistory -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+n' -Function NextHistory -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+p' -Function PreviousHistory -ViMode Command

Set-PSReadLineKeyHandler -Key 'ctrl+m' -Function GotoBrace -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+m' -Function ViGotoBrace -ViMode Insert

Set-PSReadLineKeyHandler -Key 'd,a' -Function ViDeleteBrace -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+w' -Function BackwardDeleteWord -ViMode Insert

Set-PSReadLineKeyHandler -Key 'ctrl+o' -Function ClearScreen -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+o' -Function ClearScreen -ViMode Command

Set-PSReadLineKeyHandler -Key 'y' -Function Copy -ViMode Command
Set-PSReadLineKeyHandler -Chord 'Y' -ViMode Command -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::SelectLine()
	[Microsoft.PowerShell.PSConsoleReadLine]::Copy()
}
Set-PSReadLineKeyHandler -Chord 'y,e' -ViMode Command -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardWord()
	[Microsoft.PowerShell.PSConsoleReadLine]::Copy()
	[Microsoft.PowerShell.PSConsoleReadLine]::ViBackwardWord()
}
Set-PSReadLineKeyHandler -Chord 'y,y' -ViMode Command -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::SelectAll()
	[Microsoft.PowerShell.PSConsoleReadLine]::Copy()
}
Set-PSReadLineKeyHandler -Key 'P' -Function Paste -ViMode Command
Set-PSReadLineKeyHandler -Chord 'p' -ViMode Command -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::ViInsertWithAppend()
	[Microsoft.PowerShell.PSConsoleReadLine]::Paste()
    [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
}
Set-PSReadLineKeyHandler -Chord 'g,p' -ViMode Command -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::ViInsertMode()
	[Microsoft.PowerShell.PSConsoleReadLine]::SelectForwardWord()
	[Microsoft.PowerShell.PSConsoleReadLine]::Paste()
    [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
}
Set-PSReadLineKeyHandler -Chord "'" -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert("''")
	[Microsoft.PowerShell.PSConsoleReadLine]::BackwardChar()
}
Set-PSReadLineKeyHandler -Chord '"' -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert('""')
	[Microsoft.PowerShell.PSConsoleReadLine]::BackwardChar()
}
Set-PSReadLineKeyHandler -Chord '{' -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert('{}')
	[Microsoft.PowerShell.PSConsoleReadLine]::BackwardChar()
}
Set-PSReadLineKeyHandler -Chord '(' -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert('()')
	[Microsoft.PowerShell.PSConsoleReadLine]::BackwardChar()
}
Set-PSReadLineKeyHandler -Chord '[' -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::Insert('[]')
	[Microsoft.PowerShell.PSConsoleReadLine]::BackwardChar()
}
function pd {
	Set-PSReadLineKeyHandler -Chord "'" -ScriptBlock {
		[Microsoft.PowerShell.PSConsoleReadLine]::Insert("'")
	}
	Set-PSReadLineKeyHandler -Chord '"' -ScriptBlock {
		[Microsoft.PowerShell.PSConsoleReadLine]::Insert('"')
	}
	Set-PSReadLineKeyHandler -Chord '{' -ScriptBlock {
		[Microsoft.PowerShell.PSConsoleReadLine]::Insert('{')
	}
	Set-PSReadLineKeyHandler -Chord '(' -ScriptBlock {
		[Microsoft.PowerShell.PSConsoleReadLine]::Insert('(')
	}
	Set-PSReadLineKeyHandler -Chord '[' -ScriptBlock {
		[Microsoft.PowerShell.PSConsoleReadLine]::Insert('[')
	}
}
Set-PSReadLineKeyHandler -Key "Ctrl+alt+q" -ViMode Command -ScriptBlock {
    stop-computer -force
}
Set-PSReadLineKeyHandler -Key "Ctrl+alt+q" -ViMode Insert -ScriptBlock {
    stop-computer -force
}

Remove-PSReadLineKeyHandler -Key 'ctrl+w' -ViMode Command
Remove-PSReadLineKeyHandler -Key 'ctrl+w' -ViMode Command

function vihelp {
	 Get-PSReadLineKeyHandler -Bound -Unbound
}

Set-Alias c Set-Clipboard
Set-Alias gwe Get-WinEvent
Set-Alias out out-file
Set-Alias v nvim
Set-Alias n notepad++
Set-Alias py python
Set-Alias ipy ipython
Set-Alias envad SystemPropertiesAdvanced
Set-Alias touch New-Item
Set-Alias s services.msc
Set-Alias ts taskschd.msc
Set-Alias ssh "D:\Program Files\Git\usr\bin\ssh.exe"
Set-Alias regexp D:\dev_tool\RegistryExplorer\RegistryExplorer.exe
Set-Alias tsk tshark
Set-Alias wsk wireshark
Set-Alias t psmux

function ll {
    $files = Get-ChildItem $args[0]
    $files
    Write-Host "total: $(($files|Measure-Object).Count)"
}
function lt {
    gci $args[0] | sort LastWriteTime
}
function mkdirNcd {
    $dir = $args[0]
    New-Item -Path "$dir" -ItemType Directory ; cd $args[0]
}
Set-Alias -Name mkdir -Value mkdirNcd -Option AllScope -Force

function cdll {
    pushd $args[0];ll; (pwd).path | export-clixml -path ~\dir.xml
}
function cdnoll {
    pushd $args[0] ; (pwd).path | export-clixml -path ~\dir.xml
}
Set-Alias -Name cd -Value cdll  -Option AllScope -Force

function mvll {
    $tgrtdir = Split-Path $args[1] -Parent
    Move-Item $args[0] $args[1] && ll #&& ll $args[1]
}
Set-Alias -Name mv -Value mvll  -Option AllScope -Force

function cpll {
    Copy-Item $args[0] $args[1] -Recurse
    $files = gci $args[1]
    $tgrtdir = (Split-Path $files -Parent) | get-unique
    ll $tgrtdir
}
Set-Alias -Name cp -Value cpll  -Option AllScope -Force

$d = "~/Desktop"
$dd = "d:\"
$dl = "d:\Downloads\"
function dl {
	ii $dl
}
function cddl {
	cd $dl
}
function d {
    ii ~/Desktop
}
function dd {
    ii d:\
}
function cc {
	ii C:\
}
function cdp {
    cd (split-path -parent $args[0])
}
function cdd {
    cd ~/Desktop
}
function cddd {
    cd d:/
}
function cdc {
    cd c:/
}
$pr = "$HOME\Documents\PowerShell\"
function cdpr {
    cd $HOME\Documents\PowerShell\
}
function iipr {
    ii $HOME\Documents\PowerShell\
}
function cdl($target)
{
    if($target.EndsWith(".lnk"))
    {
        $sh = new-object -com wscript.shell
        $fullpath = resolve-path $target
        $targetpath = $sh.CreateShortcut($fullpath).TargetPath
        cdll $targetpath
    }
    else {
        cdll $target
    }
}
function psupdate {
	winget install --id Microsoft.Powershell --source winget
}
function env {
  rundll32 sysdm.cpl,EditEnvironmentVariables
}
function countd {
     (Get-ChildItem -Directory | Measure-Object).Count
}
function countf {
     (Get-ChildItem -File -recurse | Measure-Object).Count
}
function pc {
  explorer file:
} 
function which ($command) {
   Get-Command -Name $command -ErrorAction SilentlyContinue |
            Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}
function pwd {
	(pwd).path
}
function find([System.Object]$arg0) {
	Get-ChildItem -Path . -Filter $arg0 -Recurse | %{$_.Fullname}
}
function grepl {
    $txt = $args[0]
    $file = $args[1]
	Get-ChildItem -Path . -Filter $file -Recurse | Select-String $txt -List | Select Path
}
function als {
    set-location $HOME\Documents\PowerShell\
    v $PROFILE
}
function alsdir {
    v $HOME\Documents\PowerShell\dir.ps1
}
function cdhosts {
    cd C:/Windows/System32/drivers/etc/
}
function vrc {
    v ~/.vimrc
}
function nvrc {
    cdnoll $HOME\AppData\Local\nvim\
    nvim .
}
function nve { $input | Out-File -Encoding utf8 $env:TEMP\nv.txt; nvim $env:TEMP\nv.txt }
Set-Alias -Name nv -Value nve  -Option AllScope -Force

function vset {
	v $HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
}
function cpd {
	$d = (pwd).path
    $d.replace("\","/") | Set-Clipboard
}
function cpdw {
	$d = (pwd).path
    $d | Set-Clipboard
}
function cpf {
    Get-ChildItem -Path "$args" | %{($_.Fullname).Replace("\","/")} | Set-Clipboard
}
function cpfw {
    Get-ChildItem -Path "$args" | %{$_.Fullname} | Set-Clipboard
}
function cpn {
    (Get-Item $args).Name | Set-Clipboard
}
function unzip {
    $src = get-item $args[0]
    $parent = (split-path -parent $src)
    if (-not ([string]::IsNullOrEmpty($args[1]))) {
        $dest = $args[1]
    } else {
        $basename = $src.basename
        $dest = new-item -itemtype Directory -path ("$parent\$basename")
    }
    Expand-Archive -Path $src -DestinationPath $dest
    ll (split-path -parent $dest)
}
function ad {
	Start-Process -Verb RunAs pwsh -ArgumentList "-WindowStyle Maximized"
}
function cpl {
    control panel
}
function size {
    gci -force "$args" -ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] } | % {
        $len = 0
        gci -recurse -force $_.fullname -ErrorAction SilentlyContinue | % { $len += $_.length }
        if($len -gt 10Mb) {
            $_.fullname, "`t`t`{0:N2} GB" -f ($len / 1Gb)
        }
    }
}
if(test-path "~\dir.xml") {
    $dir = import-clixml -Path ~\dir.xml
    Set-Location -path $dir
}
if(!(test-path "~\dir.xml")) {
    (pwd).path | export-clixml -path ~\dir.xml
    mkdir "~/_recycle"
    mkdir "d:/_recycle"
}
function fh($in) {
  Start-Process -FilePath C:\Windows\explorer.exe -ArgumentList "/select, ""$in"""  -WindowStyle maximized
}
function fp ($in){
    if (!$in) {
      $in = "."
    }
    $f = gi $in 
    $parent = split-path -parent $f 
    $name = split-path -leaf $f
    $o = new-object -com Shell.Application
    
    $folder = $o.NameSpace("$parent")
    $file = $folder.ParseName("$name")
    $file.InvokeVerb("Properties")
}
function fpc {
    $o = new-object -com Shell.Application
    $folder = $o.NameSpace("C:\")
    $file = $folder.Self
    $file.InvokeVerb("Properties")
}
function tm {
    taskmgr
}
function app {
    $s = @() 
    $s += Analyze 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' 64
    $s += Analyze 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' 32
    $s += Analyze 'Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' 64
    $s += Analyze 'Registry::HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' 32
    $s | Sort-Object -Property Name | ft
}
function ke {
  $a = (New-Object -comObject Shell.Application).Windows() |
  ? { $_.FullName -ne $null} |
  ? { $_.FullName.toLower().Endswith('\explorer.exe') } 
  $a | % {  $_.Quit() }
}
function ko {
    $brave_win = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "brave" } 
    echo $brave_win
    do {
        $brave_win | foreach-object {$_.CloseMainWindow()} | out-null
        $brave_win = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "brave" } 
    } while($brave_win)
    
    $window_tasks = get-process | ? { $_.mainwindowtitle -ne "" -and $_.mainwindowtitle -ne "Clock" -and $_.processname -ne "WindowsTerminal" -and $_.processname -ne "TextInputHost" -and $_.processname -ne "ApplicationFrameHost" -or $_.processname -eq "SystemSettings"} 
    echo $window_tasks
    $window_tasks | foreach-object {$_.CloseMainWindow()} | out-null
    get-process | ? { $_.mainwindowtitle -ne "" -and $_.mainwindowtitle -ne "Clock" -and $_.processname -ne "wezterm-gui" -and $_.processname -ne "TextInputHost" -and $_.processname -ne "ApplicationFrameHost" -or $_.processname -eq "SystemSettings"} | stop-process
    ke
}
function kch {
    $chrome_win = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "brave" } 
    echo $chrome_win
    do {
        $chrome_win | foreach-object {$_.CloseMainWindow()} | out-null
        $chrome_win = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "brave" } 
    } while($chrome_win)
}

function jf {
    (Get-Content -LiteralPath $args[0] -Raw) -split "`r?`n" | Where-Object { $_.Trim() } | ForEach-Object { ConvertFrom-Json $_ } | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $args[0]
}

function i($filename) {
    Add-Type -AssemblyName System.Windows.Forms

    $curr = (pwd).path 
    if (!($filename)) {
        $filePath = "$curr\tmp_" + (get-date).toString("yyyyMMdd_hhmmss") + ".png"
    } else {
        $filePath = "$curr\$filename.png"
    }
    $image = [System.Windows.Forms.Clipboard]::GetImage()

    if ($image -ne $null) {
        $image.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)
        Write-Host "Image saved to $filePath"
    } else {
        Write-Host "No image found in the clipboard."
    }
}

function rcw {
    $content = Get-Content -Path $PROFILE -Raw -Encoding UTF8
    $b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($content))

    $cmd = @"
`$dir = Split-Path `$PROFILE -Parent
if (!(Test-Path `$dir)) { New-Item -ItemType Directory -Path `$dir -Force | Out-Null }
if (Test-Path `$PROFILE) { Copy-Item `$PROFILE "`$PROFILE.bak.`$(Get-Date -Format 'yyyyMMdd_HHmmss')" -Force }
[IO.File]::WriteAllText(`$PROFILE, [Text.Encoding]::UTF8.GetString([Convert]::FromBase64String('$b64')), [Text.Encoding]::UTF8)
. `$PROFILE

"@
    $cmd | Set-Clipboard
    Write-Host '完整指令已複製到剪貼簿' -ForegroundColor Cyan
}

function rcl {
    $bashrcPath = "D:\public\linux\.bashrc"

    if (-not (Test-Path $bashrcPath)) {
        Write-Error "找不到檔案：$bashrcPath"
        return
    }

    $content = Get-Content -Path $bashrcPath -Raw -Encoding UTF8
    $b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($content))

    $linuxCmd = @"
cp ~/.bashrc ~/.bashrc.bak.`$(date +%Y%m%d_%H%M%S); echo '$b64' | base64 -d > ~/.bashrc && source ~/.bashrc && echo '✓ .bashrc 已更新並載入'
"@

    $linuxCmd | Set-Clipboard
    Write-Host "Linux 完整指令已複製到剪貼簿" -ForegroundColor Cyan
}
