$PBExportHeader$p_pipe_wometer.sru
$PBExportComments$Inherited from pipeline object. No status information available
forward
global type p_pipe_wometer from pipeline
end type
end forward

global type p_pipe_wometer from pipeline
end type
global p_pipe_wometer p_pipe_wometer

type variables
statictext st_read,st_written,st_errors
end variables

on p_pipe_wometer.create
call pipeline::create
TriggerEvent( this, "constructor" )
end on

on p_pipe_wometer.destroy
call pipeline::destroy
TriggerEvent( this, "destructor" )
end on

