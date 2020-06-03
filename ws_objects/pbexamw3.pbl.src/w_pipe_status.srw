$PBExportHeader$w_pipe_status.srw
$PBExportComments$The pipeline status box
forward
global type w_pipe_status from w_center
end type
type st_msg from statictext within w_pipe_status
end type
end forward

global type w_pipe_status from w_center
int X=677
int Y=268
int Width=1463
int Height=428
boolean TitleBar=true
string Title="Data Pipeline Status"
long BackColor=74481808
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
st_msg st_msg
end type
global w_pipe_status w_pipe_status

on open;string ls_msg

ls_msg = message.stringparm

If len(ls_msg) > 0 Then 
	st_msg.text = ls_msg
End If


end on

on w_pipe_status.create
this.st_msg=create st_msg
this.Control[]={this.st_msg}
end on

on w_pipe_status.destroy
destroy(this.st_msg)
end on

type st_msg from statictext within w_pipe_status
int X=23
int Y=104
int Width=1413
int Height=104
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="none"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

