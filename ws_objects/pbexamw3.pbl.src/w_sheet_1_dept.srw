$PBExportHeader$w_sheet_1_dept.srw
$PBExportComments$Descendant Sheet with D_DEPT DataWindow
forward
global type w_sheet_1_dept from w_sheet_1_dw
end type
end forward

global type w_sheet_1_dept from w_sheet_1_dw
int X=520
int Y=343
int Width=1761
int Height=1207
boolean TitleBar=true
string Title="Department List"
string MenuName="m_queries"
long BackColor=74481808
end type
global w_sheet_1_dept w_sheet_1_dept

on activate;call w_sheet_1_dw::activate;// call user object function to enable/disable the command buttons

w_frame_queries	lw_win

lw_win = iw_frame
lw_win.uo_1.uf_set_buttons (true, true, true, true, true, false, false, false)
end on

on w_sheet_1_dept.create
call w_sheet_1_dw::create
if this.MenuName = "m_queries" then this.MenuID = create m_queries
end on

on w_sheet_1_dept.destroy
call w_sheet_1_dw::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_sheet_1_dw`dw_1 within w_sheet_1_dept
int X=22
int Y=23
int Width=1672
int Height=900
string DataObject="d_dept"
end type

