$PBExportHeader$w_dwbuffers_frame.srw
$PBExportComments$MDI Frame for DataWindow buffers example
forward
global type w_dwbuffers_frame from w_center
end type
type mdi_1 from mdiclient within w_dwbuffers_frame
end type
end forward

global type w_dwbuffers_frame from w_center
int X=5
int Y=4
int Width=2967
int Height=1868
boolean TitleBar=true
string Title="DataWindow Buffers"
string MenuName="m_dwbuffers"
long BackColor=273241183
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_dwbuffers_frame w_dwbuffers_frame

type variables
String	is_DBParm
end variables

on w_dwbuffers_frame.create
if this.MenuName = "m_dwbuffers" then this.MenuID = create m_dwbuffers
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_dwbuffers_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;call super::open;m_dwbuffers	lm_Menu

SetPointer(HourGlass!)

// Set DisableBind DBParm so the SQL Preview will show the full SQL statement
is_DBParm = sqlca.DBParm
sqlca.DBParm = sqlca.DBParm + ", DisableBind=1"

// Open all windows
lm_Menu = This.MenuID
lm_Menu.m_buffers.m_openall.Post Event clicked()

// Retrieve data
lm_Menu.m_file.m_retrieve.Post Event clicked()

end event

event close;// Restore the DBParm attribute
sqlca.DBParm = is_DBParm

Show(w_main)

end event

type mdi_1 from mdiclient within w_dwbuffers_frame
long BackColor=273241183
end type

