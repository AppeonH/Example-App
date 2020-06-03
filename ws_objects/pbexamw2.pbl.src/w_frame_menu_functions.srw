$PBExportHeader$w_frame_menu_functions.srw
$PBExportComments$Frame window for w_menu_functions (Menu Techniques example)
forward
global type w_frame_menu_functions from w_center
end type
type mdi_1 from mdiclient within w_frame_menu_functions
end type
end forward

global type w_frame_menu_functions from w_center
int X=203
int Y=225
int Width=2514
int Height=1437
boolean TitleBar=true
string Title="MenuItem Attributes Example"
string MenuName="m_frame_menu_functions"
long BackColor=273241183
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
event ue_open pbm_custom01
mdi_1 mdi_1
end type
global w_frame_menu_functions w_frame_menu_functions

on ue_open;this.SetRedraw (false)
OpenSheet (w_menu_functions, this, 99, original!)
this.SetRedraw (true)

end on

on close;w_main.Show()
end on

on open;this.PostEvent ('ue_open')
end on

on w_frame_menu_functions.create
if this.MenuName = "m_frame_menu_functions" then this.MenuID = create m_frame_menu_functions
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_frame_menu_functions.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_frame_menu_functions
long BackColor=273241183
end type

