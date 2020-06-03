$PBExportHeader$w_cancel_button.srw
$PBExportComments$Cancel Button for w_cancel_retrieval
forward
global type w_cancel_button from w_center
end type
type cb_1 from commandbutton within w_cancel_button
end type
type st_count from statictext within w_cancel_button
end type
type st_1 from statictext within w_cancel_button
end type
end forward

global type w_cancel_button from w_center
int X=584
int Y=269
int Width=1295
int Height=359
boolean TitleBar=true
string Title="Hit Cancel Button to Stop Retrieval"
long BackColor=74481808
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
cb_1 cb_1
st_count st_count
st_1 st_1
end type
global w_cancel_button w_cancel_button

on w_cancel_button.create
this.cb_1=create cb_1
this.st_count=create st_count
this.st_1=create st_1
this.Control[]={ this.cb_1,&
this.st_count,&
this.st_1}
end on

on w_cancel_button.destroy
destroy(this.cb_1)
destroy(this.st_count)
destroy(this.st_1)
end on

type cb_1 from commandbutton within w_cancel_button
int X=473
int Y=132
int Width=299
int Height=109
int TabOrder=1
string Text="Cancel "
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_cancel


//This will cause the script in the user defined event 
//"cancel_request" to be executed.
parent.ParentWindow( ).TriggerEvent("cancel_requested")



end on

type st_count from statictext within w_cancel_button
int X=808
int Y=36
int Width=292
int Height=77
boolean Enabled=false
string Text="0"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_cancel_button
int X=185
int Y=36
int Width=587
int Height=77
string Text="Rows Retrieved:"
Alignment Alignment=Right!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

