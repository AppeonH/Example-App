$PBExportHeader$w_notepad_frame.srw
$PBExportComments$Main MDI frame for w_notepad
forward
global type w_notepad_frame from w_center
end type
type mdi_1 from mdiclient within w_notepad_frame
end type
end forward

global type w_notepad_frame from w_center
int X=22
int Y=33
int Width=2873
int Height=1908
boolean TitleBar=true
string Title="PowerBuilt Notepad"
string MenuName="m_notepad"
long BackColor=268435456
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean ToolBarVisible=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
event ue_postopen pbm_custom01
mdi_1 mdi_1
end type
global w_notepad_frame w_notepad_frame

type variables
int   i_document_number=0
end variables

event ue_postopen;w_notepad w_sheet

OpenSheet (w_sheet, this, 5, Cascaded!)

end event

event close;f_save_toolbar_profile(This)
Show (w_main)

end event

event open;call super::open;f_get_toolbar_profile(This, 1)

This.PostEvent("ue_postopen")

end event

on w_notepad_frame.create
if this.MenuName = "m_notepad" then this.MenuID = create m_notepad
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_notepad_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_notepad_frame
long BackColor=268435456
end type

