$PBExportHeader$w_mdi_first_next.srw
$PBExportComments$Frame for m_mdi_first_next menu
forward
global type w_mdi_first_next from w_center
end type
type mdi_1 from mdiclient within w_mdi_first_next
end type
end forward

global type w_mdi_first_next from w_center
int X=1
int Y=1
int Width=2930
int Height=2074
boolean TitleBar=true
string Title="GetFirstSheet and GetNextSheet Functions"
string MenuName="m_mdi_first_next"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_mdi_first_next w_mdi_first_next

type variables
// Variables used to communicate between instances
// of sheets
//int dept
//string dept_name
end variables

on close;// Close script for w_mdi_main


w_main.Show( )

end on

on w_mdi_first_next.create
if this.MenuName = "m_mdi_first_next" then this.MenuID = create m_mdi_first_next
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_mdi_first_next.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_mdi_first_next
long BackColor=273241183
end type

