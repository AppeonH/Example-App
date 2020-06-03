$PBExportHeader$w_nested_related.srw
$PBExportComments$Related nested report sheet for Nested Reports example.
forward
global type w_nested_related from w_nested_ancestor
end type
end forward

global type w_nested_related from w_nested_ancestor
boolean TitleBar=true
string Title="Department/Employees Report"
long BackColor=79741120
end type
global w_nested_related w_nested_related

on w_nested_related.create
call w_nested_ancestor::create
end on

on w_nested_related.destroy
call w_nested_ancestor::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_1 from w_nested_ancestor`dw_1 within w_nested_related
string DataObject="d_dept_manage_emp"
end type

