$PBExportHeader$w_orders_graph_list_sheet.srw
$PBExportComments$Allows adhoc graphs of orders by month
forward
global type w_orders_graph_list_sheet from w_graph_sheet_with_list
end type
end forward

global type w_orders_graph_list_sheet from w_graph_sheet_with_list
int Width=2785
int Height=1671
boolean TitleBar=true
string Title="Stats by Cust # - Using Graph Object"
end type
global w_orders_graph_list_sheet w_orders_graph_list_sheet

on w_orders_graph_list_sheet.create
call w_graph_sheet_with_list::create
end on

on w_orders_graph_list_sheet.destroy
call w_graph_sheet_with_list::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gr_1 from w_graph_sheet_with_list`gr_1 within w_orders_graph_list_sheet
string Title="Order Statistics by Month"
end type

on gr_1.create
call w_graph_sheet_with_list`gr_1::create
Category.Label="Period"
Values.DispAttr.Format="#,##0;[RED](#,##0)"
end on

type dw_1 from w_graph_sheet_with_list`dw_1 within w_orders_graph_list_sheet
int X=246
int Y=17
string DataObject="d_order_data_for_graph"
end type

type lb_category from w_graph_sheet_with_list`lb_category within w_orders_graph_list_sheet
boolean BringToTop=true
end type

type lb_value from w_graph_sheet_with_list`lb_value within w_orders_graph_list_sheet
boolean BringToTop=true
end type

type st_1 from w_graph_sheet_with_list`st_1 within w_orders_graph_list_sheet
boolean BringToTop=true
end type

type st_2 from w_graph_sheet_with_list`st_2 within w_orders_graph_list_sheet
boolean BringToTop=true
end type

type st_3 from w_graph_sheet_with_list`st_3 within w_orders_graph_list_sheet
boolean BringToTop=true
end type

