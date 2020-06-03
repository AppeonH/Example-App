$PBExportHeader$ds_dowjones.sru
$PBExportComments$Datastore for Dow Jones data.
forward
global type ds_dowjones from datastore
end type
end forward

global type ds_dowjones from datastore
string DataObject="d_dowjones"
end type
global ds_dowjones ds_dowjones

on ds_dowjones.create
call datastore::create
TriggerEvent( this, "constructor" )
end on

on ds_dowjones.destroy
call datastore::destroy
TriggerEvent( this, "destructor" )
end on

