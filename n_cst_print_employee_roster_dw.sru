$PBExportHeader$n_cst_print_employee_roster_dw.sru
$PBExportComments$Tabular: Employee Roster with total by department and grand total

forward
global type n_cst_print_employee_roster_dw from nonvisualobject
end type
end forward

global type n_cst_print_employee_roster_dw from nonvisualobject autoinstantiate
end type
global n_cst_print_employee_roster_dw n_cst_print_employee_roster_dw

type variables
	string	emp_lname
	string	emp_fname
	decimal {3}	salary
	integer	dept_id
	string	department_dept_name
end variables

on n_cst_print_employee_roster_dw.create
TriggerEvent( this, "constructor" )
end on

on n_cst_print_employee_roster_dw.destroy
TriggerEvent( this, "destructor" )
end on

