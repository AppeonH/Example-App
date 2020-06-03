$PBExportHeader$w_sheet_1_cust.srw
$PBExportComments$Descendant Sheet with D_CUST DataWindow
forward
global type w_sheet_1_cust from w_sheet_1_dw
end type
end forward

global type w_sheet_1_cust from w_sheet_1_dw
int Width=2600
int Height=1386
boolean TitleBar=true
string Title="Customer List"
string MenuName="m_queries"
long BackColor=74481808
end type
global w_sheet_1_cust w_sheet_1_cust

on activate;call w_sheet_1_dw::activate;// call user object function to enable/disable the command buttons

w_frame_queries	lw_win

lw_win = iw_frame
lw_win.uo_1.uf_set_buttons (true, true, true, true, true, true, true, true)
end on

on w_sheet_1_cust.create
call w_sheet_1_dw::create
if this.MenuName = "m_queries" then this.MenuID = create m_queries
end on

on w_sheet_1_cust.destroy
call w_sheet_1_dw::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_sheet_1_dw`dw_1 within w_sheet_1_cust
int Width=2532
string DataObject="d_cust"
end type

