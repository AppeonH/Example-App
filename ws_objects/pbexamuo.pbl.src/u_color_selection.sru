$PBExportHeader$u_color_selection.sru
$PBExportComments$Color selector, with SLEs and HScrollBars for R,G,B
forward
global type u_color_selection from UserObject
end type
type st_3 from statictext within u_color_selection
end type
type st_2 from statictext within u_color_selection
end type
type st_1 from statictext within u_color_selection
end type
type hsb_green from hscrollbar within u_color_selection
end type
type hsb_red from hscrollbar within u_color_selection
end type
type sle_blue from singlelineedit within u_color_selection
end type
type sle_green from singlelineedit within u_color_selection
end type
type sle_red from singlelineedit within u_color_selection
end type
type hsb_blue from hscrollbar within u_color_selection
end type
type rr_1 from roundrectangle within u_color_selection
end type
end forward

global type u_color_selection from UserObject
int Width=754
int Height=458
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event color_changed pbm_custom01
st_3 st_3
st_2 st_2
st_1 st_1
hsb_green hsb_green
hsb_red hsb_red
sle_blue sle_blue
sle_green sle_green
sle_red sle_red
hsb_blue hsb_blue
rr_1 rr_1
end type
global u_color_selection u_color_selection

type variables
int   ii_r, ii_g, ii_b
end variables

forward prototypes
public subroutine uf_set_rgb (long al_rgb)
public function long uf_get_rgb ()
end prototypes

public subroutine uf_set_rgb (long al_rgb);//////////////////////////////////////////////////////////////////////
//
// Function: uf_set_rgb
//
// Purpose: initialize the RGB values on this user object to the
//				long value that is passed to this function
//
//	Scope: public
//
//	Arguments: al_rgb		the RGB value that you want to use to set
//								the RGB values on this user object
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

// set the red color value
ii_r = Mod (al_rgb, 256)
al_rgb = al_rgb / 256

// set the green color value
ii_g = Mod (al_rgb, 256)
al_rgb = al_rgb / 256

// set the blue color value
ii_b = Mod (al_rgb, 256)

// set the fill color on the 'test color palette' to the current RGB value
rr_1.fillcolor = rgb (ii_r, ii_g, ii_b)

// set the horizontal scrollbars to the correct positions
hsb_red.position = ii_r
hsb_green.position = ii_g
hsb_blue.position = ii_b

// set the red, green, and blue text values to the correct values.
sle_red.text = String (ii_r)
sle_green.text = String (ii_g)
sle_blue.text = String (ii_b)


end subroutine

public function long uf_get_rgb ();//////////////////////////////////////////////////////////////////////
//
// Function: uf_get_rgb
//
// Purpose: returns the current RGB value for this user object
//
//	Scope: public
//
//	Arguments: none	
//
//	Returns: long		the current RGB value for this user object
//
//////////////////////////////////////////////////////////////////////

return RGB (ii_r, ii_g, ii_b)
end function

on u_color_selection.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.hsb_green=create hsb_green
this.hsb_red=create hsb_red
this.sle_blue=create sle_blue
this.sle_green=create sle_green
this.sle_red=create sle_red
this.hsb_blue=create hsb_blue
this.rr_1=create rr_1
this.Control[]={ this.st_3,&
this.st_2,&
this.st_1,&
this.hsb_green,&
this.hsb_red,&
this.sle_blue,&
this.sle_green,&
this.sle_red,&
this.hsb_blue,&
this.rr_1}
end on

on u_color_selection.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.hsb_green)
destroy(this.hsb_red)
destroy(this.sle_blue)
destroy(this.sle_green)
destroy(this.sle_red)
destroy(this.hsb_blue)
destroy(this.rr_1)
end on

type st_3 from statictext within u_color_selection
int X=43
int Y=324
int Width=153
int Height=71
boolean Enabled=false
string Text="Blue:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_color_selection
int X=8
int Y=228
int Width=193
int Height=71
boolean Enabled=false
string Text="Green:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=65280
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_color_selection
int X=68
int Y=135
int Width=132
int Height=71
boolean Enabled=false
string Text="Red:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=255
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type hsb_green from hscrollbar within u_color_selection
int X=392
int Y=231
int Width=310
int Height=42
int TabOrder=30
boolean Enabled=false
int MaxPosition=255
end type

on pageright;//////////////////////////////////////////////////////////////////////
// increment the green color value by 50
//////////////////////////////////////////////////////////////////////

if ii_g > 205 then
	ii_g = 255
else
	ii_g = ii_g + 50
end if
sle_green.text = String (ii_g)
this.position = ii_g

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ("color_changed")
end on

on lineleft;/////////////////////////////////////////////////////////////////////
// Decrement the green color value by 10
/////////////////////////////////////////////////////////////////////

if ii_g < 10 then
	ii_g = 0
else
	ii_g = ii_g - 10
end if
sle_green.text = String (ii_g)
this.position = ii_g
rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)

parent.TriggerEvent ('color_changed')
end on

on lineright;//////////////////////////////////////////////////////////////////////
// increment the green color value by 10
//////////////////////////////////////////////////////////////////////

if ii_g > 245 then
	ii_g = 255
else
	ii_g = ii_g + 10
end if
sle_green.text = String (ii_g)
this.position = ii_g

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ("color_changed")
end on

on moved;/////////////////////////////////////////////////////////////////////
// Change the green color value based on current position of scrollbar
/////////////////////////////////////////////////////////////////////

ii_g = this.position
sle_green.text = String (ii_g)

// Change the test palette color
rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ('color_changed')
end on

on pageleft;//////////////////////////////////////////////////////////////////////
// Decrement the green color value by 50
//////////////////////////////////////////////////////////////////////

if ii_g < 50 then
	ii_g = 0
else
	ii_g = ii_g - 50
end if
sle_green.text = String (ii_g)
this.position = ii_g

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ("color_changed")
end on

type hsb_red from hscrollbar within u_color_selection
int X=392
int Y=141
int Width=310
int Height=42
int TabOrder=10
boolean Enabled=false
int MaxPosition=255
end type

on lineright;//////////////////////////////////////////////////////////////////////
// increment the red color value by 10
//////////////////////////////////////////////////////////////////////

if ii_r > 245 then
	ii_r = 255
else
	ii_r = ii_r + 10
end if
sle_red.text = String (ii_r)
this.position = ii_r

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ("color_changed")
end on

on pageleft;//////////////////////////////////////////////////////////////////////
// Decrement the red color value by 50
//////////////////////////////////////////////////////////////////////

if ii_r < 50 then
	ii_r = 0
else
	ii_r = ii_r - 50
end if
sle_red.text = String (ii_r)
this.position = ii_r

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ("color_changed")
end on

on lineleft;/////////////////////////////////////////////////////////////////////
// Decrement the red color value by 10
/////////////////////////////////////////////////////////////////////

if ii_r < 10 then
	ii_r = 0
else
	ii_r = ii_r - 10
end if
sle_red.text = String (ii_r)
this.position = ii_r
rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)

parent.TriggerEvent ('color_changed')
end on

on moved;/////////////////////////////////////////////////////////////////////
// Change the red color value based on current position of scrollbar
/////////////////////////////////////////////////////////////////////

ii_r = this.position
sle_red.text = String (ii_r)

// Change the test palette color
rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ('color_changed')
end on

on pageright;//////////////////////////////////////////////////////////////////////
// increment the red color value by 50
//////////////////////////////////////////////////////////////////////

if ii_r > 205 then
	ii_r = 255
else
	ii_r = ii_r + 50
end if
sle_red.text = String (ii_r)
this.position = ii_r

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ("color_changed")
end on

type sle_blue from singlelineedit within u_color_selection
int X=225
int Y=324
int Width=150
int Height=71
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
string Pointer="arrow!"
long TextColor=16777215
long BackColor=16711680
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on getfocus;// select the text when this single line edit get focus

this.SelectText (1, Len (this.text))
end on

on modified;//////////////////////////////////////////////////////////////////////
// Change the blue color value based on the data entered
//////////////////////////////////////////////////////////////////////

int	li_new_value


if IsNumber (this.text) then
	li_new_value = Integer (this.text)
	if li_new_value < 0 or li_new_value > 255 then
		Beep (1)
		this.text = String (ii_b)
	else
		ii_b = li_new_value
		rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
		hsb_blue.position = ii_b
		parent.TriggerEvent ("color_changed")
	end if
else
	Beep (1)
	this.text = String (ii_b)
end if


end on

type sle_green from singlelineedit within u_color_selection
int X=225
int Y=228
int Width=150
int Height=77
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
string Pointer="arrow!"
long TextColor=16777215
long BackColor=65280
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on getfocus;// select the text when this single line edit get focus

this.SelectText (1, Len (this.text))
end on

on modified;//////////////////////////////////////////////////////////////////////
// Change the green color value based on the data entered
//////////////////////////////////////////////////////////////////////

int	li_new_value


if IsNumber (this.text) then
	li_new_value = Integer (this.text)
	if li_new_value < 0 or li_new_value > 255 then
		Beep (1)
		this.text = String (ii_g)
	else
		ii_g = li_new_value
		rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
		hsb_green.position = ii_g
		parent.TriggerEvent ("color_changed")
	end if
else
	Beep (1)
	this.text = String (ii_g)
end if


end on

type sle_red from singlelineedit within u_color_selection
int X=225
int Y=135
int Width=150
int Height=77
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
string Pointer="arrow!"
long TextColor=16777215
long BackColor=255
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on getfocus;// select the text when this single line edit get focus

this.SelectText (1, Len (this.text))
end on

on modified;//////////////////////////////////////////////////////////////////////
// Change the red color value based on the data entered
//////////////////////////////////////////////////////////////////////

int	li_new_value


if IsNumber (this.text) then
	li_new_value = Integer (this.text)
	if li_new_value < 0 or li_new_value > 255 then
		Beep (1)
		this.text = String (ii_r)
	else
		ii_r = li_new_value
		rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
		hsb_red.position = ii_r
		parent.TriggerEvent ("color_changed")
	end if
else
	Beep (1)
	this.text = String (ii_r)
end if


end on

type hsb_blue from hscrollbar within u_color_selection
int X=388
int Y=327
int Width=310
int Height=42
int TabOrder=50
boolean Enabled=false
int MaxPosition=255
end type

on pageright;//////////////////////////////////////////////////////////////////////
// increment the blue color value by 50
//////////////////////////////////////////////////////////////////////

if ii_b > 205 then
	ii_b = 255
else
	ii_b = ii_b + 50
end if
sle_blue.text = String (ii_b)
this.position = ii_b

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ("color_changed")
end on

on lineleft;/////////////////////////////////////////////////////////////////////
// Decrement the blue color value by 10
/////////////////////////////////////////////////////////////////////

if ii_b < 10 then
	ii_b = 0
else
	ii_b = ii_b - 10
end if
sle_blue.text = String (ii_b)
this.position = ii_b

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ('color_changed')
end on

on lineright;//////////////////////////////////////////////////////////////////////
// increment the blue color value by 10
//////////////////////////////////////////////////////////////////////

if ii_b > 245 then
	ii_b = 255
else
	ii_b = ii_b + 10
end if
sle_blue.text = String (ii_b)
this.position = ii_b

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ("color_changed")
end on

on moved;/////////////////////////////////////////////////////////////////////
// Change the blue color value based on current position of scrollbar
/////////////////////////////////////////////////////////////////////

ii_b = this.position
sle_blue.text = String (ii_b)

// Change the test palette color
rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ('color_changed')
end on

on pageleft;//////////////////////////////////////////////////////////////////////
// Decrement the blue color value by 50
//////////////////////////////////////////////////////////////////////

if ii_b < 50 then
	ii_b = 0
else
	ii_b = ii_b - 50
end if
sle_blue.text = String (ii_b)
this.position = ii_b

rr_1.fillcolor = RGB (ii_r, ii_g, ii_b)
parent.TriggerEvent ("color_changed")
end on

type rr_1 from roundrectangle within u_color_selection
int X=225
int Y=23
int Width=274
int Height=77
boolean Enabled=false
int LineThickness=4
int CornerHeight=445
int CornerWidth=40
long LineColor=1090519039
long FillColor=16777215
end type

