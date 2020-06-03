$PBExportHeader$w_frame_queries.srw
$PBExportComments$Custom MDI frame with DW button bar user object
forward
global type w_frame_queries from w_center
end type
type mdi_1 from mdiclient within w_frame_queries
end type
type uo_1 from u_dw_ribbon_2 within w_frame_queries
end type
end forward

global type w_frame_queries from w_center
int X=1
int Y=1
int Width=2937
int Height=1981
boolean TitleBar=true
string Title="Custom MDI Frame"
string MenuName="m_frame_queries"
long BackColor=273241183
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
uo_1 uo_1
end type
global w_frame_queries w_frame_queries

type variables

end variables

on resize;// Resize script for w_mdi_frame_2

int	nX, nY, nWidth, nHeight

nX = WorkSpaceX (this)
nY = WorkSpaceY (this)

nWidth  = this.WorkSpaceWidth( )
nHeight = this.WorkSpaceHeight( )

nHeight = nHeight - (uo_1.y + uo_1.height)
nHeight = nHeight - mdi_1.MicroHelpHeight

mdi_1.Move (0, uo_1.y + uo_1.height)
mdi_1.Resize (nWidth, nHeight + 4)

end on

on open;// disable all of the command buttons on the user object

uo_1.uf_set_buttons (false, false, false, false, false, false, false, false)

end on

on w_frame_queries.create
if this.MenuName = "m_frame_queries" then this.MenuID = create m_frame_queries
this.mdi_1=create mdi_1
this.uo_1=create uo_1
this.Control[]={ this.mdi_1,&
this.uo_1}
end on

on w_frame_queries.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.uo_1)
end on

on close;// Close script 

this.Hide()
w_main.Show()

end on

type mdi_1 from mdiclient within w_frame_queries
long BackColor=273241183
end type

type uo_1 from u_dw_ribbon_2 within w_frame_queries
int X=1
int Y=1
int Width=2923
end type

on close;call u_dw_ribbon_2::close;// Close (user defined) script for uo_1 inherited from u_dw_ribbon_2

Close (parent) 

end on

on uo_1.destroy
call u_dw_ribbon_2::destroy
end on

