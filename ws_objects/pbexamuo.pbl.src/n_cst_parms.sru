$PBExportHeader$n_cst_parms.sru
$PBExportComments$Custom class user object containing parameters to be passed
forward
global type n_cst_parms from nonvisualobject
end type
end forward

global type n_cst_parms from nonvisualobject autoinstantiate
end type
global n_cst_parms n_cst_parms

type variables
Integer	ii_Parm1, ii_Parm2, ii_OpenPos
String	is_Filter, is_DataObject, is_Label
Window	iw_Parent, iw_Frame

end variables

on n_cst_parms.create
TriggerEvent( this, "constructor" )
end on

on n_cst_parms.destroy
TriggerEvent( this, "destructor" )
end on

