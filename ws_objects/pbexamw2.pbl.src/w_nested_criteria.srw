$PBExportHeader$w_nested_criteria.srw
$PBExportComments$Related nested report w/criteria sheet for Nested Reports example.
forward
global type w_nested_criteria from w_nested_ancestor
end type
end forward

global type w_nested_criteria from w_nested_ancestor
boolean TitleBar=true
string Title="Department/Employees Hight Salaries Report"
long BackColor=79741120
end type
global w_nested_criteria w_nested_criteria

on w_nested_criteria.create
call w_nested_ancestor::create
end on

on w_nested_criteria.destroy
call w_nested_ancestor::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_nested_ancestor`dw_1 within w_nested_criteria
string DataObject="d_dept_high_salaries"
end type

