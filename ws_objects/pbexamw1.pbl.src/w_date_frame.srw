$PBExportHeader$w_date_frame.srw
$PBExportComments$MDI Frame for Year 2000 example
forward
global type w_date_frame from w_center
end type
type mdi_1 from mdiclient within w_date_frame
end type
end forward

global type w_date_frame from w_center
int X=5
int Y=4
int Width=2793
int Height=1588
boolean TitleBar=true
string Title="Year 2000 Example"
string MenuName="m_date_frame"
long BackColor=277038117
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_date_frame w_date_frame

on w_date_frame.create
if this.MenuName = "m_date_frame" then this.MenuID = create m_date_frame
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_date_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event close;w_main.Show()

end event

type mdi_1 from mdiclient within w_date_frame
long BackColor=277038117
end type

