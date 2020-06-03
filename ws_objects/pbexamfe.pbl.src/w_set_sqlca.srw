$PBExportHeader$w_set_sqlca.srw
$PBExportComments$Change to new sample database
forward
global type w_set_sqlca from w_center
end type
type sle_logpass from singlelineedit within w_set_sqlca
end type
type sle_logid from singlelineedit within w_set_sqlca
end type
type sle_server from singlelineedit within w_set_sqlca
end type
type sle_database from singlelineedit within w_set_sqlca
end type
type sle_dbpass from singlelineedit within w_set_sqlca
end type
type sle_userid from singlelineedit within w_set_sqlca
end type
type sle_dbms from singlelineedit within w_set_sqlca
end type
type st_12 from statictext within w_set_sqlca
end type
type st_11 from statictext within w_set_sqlca
end type
type st_10 from statictext within w_set_sqlca
end type
type sle_dbparm from singlelineedit within w_set_sqlca
end type
type cb_cancel from commandbutton within w_set_sqlca
end type
type cb_ok from commandbutton within w_set_sqlca
end type
type st_9 from statictext within w_set_sqlca
end type
type st_6 from statictext within w_set_sqlca
end type
type st_5 from statictext within w_set_sqlca
end type
type st_4 from statictext within w_set_sqlca
end type
type st_3 from statictext within w_set_sqlca
end type
type st_2 from statictext within w_set_sqlca
end type
type st_1 from statictext within w_set_sqlca
end type
type st_7 from statictext within w_set_sqlca
end type
end forward

global type w_set_sqlca from w_center
int X=683
int Y=269
int Width=1689
int Height=1546
boolean TitleBar=true
string Title="Set Value for Transaction Object"
long BackColor=74481808
boolean ControlMenu=true
boolean Resizable=true
boolean ToolBarVisible=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
sle_logpass sle_logpass
sle_logid sle_logid
sle_server sle_server
sle_database sle_database
sle_dbpass sle_dbpass
sle_userid sle_userid
sle_dbms sle_dbms
st_12 st_12
st_11 st_11
st_10 st_10
sle_dbparm sle_dbparm
cb_cancel cb_cancel
cb_ok cb_ok
st_9 st_9
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_7 st_7
end type
global w_set_sqlca w_set_sqlca

event open;call super::open;// Open script for W_SET_SQLCA
sle_dbms.Text = sqlca.DBMS
sle_database.Text = sqlca.database
sle_userid.Text	= sqlca.userid
sle_dbpass.Text	= sqlca.dbpass
sle_logid.Text		= sqlca.logid
sle_logpass.Text	= sqlca.logpass
sle_server.Text	= sqlca.servername	
sle_dbparm.Text	= sqlca.dbparm
end event

on w_set_sqlca.create
this.sle_logpass=create sle_logpass
this.sle_logid=create sle_logid
this.sle_server=create sle_server
this.sle_database=create sle_database
this.sle_dbpass=create sle_dbpass
this.sle_userid=create sle_userid
this.sle_dbms=create sle_dbms
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.sle_dbparm=create sle_dbparm
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_9=create st_9
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_7=create st_7
this.Control[]={ this.sle_logpass,&
this.sle_logid,&
this.sle_server,&
this.sle_database,&
this.sle_dbpass,&
this.sle_userid,&
this.sle_dbms,&
this.st_12,&
this.st_11,&
this.st_10,&
this.sle_dbparm,&
this.cb_cancel,&
this.cb_ok,&
this.st_9,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_7}
end on

on w_set_sqlca.destroy
destroy(this.sle_logpass)
destroy(this.sle_logid)
destroy(this.sle_server)
destroy(this.sle_database)
destroy(this.sle_dbpass)
destroy(this.sle_userid)
destroy(this.sle_dbms)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.sle_dbparm)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_9)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_7)
end on

type sle_logpass from singlelineedit within w_set_sqlca
int X=534
int Y=906
int Width=872
int Height=81
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_logid from singlelineedit within w_set_sqlca
int X=534
int Y=801
int Width=872
int Height=81
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_server from singlelineedit within w_set_sqlca
int X=534
int Y=695
int Width=872
int Height=81
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_database from singlelineedit within w_set_sqlca
int X=534
int Y=589
int Width=872
int Height=81
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_dbpass from singlelineedit within w_set_sqlca
int X=534
int Y=484
int Width=872
int Height=81
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_userid from singlelineedit within w_set_sqlca
int X=534
int Y=378
int Width=872
int Height=81
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_dbms from singlelineedit within w_set_sqlca
int X=534
int Y=273
int Width=872
int Height=81
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within w_set_sqlca
int X=40
int Y=113
int Width=1039
int Height=65
boolean Enabled=false
string Text="Database option to modify these at any time."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within w_set_sqlca
int X=40
int Y=61
int Width=1608
int Height=65
boolean Enabled=false
string Text="samples can be run.  The Code Examples front-end menu has a Change"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within w_set_sqlca
int X=40
int Y=10
int Width=1615
int Height=65
boolean Enabled=false
string Text="Transaction values must be set properly before database or DataWindow"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_dbparm from singlelineedit within w_set_sqlca
int X=534
int Y=1012
int Width=872
int Height=81
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_set_sqlca
int X=825
int Y=1226
int Width=338
int Height=100
int TabOrder=100
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn (Parent, -1)
end event

type cb_ok from commandbutton within w_set_sqlca
int X=470
int Y=1226
int Width=338
int Height=100
int TabOrder=90
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;SetPointer (HourGlass!)

// Disconnect from the "old" DBMS
Disconnect;

// Set new values in transaction object
sqlca.DBMS = sle_dbms.Text
sqlca.database = sle_database.Text
sqlca.userid = sle_userid.Text
sqlca.dbpass = sle_dbpass.Text
sqlca.logid = sle_logid.Text
sqlca.logpass = sle_logpass.Text
sqlca.servername = sle_server.Text
sqlca.dbparm = sle_dbparm.Text

// Connect to the "new" DBMS
Connect;

//w_main.st_connecting.Hide ()
If sqlca.sqlcode < 0 Then
	MessageBox ("Error:  Unable to Connect to Database", &
					sqlca.sqlerrtext, Exclamation!)
	Return
End If

// New Connect was successful...
// Save paremeters to INI file or registry
f_set_profile("sqlca", "dbms", sle_dbms.Text)
f_set_profile("sqlca", "database", sle_database.Text)
f_set_profile("sqlca", "userid", sle_userid.Text)
f_set_profile("sqlca", "dbpass", sle_dbpass.Text)
f_set_profile("sqlca", "logid", sle_logid.Text)
f_set_profile("sqlca", "logpass", sle_logpass.Text)
f_set_profile("sqlca", "servername", sle_server.Text)
f_set_profile("sqlca", "dbparm", sle_dbparm.Text)

CloseWithReturn (Parent,1)
end event

type st_9 from statictext within w_set_sqlca
int X=285
int Y=1021
int Width=232
int Height=61
boolean Enabled=false
string Text="DBPARM:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_set_sqlca
int X=36
int Y=916
int Width=481
int Height=61
boolean Enabled=false
string Text="Logon Password:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_set_sqlca
int X=196
int Y=810
int Width=321
int Height=61
boolean Enabled=false
string Text="Logon ID:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_set_sqlca
int X=242
int Y=493
int Width=274
int Height=61
boolean Enabled=false
string Text="Password:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_set_sqlca
int X=239
int Y=388
int Width=278
int Height=61
boolean Enabled=false
string Text="User ID:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_set_sqlca
int X=161
int Y=599
int Width=356
int Height=61
boolean Enabled=false
string Text="Database:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_set_sqlca
int X=274
int Y=282
int Width=242
int Height=61
boolean Enabled=false
string Text="DBMS:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_set_sqlca
int X=153
int Y=705
int Width=363
int Height=61
boolean Enabled=false
string Text="Server Name:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

