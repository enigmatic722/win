function prompt {  
    " $([char]27)[38;5;69m$($executionContext.SessionState.Path.CurrentLocation)`r`n$([char]27)[39m> "
}

if(test-path "~\Documents\WindowsPowerShell\dir.ps1") {
    . ~\Documents\WindowsPowerShell\dir.ps1
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
function ll {
    $files = Get-ChildItem $args[0]
    $files
    Write-Host "total: $(($files|Measure-Object).Count)"
}
Set-Alias touch new-item
Set-Alias -Name v -Value vim
Set-Alias -Name n -Value notepad
Set-Alias -Name s -Value services.msc
Set-Alias -Name vs -Value code
Set-Alias -Name py -Value ipython
Set-Alias -Name fz -Value "C:\Program Files\FileZilla FTP Client\filezilla.exe"
Set-Alias -Name gs -Value Get-Service
Set-Alias -name ie -value "C:\Program Files\Internet Explorer\iexplore.exe"
Set-Alias -name ch -value "C:\Program Files\Google\Chrome\Application\chrome.exe"
Set-Alias -name tm -value taskmgr
Set-Alias -name curl -value curl.exe -Option AllScope -Force
Set-Alias -Name sc -Value sc.exe -Option AllScope -Force
Set-Alias -Name sm -Value servermanager -Option AllScope -Force
Set-Alias -Name who -Value quser -Option AllScope -Force
Set-Alias -Name inetmgr -Value C:\Windows\System32\inetsrv\InetMgr.exe

if(test-path "C:\Program Files\Notepad++\notepad++.exe") {
    Set-Alias -Name n -Value  "C:\Program Files\Notepad++\notepad++.exe"
}

function scgs {
    cmd /c "sc query state= all | find `"SERVICE_NAME`""
}

# Vi-Mode
Set-PSReadlineOption -EditMode vi
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

Set-PSReadlineKeyHandler -Chord Ctrl+[ -Function ViCommandMode -ViMode Insert
Set-PSReadLineKeyHandler -Chord Ctrl+[ -ViMode Command -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
    [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar()
}

# Set-PSReadlineKeyHandler -Chord Ctrl+Oem4 -Function ViCommandMode -ViMode Insert
# Set-PSReadLineKeyHandler -Chord Ctrl+Oem4 -ViMode Command -ScriptBlock {
#     [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
#     [Microsoft.PowerShell.PSConsoleReadLine]::ForwardChar()
# }

Set-PSReadLineKeyHandler -Key 'ctrl+n' -Function HistorySearchForward -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+n' -Function HistorySearchForward -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+j' -Function HistorySearchForward -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+j' -Function HistorySearchForward -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+k' -Function HistorySearchBackward -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+k' -Function HistorySearchBackward -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+p' -Function HistorySearchBackward -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+p' -Function HistorySearchBackward -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+l' -Function ForwardChar   -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+h' -Function BackwardChar  -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+a' -Function BeginningOfLine -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+e' -Function EndOfLine       -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+w' -Function ViBackwardDeleteGlob -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+u' -Function BackwardDeleteLine -ViMode Insert
Set-PSReadlineKeyHandler -Key 'ctrl+d' -Function ViExit
Set-PSReadLineKeyHandler -Key 'ctrl+l' -Function ForwardChar   -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+h' -Function BackwardChar  -ViMode Command
Set-PSReadLineKeyHandler -Key 'alt+j' -Function ScrollDisplayDownLine
Set-PSReadLineKeyHandler -Key 'alt+k' -Function ScrollDisplayUpLine
Set-PSReadLineKeyHandler -Key 'alt+j' -Function ScrollDisplayDownLine -ViMode Command
Set-PSReadLineKeyHandler -Key 'alt+k' -Function ScrollDisplayUpLine -ViMode Command
Set-PSReadLineKeyHandler -Key 'alt+J' -Function ScrollDisplayDown 
Set-PSReadLineKeyHandler -Key 'alt+K' -Function ScrollDisplayUp
Set-PSReadLineKeyHandler -Key 'alt+J' -Function ScrollDisplayDown -ViMode Command
Set-PSReadLineKeyHandler -Key 'alt+K' -Function ScrollDisplayUp -ViMode Command
Set-PSReadLineKeyHandler -Key 'alt+i' -Function ScrollDisplayTop
Set-PSReadLineKeyHandler -Key 'alt+;' -Function ScrollDisplayToCursor
Set-PSReadLineKeyHandler -Key 'alt+i' -Function ScrollDisplayTop -ViMode Command
Set-PSReadLineKeyHandler -Key 'alt+;' -Function ScrollDisplayToCursor -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+e' -Function ScrollDisplayDownLine -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+y' -Function ScrollDisplayUpLine -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+u' -Function ScrollDisplayUp -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+f' -Function ScrollDisplayDown -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+b' -Function ScrollDisplayUp -ViMode Command
Set-PSReadLineKeyHandler -Key 'V' -Function SelectAll -ViMode Command
Set-PSReadlineKeyHandler -Key 'ctrl+o' -Function ClearScreen
Set-PSReadlineKeyHandler -Key 'ctrl+o' -Function ClearScreen -ViMode Command

Set-PSReadlineKeyHandler -Key 'alt+e' -ViMode Command -ScriptBlock {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait("^%{TAB}")
}

Set-PSReadlineKeyHandler -Key 'alt+e' -ViMode Insert -ScriptBlock {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait("^%{TAB}")
}

Set-PSReadLineKeyHandler -Key 'v' -Function CaptureScreen -ViMode Command
Set-PSReadLineKeyHandler -Chord 'Y' -ViMode Command -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::SelectLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Copy()
}

# Set-PSReadLineKeyHandler -Chord 'y,y' -ViMode Command -ScriptBlock {
#     [Microsoft.PowerShell.PSConsoleReadLine]::SelectAll()
#     [Microsoft.PowerShell.PSConsoleReadLine]::Copy()
# }

Set-PSReadLineKeyHandler -Chord 'y' -function Copy -ViMode Command 
Set-PSReadLineKeyHandler -Key 'alt+L' -Function SelectForwardWord -ViMode Command
Set-PSReadLineKeyHandler -Key 'alt+L' -Function SelectForwardWord -ViMode Insert
Set-PSReadLineKeyHandler -Key 'alt+H' -Function SelectBackwardWord -ViMode Command
Set-PSReadLineKeyHandler -Key 'alt+H' -Function SelectBackwardWord -ViMode Insert

Set-PSReadLineKeyHandler -Key 'ctrl+x' -Function Cut -ViMode Insert
Set-PSReadLineKeyHandler -Key 'ctrl+r' -Function Redo -ViMode Command

Set-PSReadLineKeyHandler -Key 'ctrl+m' -Function GotoBrace -ViMode Command
Set-PSReadLineKeyHandler -Key 'ctrl+m' -Function ViGotoBrace -ViMode Insert

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

function pm {
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


if(Test-Path ~\Documents\WindowsPowerShell\vi.ps1) {
    . ~\Documents\WindowsPowerShell\vi.ps1
}

Remove-PSReadLineKeyHandler -Chord 'ctrl+t' # delete original keybinding
Set-PSReadLineKeyHandler -Key "'" -Function RepeatLastCharSearchBackwards -ViMode Command
Set-PSReadLineKeyHandler -Key 'd,m' -Function ViDeleteBrace -ViMode Command

function vihelp {
	 Get-PSReadLineKeyHandler -Bound -Unbound
}

Set-PSReadlineOption -BellStyle None
################################################################################################
## profile
function alsp {
  v C:\Users\Administrator\Documents\WindowsPowerShell\profile.ps1
}

function als {
	v C:\Users\Administrator\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
}

function alsdir {
    v C:\Users\Administrator\Documents\WindowsPowerShell\dir.ps1
}

## cd
function cdll {
    pushd $args[0] ; ls 
} 
Set-Alias -Name cd -Value cdll -Option AllScope -Force

function mvll {
    $ErrorActionPreference = 'Stop'
    Move-Item $args[0] $args[1] -verbose
    ll
}
Set-Alias -Name mv -Value mvll  -Option AllScope -Force

function cpll {
    Copy-Item $args[0] $args[1] -Recurse -Verbose
    ll $args[1]
}
Set-Alias -Name cp -Value cpll  -Option AllScope -Force

function cpFlat {
    Get-ChildItem -Path "$args[0]" -Recurse -Filter *.* | where { ! $_.PSIsContainer } | Copy-Item -Destination "$args[1]"
}

function rmCpToBk {
    $disk = (get-location).Drive.Name
    $time = (Get-Date).ToString("yyyyMMddHHmmss")

    $files = Get-Item $args[0]
    
    foreach($src in $files) {
        $basename = $src.Basename
        $ext = $src.Extension

        $target = "$basename.$time$ext"
        
        if(!$ext -and !($src -is [System.IO.DirectoryInfo])) {
            $target = ".$time.$basename"
        } 
        
        if($ext -and ($basename -eq $ext) -and ($src -is [System.IO.DirectoryInfo])) {
            $target = "$ext.$time"
        } 
        
        move-item $src "$disk`:/sp/`_recycle/$target" -force
    }
    ll (split-path $files | Sort-Object | get-unique)
}
Set-Alias -Name rm -Value rmCpToBk -Option AllScope -Force

function cdrec {
    cd "c:/sp/_recycle"
}

function cdred {
    cd "d:/sp/_recycle"
}

function bd() {
    popd ; ll
}

function cdln($target)
{
    if($target.EndsWith(".lnk"))
    {
        $sh = new-object -com wscript.shell
        $fullpath = resolve-path $target
        $targetpath = $sh.CreateShortcut($fullpath).TargetPath
        set-location $targetpath
    }
    else {
        set-location $target
    }
}

function mklnk {
	$src = $args[0]
	$trgt = $args[1]
	New-Item -ItemType SymbolicLink  -Path $src  -Target "$trgt"
}

## mkdir
function mkdirNcd {
    $dir = $args[0]
    New-Item -Path "$dir" -ItemType Directory ; cd $dir
}
Set-Alias -Name mkdir -Value mkdirNcd -Option AllScope -Force

function dl {
	ii ~\Downloads
}
## list
function lt {
    gci $args[0] | sort LastWriteTime
}

function ltr {
    gci $args[0] | sort LastWriteTime -desc
}

function ltgt {
    ls -r -file | ? { $_.LastWriteTime -gt (Get-Date).AddDays(-1) } | sort LastWriteTime
}

function ltgtd {
    ls -r -file | ? { $_.LastWriteTime -gt (Get-Date).AddDays(-1) } | sort DirectoryName | select DirectoryName -unique 
}

function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# function telnet {
#    Test-NetConnection $args[0] -port $args[1] -InformationLevel "Detailed"
# }

## find
function find {
    $file = $args[0]
	$result = Get-ChildItem -Path . -Filter $file -Recurse | Select fullname
    $items = ''
    foreach($item in $result) {
        echo $item.fullname
        $items += "'$($item.fullname)' "
    }
    if (-not ([string]::IsNullOrEmpty($items))) {
        $items | Set-Clipboard
        Write-Host "total: $(($result|Measure-Object).Count)"
    }
}

## find show relative
function findrl {
    $file = $args[0]
	$result = Get-ChildItem -Path . -Filter $file -Recurse | Resolve-Path -Relative
    $items = ''
    foreach($item in $result) {
        echo $item
        $items += "'$($item)' "
    }
    if (-not ([string]::IsNullOrEmpty($items))) {
        $items | Set-Clipboard
        Write-Host "total: $(($result|Measure-Object).Count)"
    }
}

function grepl {
    $file = $args[1]
    $txt = $args[0]
	$result = Get-ChildItem -Path . -Filter $file -Recurse | Select-String $txt -List | Select Path
    $items = ''
    foreach($item in $result) {
        echo $item.Path
        $items += "'$($item.Path)' "
    }
    if (-not ([string]::IsNullOrEmpty($items))) {
        $items | Set-Clipboard
        Write-Host "total: $(($result|Measure-Object).Count)"
    }
}

function greplw {
    $file = $args[0]
    $txt = $args[1]
	Get-ChildItem -Path . -Filter $file -Recurse | Select-String \b$txt\b -List | %{( "'" + $_.Path + "'")}
}

# function mvfindbyw {
#     $file = $args[0]
#     $txt = $args[1]
#     $dest = $args[2]
#     $result = Get-ChildItem -Path . -Filter $file -Recurse | Select-String \b$txt\b -List | Select path
#     echo $result
#     mv -Path $($result.path) -Destination $dest 
# }

## cp
function cpd {
  $d = (pwd).path 
  # $d.replace("\","/") | Set-Clipboard ; (pwd).path  | export-clixml -path ~\dir.xml
  $d.replace("\","/") | Set-Clipboard ; (pwd).path  | export-clixml -path ~\dir.xml
}

function cpdw {
	$d = (pwd).path 
    $d | Set-Clipboard
}

function cpdl {
	$d = (pwd).path
    $tail = $d.replace("\","/").replace(":","").substring(1)
    $head = $d.substring(0,1)
    if($head -eq "D") {
        $dir = "/mnt/d$tail"
    } else {
        $dir = "/mnt/c$tail"
    }
    $dir | Set-Clipboard
}

function cpf {
    Get-Item -Path "$args" | %{($_.Fullname).replace("\","/")} | Set-Clipboard
}

function cpc($source) {
    Set-Clipboard -Path $source
}

function cpn {
    (Get-Item $args).Name | Set-Clipboard
}

function cpnb {
    (Get-Item $args).BaseName | Set-Clipboard
}

function cpfw {
    Get-Item -Path "$args" | %{($_.Fullname)} | Set-Clipboard
}

function cpfl {
	$d = Get-ChildItem -Path "$args" | %{($_.Fullname).replace("\","/")}
    $tail = $d.substring(1)
    $head = $d.substring(0,1)
    if($head -eq "D") {
        $dir = "/mnt/d$tail"
    } else {
        $dir = "/mnt/c$tail"
    }
    $dir | Set-Clipboard
}

## dir
function cdpr {
    cd ~/Documents/WindowsPowerShell
}

function iipr {
    ii ~/Documents/WindowsPowerShell
}

function rmpr {
    if (test-path ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1) {
        ri ~/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
    }
}

function npr {
    notepad C:\Users\Administrator\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1
}

$d = "C:\Users\Administrator/desktop"
function d {
  ii ~/desktop
}
function cdd {
    cd ~/Desktop
}
function dd {
	ii d:\
}
function c {
	ii C:\
}
function cddd {
	cd d:/
}
function cdc {
    cd c:/
}
function cdst {
    cd "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
}
function st {
    ii "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup"
}
## vim
function vrc {
	v C:\Users\Administrator\.vimrc
}
## zip
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

function zip {
    $src = get-item $args[0]
    $parent = (split-path -parent $src)
    
    if (-not ([string]::IsNullOrEmpty($args[1]))) {
        $dest = $args[1]
    } else {
        $basename = $src.basename
        $dest =  "$parent\$basename.zip"
    }
    
    Compress-Archive -Path $src -DestinationPath $dest
    ll (split-path -parent $dest)
}

## readonly
function nro {
    Set-ItemProperty $args[0] -name IsReadOnly -value $false
}
function ro {
    Set-ItemProperty $args[0] -name IsReadOnly -value $true
}

## env
function env {
  rundll32 sysdm.cpl,EditEnvironmentVariables
}
function envad {
    SystemPropertiesAdvanced
}
function cpl {
    control panel
}
function hosts {
    n C:/Windows/System32/drivers/etc/hosts
}
function cdhosts {
    cd C:/Windows/System32/drivers/etc/
}

function setViCommandMode{
    [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
}

function mapTwoLetterFunc($a,$b,$func) {
  if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()) {
    $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    if ($key.Character -eq $b) {
        &$func
    } else {
      [Microsoft.Powershell.PSConsoleReadLine]::Insert("$a")
      # Representation of modifiers (like shift) when ReadKey uses IncludeKeyDown
      if ($key.Character -eq 0x00) {
        return
      } else {
        # Insert func above converts escape characters to their literals, e.g.
        # converts return to ^M. This doesn't.
        $wshell = New-Object -ComObject wscript.shell
        $wshell.SendKeys("{$($key.Character)}")
      }
    }
  }
}

function gh {
    get-hotfix | where-object { $_.InstalledBy -eq "NT AUTHORITY\SYSTEM" } | sort InstalledOn -ErrorAction SilentlyContinue | ft -autosize
}

if(!(test-path ~\dir.xml)) {
    new-item -itemtype file -path ~\dir.xml -force
    (pwd).path | export-clixml -path ~\dir.xml
}


function wft {
    Get-NetFirewallRule -displayname $args[0] |
        Format-Table -autosize -Property Name,
        DisplayName,
        @{Name='Protocol';Expression={($PSItem | Get-NetFirewallPortFilter).Protocol}},
        @{Name='LocalPort';Expression={($PSItem | Get-NetFirewallPortFilter).LocalPort}},
        @{Name='RemotePort';Expression={($PSItem | Get-NetFirewallPortFilter).RemotePort}},
        @{Name='RemoteAddress';Expression={($PSItem | Get-NetFirewallAddressFilter).RemoteAddress}},
        Enabled,
        Profile,
        Direction
}

function wfl {
    Get-NetFirewallRule -displayname $args[0] |
        Format-List -autosize -Property Name,
        DisplayName,
        @{Name='Protocol';Expression={($PSItem | Get-NetFirewallPortFilter).Protocol}},
        @{Name='LocalPort';Expression={($PSItem | Get-NetFirewallPortFilter).LocalPort}},
        @{Name='RemotePort';Expression={($PSItem | Get-NetFirewallPortFilter).RemotePort}},
        @{Name='RemoteAddress';Expression={($PSItem | Get-NetFirewallAddressFilter).RemoteAddress}},
        Enabled,
        Profile,
        Direction
}

function tasks {
    Get-ScheduledTask | 
    select taskname, 
    @{Name='Action';Expression={($PSItem.actions ).execute}}, 
    state, 
    @{Name='LastRunTime';Expression={($PSItem | Get-ScheduledTaskInfo).LastRunTime}},
    @{Name='LastTaskResult';Expression={($PSItem | Get-ScheduledTaskInfo).LastTaskResult}},
    @{Name='NextRunTime';Expression={($PSItem | Get-ScheduledTaskInfo).NextRunTime}},
    @{Name='NumberOfMissedRuns';Expression={($PSItem | Get-ScheduledTaskInfo).NumberOfMissedRuns}}
}


function wfp {
    get-NetFirewallRule -DisplayName $args[0] | Get-NetFirewallAddressFilter
}

function cybaddwf {
    $IPs = @() 
    New-NetFirewallRule -DisplayName "Cyberark" `
                        -Direction Inbound `
                        -Action Allow `
                        -Protocol TCP `
                        -Profile Any `
                        -RemoteAddress $IPs `
                        -LocalPort 135,445,139,3389
}

function initcyb {
    cybaddwf
    cybaddreg
}

function wfls {
    get-netfirewallrule | sort DisplayName | select DisplayName -unique
}

function wfget($name) {
    (Get-NetFirewallRule -DisplayName $name | Get-NetFirewallAddressFilter).RemoteAddress
}

function wfgetp($name) {
    Get-NetFirewallRule -DisplayName $name | Get-NetFirewallPortFilter
}

function wfadd($name, $newips) {
    $ips  = (Get-NetFirewallRule -DisplayName $name | Get-NetFirewallAddressFilter ).RemoteAddress
    
    if (!($ips -eq "Any")) {
        if ($ips -is [string]) {
            $ips = @($ips)
        }
        $newips = $ips + $newips
    }
    
    Set-NetFirewallRule -DisplayName $name -RemoteAddress $newips 
    (Get-NetFirewallRule -DisplayName $name | Get-NetFirewallAddressFilter).RemoteAddress
}

function size {
    gci -force "$args" -ErrorAction SilentlyContinue | ? { $_ -is [io.directoryinfo] } | % {
        $len = 0
        gci -recurse -force $_.fullname -ErrorAction SilentlyContinue | % { $len += $_.length }
        if($len -gt 10Mb) {
            $_.fullname, "`t`t`t{0:N2} GB" -f ($len / 1Gb)
        }
    }
}

function Analyze( $p, $f) {
    Get-ItemProperty $p |foreach {
       if (($_.DisplayName) -or ($_.version)) {
            [PSCustomObject]@{ 
                    From = $f;
                    Name = $_.DisplayName;
                    Version = $_.DisplayVersion;
                    # Install = $_.InstallDate
                    Publisher = $_.Publisher;
                    Path = if($_.DisplayIcon) {$_.DisplayIcon} else {$_.InstallSource} ;
             }
       } 
    }
# Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* | sort-object -property DisplayName | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize
# Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | sort-object -property DisplayName | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate | Format-Table –AutoSize
# Get-CimInstance Win32_Product | Sort-Object -property Name | Format-Table -Property Version, InstallDate, Name
}


function app {
    $s = @() 
    $s += Analyze 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' 64
    $s += Analyze 'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' 32
    $s += Analyze 'Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' 64
    $s += Analyze 'Registry::HKEY_CURRENT_USER\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' 32
    
    # Get-ItemProperty Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | sort-object -property DisplayName | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, "Inno Setup: App Path", DisplayIcon| Format-Table –AutoSize
    
    $s | Sort-Object -Property Name | ft
}


function out ($filename) {
    # $input for pipeline
    $Input | Out-File $filename -encoding UTF8
}


function gencsr {
    openssl req -new -newkey rsa:2048 -nodes -keyout server.key -out server.csr -config csr.conf 
    openssl req -in "server.csr" -noout -text 
}

function genp12($ext) {
    if (!($ext)) {
        $ext = "p12"
    }
    openssl pkcs12 -export -out server.$ext -inkey server.key -in server.cer -certfile ca.cer
}

function csr($path) {
    if ($path) {
        openssl req -in $path -noout -text 
    }
}

function pipeline_example {
  if ($MyInvocation.ExpectingInput) { # Pipeline input present.
    # $Input passes the collected pipeline input through.
    $Input | coreutils tail @args
  } else {
    coreutils tail @args
  }
}

function ad_install {
    get-windowsfeature -name rsat-ad*
    add-windowsfeature -name rsat-ad-powershell
}

# function np {
#         notepad C:/Users/Administrator/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
# }

function cert_all {
    Get-ChildItem Cert:\ -Recurse
} 

function cert_my {
    Get-ChildItem Cert:\LocalMachine\My | ft
    Get-ChildItem Cert:\CurrentUser\My | ft
}

function iip {
    ii (split-path -parent $args[0])
}

function cdp {
    cd (split-path -parent $args[0])
}


# reboot check
function info {
    $properties = @(
        @{n='TimeStamp';e={$_.TimeCreated}},
        # @{n='Id';e={$_.Id}},
        @{n='User';e={$_.Properties[6].Value}},
        # @{n='Msg';e={$_.message}},
        @{n='Reason/Application';e={$_.Properties[0].Value}},
        @{n='Id';e={$_.Id}},
        @{n='Action';e={if($_.Id -eq "6005") {$_.message} else {$_.Properties[4].Value}}}
    )
    # Get-WinEvent -FilterHashTable @{LogName='System'; ID=12, 13, 19, 41, 1001, 1074, 6005, 6008, 6009, 7045} | Sort-Object TimeCreated | Select $properties 
    Get-WinEvent -FilterHashTable @{LogName='System'; ID=19, 1074, 6005} | Sort-Object TimeCreated | Select $properties | ft
}

function evt($evtId) {
    $properties = @(
        @{n='TimeStamp';e={$_.TimeCreated}},
        @{n='User';e={$_.Properties[6].Value}},
        @{n='Reason/Application';e={$_.Properties[0].Value}},
        @{n='Action';e={$_.Properties[4].Value}},
        @{n='Id';e={$_.Id}},
        @{n='Msg';e={($_.message -split '\n')[0].trim()}}
    )
    Get-WinEvent -FilterHashTable @{LogName='System'; ID=$evtId} | Sort-Object TimeCreated | Select $properties | Format-Table -autosize
}

function evtt($hour) {
    $properties = @(
        @{n='TimeStamp';e={$_.TimeCreated}},
        @{n='ID';e={$_.ID}},
        @{n='User';e={$_.Properties[6].Value}},
        @{n='Reason/Application';e={$_.Properties[0].Value}},
        @{n='Action';e={$_.Properties[4].Value}}
    )
    Get-WinEvent -FilterHashTable @{LogName='System'; StartTime=(Get-Date).AddHours(-$hour)} | Select $properties | ft
}


function evt_login_3 {
    $properties = @(
        @{n='TimeStamp';e={$_.TimeCreated}},
        @{n='User';e={$_.Properties[6].Value}},
        @{n='Reason/Application';e={$_.Properties[0].Value}},
        @{n='Action';e={$_.Properties[4].Value}}
    )
    Get-WinEvent -FilterHashTable @{LogName='Security'; ID=4776} | Select $properties | Sort-Object -Descending "$_.TimeCreated"
    Get-WinEvent -FilterHashTable @{LogName='Security'; ID=4776} | select TimeCreated, message | fl
    Get-WinEvent -FilterHashTable @{LogName='Security'; ID=4776} -Newest 1000
    Get-WinEvent -FilterHashTable @{LogName='Security'; ID=4776; StartTime=(Get-Date).AddMinutes(-10)} | fl -property TimeCreated, message
}

function login($min) {
    Get-WinEvent -FilterHashTable @{LogName='Security'; ID=4776; StartTime=(Get-Date).AddMinutes(-$min)} | fl -property TimeCreated, message
}

function grant_full($f, $u) {
    # for query: ICACLS [file]
    ICACLS "$f" /grant:r "$u`:(OI)(CI)(F)" /t /C
}


function u {
    $ErrorActionPreference = 'SilentlyContinue'
    # $users = ((Get-LocalGroup).name | Get-LocalGroupMember) | sort | get-unique
    ((Get-LocalGroup).name | Get-LocalGroupMember) | sort | get-unique | %{$user = $_; [PSCustomObject]@{ 
        "User"   = $user.Name
        "SID" = $user.sid
        "Groups" = Get-LocalGroup | Where-Object {  $user.SID -in ($_ | Get-LocalGroupMember | Select-Object -ExpandProperty "SID") } | Select-Object -ExpandProperty "Name" 
    }} | Format-Table -AutoSize
}

function sid($user) {
    $ErrorActionPreference = 'SilentlyContinue'
    if($user) {
        $sid = (((Get-LocalGroup).name | Get-LocalGroupMember) | where {$_.name -eq "" -or $_.name -eq "$env:COMPUTERNAME\$user"} | sort | get-unique | select sid).sid
        set-clipboard $sid; 
        echo $sid.value
    } else {
        ((Get-LocalGroup).name | Get-LocalGroupMember) | sort | get-unique | %{$user = $_; [PSCustomObject]@{ 
            "User"   = $user.Name
            "SID" = $user.sid
        }} | Format-Table -AutoSize
    }
}

function gsid($group) {
    if ($group) {
        $sid = (get-localgroup | where {$_.name -eq $group}| select sid).sid
        Set-Clipboard $sid
        echo $sid.value
    } else {
        get-localgroup | select name, sid
    }
}

function lsid {
    get-localuser | select Name, SID, Enabled, Description
}

function lu {
    get-localuser | select Name, SID, Enabled, Description
}

function sdshow($service) {
    sc sdshow $service
}

function sdset($service, $user) {
    $sid = sid $user
    if (!($sid)) {
        $sid = gsid $user
    }
    if ($sid) {
        sc sdset $service "D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;IU)(A;;CCLCSWLOCRRC;;;SU)(A;;RPWPCR;;;$sid)S:(AU;FA;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;WD)"
        sc sdshow $service
    } else {
        echo "User or Group Not Exist!!!"
    }
}

function g {
    get-localgroup | select name, sid
}

function tlschk {
     [Net.ServicePointManager]::SecurityProtocol
}

# auto cd
$dir = import-clixml -Path ~\dir.xml
# $dir = import-clixml -Path ~\dir.xml
Set-Location -path $dir


# env var
function aetenv () {
    $env:OPENSSL_CONF = 'D:\Apache24\conf\openssl.cnf';
    $env:OPENSSL_CONF = 'C:\Program Files (x86)\Serena\Dimensions 14.3\CM\prog\openssl.cnf';
 C:\Program Files (x86)\Serena\Dimensions 14.3\CM\prog\openssl.cnf   
    set OPENSSL_CONF=D:\Apache24\conf\openssl.cnf
}

function listen {
    (Get-NetTCPConnection -state listen) | sort OwningProcess |
        Format-Table -autosize -Property OwningProcess,
        @{Name='Name';Expression={($PSItem | %{(get-process -id $_.OwningProcess)}).ProcessName}},
        LocalPort,
        State 
}


function lgof {
    # Start-Sleep -s 5; logoff
    ko; Start-Sleep -s 5; shutdown /l /f
}

function lgofn {
    shutdown /l /f
}
Set-PSReadLineKeyHandler -Key "Ctrl+alt+o" -ViMode Command -ScriptBlock {
    lgofn
}

Set-PSReadLineKeyHandler -Key "Ctrl+alt+o" -ViMode Insert -ScriptBlock {
    lgofn
}

function mklink($Link, $Target) {
    New-Item -ItemType SymbolicLink -Name $Link -Target $Target
}

function stinit {
    New-Item -ItemType SymbolicLink -Path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\powershell" -Target C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
}

function ps_cmd {
    Get-WmiObject Win32_Process -Filter "name = 'powershell.exe'" | Select-Object CommandLine
}

function s2p ($service) {
    $id = Get-CimInstance -Class Win32_Service -Filter "Name LIKE '%$service%'" | 
          Select-Object -ExpandProperty ProcessId
    ps -id $id      
          # Get-CimInstance -Class Win32_Service -Filter "JCICSecurityServiceV2" | 
}

function p2s ($ps) {
    Get-WmiObject win32_service | ?{$_.PathName -like "*$ps*"} | ft -autosize  Name, DisplayName, State, PathName, ProcessId
}

function pid2s ($ps) {
    Get-WmiObject win32_service | ?{$_.ProcessId -eq "$ps"} | ft -autosize  Name, DisplayName, State, PathName, ProcessId
}

function gsp ($service) {
    Get-WmiObject win32_service | ?{$_.Name -like "*$service*"} | ft -autosize  Name, DisplayName, State, PathName, ProcessId
}

function kch {
    $chrome_win = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "chrome" } 
    ## chrome or brave
    echo $chrome_win
    do {
        $chrome_win | foreach-object {$_.CloseMainWindow()} | out-null
        $chrome_win = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "chrome" } 
    } while($chrome_win)
}

function krmt {
    $window_tasks = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "mstsc"} 
    echo $window_tasks
    $window_tasks | foreach-object {$_.CloseMainWindow()} | out-null
    get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -eq "mstsc"} | stop-process
}

function ko {
    ## chrome
    kch
    
    ## apps
    $window_tasks = get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -ne "powershell" -and $_.processname -ne "SystemSettings"  -and $_.processname -ne "TextInputHost" -and $_.processname -ne "ShellExperienceHost"} 
    echo $window_tasks
    $window_tasks | foreach-object {$_.CloseMainWindow()} | out-null
    get-process | ? { $_.mainwindowtitle -ne "" -and $_.processname -ne "powershell" -and $_.processname -ne "SystemSettings" -and $_.processname -ne "TextInputHost" -and $_.processname -ne "ShellExperienceHost"} | stop-process
    
    ## explore
    ke
}

function a {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait("^%{TAB}")
}

# function ke {
#     (New-Object -ComObject Shell.Application).Windows() | Where-Object{$_.Name -eq "檔案總管"} | ForEach-Object{ $_.Quit() }
# }

function ke {
  $a = (New-Object -comObject Shell.Application).Windows() |
  ? { $_.FullName -ne $null} |
  ? { $_.FullName.toLower().Endswith('\explorer.exe') } 
  $a | % {  $_.Quit() }
}

function cdu {
    cd c:\users
}

function iiu {
    ii c:\users
}


function cdsp {
    cd D:/SP
}

function cddl {
    cd ~/Downloads
}

function w {
    start-process ms-settings:windowsupdate
}

function evt {
    eventvwr
}

function ts {
    control schedtasks
}

function fh($in) {
  Start-Process -FilePath C:\Windows\explorer.exe -ArgumentList "/select, ""$in"""  -WindowStyle maximized
}

$sp = "D:\sp"
function cdsp {
    cd $sp
}

Set-Alias -Name sp -Value iisp -Option AllScope -Force
function iisp {
    ii $sp
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

    #$folder.Self.InvokeVerb("Properties")
    $file.InvokeVerb("Properties")
}

function fpc {
    $shell = New-Object -ComObject Shell.Application
    $folder = $shell.NameSpace("C:\")
    $folder.Self.InvokeVerb("Properties")
}
  
function pc {
  explorer file:
} 

function p {
    Start-Process -FilePath "C:\Users\Administrator\Desktop\pwsh.lnk"
}

function pp {
    Start-Process -FilePath "C:\Users\Administrator\Desktop\pwsh.lnk"; exit
}

function cmdad {
    Start-Process -Verb RunAs cmd.exe 
}

function countf {
     (Get-ChildItem -recurse -File | Measure-Object).Count 
}

function countd {
     (Get-ChildItem -Directory | Measure-Object).Count 
}

function sys {
   control /name microsoft.system
}

function os {
    Get-ComputerInfo -Property WindowsProductName
}

function ip {
    $ip = (ipconfig | findstr "IPv4").split(':')[1].trim() 
    Set-Clipboard $ip
    # hostname
    echo $ip
}

function hn {
    $hn = hostname
    Set-Clipboard $hn
    echo $hn
}

function bk($path) {
    $f = gi $path
    $filename = split-path -leaf $f
    $today = (get-date).toString("yyyyMMdd")
    $newFilename = "$filename.bk$today"
    rename-item $f $newFilename
    ll $newFilename
}

function skipCertCheck2 {
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
    [System.Net.ServicePointManager]::SecurityProtocol = [Net.securityProtocolType]::Tls12
    $wc = New-Object System.Net.WebClient
    $wc.DownloadString('https://127.0.0.1:8443')
}
function se {
    Start-Process "ms-settings:"
}

function tsaddsh {
    if(test-path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\pwsh.lnk") {
        mv "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\pwsh.lnk" D:\sp\pwsh.lnk
    } elseif(test-path "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\powershell.lnk") {
        mv "~\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\powershell.lnk" D:\sp\pwsh.lnk
    }
    "ii D:\sp\pwsh.lnk" | Out-File -FilePath D:\sp\pwsh.ps1; cdd
    $user = whoami
    # $TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NonInteractive -NoProfile -ExecutionPolicy Bypass -File D:\sp\pwsh.ps1"
    $TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File D:\sp\pwsh.ps1"
    $TaskPrincipal = New-ScheduledTaskPrincipal -UserId $user -RunLevel Highest
    $TaskTrigger = New-ScheduledTaskTrigger -AtLogOn -User $user
    Register-ScheduledTask -TaskName "pwsh" -Action $TaskAction -Trigger $TaskTrigger -Principal $TaskPrincipal
    
    # $TaskTrigger = New-ScheduledTaskTrigger -Daily -At '9:00 AM'
    # $TaskPrincipal = New-ScheduledTaskPrincipal -UserId "NT AUTHORITY\SYSTEM" -RunLevel Highest -LogonType Service
    # $TaskSettings = New-ScheduledTaskSettingsSet -Hidden -Compatibility Win8 -DontStopIfGoingOnBatteries
    # $TaskAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NonInteractive -NoProfile -ExecutionPolicy Bypass -File D:\sp\pwsh.ps1"
}

function modifyts {
    $NewAction = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NonInteractive -NoProfile -File D:\sp\pwsh.ps1"
    Set-ScheduledTask -TaskName "pwsh" -Action $NewAction
    lgof
}
function watch {
    $cmd = $args -join ' '
    while($true) {
        Invoke-Expression $cmd
        sleep -Milliseconds 100
        cls
    }
}
function fqdn {
    $fqdn = [System.Net.Dns]::GetHostByName($env:computerName).HostName
    Set-Clipboard $fqdn
    echo $fqdn
}
