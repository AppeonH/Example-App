$PBExportHeader$w_dynsql_frame.srw
$PBExportComments$MDI Frame Window for Dynamic SQL example
forward
global type w_dynsql_frame from w_center
end type
type mdi_1 from mdiclient within w_dynsql_frame
end type
end forward

global type w_dynsql_frame from w_center
int X=8
int Y=17
int Width=2898
int Height=1898
boolean TitleBar=true
string Title="Dynamic SQL: 4 Formats"
string MenuName="m_dynsql_frame"
long BackColor=273241183
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_dynsql_frame w_dynsql_frame

on close;w_main.Show()
end on

on w_dynsql_frame.create
if this.MenuName = "m_dynsql_frame" then this.MenuID = create m_dynsql_frame
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_dynsql_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_dynsql_frame
long BackColor=273241183
end type

