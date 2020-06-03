$PBExportHeader$u_report_structure.sru
$PBExportComments$User object used as a structure for the Example Report
forward
global type u_report_structure from nonvisualobject
end type
end forward

global type u_report_structure from nonvisualobject autoinstantiate
end type
global u_report_structure u_report_structure

type variables
String	is_Application, is_Object, is_Title
end variables

on u_report_structure.create
TriggerEvent( this, "constructor" )
end on

on u_report_structure.destroy
TriggerEvent( this, "destructor" )
end on

