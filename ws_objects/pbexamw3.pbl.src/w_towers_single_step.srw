$PBExportHeader$w_towers_single_step.srw
$PBExportComments$Tower of Hanoi Wait Box
forward
global type w_towers_single_step from w_center
end type
type cb_cancel from commandbutton within w_towers_single_step
end type
type cb_step from commandbutton within w_towers_single_step
end type
end forward

global type w_towers_single_step from w_center
int X=1633
int Y=1405
int Width=882
int Height=410
boolean TitleBar=true
string Title="Towers of Hanoi"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
cb_cancel cb_cancel
cb_step cb_step
end type
global w_towers_single_step w_towers_single_step

on w_towers_single_step.create
this.cb_cancel=create cb_cancel
this.cb_step=create cb_step
this.Control[]={ this.cb_cancel,&
this.cb_step}
end on

on w_towers_single_step.destroy
destroy(this.cb_cancel)
destroy(this.cb_step)
end on

type cb_cancel from commandbutton within w_towers_single_step
int X=136
int Y=177
int Width=577
int Height=109
int TabOrder=20
string Text="&Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//turn off the single step click box
//return a 0 meaning single step will not continue
Closewithreturn(Parent,0)
end on

type cb_step from commandbutton within w_towers_single_step
int X=136
int Y=33
int Width=577
int Height=109
int TabOrder=10
string Text="&Step"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//close window and allow processing to continue
//close returning a 1 meaning that single step will continue.
ClosewithReturn(Parent,1)
end on

