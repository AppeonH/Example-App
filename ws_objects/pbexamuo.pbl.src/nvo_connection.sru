$PBExportHeader$nvo_connection.sru
$PBExportComments$Distributed PB example Connection user object used to connect to server.
forward
global type nvo_connection from connection
end type
end forward

global type nvo_connection from connection
end type
global nvo_connection nvo_connection

on nvo_connection.create
call connection::create
TriggerEvent( this, "constructor" )
end on

on nvo_connection.destroy
call connection::destroy
TriggerEvent( this, "destructor" )
end on

