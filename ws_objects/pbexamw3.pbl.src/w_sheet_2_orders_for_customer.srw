$PBExportHeader$w_sheet_2_orders_for_customer.srw
$PBExportComments$Descendant:  Customer form, with list of orders
forward
global type w_sheet_2_orders_for_customer from w_sheet_2_dws
end type
end forward

global type w_sheet_2_orders_for_customer from w_sheet_2_dws
int Width=2497
int Height=1613
boolean TitleBar=true
string Title="Orders for Customer"
string MenuName="m_queries"
end type
global w_sheet_2_orders_for_customer w_sheet_2_orders_for_customer

on open;// Open script for w_sheet_2_orders_for_customer
//inherited from w_sheet_2_dws

// Tell ancestor script that we don't want hightlighting. 
// Note: highlight row is an instance variable of the grand-ancestor,
// w_sheet_1_dw, and , as such, is available here. It is used in the
// rowfocuschanged event of dw_1 in that ancestor to control highlighting.
col1_name = "id"
Call super::open

ib_highlight_row = false


end on

on activate;call w_sheet_2_dws::activate;// call user object function to enable/disable the command buttons

iw_frame.uo_1.uf_set_buttons (true, true, true, true, true, false, false, false)
end on

on w_sheet_2_orders_for_customer.create
call w_sheet_2_dws::create
if this.MenuName = "m_queries" then this.MenuID = create m_queries
end on

on w_sheet_2_orders_for_customer.destroy
call w_sheet_2_dws::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_sheet_2_dws`dw_1 within w_sheet_2_orders_for_customer
int Y=29
int Width=2428
int Height=333
string DataObject="d_cust"
boolean VScrollBar=false
end type

type dw_2 from w_sheet_2_dws`dw_2 within w_sheet_2_orders_for_customer
int X=311
int Y=577
int Width=1838
string DataObject="d_orders_for_cust"
end type

