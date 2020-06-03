$PBExportHeader$w_dde_server.srw
$PBExportComments$Works with w_dde_client to demonstrate how to do a PB DDE server
forward
global type w_dde_server from w_center
end type
type st_6 from statictext within w_dde_server
end type
type cbx_data3 from checkbox within w_dde_server
end type
type cbx_data2 from checkbox within w_dde_server
end type
type cbx_data1 from checkbox within w_dde_server
end type
type sle_data3 from singlelineedit within w_dde_server
end type
type st_4 from statictext within w_dde_server
end type
type mle_msg from multilineedit within w_dde_server
end type
type sle_data2 from singlelineedit within w_dde_server
end type
type sle_data1 from singlelineedit within w_dde_server
end type
type st_2 from statictext within w_dde_server
end type
type st_1 from statictext within w_dde_server
end type
type st_3 from statictext within w_dde_server
end type
type st_5 from statictext within w_dde_server
end type
end forward

global type w_dde_server from w_center
int X=22
int Y=141
int Width=1298
int Height=948
boolean TitleBar=true
string Title="DDE Server"
long BackColor=78748035
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=popup!
st_6 st_6
cbx_data3 cbx_data3
cbx_data2 cbx_data2
cbx_data1 cbx_data1
sle_data3 sle_data3
st_4 st_4
mle_msg mle_msg
sle_data2 sle_data2
sle_data1 sle_data1
st_2 st_2
st_1 st_1
st_3 st_3
st_5 st_5
end type
global w_dde_server w_dde_server

type variables
String is_ddeappl = "DDE_Demo",is_ddetopic="DDE"
string is_item1="Data1",is_item2="Data2",is_item3="Data3"

end variables

forward prototypes
public subroutine set_msg (string msg)
public subroutine check_hotlink (checkbox status, string data, string item)
end prototypes

public subroutine set_msg (string msg);// display the message
mle_msg.text = msg
end subroutine

public subroutine check_hotlink (checkbox status, string data, string item);int resp 
// if the checkbox is checked then the field is hotlinked
if status.checked then
	// send the hotlinked data to the requestor application
	resp = setdatadde(data,is_ddeappl,is_ddetopic,item)
	if resp <> 1 then messagebox("Error on hotlink handler","Setdatadde Failed for data area = "+item+". Error code = "+string(resp))
end if
end subroutine

on remoterequest;string data,appl,topic
// who sent the request and what is it?
getdataddeorigin(appl,topic,data)
set_msg("Remoterequest triggered, ~r~n  Application = "+appl+"~r~n  Topic = "+topic+"~r~n  Request = "+data)
choose case data
	case is_item1
		data = sle_data1.text
	case is_item2
		data = sle_data2.text
	case is_item3
		data = sle_data3.text
	case else
		data = "Unknown Request"
end choose
// send the data back
setdatadde(data)

end on

on open;// start the server and specify what it will support
if startserverdde(is_ddeappl,is_ddetopic,is_item1,is_item2,is_item3) = 1 then 
	set_msg("Server Started")
end if


end on

on remoteexec;string data,appl,topic
// who is the command from 
getcommandddeorigin(appl)
// what is the command
getcommanddde(data)
Set_msg("remoteexec triggered, ~r~n  Application = "+appl+"~r~n  Request = "+data)
// tell the sender that we got the message OK
respondremote(true)
end on

on w_dde_server.create
this.st_6=create st_6
this.cbx_data3=create cbx_data3
this.cbx_data2=create cbx_data2
this.cbx_data1=create cbx_data1
this.sle_data3=create sle_data3
this.st_4=create st_4
this.mle_msg=create mle_msg
this.sle_data2=create sle_data2
this.sle_data1=create sle_data1
this.st_2=create st_2
this.st_1=create st_1
this.st_3=create st_3
this.st_5=create st_5
this.Control[]={ this.st_6,&
this.cbx_data3,&
this.cbx_data2,&
this.cbx_data1,&
this.sle_data3,&
this.st_4,&
this.mle_msg,&
this.sle_data2,&
this.sle_data1,&
this.st_2,&
this.st_1,&
this.st_3,&
this.st_5}
end on

on w_dde_server.destroy
destroy(this.st_6)
destroy(this.cbx_data3)
destroy(this.cbx_data2)
destroy(this.cbx_data1)
destroy(this.sle_data3)
destroy(this.st_4)
destroy(this.mle_msg)
destroy(this.sle_data2)
destroy(this.sle_data1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_5)
end on

on close;// stop the server
stopserverdde(is_ddeappl,is_ddetopic)
if isvalid(w_dde_client) then close(w_dde_client)

end on

on remotehotlinkstart;string item,appl,topic
// Who wants to be hotlinked and what do they want to be hotlinked on
getdataddeorigin(appl,topic,item)
Set_msg("remotehotlinkstart triggered, ~r~n  Application = "+appl+"~r~n  Topic = "+topic+"~r~n  Item = "+item)
choose case item
	case is_item1
		cbx_data1.checked = true
	case is_item2
		cbx_data2.checked = true
	case is_item3
		cbx_data3.checked = true
	case else
		messagebox("remotehotlinkstart","Unknown item requested. Item = "+item)
		respondremote(false)
		return
end choose
// tell the requesttor that we got the message OK
respondremote(true)


end on

on remotehotlinkstop;string item,appl,topic
beep(1)
// who wants to stop the hotlink and what do they want to stop linking on
getdataddeorigin(appl,topic,item)
Set_msg("remotehotlinkstop triggered, ~r~n  Application = "+appl+"~r~n  Topic = "+topic+"~r~n  Item = "+item)
choose case item
	case is_item1
		cbx_data1.checked = false
	case is_item2
		cbx_data2.checked = false
	case is_item3 
		cbx_data3.checked = false
	case else
		messagebox("remotehotlinkstart","Unknown item requested. Item = "+item)
		respondremote(false)
		return
end choose
// tell the requestor that we got the message OK
respondremote(true)


end on

type st_6 from statictext within w_dde_server
int X=11
int Y=33
int Width=260
int Height=68
boolean Enabled=false
string Text="Data Area"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_data3 from checkbox within w_dde_server
int X=1014
int Y=308
int Width=82
int Height=68
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_data2 from checkbox within w_dde_server
int X=1014
int Y=212
int Width=82
int Height=68
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_data1 from checkbox within w_dde_server
int X=1014
int Y=116
int Width=82
int Height=68
boolean Enabled=false
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_data3 from singlelineedit within w_dde_server
int X=178
int Y=301
int Width=715
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

on modified;// determine if the field is hotlinked
check_hotlink(cbx_data3,this.text,is_item3)

end on

type st_4 from statictext within w_dde_server
int X=54
int Y=301
int Width=104
int Height=68
boolean Enabled=false
string Text="#3"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_msg from multilineedit within w_dde_server
int X=22
int Y=465
int Width=1188
int Height=356
int TabOrder=40
BorderStyle BorderStyle=StyleLowered!
boolean DisplayOnly=true
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_data2 from singlelineedit within w_dde_server
int X=178
int Y=205
int Width=715
int Height=84
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;// determine if the field is hotlinked
check_hotlink(cbx_data2,this.text,is_item2)

end on

type sle_data1 from singlelineedit within w_dde_server
int X=178
int Y=109
int Width=715
int Height=84
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;// determine if the field is hotlinked
check_hotlink(cbx_data1,this.text,is_item1)

end on

type st_2 from statictext within w_dde_server
int X=65
int Y=209
int Width=100
int Height=68
boolean Enabled=false
string Text="#2"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_dde_server
int X=65
int Y=116
int Width=100
int Height=68
boolean Enabled=false
string Text="#1"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_dde_server
int X=33
int Y=404
int Width=210
int Height=49
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

type st_5 from statictext within w_dde_server
int X=900
int Y=52
int Width=306
int Height=68
boolean Enabled=false
string Text="Hot linked"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78748035
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

