$PBExportHeader$w_sheet_2_employee_address_info.srw
$PBExportComments$Descendant Sheet with D_EMPLOYEE_NAME_LIST and D_EMP_ADDRESS_FORM
forward
global type w_sheet_2_employee_address_info from w_sheet_2_dws
end type
end forward

global type w_sheet_2_employee_address_info from w_sheet_2_dws
int Width=2593
int Height=1613
boolean TitleBar=true
string Title="Employee Name & Address Information"
string MenuName="m_queries"
end type
global w_sheet_2_employee_address_info w_sheet_2_employee_address_info

on activate;call w_sheet_2_dws::activate;// call user object function to enable/disable the command buttons

iw_frame.uo_1.uf_set_buttons (true, true, true, true, true, false, false, false)
end on

on w_sheet_2_employee_address_info.create
call w_sheet_2_dws::create
if this.MenuName = "m_queries" then this.MenuID = create m_queries
end on

on w_sheet_2_employee_address_info.destroy
call w_sheet_2_dws::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

on open;col1_name = "emp_id"
Call super::open
end on

type dw_1 from w_sheet_2_dws`dw_1 within w_sheet_2_employee_address_info
int X=613
int Width=1198
int Height=537
string DataObject="d_employee_name_list"
end type

type dw_2 from w_sheet_2_dws`dw_2 within w_sheet_2_employee_address_info
int Y=601
int Width=2506
string DataObject="d_emp_address_form"
boolean VScrollBar=false
end type

