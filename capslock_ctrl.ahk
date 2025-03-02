#SingleInstance force

; SetCapsLockState, AlwaysOff  
; SetStoreCapslockMode,Off


if not A_IsAdmin
{
   ; Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
    Run *RunAs "%A_AhkPath%" "%A_ScriptFullPath%"
   ExitApp
}
CapsLock::Control
