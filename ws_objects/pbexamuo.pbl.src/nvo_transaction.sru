$PBExportHeader$nvo_transaction.sru
$PBExportComments$Distributed PB example Transaction user object
forward
global type nvo_transaction from transaction
end type
end forward

global type nvo_transaction from transaction
end type
global nvo_transaction nvo_transaction

on nvo_transaction.create
call transaction::create
TriggerEvent( this, "constructor" )
end on

on nvo_transaction.destroy
call transaction::destroy
TriggerEvent( this, "destructor" )
end on

