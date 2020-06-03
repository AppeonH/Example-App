$PBExportHeader$w_uo_colors.srw
$PBExportComments$UO:  Shows 2 color-changer UOs
forward
global type w_uo_colors from w_center
end type
type st_2 from statictext within w_uo_colors
end type
type st_1 from statictext within w_uo_colors
end type
type cb_cancel from commandbutton within w_uo_colors
end type
type uo_back_color from u_color_selection within w_uo_colors
end type
type uo_label_color from u_color_selection within w_uo_colors
end type
type gb_2 from groupbox within w_uo_colors
end type
type gb_1 from groupbox within w_uo_colors
end type
end forward

global type w_uo_colors from w_center
int X=65
int Y=481
int Width=2795
int Height=964
boolean TitleBar=true
string Title="User Objects for Changing Colors"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
uo_back_color uo_back_color
uo_label_color uo_label_color
gb_2 gb_2
gb_1 gb_1
end type
global w_uo_colors w_uo_colors

type prototypes

end prototypes

type variables
dec {2} pct_complete

end variables

on open;//////////////////////////////////////////////////////////////////////
// get the rgb value of the window background color
//////////////////////////////////////////////////////////////////////

long	ll_rgb
int	li_color_window = 5		// enum 'color_window' for window background

// If background has been set to a real color in the window style,
// use 'this.background'. If a special color has been used
// like 'transparent' or 'window', the high order bits in the
// background attribute are used by PowerBuilder. Therefore,
// the backgound attribute doesn't contain a true rgb value. If 'special'
// colors were used, the rgb should be obtained using the
// 'GetSystemColor' SDK function to get the default window background. 

if (this.backcolor < 0 or this.backcolor > RGB (255,255,255)) then
	ll_rgb = gu_ext_func.uf_GetSysColor (li_color_window)
else
	ll_rgb = this.backcolor
end if

// pass the window background and text colors to the user objects.
// the uf_set_rgb function will set the red, green, and blue values
// on the user objects to the appropriate values for the window 
// background color and text color on this window.
uo_back_color.uf_set_rgb (ll_rgb)
uo_label_color.uf_set_rgb (st_1.TextColor)


end on

on w_uo_colors.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.uo_back_color=create uo_back_color
this.uo_label_color=create uo_label_color
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={ this.st_2,&
this.st_1,&
this.cb_cancel,&
this.uo_back_color,&
this.uo_label_color,&
this.gb_2,&
this.gb_1}
end on

on w_uo_colors.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.uo_back_color)
destroy(this.uo_label_color)
destroy(this.gb_2)
destroy(this.gb_1)
end on

on close;w_main.Show()
end on

type st_2 from statictext within w_uo_colors
int X=11
int Y=77
int Width=2187
int Height=71
boolean Enabled=false
string Text="Color can be changed by manually entering in RGB values or by using the scroll bars."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_uo_colors
int X=11
int Y=17
int Width=2386
int Height=71
boolean Enabled=false
string Text="Change the color of the window background and text by utilizing the two user objects below."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_uo_colors
int X=2486
int Y=39
int Width=246
int Height=109
int TabOrder=10
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close (parent)
end on

type uo_back_color from u_color_selection within w_uo_colors
int X=267
int Y=324
int Width=726
int Height=417
int TabOrder=40
boolean Border=false
long BackColor=74481808
end type

on color_changed;// Change the background color of the window and all controls on the
// window to the rgb values specified by this user object.

long	ll_rgb

ll_rgb = this.uf_get_rgb()

parent.st_1.BackColor = ll_rgb
parent.st_2.BackColor = ll_rgb
parent.BackColor = ll_rgb




end on

on uo_back_color.destroy
call u_color_selection::destroy
end on

type uo_label_color from u_color_selection within w_uo_colors
int X=1441
int Y=324
int Width=729
int Height=417
int TabOrder=50
boolean Border=false
long BackColor=74481808
end type

on color_changed;// Change the text color of the window controls to the rgb values 
// specified by this user object.

long	ll_rgb

ll_rgb = this.uf_get_rgb()

parent.st_1.TextColor = ll_rgb
parent.st_2.TextColor = ll_rgb
gb_1.TextColor = ll_rgb
gb_2.TextColor = ll_rgb

end on

on uo_label_color.destroy
call u_color_selection::destroy
end on

type gb_2 from groupbox within w_uo_colors
int X=1366
int Y=253
int Width=897
int Height=548
int TabOrder=30
string Text="Text color"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_uo_colors
int X=200
int Y=253
int Width=897
int Height=548
int TabOrder=20
string Text="Window Background color"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

