$PBExportHeader$w_employee_graph_list_sheet.srw
$PBExportComments$Window that parses through the employee datawindow and allows user to select which columns are graphed
forward
global type w_employee_graph_list_sheet from w_graph_sheet_with_list
end type
end forward

global type w_employee_graph_list_sheet from w_graph_sheet_with_list
int Width=2777
int Height=1665
boolean TitleBar=true
string Title="Stats by Dept - Using Graph Object"
long BackColor=74481808
end type
global w_employee_graph_list_sheet w_employee_graph_list_sheet

on w_employee_graph_list_sheet.create
call w_graph_sheet_with_list::create
end on

on w_employee_graph_list_sheet.destroy
call w_graph_sheet_with_list::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type gr_1 from w_graph_sheet_with_list`gr_1 within w_employee_graph_list_sheet
string Title="Statistics by Department"
end type

type dw_1 from w_graph_sheet_with_list`dw_1 within w_employee_graph_list_sheet
int Y=13
int Height=557
string DataObject="d_dept_data_for_graph"
end type

type lb_category from w_graph_sheet_with_list`lb_category within w_employee_graph_list_sheet
boolean BringToTop=true
long TextColor=41943040
long BackColor=74481808
end type

type lb_value from w_graph_sheet_with_list`lb_value within w_employee_graph_list_sheet
boolean BringToTop=true
long TextColor=41943040
long BackColor=1086902488
end type

type st_1 from w_graph_sheet_with_list`st_1 within w_employee_graph_list_sheet
boolean BringToTop=true
long TextColor=41943040
long BackColor=74481808
int Weight=400
end type

type st_2 from w_graph_sheet_with_list`st_2 within w_employee_graph_list_sheet
boolean BringToTop=true
long TextColor=41943040
long BackColor=74481808
int Weight=400
end type

type st_3 from w_graph_sheet_with_list`st_3 within w_employee_graph_list_sheet
boolean BringToTop=true
long TextColor=41943040
long BackColor=74481808
int Weight=400
end type

