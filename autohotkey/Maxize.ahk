#Requires AutoHotkey v3.0

home_dir := EnvGet("USERPROFILE")
F12::
{
if WinGetMinMax("A") = 0  ; If window is not maximized
    WinMaximize("A")      ; Maximize it
else                      ; If window is maximized
    WinRestore("A")       ; Restore it

}

