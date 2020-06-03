$PBExportHeader$w_ole_example_frame.srw
$PBExportComments$Frame for w_ole_example
forward
global type w_ole_example_frame from w_center
end type
type mdi_1 from mdiclient within w_ole_example_frame
end type
end forward

global type w_ole_example_frame from w_center
int X=1
int Y=1
int Width=2923
int Height=1921
boolean TitleBar=true
string Title="OLE 2.0 Examples"
string MenuName="m_ole_frame"
long BackColor=268435456
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
event ue_postopen pbm_custom01
mdi_1 mdi_1
end type
global w_ole_example_frame w_ole_example_frame

event ue_postopen;w_ole_example win_temp

SetPointer(HourGlass!)
OpenSheet(win_temp,"w_ole_example",this,0,layered!)

end event

on w_ole_example_frame.create
if this.MenuName = "m_ole_frame" then this.MenuID = create m_ole_frame
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_ole_example_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

on open;This.PostEvent("ue_postopen")

end on

on close;show(w_main)
end on

type mdi_1 from mdiclient within w_ole_example_frame
long BackColor=268435456
end type

