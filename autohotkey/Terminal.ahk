#Requires AutoHotkey v2.0

home_dir := EnvGet("USERPROFILE")
#t::
{
  Run "wt", home_dir
  ; msgbox home_dir
}




