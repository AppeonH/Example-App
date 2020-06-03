$PBExportHeader$w_dde_client.srw
$PBExportComments$Works with w_dde_server to demonstrate how to do a PB DDE server
forward
global type w_dde_client from w_center
end type
type cb_exit from commandbutton within w_dde_client
end type
type cb_help from commandbutton within w_dde_client
end type
type rb_gr_data3 from radiobutton within w_dde_client
end type
type rb_gr_data2 from radiobutton within w_dde_client
end type
type rb_gr_data1 from radiobutton within w_dde_client
end type
type rb_data3 from radiobutton within w_dde_client
end type
type rb_data2 from radiobutton within w_dde_client
end type
type rb_data1 from radiobutton within w_dde_client
end type
type cb_stop from commandbutton within w_dde_client
end type
type cb_starthotlink from commandbutton within w_dde_client
end type
type st_1 from statictext within w_dde_client
end type
type sle_command from singlelineedit within w_dde_client
end type
type mle_msg from multilineedit within w_dde_client
end type
type cb_getremote from commandbutton within w_dde_client
end type
type cb_exec from commandbutton within w_dde_client
end type
type st_2 from statictext within w_dde_client
end type
type gb_getremote from groupbox within w_dde_client
end type
type gb_hotlinks from groupbox within w_dde_client
end type
end forward

global type w_dde_client from w_center
int X=1537
int Y=180
int Width=1334
int Height=1226
boolean TitleBar=true
string Title="DDE Client"
long BackColor=78748035
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
cb_exit cb_exit
cb_help cb_help
rb_gr_data3 rb_gr_data3
rb_gr_data2 rb_gr_data2
rb_gr_data1 rb_gr_data1
rb_data3 rb_data3
rb_data2 rb_data2
rb_data1 rb_data1
cb_stop cb_stop
cb_starthotlink cb_starthotlink
st_1 st_1
sle_command sle_command
mle_msg mle_msg
cb_getremote cb_getremote
cb_exec cb_exec
st_2 st_2
gb_getremote gb_getremote
gb_hotlinks gb_hotlinks
end type
global w_dde_client w_dde_client

type variables
String is_ddeappl = "DDE_Demo",is_dde_topic="DDE"
String is_hotlink_field = "Data1"
String is_getremote_field = "Data1"
string is_hotlink_list[3]
integer ii_hotlink_cnt = 0
end variables

forward prototypes
public subroutine set_msg (string msg)
end prototypes

public subroutine set_msg (string msg);// display the message
mle_msg.text = msg
end subroutine

on close;
integer i,resp
// if there are any running hotlinks then stop them before closing
for i = 1 to 3
	if len(is_hotlink_list[i]) > 0 then 
		resp = stophotlink(is_hotlink_list[i],is_ddeappl,is_dde_topic)
	end if
next
if isvalid(w_dde_server) then close(w_dde_server)
w_main.show()

end on

on hotlinkalarm;string data,appl,topic,item
// who sent the alarm
getdataddeorigin(appl,topic,item)
// get the data
getdatadde(data)
// tell the sender that we handled the hotlink OK
respondremote(true)
set_msg("Hotlinkalarm triggered. ~r~n  Application = "+appl+" Topic= "+topic+"~r~n  Item = "+item+"~r~n  Data = "+data)
end on

on open;open(w_dde_server)
end on

on w_dde_client.create
this.cb_exit=create cb_exit
this.cb_help=create cb_help
this.rb_gr_data3=create rb_gr_data3
this.rb_gr_data2=create rb_gr_data2
this.rb_gr_data1=create rb_gr_data1
this.rb_data3=create rb_data3
this.rb_data2=create rb_data2
this.rb_data1=create rb_data1
this.cb_stop=create cb_stop
this.cb_starthotlink=create cb_starthotlink
this.st_1=create st_1
this.sle_command=create sle_command
this.mle_msg=create mle_msg
this.cb_getremote=create cb_getremote
this.cb_exec=create cb_exec
this.st_2=create st_2
this.gb_getremote=create gb_getremote
this.gb_hotlinks=create gb_hotlinks
this.Control[]={ this.cb_exit,&
this.cb_help,&
this.rb_gr_data3,&
this.rb_gr_data2,&
this.rb_gr_data1,&
this.rb_data3,&
this.rb_data2,&
this.rb_data1,&
this.cb_stop,&
this.cb_starthotlink,&
this.st_1,&
this.sle_command,&
this.mle_msg,&
this.cb_getremote,&
this.cb_exec,&
this.st_2,&
this.gb_getremote,&
this.gb_hotlinks}
end on

on w_dde_client.destroy
destroy(this.cb_exit)
destroy(this.cb_help)
destroy(this.rb_gr_data3)
destroy(this.rb_gr_data2)
destroy(this.rb_gr_data1)
destroy(this.rb_data3)
destroy(this.rb_data2)
destroy(this.rb_data1)
destroy(this.cb_stop)
destroy(this.cb_starthotlink)
destroy(this.st_1)
destroy(this.sle_command)
destroy(this.mle_msg)
destroy(this.cb_getremote)
destroy(this.cb_exec)
destroy(this.st_2)
destroy(this.gb_getremote)
destroy(this.gb_hotlinks)
end on

type cb_exit from commandbutton within w_dde_client
int X=978
int Y=973
int Width=242
int Height=109
int TabOrder=90
string Text="Exit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type cb_help from commandbutton within w_dde_client
int X=978
int Y=833
int Width=242
int Height=109
int TabOrder=60
string Text="Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help(classname(parent))
end on

type rb_gr_data3 from radiobutton within w_dde_client
int X=75
int Y=973
int Width=242
int Height=68
string Text="Data3"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;if this.checked then is_getremote_field= this.text
end on

type rb_gr_data2 from radiobutton within w_dde_client
int X=75
int Y=900
int Width=242
int Height=68
string Text="Data2"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;if this.checked then is_getremote_field= this.text
end on

type rb_gr_data1 from radiobutton within w_dde_client
int X=75
int Y=833
int Width=242
int Height=68
string Text="Data1"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;if this.checked then is_getremote_field= this.text
end on

type rb_data3 from radiobutton within w_dde_client
int X=708
int Y=641
int Width=242
int Height=68
string Text="Data3"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;if this.checked then is_hotlink_field = this.text
end on

type rb_data2 from radiobutton within w_dde_client
int X=708
int Y=564
int Width=242
int Height=68
string Text="Data2"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;if this.checked then is_hotlink_field = this.text
end on

type rb_data1 from radiobutton within w_dde_client
int X=708
int Y=497
int Width=242
int Height=68
string Text="Data1"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;if this.checked then is_hotlink_field = this.text
end on

type cb_stop from commandbutton within w_dde_client
int X=993
int Y=596
int Width=246
int Height=109
int TabOrder=100
string Text="Stop"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;int resp
resp = stophotlink(is_hotlink_field,is_ddeappl,is_dde_topic)
if resp <> 1 then 
	messagebox("Stop Hotlink","Error code = "+string(resp))
	return
end if
// remove the hotlink field from the hotlink list
for resp = 1 to 3
	if is_hotlink_list[resp] = is_hotlink_field then 
		is_hotlink_list[resp] = ''
		return
	end if
next
end on

type cb_starthotlink from commandbutton within w_dde_client
int X=993
int Y=468
int Width=246
int Height=109
int TabOrder=70
string Text="Start "
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;int resp
resp = starthotlink(is_hotlink_field,is_ddeappl,is_dde_topic)
if resp <> 1 then 
	messagebox("Starthotlink Error",string(resp))
	return
end if
// place the hotlink filed into the hotlink list
for resp = 1 to 3
	if len(is_hotlink_list[resp]) = 0 then 
		is_hotlink_list[resp] = is_hotlink_field
		return
	end if
next
end on

type st_1 from statictext within w_dde_client
int X=43
int Y=404
int Width=520
int Height=113
boolean Enabled=false
string Text="Execute Remote Command"
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_command from singlelineedit within w_dde_client
int X=43
int Y=516
int Width=552
int Height=84
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_msg from multilineedit within w_dde_client
int X=18
int Y=84
int Width=1256
int Height=305
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_getremote from commandbutton within w_dde_client
int X=417
int Y=884
int Width=338
int Height=109
int TabOrder=80
string Text="Getremote "
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;int resp
string data
resp = getremote(is_getremote_field,data,is_ddeappl,is_dde_topic)
if resp = 1 then 
	set_msg("Getremote "+is_getremote_field+" = "+data)
else
	messagebox("getremote error",String(resp))
end if

end on

type cb_exec from commandbutton within w_dde_client
int X=43
int Y=628
int Width=562
int Height=109
int TabOrder=40
string Text="&Execute Command"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// tell the 
int resp
string data
// tell the server to execute a command
resp = execremote(sle_command.text,is_ddeappl,is_dde_topic)
if resp <> 1 then messagebox("error on execremote",string(resp))
end on

type st_2 from statictext within w_dde_client
int X=18
int Y=20
int Width=406
int Height=61
boolean Enabled=false
string Text="Status :"
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_getremote from groupbox within w_dde_client
int X=33
int Y=781
int Width=801
int Height=292
int TabOrder=50
string Text="GetRemote"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_hotlinks from groupbox within w_dde_client
int X=662
int Y=404
int Width=612
int Height=324
int TabOrder=20
string Text="Hot Links"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

