$PBExportHeader$w_employee_graph.srw
$PBExportComments$Window to show the datawindow of employee salaries and graph them in a graph object
forward
global type w_employee_graph from w_graph_sheet
end type
end forward

global type w_employee_graph from w_graph_sheet
int Width=2856
int Height=1527
boolean TitleBar=true
string Title="Salary By Dept - Using Graph Object"
long BackColor=74481808
end type
global w_employee_graph w_employee_graph

on open;// Create a new series calles "Total Salaries"
int series_num
series_num = gr_1.addseries ( "Total Salaries" )
if series_num < 1 then return
Call super::open
end on

on w_employee_graph.create
call w_graph_sheet::create
end on

on w_employee_graph.destroy
call w_graph_sheet::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gr_1 from w_graph_sheet`gr_1 within w_employee_graph
int Y=525
int Height=849
string Title="Total Employee Salaries by Department"
end type

on gr_1.create
call w_graph_sheet`gr_1::create
Category.DispAttr.TextSize=-11
Category.DispAttr.AutoSize=false
Category.LabelDispAttr.TextSize=-15
Category.LabelDispAttr.AutoSize=false
Values.DispAttr.Format="#,##0"
Values.LabelDispAttr.TextSize=-12
Values.LabelDispAttr.AutoSize=false
LegendDispAttr.TextSize=-11
LegendDispAttr.AutoSize=false
end on

type dw_1 from w_graph_sheet`dw_1 within w_employee_graph
int Width=1473
int Height=465
string DataObject="d_total_employee_salary"
boolean VScrollBar=true
end type

