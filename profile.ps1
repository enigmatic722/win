Import-Module oh-my-posh
Import-Module posh-git
Import-Module Terminal-Icons

$env:TERM = "xterm-256color"
Set-PoshPrompt -Theme pure
Set-PSReadLineOption -Colors @{"Parameter"="#808080"}
Set-PSReadLineOption -Colors @{"Operator"="#808080"}

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineOption -BellStyle None

if(test-path "$HOME\Documents\PowerShell\dir.ps1") {
    . $HOME\Documents\PowerShell\dir.ps1
}
if(test-path "$HOME\Documents\PowerShell\ch.ps1") {
    . $HOME\Documents\PowerShell\ch.ps1
}
if(test-path "$HOME\Documents\PowerShell\rmt.ps1") {
    . $HOME\Documents\PowerShell\rmt.ps1
}
if(test-path "$HOME\Documents\PowerShell\bookmark.ps1") {
    . $HOME\Documents\PowerShell\bookmark.ps1
}
if(test-path "$HOME\Documents\PowerShell\tools.ps1") {
    . $HOME\Documents\PowerShell\tools.ps1
}

# function prompt {  
#     " $([char]27)[38;5;69m$($executionContext.SessionState.Path.CurrentLocation)`r`n$([char]27)[39m> "
# }

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

            move-item $src "$disk`:/`_recycle/$target" -force
        }
        ll
    }
}
function cdrec {
    cd "c:/_recycle"
}
function cdred {
    cd "d:/_recycle"
}
Set-Alias -Name rm -Value rmCpToBk -Option AllScope -Force

function alsrmt {
    v $HOME\Documents\PowerShell\rmt.ps1
}
function bm {
    v $HOME\Documents\PowerShell\bookmark.ps1
}

# Vi-Mode
Set-PSReadlineOption -EditMode vi
Write-Host -NoNewLine "`e[5 q"

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        Write-Host -NoNewLine "`e[1 q"
    } else {
        Write-Host -NoNewLine "`e[5 q"
    }
}

Set-PSReadlineKeyHandler -Chord Ctrl+Oem4 -Function ViCommandMode -ViMode Insert
Set-PSReadLineKeyHandler -Chord Ctrl+Oem4 -ViMode Command -ScriptBlock {
	[Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
	[Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar()
}
# Set-PSReadLineKeyHandler -Key 'ctrl+[' -Function ViCommandMode -ViMode Insert
# Set-PSReadLineKeyHandler -Key 'ctrl+[' -Function ViCommandMode -ViMode Command
# Set-PSReadlineKeyHandler -Chord alt+l -Function ViCommandMode

Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange
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

Set-PSReadLineKeyHandler -Key 'shift+end' -Function SelectLine -ViMode Command
Set-PSReadLineKeyHandler -Key 'shift+end' -Function SelectLine -ViMode Insert
Set-PSReadLineKeyHandler -Key 'shift+home' -Function SelectBackwardsLine -ViMode Command
Set-PSReadLineKeyHandler -Key 'shift+home' -Function SelectBackwardsLine -ViMode Insert
Set-PSReadLineKeyHandler -Key 'shift+leftArrow' -Function SelectBackwardChar -ViMode Command
Set-PSReadLineKeyHandler -Key 'shift+leftArrow' -Function SelectBackwardChar -ViMode Insert
Set-PSReadLineKeyHandler -Key 'shift+rightArrow' -Function SelectForwardChar -ViMode Command
Set-PSReadLineKeyHandler -Key 'shift+rightArrow' -Function SelectForwardChar -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+shift+leftArrow' -Function SelectBackwardWord -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+shift+leftArrow' -Function SelectBackwardWord -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+shift+rightArrow' -Function SelectForwardWord -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+shift+rightArrow' -Function SelectForwardWord -ViMode Insert

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
function p {
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
function vihelp {
	 Get-PSReadLineKeyHandler -Bound -Unbound
}

## unbound keybinding
Remove-PSReadLineKeyHandler -Key 'ctrl+w' -ViMode Command
Remove-PSReadLineKeyHandler -Key 'ctrl+w' -ViMode Command

################


Set-Alias c Set-Clipboard
Set-Alias gwe Get-WinEvent
Set-Alias t psmux
Set-Alias tsk tshark
Set-Alias wsk wireshark
Set-Alias regexp D:\dev_tool\RegistryExplorer\RegistryExplorer.exe
Set-Alias out out-file
Set-Alias idr idris
Set-Alias v nvim
Set-Alias n notepad++
Set-Alias vs code
Set-Alias py python
Set-Alias ipy ipython
Set-Alias envad SystemPropertiesAdvanced
Set-Alias man get-help
Set-Alias nc ncat
Set-Alias touch New-Item
Set-Alias s services.msc
Set-Alias ssh "D:\Program Files\Git\usr\bin\ssh.exe"
Set-Alias ts taskschd.msc

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
    pushd $args[0];ll; (pwd).path | export-clixml -path D:\dir.xml
}
function cdnoll {
    pushd $args[0] ; (pwd).path | export-clixml -path D:\dir.xml
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
    # $tgrtdir = (Split-Path $files -Parent) | sort | get-unique
    $tgrtdir = (Split-Path $files -Parent) | get-unique
    # $tgrtdir = (Split-Path $files -Parent)
    ll $tgrtdir
}
Set-Alias -Name cp -Value cpll  -Option AllScope -Force

$d = "~/Desktop"
$dd = "d:/"
$dl = "d:\Downloads\"
function dl {
	# ii $HOME\Downloads\
	ii d:\Downloads\
}
function cddl {
	# cd $HOME\Downloads\
	cd d:\Downloads\
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


## tool
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
	# Get-ChildItem -Path . -Filter $arg0 -Recurse -Name
	Get-ChildItem -Path . -Filter $arg0 -Recurse | %{$_.Fullname}
}

function grepl { # findby
    $txt = $args[0]
    $file = $args[1]
	Get-ChildItem -Path . -Filter $file -Recurse | Select-String $txt -List | Select Path
}

function als {
    set-location $HOME\Documents\PowerShell\
    v $HOME\Documents\PowerShell\profile.ps1
}

function hosts {
    v C:/Windows/System32/drivers/etc/hosts
}

function vrc {
    v ~/.vimrc
}

function trc {
    v ~/.tmux.conf
}
function nvrc {
    cdnoll $HOME\AppData\Local\nvim\
    nvim .
}
function nve { $input | Out-File -Encoding utf8 $env:TEMP\nv.txt; nvim $env:TEMP\nv.txt }
Set-Alias -Name nv -Value nve  -Option AllScope -Force

function nvcl {
	rm $HOME\AppData\Local\nvim-data\shada\ -r -fo
}
function vset {
	v $HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
}
#
## cp path
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

function mklnk {
	$lnk = $args[0]
	$trgt = $args[1]
	New-Item -ItemType SymbolicLink  -Path $lnk  -Target "$trgt"
}
function ad {
	Start-Process -Verb RunAs pwsh -ArgumentList "-WindowStyle Maximized"
}
function cpl {
    control panel
}
##################
# Variables
## Profile Path
$scriptFolder = Split-Path -Parent $MyInvocation.MyCommand.Path
$global:DefaultUser = [System.Environment]::UserName
$env:POSH_SESSION_DEFAULT_USER = [System.Environment]::UserName

function size {
    gci -force "$args" -ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] } | % {
        $len = 0
        gci -recurse -force $_.fullname -ErrorAction SilentlyContinue | % { $len += $_.length }
        # echo $len
        if($len -gt 10Mb) {
            $_.fullname, "`t`t`{0:N2} GB" -f ($len / 1Gb)
        }
    }
}

function td {
    #This will configure the Windows taskbar to auto-hide
    [cmdletbinding(SupportsShouldProcess)]
    [Alias("Hide-TaskBar")]
    [OutputType("None")]
    Param()

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        $RegPath = 'HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'
    } #begin
    Process {
        if (Test-Path $regpath) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Auto Hiding Windows 10 TaskBar"
            $RegValues = (Get-ItemProperty -Path $RegPath).Settings
            $RegValues[8] = 3

            Set-ItemProperty -Path $RegPath -Name Settings -Value $RegValues

            if ($PSCmdlet.ShouldProcess("Explorer", "Restart")) {
                #Kill the Explorer process to force the change
                Stop-Process -Name explorer -Force
            }
        }
        else {
            Write-Warning "Can't find registry location $regpath."
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

}

Function te {
    #This will disable the Windows taskbar auto-hide setting
    [cmdletbinding(SupportsShouldProcess)]
    [Alias("Show-TaskBar")]
    [OutputType("None")]
    Param()

    Begin {
        Write-Verbose "[$((Get-Date).TimeofDay) BEGIN  ] Starting $($myinvocation.mycommand)"
        $RegPath = 'HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3'
    } #begin
    Process {
        if (Test-Path $regpath) {
            Write-Verbose "[$((Get-Date).TimeofDay) PROCESS] Auto Hiding Windows 10 TaskBar"
            $RegValues = (Get-ItemProperty -Path $RegPath).Settings
            $RegValues[8] = 2

            Set-ItemProperty -Path $RegPath -Name Settings -Value $RegValues

            if ($PSCmdlet.ShouldProcess("Explorer", "Restart")) {
                #Kill the Explorer process to force the change
                Stop-Process -Name explorer -Force
            }
        }
        else {
            Write-Warning "Can't find registry location $regpath."
        }
    } #process
    End {
        Write-Verbose "[$((Get-Date).TimeofDay) END    ] Ending $($myinvocation.mycommand)"
    } #end

}

if(test-path "D:\dir.xml") {
    $dir = import-clixml -Path D:\dir.xml
    Set-Location -path $dir
}

if(!(test-path "D:\dir.xml")) {
    (pwd).path | export-clixml -path D:\dir.xml
    mkdir "c:/_recycle"
    mkdir "d:/_recycle"
}

## lang
function initpy {
    ipython profile create
    ipython locate profile
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

function bl {
    bthprops.cpl
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
    ## chrome or brave
    echo $brave_win
    do {
        $brave_win | foreach-object {$_.CloseMainWindow()} | out-null
        $brave_win = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "brave" } 
    } while($brave_win)
    
    ## apps open window
    $window_tasks = get-process | ? { $_.mainwindowtitle -ne "" -and $_.mainwindowtitle -ne "Clock" -and $_.processname -ne "WindowsTerminal" -and $_.processname -ne "TextInputHost" -and $_.processname -ne "ApplicationFrameHost" -or $_.processname -eq "SystemSettings"} 
    echo $window_tasks
    $window_tasks | foreach-object {$_.CloseMainWindow()} | out-null
    # $unclosable = get-process | ? { $_.mainwindowtitle -ne "" -and $_.mainwindowtitle -ne "Clock" -and $_.processname -ne "wezterm-gui" -and $_.processname -ne "TextInputHost" -and $_.processname -ne "ApplicationFrameHost" -or $_.processname -eq "SystemSettings"} 
    # $unclosable | foreach-object {cmd /C "wmic process where name='$($_.processname).exe' call terminate > NUL"}
    get-process | ? { $_.mainwindowtitle -ne "" -and $_.mainwindowtitle -ne "Clock" -and $_.processname -ne "wezterm-gui" -and $_.processname -ne "TextInputHost" -and $_.processname -ne "ApplicationFrameHost" -or $_.processname -eq "SystemSettings"} | stop-process
    
    ke
}
    
function kch {
    $chrome_win = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "brave" } 
    ## chrome or brave
    echo $chrome_win
    do {
        $chrome_win | foreach-object {$_.CloseMainWindow()} | out-null
        $chrome_win = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "brave" } 
    } while($chrome_win)
}

function weid($path, $id) {
    $file = split-path $path -leaf
    Get-WinEvent -Path $file -Oldest | where {$_.id -eq $id} |  ForEach-Object {
        $xml = [xml]$_.ToXml()
        
        # 先把 EventData 整理成 Hashtable
        $eventData = [ordered]@{}
        if ($xml.Event.EventData.Data) {
            foreach ($data in @($xml.Event.EventData.Data)) {
                if ($data.Name) {
                    $eventData[$data.Name] = $data.'#text'
                }
            }
        }
        
        # 建立物件：只有 EventData 轉成 JSON 字串
        [PSCustomObject]@{
            # TimeCreated      = $_.TimeCreated.ToUniversalTime().ToString('yyyy-MM-dd HH:mm:ss')
            TimeCreated      = $_.TimeCreated.ToUniversalTime().ToString('dd/MM/yyyy HH:mm:ss')
            Id               = $_.Id
            UserId               = $_.Id
            LevelDisplayName = $_.LevelDisplayName
            ProviderName     = $_.ProviderName
            MachineName      = $_.MachineName
            RecordId         = $_.RecordId
            ProcessId        = $_.ProcessId
            ThreadId         = $_.ThreadId
            Message          = $_.Message
            EventDataJson    = ($eventData | ConvertTo-Json -Depth 5)   # 這裡才轉 JSON
        }
    } | Format-List * | out-file ".\id-$id-$file.log"        
}

function wek($path, $key) {
    $file = split-path $path -leaf
    Get-WinEvent -Path $file -Oldest | ForEach-Object {
        $xml = [xml]$_.ToXml()
        
        # 先把 EventData 整理成 Hashtable
        $eventData = [ordered]@{}
        if ($xml.Event.EventData.Data) {
            foreach ($data in @($xml.Event.EventData.Data)) {
                if ($data.Name) {
                    $eventData[$data.Name] = $data.'#text'
                }
            }
        }
        $eventDataJson = ($eventData | ConvertTo-Json -Depth 5)
        # write-host "$eventDataJson"
        if ($eventDataJson.Contains($key)) {
            # 建立物件：只有 EventData 轉成 JSON 字串
            [PSCustomObject]@{
                # TimeCreated      = $_.TimeCreated.ToUniversalTime().ToString('yyyy-MM-dd HH:mm:ss')
                TimeCreated      = $_.TimeCreated.ToUniversalTime().ToString('dd/MM/yyyy HH:mm:ss')
                Id               = $_.Id
                UserId               = $_.Id
                LevelDisplayName = $_.LevelDisplayName
                ProviderName     = $_.ProviderName
                MachineName      = $_.MachineName
                RecordId         = $_.RecordId
                ProcessId        = $_.ProcessId
                ThreadId         = $_.ThreadId
                Message          = $_.Message
                EventDataJson    = $eventDataJson  # 這裡才轉 JSON
            }
        } 
    } | Format-List * | out-file ".\key-$key-$file.log"        
}

function jf {
    (Get-Content -LiteralPath $args[0] -Raw) -split "`r?`n" | Where-Object { $_.Trim() } | ForEach-Object { ConvertFrom-Json $_ } | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $args[0]
}

function i($filename) {
# Add the necessary assembly for clipboard operations
    Add-Type -AssemblyName System.Windows.Forms

    $curr = (pwd).path 
# Try to get the image from the clipboard
    if (!($filename)) {
        $filePath = "$curr\tmp_" + (get-date).toString("yyyyMMdd_hhmmss") + ".png"
    } else {
        $filePath = "$curr\$filename.png"
    }
    $image = [System.Windows.Forms.Clipboard]::GetImage()


# Check if an image was found and save it
    if ($image -ne $null) {
        $image.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png) # You can change the format (e.g., Png, Bmp)
        Write-Host "Image saved to $filePath"
    } else {
        Write-Host "No image found in the clipboard."
    }
}

$env:VIRTUAL_ENV_DISABLE_PROMPT = 1
