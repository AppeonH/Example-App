$PBExportHeader$w_dwbuffers_ancestor.srw
$PBExportComments$Ancestor sheet for DataWindow buffers example
forward
global type w_dwbuffers_ancestor from w_center
end type
type dw_data from datawindow within w_dwbuffers_ancestor
end type
end forward

global type w_dwbuffers_ancestor from w_center
int X=673
int Y=263
int Width=1579
int Height=989
boolean TitleBar=true
string Title="Untitled"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
boolean ToolBarVisible=true
event ue_retrieve ( )
event ue_insert ( )
event ue_delete ( )
event ue_update ( )
event ue_undo ( )
event ue_refresh ( )
dw_data dw_data
end type
global w_dwbuffers_ancestor w_dwbuffers_ancestor

event open;call super::open;Post Event ue_refresh()

end event

event resize;//  Resize the datawindow to be the same size as the window workspace.

dw_data.Resize(This.WorkSpaceWidth( ), This.WorkSpaceHeight( ))

end event

on w_dwbuffers_ancestor.create
this.dw_data=create dw_data
this.Control[]={ this.dw_data}
end on

on w_dwbuffers_ancestor.destroy
destroy(this.dw_data)
end on

type dw_data from datawindow within w_dwbuffers_ancestor
int Width=491
int Height=359
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

