$PBExportHeader$w_step.srw
$PBExportComments$Response window used to step through a process.  Input:  title, "@", description.  Output:  1 for proceed, 0 for cancel.
forward
global type w_step from w_center
end type
type mle_description from multilineedit within w_step
end type
type cb_cancel from commandbutton within w_step
end type
type cb_proceed from commandbutton within w_step
end type
end forward

global type w_step from w_center
int X=697
int Y=529
int Width=1522
int Height=868
boolean TitleBar=true
string Title="Untitled"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
mle_description mle_description
cb_cancel cb_cancel
cb_proceed cb_proceed
end type
global w_step w_step

on open;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Obtain the title and description from the message object.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string	ls_parm
int		li_pos


ls_parm = message.StringParm
li_pos = Pos (ls_parm, "@")
if li_pos > 0 then
	this.title = Left (ls_parm, li_pos - 1)
	mle_description.text = Mid (ls_parm, li_pos + 1)
else
	this.title = ls_parm
end if
end on

on w_step.create
this.mle_description=create mle_description
this.cb_cancel=create cb_cancel
this.cb_proceed=create cb_proceed
this.Control[]={ this.mle_description,&
this.cb_cancel,&
this.cb_proceed}
end on

on w_step.destroy
destroy(this.mle_description)
destroy(this.cb_cancel)
destroy(this.cb_proceed)
end on

type mle_description from multilineedit within w_step
int X=43
int Y=36
int Width=1416
int Height=509
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean DisplayOnly=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_step
int X=754
int Y=605
int Width=292
int Height=97
int TabOrder=30
string Text="&Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return a value of 0, which will signify that cancel was hit.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CloseWithReturn (parent, 0)
end on

type cb_proceed from commandbutton within w_step
int X=402
int Y=605
int Width=313
int Height=97
int TabOrder=20
string Text="&Proceed"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Return a value of 1, which will signify that proceed was hit.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CloseWithReturn (parent, 1)
end on

