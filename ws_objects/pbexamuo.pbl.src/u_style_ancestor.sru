$PBExportHeader$u_style_ancestor.sru
$PBExportComments$Edit Box with 3 pictures to set style (bold, italic, underline)
forward
global type u_style_ancestor from UserObject
end type
type p_underline from picture within u_style_ancestor
end type
type p_italic from picture within u_style_ancestor
end type
type p_bold from picture within u_style_ancestor
end type
type sle_text from singlelineedit within u_style_ancestor
end type
end forward

global type u_style_ancestor from UserObject
int Width=1007
int Height=154
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
p_underline p_underline
p_italic p_italic
p_bold p_bold
sle_text sle_text
end type
global u_style_ancestor u_style_ancestor

type variables
string alignment
end variables

on u_style_ancestor.create
this.p_underline=create p_underline
this.p_italic=create p_italic
this.p_bold=create p_bold
this.sle_text=create sle_text
this.Control[]={ this.p_underline,&
this.p_italic,&
this.p_bold,&
this.sle_text}
end on

on u_style_ancestor.destroy
destroy(this.p_underline)
destroy(this.p_italic)
destroy(this.p_bold)
destroy(this.sle_text)
end on

type p_underline from picture within u_style_ancestor
int X=840
int Y=20
int Width=82
int Height=81
int TabOrder=40
string PictureName="pb_u_up.bmp"
end type

on clicked;//////////////////////////////////////////////////////////////////////
// Make the single line edit text underlined
//////////////////////////////////////////////////////////////////////

if this.picturename = "pb_u_up.bmp" then
	this.picturename = "pb_u_dn.bmp"
	sle_text.underline = true
else
	this.picturename = "pb_u_up.bmp"
	sle_text.underline = false
end if
end on

type p_italic from picture within u_style_ancestor
int X=758
int Y=20
int Width=82
int Height=81
int TabOrder=30
string PictureName="pb_i_up.bmp"
end type

on clicked;//////////////////////////////////////////////////////////////////////
// Make the single line edit text italic
//////////////////////////////////////////////////////////////////////

if this.picturename = "pb_i_up.bmp" then
	this.picturename = "pb_i_dn.bmp"
	sle_text.italic = true
else
	this.picturename = "pb_i_up.bmp"
	sle_text.italic = false
end if
end on

type p_bold from picture within u_style_ancestor
int X=676
int Y=20
int Width=82
int Height=81
int TabOrder=20
string PictureName="pb_b_up.bmp"
end type

on clicked;//////////////////////////////////////////////////////////////////////
// Make the single line edit text bold
//////////////////////////////////////////////////////////////////////

if this.picturename = "pb_b_up.bmp" then
	this.picturename = "pb_b_dn.bmp"
	sle_text.weight = 700
else
	this.picturename = "pb_b_up.bmp"
	sle_text.weight = 400
end if

end on

type sle_text from singlelineedit within u_style_ancestor
int X=18
int Y=20
int Width=577
int Height=81
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="u_style_ancestor"
string Pointer="arrow!"
long TextColor=33554432
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

