$PBExportHeader$w_notepad_colors.srw
$PBExportComments$Allows selection of colors for text in the notepad
forward
global type w_notepad_colors from w_center
end type
type cb_cancel from commandbutton within w_notepad_colors
end type
type cb_ok from commandbutton within w_notepad_colors
end type
type uo_colors from u_color_selection within w_notepad_colors
end type
end forward

global type w_notepad_colors from w_center
int X=964
int Y=573
int Width=1003
int Height=775
boolean TitleBar=true
string Title="Change Text Color"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_cancel cb_cancel
cb_ok cb_ok
uo_colors uo_colors
end type
global w_notepad_colors w_notepad_colors

type variables
MultiLineEdit   imle_parm
end variables

on open;long	ll_fillcolor


//////////////////////////////////////////////////////////////////////
// Obtain the MultiLineEdit from the message object
//////////////////////////////////////////////////////////////////////
imle_parm = message.powerobjectparm
ll_fillcolor = imle_parm.TextColor


//////////////////////////////////////////////////////////////////////
// Initialize the user object color changer to the current text color of the
// MultiLineEdit.
//////////////////////////////////////////////////////////////////////
uo_colors.uf_set_rgb (ll_fillcolor)


end on

on w_notepad_colors.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.uo_colors=create uo_colors
this.Control[]={ this.cb_cancel,&
this.cb_ok,&
this.uo_colors}
end on

on w_notepad_colors.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.uo_colors)
end on

type cb_cancel from commandbutton within w_notepad_colors
int X=523
int Y=535
int Width=246
int Height=109
int TabOrder=30
string Text="Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type cb_ok from commandbutton within w_notepad_colors
int X=225
int Y=535
int Width=246
int Height=109
int TabOrder=20
string Text="OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Set the text color to the RGB value specified by the user object

imle_parm.textcolor = uo_colors.uf_get_rgb()
close (parent)
end on

type uo_colors from u_color_selection within w_notepad_colors
int X=114
int Y=39
int TabOrder=10
boolean Border=false
end type

on uo_colors.destroy
call u_color_selection::destroy
end on

