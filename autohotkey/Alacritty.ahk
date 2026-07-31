; #Requires AutoHotkey v2.0
;
; home_dir := EnvGet("USERPROFILE")
; #k::
; {
;   Run "alacritty", home_dir
;   ; msgbox home_dir
; }


#Requires AutoHotkey v2.0

home_dir := EnvGet("USERPROFILE")
; #k::
; {
;   Run "alacritty", home_dir
;   ; msgbox home_dir
; }


#k:: {
    ; The Run function in v2 returns the process ID (PID)
    ; directly when a variable is passed by reference.
    ; Use the & symbol to get a reference to the variable `procId`.
    procId := Run("C:\Users\linyun\scoop\apps\alacritty\current\alacritty.exe",,, "pid")

    ; WinWait is a function in v2, so it uses parentheses and
    ; requires the target to be a string.
    ; "ahk_pid " is a string literal, and procId is the variable.
    ; The period (.) is the concatenation operator in v2.
    WinWait("ahk_pid " . procId)
    
    ; WinActivate is also a function.
    ; We activate the window using the same "ahk_pid" syntax.
    WinActivate("ahk_pid " . procId)

    return
}






