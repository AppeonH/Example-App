$PBExportHeader$w_crosstab_status.srw
$PBExportComments$Status box to show status of the crosstab loading
forward
global type w_crosstab_status from w_center
end type
type lb_status from listbox within w_crosstab_status
end type
end forward

global type w_crosstab_status from w_center
int X=676
int Y=269
int Width=1359
int Height=711
boolean TitleBar=true
string Title="Crosstab Status"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
event ue_additem pbm_custom01
lb_status lb_status
end type
global w_crosstab_status w_crosstab_status

on ue_additem;string ls_item

ls_item = string(message.wordparm)
lb_status.additem(ls_item)
end on

on w_crosstab_status.create
this.lb_status=create lb_status
this.Control[]={ this.lb_status}
end on

on w_crosstab_status.destroy
destroy(this.lb_status)
end on

type lb_status from listbox within w_crosstab_status
int X=68
int Y=65
int Width=1160
int Height=471
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
long TextColor=41943040
int TextSize=-12
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"1.  Retrieving Data"}
end type

