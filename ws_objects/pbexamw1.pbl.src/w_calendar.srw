$PBExportHeader$w_calendar.srw
$PBExportComments$Window to demonstrate the user object drop down calendar
forward
global type w_calendar from w_center
end type
type cb_close from commandbutton within w_calendar
end type
type st_2 from statictext within w_calendar
end type
type st_1 from statictext within w_calendar
end type
type ddlb_date from dropdownlistbox within w_calendar
end type
type uo_1 from u_ddcal within w_calendar
end type
type gb_1 from groupbox within w_calendar
end type
end forward

global type w_calendar from w_center
int X=502
int Y=359
int Width=1871
int Height=1223
boolean TitleBar=true
string Title="Drop Down Calendar"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_close cb_close
st_2 st_2
st_1 st_1
ddlb_date ddlb_date
uo_1 uo_1
gb_1 gb_1
end type
global w_calendar w_calendar

on close;w_main.Show()
end on

on open;//Initialize the userobject by calling its local function Init_cal and passing it a start date
uo_1.init_cal(today())
uo_1.set_date_format ( ddlb_date.text )
end on

on w_calendar.create
this.cb_close=create cb_close
this.st_2=create st_2
this.st_1=create st_1
this.ddlb_date=create ddlb_date
this.uo_1=create uo_1
this.gb_1=create gb_1
this.Control[]={ this.cb_close,&
this.st_2,&
this.st_1,&
this.ddlb_date,&
this.uo_1,&
this.gb_1}
end on

on w_calendar.destroy
destroy(this.cb_close)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.ddlb_date)
destroy(this.uo_1)
destroy(this.gb_1)
end on

type cb_close from commandbutton within w_calendar
int X=1380
int Y=961
int Width=324
int Height=87
int TabOrder=30
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type st_2 from statictext within w_calendar
int X=107
int Y=215
int Width=865
int Height=71
boolean Enabled=false
string Text="User Object Drop Down Calendar"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_calendar
int X=68
int Y=17
int Width=1721
int Height=113
boolean Enabled=false
string Text="Click the drop down button on the user object to display the drop down calendar."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddlb_date from dropdownlistbox within w_calendar
int X=1089
int Y=295
int Width=644
int Height=535
int TabOrder=20
string Text="dd-mmm-yy"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"dd-mmm-yy",&
"[LongDate]",&
"[ShortDate]",&
"mmm-yy",&
"dddd, mmm d, yyyy",&
"mm/dd/yyyy",&
"mm/dd/yy"}
end type

on modified;//register w/user object that the format has changed
uo_1.set_date_format ( ddlb_date.text )
end on

type uo_1 from u_ddcal within w_calendar
int X=72
int Y=260
int Width=957
long BackColor=74481808
end type

on uo_1.destroy
call u_ddcal::destroy
end on

type gb_1 from groupbox within w_calendar
int X=1046
int Y=215
int Width=737
int Height=212
int TabOrder=10
string Text="Date Format "
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

