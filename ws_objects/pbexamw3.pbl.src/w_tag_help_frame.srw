$PBExportHeader$w_tag_help_frame.srw
$PBExportComments$MDI Frame window for Context-Sensitive MicroHelp example.
forward
global type w_tag_help_frame from w_center
end type
type mdi_1 from mdiclient within w_tag_help_frame
end type
end forward

global type w_tag_help_frame from w_center
int X=46
int Y=9
int Width=2830
int Height=1901
boolean TitleBar=true
string Title="Context-Sensitive MicroHelp"
string MenuName="m_tag_help_frame"
long BackColor=268435456
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_tag_help_frame w_tag_help_frame

on close;w_main.Show()
end on

on w_tag_help_frame.create
if this.MenuName = "m_tag_help_frame" then this.MenuID = create m_tag_help_frame
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_tag_help_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_tag_help_frame
long BackColor=268435456
end type

