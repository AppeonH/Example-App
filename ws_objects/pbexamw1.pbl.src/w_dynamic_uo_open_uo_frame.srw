$PBExportHeader$w_dynamic_uo_open_uo_frame.srw
$PBExportComments$MDI Frame window. Used in the Dynamic User Object Example
forward
global type w_dynamic_uo_open_uo_frame from w_center
end type
type mdi_1 from mdiclient within w_dynamic_uo_open_uo_frame
end type
end forward

global type w_dynamic_uo_open_uo_frame from w_center
int X=32
int Y=36
int Width=2857
int Height=1836
boolean TitleBar=true
string Title="Dynamic User Objects"
string MenuName="m_dynamic_uo_open_udo"
long BackColor=273241183
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
event ue_postopen pbm_custom01
mdi_1 mdi_1
end type
global w_dynamic_uo_open_uo_frame w_dynamic_uo_open_uo_frame

type variables

end variables

event ue_postopen;w_dynamic_uo_work_area w_sheet

OpenSheet(w_sheet,this,0, ORIGINAL!)

end event

event open;call super::open;sqlca.AutoCommit = True

toolbarvisible = false

This.PostEvent("ue_postopen")

end event

on w_dynamic_uo_open_uo_frame.create
if this.MenuName = "m_dynamic_uo_open_udo" then this.MenuID = create m_dynamic_uo_open_udo
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_dynamic_uo_open_uo_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event close;sqlca.AutoCommit = False

w_main.show()
end event

type mdi_1 from mdiclient within w_dynamic_uo_open_uo_frame
long BackColor=12632256
end type

