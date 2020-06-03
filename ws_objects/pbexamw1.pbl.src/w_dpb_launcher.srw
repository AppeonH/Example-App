$PBExportHeader$w_dpb_launcher.srw
$PBExportComments$Distributed PB Launcher
forward
global type w_dpb_launcher from w_center
end type
type st_4 from statictext within w_dpb_launcher
end type
type st_3 from statictext within w_dpb_launcher
end type
type st_2 from statictext within w_dpb_launcher
end type
type st_1 from statictext within w_dpb_launcher
end type
type mle_servernotes from multilineedit within w_dpb_launcher
end type
type mle_clientnotes from multilineedit within w_dpb_launcher
end type
type cb_serverlocation from commandbutton within w_dpb_launcher
end type
type sle_serverlocation from singlelineedit within w_dpb_launcher
end type
type cb_clientlocation from commandbutton within w_dpb_launcher
end type
type sle_clientlocation from singlelineedit within w_dpb_launcher
end type
type pb_runserver from picturebutton within w_dpb_launcher
end type
type pb_runclient from picturebutton within w_dpb_launcher
end type
type gb_2 from groupbox within w_dpb_launcher
end type
type gb_1 from groupbox within w_dpb_launcher
end type
end forward

global type w_dpb_launcher from w_center
int X=846
int Y=388
int Width=2117
int Height=1232
boolean TitleBar=true
string Title="Distributed Powerbuilder Launcher"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_postopen ( )
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
mle_servernotes mle_servernotes
mle_clientnotes mle_clientnotes
cb_serverlocation cb_serverlocation
sle_serverlocation sle_serverlocation
cb_clientlocation cb_clientlocation
sle_clientlocation sle_clientlocation
pb_runserver pb_runserver
pb_runclient pb_runclient
gb_2 gb_2
gb_1 gb_1
end type
global w_dpb_launcher w_dpb_launcher

type prototypes
Function uint GetWindowsDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL"
Function uint GetSystemDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL"
Function uint GetDriveTypeA (string drive) library "KERNEL32.DLL"
Function ulong GetCurrentDirectoryA (ulong textlen, ref string dirtext) library "KERNEL32.DLL"

end prototypes

type variables
s_parms istr_parms
string is_caller
string is_port
string is_dirsep
end variables

forward prototypes
public subroutine of_setnotes (multilineedit aml_target, string as_note)
end prototypes

event ue_postopen;sle_clientlocation.text = istr_parms.s_client
mle_clientnotes.text = istr_parms.s_clientnotes
sle_serverlocation.text = istr_parms.s_server
mle_servernotes.text = istr_parms.s_servernotes
end event

public subroutine of_setnotes (multilineedit aml_target, string as_note);// called to set text to passed in multiline
aml_target.text = as_note
end subroutine

on w_dpb_launcher.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.mle_servernotes=create mle_servernotes
this.mle_clientnotes=create mle_clientnotes
this.cb_serverlocation=create cb_serverlocation
this.sle_serverlocation=create sle_serverlocation
this.cb_clientlocation=create cb_clientlocation
this.sle_clientlocation=create sle_clientlocation
this.pb_runserver=create pb_runserver
this.pb_runclient=create pb_runclient
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.mle_servernotes,&
this.mle_clientnotes,&
this.cb_serverlocation,&
this.sle_serverlocation,&
this.cb_clientlocation,&
this.sle_clientlocation,&
this.pb_runserver,&
this.pb_runclient,&
this.gb_2,&
this.gb_1}
end on

on w_dpb_launcher.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.mle_servernotes)
destroy(this.mle_clientnotes)
destroy(this.cb_serverlocation)
destroy(this.sle_serverlocation)
destroy(this.cb_clientlocation)
destroy(this.sle_clientlocation)
destroy(this.pb_runserver)
destroy(this.pb_runclient)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event close;Show(w_main)
end event

event open;call super::open;environment lenv_sys

getenvironment(lenv_sys)
// set directory separator for platform
// for unix
if lenv_sys.OSType = aix! or &
	lenv_sys.OSType = hpux! or &
	lenv_sys.OSType = osf1! or &
	lenv_sys.OSType = sol2! then
	is_dirsep = "/"
else
	is_dirsep ="\"
end if

end event

type st_4 from statictext within w_dpb_launcher
int X=114
int Y=756
int Width=192
int Height=104
boolean Enabled=false
string Text="Notes:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_dpb_launcher
int X=101
int Y=208
int Width=192
int Height=52
boolean Enabled=false
string Text="Notes:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_dpb_launcher
int X=101
int Y=96
int Width=197
int Height=60
boolean Enabled=false
string Text="Location"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_dpb_launcher
int X=114
int Y=656
int Width=197
int Height=88
boolean Enabled=false
string Text="Location"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_servernotes from multilineedit within w_dpb_launcher
int X=306
int Y=192
int Width=1344
int Height=284
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
boolean AutoVScroll=true
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_clientnotes from multilineedit within w_dpb_launcher
int X=320
int Y=756
int Width=1344
int Height=284
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoVScroll=true
boolean DisplayOnly=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_serverlocation from commandbutton within w_dpb_launcher
int X=1518
int Y=92
int Width=119
int Height=76
int TabOrder=60
string Text="..."
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_path
string ls_filename
int 	 li_return


li_return = GetFileOpenName("Select Application to Execute", ls_path, ls_filename, "EXE", &
										+ "Application Files (*.EXE), *.EXE, *.*")
										
										
if li_return = 1 then
	sle_serverlocation.text = ls_path
end if

end event

type sle_serverlocation from singlelineedit within w_dpb_launcher
int X=306
int Y=92
int Width=1230
int Height=76
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_clientlocation from commandbutton within w_dpb_launcher
int X=1550
int Y=656
int Width=119
int Height=76
int TabOrder=20
string Text="..."
int TextSize=-12
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_path
string ls_filename
int 	 li_return


li_return = GetFileOpenName("Select Application to Execute", ls_path, ls_filename, "EXE", &
										+ "Application Files (*.EXE), *.EXE, *.*")
										
										
if li_return = 1 then
	sle_clientlocation.text = ls_path
end if

end event

type sle_clientlocation from singlelineedit within w_dpb_launcher
int X=320
int Y=656
int Width=1230
int Height=76
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type pb_runserver from picturebutton within w_dpb_launcher
int X=1682
int Y=192
int Width=320
int Height=92
int TabOrder=100
string Text="Run Server"
VTextAlign VTextAlign=VCenter!
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_run
int li_return

// get command line
ls_run = sle_serverlocation.text

// if not empty, run it
if not ls_run ="" then
	li_return = run(ls_run)
else
	messagebox("Error", "Server name has not been specified.  Please select a server name.")
	return -1
end if

// check for error
if li_return = -1 then
	messagebox("Execution Error", string(li_return)+":Error running: "+ls_run)
	return li_return
else
	pb_runclient.enabled = true
	return 1
end if



end event

type pb_runclient from picturebutton within w_dpb_launcher
int X=1696
int Y=756
int Width=320
int Height=92
int TabOrder=70
boolean Enabled=false
string Text="Run Client"
VTextAlign VTextAlign=VCenter!
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int li_return
string ls_run

// get command line
ls_run = sle_clientlocation.text

// if not empty, run it
if not ls_run ="" then
	li_return = run(ls_run)
end if

// check for error
if li_return = -1 then
	messagebox("Execution Error", "Error:"+string(li_return))
end if

end event

type gb_2 from groupbox within w_dpb_launcher
int X=18
int Y=576
int Width=2034
int Height=516
int TabOrder=50
string Text="Client Application"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_dpb_launcher
int X=18
int Y=16
int Width=2034
int Height=516
int TabOrder=80
string Text="Server Application"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=700
string FaceName="MS Sans Serif"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

