$PBExportHeader$u_style_bar.sru
$PBExportComments$Ribbon bar with text, border, fonts, type styles, justifications
forward
global type u_style_bar from UserObject
end type
type ddlb_font from dropdownlistbox within u_style_bar
end type
type ddlb_size from dropdownlistbox within u_style_bar
end type
type p_underline from picture within u_style_bar
end type
type p_italic from picture within u_style_bar
end type
type p_bold from picture within u_style_bar
end type
type p_right from picture within u_style_bar
end type
type p_center from picture within u_style_bar
end type
type p_left from picture within u_style_bar
end type
type ddlb_border from dropdownlistbox within u_style_bar
end type
type sle_text from singlelineedit within u_style_bar
end type
end forward

global type u_style_bar from UserObject
int Width=2825
int Height=156
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event ue_style_changed pbm_custom01
ddlb_font ddlb_font
ddlb_size ddlb_size
p_underline p_underline
p_italic p_italic
p_bold p_bold
p_right p_right
p_center p_center
p_left p_left
ddlb_border ddlb_border
sle_text sle_text
end type
global u_style_bar u_style_bar

type variables
string is_alignment
string is_type_change
end variables

forward prototypes
public subroutine uf_load_true_type_size ()
public function string uf_get_style (ref object_style astr_style)
public subroutine uf_set_style (object_style astr_style)
end prototypes

public subroutine uf_load_true_type_size ();//Loads the ddlb.size with appriopirate font sizes for
//True Type Fonts

int li_index

ddlb_size.AddItem (String(li_index," 8"))
ddlb_size.AddItem (String(li_index," 9"))

For li_index = 10 to 12
	ddlb_size.AddItem (String(li_index,"##"))
Next
For li_index = 14 to 72 step 2
	ddlb_size.AddItem (String(li_index,"##"))
Next

end subroutine

public function string uf_get_style (ref object_style astr_style);// return text
// this will populate the structure passed with the contents of the style bar.
// the last changed item on the style bar is returned directly by the function in a string

astr_style.text = sle_text.text

// return border
choose case ddlb_border.text
	case "None"
		astr_style.border = "0"
	case "Shadow Box"
		astr_style.border = "1"
	case "Box"
		astr_style.border = "2"
	case "Underline"
		astr_style.border = "4"
	case "3D Lowered"
		astr_style.border = "5"
	case "3D Raised"
		astr_style.border = "6"
	case "Resize"
		astr_style.border = "3"
end choose

// return font
astr_style.font_face = ddlb_font.text

// return font size
astr_style.font_height = ddlb_size.text

// return bold value
if p_bold.picturename = "pb_b_dn.bmp" then
	astr_style.font_weight = "700"
else
	astr_style.font_weight = "400"
end if

// return italic
if p_italic.picturename = "pb_i_dn.bmp" then
	astr_style.italic = "1"
else
	astr_style.italic = "0"
end if

// return underline
if p_underline.picturename = "pb_u_dn.bmp" then
	astr_style.underline = "1"
else
	astr_style.underline = "0"
end if

// return alignment
astr_style.alignment = is_alignment

return is_type_change

end function

public subroutine uf_set_style (object_style astr_style);//this will set the correct style bar positions and labels with passed a structure
//of type style 

string ls_text

// Set text
if astr_style.text = "" then
	hide (sle_text)
else
	sle_text.text = astr_style.text
	show (sle_text)
end if

// Set Border
choose case astr_style.border
	case "0"
		ls_text = "None"
	case "1"
		ls_text = "Shadow Box"
	case "2"
		ls_text = "Box"
	case "4"
		ls_text = "Underline"
	case "5"
		ls_text = "3D Lowered"
	case "6"
		ls_text = "3D Raised"
end choose
if ddlb_border.text <> ls_text then ddlb_border.text = ls_text

// Set font face
if ddlb_font.text <> astr_style.font_face then
	ddlb_font.text = astr_style.font_face
	Triggerevent (ddlb_font, selectionchanged!)
end if

// Set Font Height if a non-zero one was passed.
// Otherwise, let it default based on font face.
if astr_style.font_height <> "0" then
	if ddlb_size.text <> astr_style.font_height then ddlb_size.text = astr_style.font_height
end if

// Set Font Weight
if astr_style.font_weight = "400" then
	ls_text = "pb_b_up.bmp"
else
	ls_text = "pb_b_dn.bmp"
end if
if p_bold.picturename <> ls_text then p_bold.picturename = ls_text

// Set Italic
if astr_style.italic = "1" then
	ls_text = "pb_i_dn.bmp"
else
	ls_text = "pb_i_up.bmp"
end if
if p_italic.picturename <> ls_text then p_italic.picturename = ls_text

// Set Underline
if astr_style.underline = "1" then
	ls_text = "pb_u_dn.bmp"
else
	ls_text = "pb_u_up.bmp"
end if
if p_underline.picturename <> ls_text then p_underline.picturename = ls_text

// Set Alignment
choose case astr_style.alignment
	case "0"
		if p_left.picturename = "pb_l_up.bmp" then
			p_left.picturename  = "pb_l_dn.bmp"
			p_center.picturename = "pb_c_up.bmp"
			p_right.picturename = "pb_r_up.bmp"
		end if
	case "1"
		if p_right.picturename = "pb_r_up.bmp" then
			p_left.picturename = "pb_l_up.bmp"
			p_center.picturename = "pb_c_up.bmp"
			p_right.picturename = "pb_r_dn.bmp"
		end if
	case "2"
		if p_center.picturename = "pb_c_up.bmp" then
			p_left.picturename = "pb_l_up.bmp"
			p_center.picturename = "pb_c_dn.bmp"
			p_right.picturename = "pb_r_up.bmp"
		end if
end choose

is_alignment = astr_style.alignment

end subroutine

on u_style_bar.create
this.ddlb_font=create ddlb_font
this.ddlb_size=create ddlb_size
this.p_underline=create p_underline
this.p_italic=create p_italic
this.p_bold=create p_bold
this.p_right=create p_right
this.p_center=create p_center
this.p_left=create p_left
this.ddlb_border=create ddlb_border
this.sle_text=create sle_text
this.Control[]={this.ddlb_font,&
this.ddlb_size,&
this.p_underline,&
this.p_italic,&
this.p_bold,&
this.p_right,&
this.p_center,&
this.p_left,&
this.ddlb_border,&
this.sle_text}
end on

on u_style_bar.destroy
destroy(this.ddlb_font)
destroy(this.ddlb_size)
destroy(this.p_underline)
destroy(this.p_italic)
destroy(this.p_bold)
destroy(this.p_right)
destroy(this.p_center)
destroy(this.p_left)
destroy(this.ddlb_border)
destroy(this.sle_text)
end on

type ddlb_font from dropdownlistbox within u_style_bar
int X=1175
int Y=20
int Width=626
int Height=324
int TabOrder=30
string Text="System"
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Arial",&
"Courier New",&
"System",&
"Times New Roman"}
end type

on selectionchanged;//Selectionchanged script for ddlb_font

string ls_hold 

ls_hold = ddlb_size.text

ddlb_size.Reset( ) 

choose case this.text
	case "Arial"
		uf_load_true_type_size()
	case "Courier New"
		uf_load_true_type_size()		
	case "System"
		ddlb_size.AddItem(" 9")
		ddlb_size.AddItem("10")
	case "Times New Roman"
		uf_load_true_type_size()
end choose

ddlb_size.text = ls_hold

is_type_change = "Font"
parent.triggerevent("ue_style_changed")
end on

type ddlb_size from dropdownlistbox within u_style_bar
int X=1842
int Y=20
int Width=242
int Height=352
int TabOrder=40
string Text="15"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean AllowEdit=true
long TextColor=33554432
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;is_type_change = "Size"
parent.triggerevent("ue_style_changed")
end on

type p_underline from picture within u_style_bar
int X=2336
int Y=20
int Width=87
int Height=80
int TabOrder=70
string PictureName="pb_u_up.bmp"
end type

on clicked;//Clicked script for p_underline

if this.picturename = "pb_u_up.bmp" then
	this.picturename = "pb_u_dn.bmp"
else
	this.picturename = "pb_u_up.bmp"
end if

is_type_change = "underline"
parent.triggerevent("ue_style_changed")
end on

type p_italic from picture within u_style_bar
int X=2249
int Y=20
int Width=87
int Height=80
int TabOrder=60
string PictureName="pb_i_up.bmp"
end type

on clicked;//Clicked script for p_italic

if this.picturename = "pb_i_up.bmp" then
	this.picturename = "pb_i_dn.bmp"
else
	this.picturename = "pb_i_up.bmp"
end if

is_type_change = "italic"
parent.triggerevent("ue_style_changed")
end on

type p_bold from picture within u_style_bar
int X=2162
int Y=20
int Width=87
int Height=80
int TabOrder=50
string PictureName="pb_b_up.bmp"
end type

on clicked;//Clicked script for p_bold

if this.picturename = "pb_b_up.bmp" then
	this.picturename = "pb_b_dn.bmp"
else
	this.picturename = "pb_b_up.bmp"
end if

is_type_change = "Bold"
parent.triggerevent("ue_style_changed")
end on

type p_right from picture within u_style_bar
int X=2661
int Y=20
int Width=87
int Height=80
int TabOrder=100
string PictureName="pb_r_up.bmp"
end type

on clicked;//Clicked script for p_right

is_alignment = "1"
this.picturename = "pb_r_dn.bmp"
p_center.picturename = "pb_c_up.bmp"
p_left.picturename = "pb_l_up.bmp"

is_type_change = "right"
parent.triggerevent("ue_style_changed")

end on

type p_center from picture within u_style_bar
int X=2569
int Y=20
int Width=87
int Height=80
int TabOrder=90
string PictureName="pb_c_up.bmp"
end type

on clicked;//Clicked script for p_center

is_alignment = "2"
this.picturename = "pb_c_dn.bmp"
p_left.picturename = "pb_l_up.bmp"
p_right.picturename = "pb_r_up.bmp"

is_type_change = "center"
parent.triggerevent("ue_style_changed")

end on

type p_left from picture within u_style_bar
int X=2487
int Y=20
int Width=87
int Height=80
int TabOrder=80
string PictureName="pb_l_up.bmp"
end type

on clicked;//Clicked script for p_left

is_alignment = "0"
this.picturename = "pb_l_dn.bmp"
p_center.picturename = "pb_c_up.bmp"
p_right.picturename = "pb_r_up.bmp"


is_type_change = "left"
parent.triggerevent("ue_style_changed")
end on

type ddlb_border from dropdownlistbox within u_style_bar
int X=645
int Y=20
int Width=471
int Height=324
int TabOrder=20
string Text="None"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"None",&
"Shadow Box",&
"Box",&
"3D Lowered",&
"3D Raised",&
"Resize"}
end type

on selectionchanged;is_type_change = "border"

parent.triggerevent("ue_style_changed")
end on

type sle_text from singlelineedit within u_style_bar
int X=23
int Y=20
int Width=581
int Height=80
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Pointer="arrow!"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;is_type_change = "text"
parent.triggerevent("ue_style_changed")
end on

