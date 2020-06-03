$PBExportHeader$ds_lib_string.sru
$PBExportComments$Distributed PB example Datastore object used for retrieving datawindow objetcs from pbl
forward
global type ds_lib_string from datastore
end type
end forward

global type ds_lib_string from datastore
string DataObject="d_lib_string"
end type
global ds_lib_string ds_lib_string

on ds_lib_string.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on ds_lib_string.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

