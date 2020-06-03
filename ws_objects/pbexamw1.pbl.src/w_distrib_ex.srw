$PBExportHeader$w_distrib_ex.srw
$PBExportComments$Distributed PB Example
forward
global type w_distrib_ex from w_dpb_launcher
end type
end forward

global type w_distrib_ex from w_dpb_launcher
int Height=1244
boolean TitleBar=true
string Title="Distributed Powerbuilder Example"
end type
global w_distrib_ex w_distrib_ex

on w_distrib_ex.create
call super::create
end on

on w_distrib_ex.destroy
call super::destroy
end on

event open;call super::open;istr_parms.s_client = "distrib" + is_dirsep + "distexam" + is_dirsep +"clntapp"
istr_parms.s_clientnotes = "The asynchronous call is initiated when you click  Async Function Call button. This POSTs the function call to the server, passing a text string and a object handle that the server will use to return the result." 
istr_parms.s_server = "distrib" + is_dirsep + "distexam" + is_dirsep + "srvrapp"
istr_parms.s_servernotes = "When the server receives the function call, a message box will pop up to indicate the call was received. On the client side, a message box will pop up to indicate the PUSH from the server."

post event ue_postopen()
end event

event ue_postopen;call super::ue_postopen;is_caller = ProfileString("distributed" + is_dirsep + "distrib_ex" + &
	is_dirsep + "dpb_info.ini", "server", "application", "nameserver")
is_port = "10100"
end event

type cb_serverlocation from w_dpb_launcher`cb_serverlocation within w_distrib_ex
int X=1531
end type

type cb_clientlocation from w_dpb_launcher`cb_clientlocation within w_distrib_ex
int X=1545
end type

