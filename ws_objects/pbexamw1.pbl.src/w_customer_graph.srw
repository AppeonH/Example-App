$PBExportHeader$w_customer_graph.srw
$PBExportComments$This window contains the customer balance datawindow and the graph object to graph the data
forward
global type w_customer_graph from w_graph_sheet
end type
end forward

global type w_customer_graph from w_graph_sheet
int Width=2856
int Height=1658
boolean TitleBar=true
string Title="Balance by Customer - Using Graph Object"
long BackColor=74481808
end type
global w_customer_graph w_customer_graph

on open;// Create a new series calles "Total Orders"
int series_num
series_num = gr_1.addseries ( "Total Orders" )
if series_num < 1 then return
Call super::open
end on

on w_customer_graph.create
call w_graph_sheet::create
end on

on w_customer_graph.destroy
call w_graph_sheet::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gr_1 from w_graph_sheet`gr_1 within w_customer_graph
grGraphType GraphType=ColGraph!
string Title="Southern Region: Orders By Customer"
end type

on gr_1.create
call w_graph_sheet`gr_1::create
Category.Label="Customers"
Category.LabelDispAttr.TextSize=-11
Category.LabelDispAttr.AutoSize=false
Values.DispAttr.Format="#,##0"
Values.LabelDispAttr.TextSize=-12
Values.LabelDispAttr.AutoSize=false
end on

type dw_1 from w_graph_sheet`dw_1 within w_customer_graph
int Width=1156
string DataObject="d_total_customer_orders"
boolean VScrollBar=true
end type

