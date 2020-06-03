$PBExportHeader$p_pipe_wmeter.sru
$PBExportComments$Inherited from pipeline object. Will display status information in static text boxes
forward
global type p_pipe_wmeter from pipeline
end type
end forward

global type p_pipe_wmeter from pipeline
end type
global p_pipe_wmeter p_pipe_wmeter

type variables
statictext st_read,st_written,st_errors

end variables

on pipemeter;st_read.text    = string (rowsread)
st_written.text = string (rowswritten)
st_errors.text  = string (rowsinerror)
end on

on p_pipe_wmeter.create
call pipeline::create
TriggerEvent( this, "constructor" )
end on

on p_pipe_wmeter.destroy
call pipeline::destroy
TriggerEvent( this, "destructor" )
end on

