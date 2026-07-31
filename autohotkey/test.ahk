#Requires AutoHotkey v2.0

GetCurrentInputLocaleID() {
    WinID := WinGetID("A")
    ThreadID := DllCall("GetWindowThreadProcessId", "Ptr", WinID, "Ptr", 0)
    return DllCall("GetKeyboardLayout", "UInt", ThreadID, "UPtr")
}
SwitchChsEng() {
    InputLocaleID := GetCurrentInputLocaleID()
    ; 0x04090409 is English (US)
    if (InputLocaleID != 0x04090409) ; 67699721 in decimal
        ; Send("^#{Space}") ; Switch to Chinese
        Send("#{Space}") ; Switch to English
        Send("{Esc}")
    ; else
}

ForceSwitchEng(){
  PostMessage 0x0050, 0, 0x4090409,, "A"  ; 0x0050 is WM_INPUTLANGCHANGEREQUEST.
  ; Send("{Esc}")
}

~Esc:: ForceSwitchEng()

  ; $Esc:: SwitchChsEng()
; Esc::
; {
;   MsgBox "You pressed the Escape key!"
; }
