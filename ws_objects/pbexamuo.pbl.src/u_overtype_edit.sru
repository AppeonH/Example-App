$PBExportHeader$u_overtype_edit.sru
$PBExportComments$Single line edit which allows characters to be entered in overtype mode (default for sle is to insert characters)
forward
global type u_overtype_edit from singlelineedit
end type
end forward

global type u_overtype_edit from singlelineedit
int Width=754
int Height=87
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
event ue_keypress pbm_char
event ue_delchar pbm_custom01
end type
global u_overtype_edit u_overtype_edit

on ue_keypress;//////////////////////////////////////////////////////////////////////
// For each key that is pressed, delete the character that it was 
// entered over.
//////////////////////////////////////////////////////////////////////

this.SetRedraw (false)
this.PostEvent ('ue_delchar')



end on

on ue_delchar;//////////////////////////////////////////////////////////////////////
// Delete character at current position
//////////////////////////////////////////////////////////////////////

Send (Handle (this), 256,46, Long (0, 0))
this.SetRedraw (true)
end on

