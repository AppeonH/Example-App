$PBExportHeader$u_numeric_edit.sru
$PBExportComments$Single line edit which only accepts numeric input
forward
global type u_numeric_edit from UserObject
end type
type sle_1 from singlelineedit within u_numeric_edit
end type
end forward

global type u_numeric_edit from UserObject
int Width=498
int Height=135
long BackColor=12632256
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
sle_1 sle_1
end type
global u_numeric_edit u_numeric_edit

on u_numeric_edit.create
this.sle_1=create sle_1
this.Control[]={ this.sle_1}
end on

on u_numeric_edit.destroy
destroy(this.sle_1)
end on

type sle_1 from singlelineedit within u_numeric_edit
event char pbm_enchange
int X=11
int Y=17
int Width=466
int Height=97
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Pointer="arrow!"
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on char;//////////////////////////////////////////////////////////////////////
// Only allow 0-9 to be entered into the SLE
//////////////////////////////////////////////////////////////////////

if Len (this.text) > 0 then
	if not IsNumber (this.text) then
		this.text = Left (this.text, Len (this.text) - 1)
		Beep (1)
	end if
end if
end on

