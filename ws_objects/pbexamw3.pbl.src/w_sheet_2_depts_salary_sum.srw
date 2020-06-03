$PBExportHeader$w_sheet_2_depts_salary_sum.srw
$PBExportComments$Descendant:  (1) Dept. list; (2) Dept. Sum of Salary
forward
global type w_sheet_2_depts_salary_sum from w_sheet_2_dws
end type
end forward

global type w_sheet_2_depts_salary_sum from w_sheet_2_dws
int Width=1820
int Height=1613
boolean TitleBar=true
string Title="Department Salary Summary"
string MenuName="m_queries"
end type
global w_sheet_2_depts_salary_sum w_sheet_2_depts_salary_sum

on activate;call w_sheet_2_dws::activate;// call user object function to enable/disable the command buttons

iw_frame.uo_1.uf_set_buttons (true, true, true, true, true, false, false, false)
end on

on w_sheet_2_depts_salary_sum.create
call w_sheet_2_dws::create
if this.MenuName = "m_queries" then this.MenuID = create m_queries
end on

on w_sheet_2_depts_salary_sum.destroy
call w_sheet_2_dws::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

on open;col1_name = "dept_id"
Call super::open
end on

type dw_1 from w_sheet_2_dws`dw_1 within w_sheet_2_depts_salary_sum
int X=33
int Width=1710
string DataObject="d_dept"
end type

type dw_2 from w_sheet_2_dws`dw_2 within w_sheet_2_depts_salary_sum
int X=33
int Width=1710
string DataObject="d_sum_dept_salary"
end type

