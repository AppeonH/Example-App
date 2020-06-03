$PBExportHeader$w_nested_frame.srw
$PBExportComments$Frame window for Nested Reports example.
forward
global type w_nested_frame from w_center
end type
type mdi_1 from mdiclient within w_nested_frame
end type
end forward

global type w_nested_frame from w_center
int X=11
int Y=7
int Width=2898
int Height=1908
boolean TitleBar=true
string Title="Nested Reports"
string MenuName="m_nest_frame"
long BackColor=273241183
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_nested_frame w_nested_frame

on close;w_main.Show()
end on

on w_nested_frame.create
if this.MenuName = "m_nest_frame" then this.MenuID = create m_nest_frame
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_nested_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_nested_frame
long BackColor=273241183
end type

