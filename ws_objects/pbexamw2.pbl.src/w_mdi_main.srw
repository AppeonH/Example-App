$PBExportHeader$w_mdi_main.srw
$PBExportComments$MDI:  Frame window
forward
global type w_mdi_main from w_center
end type
type mdi_1 from mdiclient within w_mdi_main
end type
end forward

global type w_mdi_main from w_center
int X=1
int Y=1
int Width=2930
int Height=2074
boolean TitleBar=true
string Title="Department Reports"
string MenuName="m_mdiframe"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=mdihelp!
event ue_postopen pbm_custom01
mdi_1 mdi_1
end type
global w_mdi_main w_mdi_main

type variables
// Variables used to communicate between instances
// of sheets
//int dept
//string dept_name
end variables

on ue_postopen;OpenSheet(w_drag_a_dept  , this, 2, original!)

end on

on open;// Open script for w_mdi_main

This.PostEvent("ue_postopen")

end on

on w_mdi_main.create
if this.MenuName = "m_mdiframe" then this.MenuID = create m_mdiframe
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_mdi_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

on close;// Close script for w_mdi_main

this.Hide( )
w_main.Show( )

end on

type mdi_1 from mdiclient within w_mdi_main
long BackColor=273241183
end type

