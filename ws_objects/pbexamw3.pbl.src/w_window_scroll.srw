$PBExportHeader$w_window_scroll.srw
$PBExportComments$Scroll Units Per Line and Scroll Lines Per Page example
forward
global type w_window_scroll from w_center
end type
type cb_apply from commandbutton within w_window_scroll
end type
type st_display from statictext within w_window_scroll
end type
type cb_help from commandbutton within w_window_scroll
end type
type cb_close from commandbutton within w_window_scroll
end type
type em_lines from editmask within w_window_scroll
end type
type em_units from editmask within w_window_scroll
end type
type st_2 from statictext within w_window_scroll
end type
type st_1 from statictext within w_window_scroll
end type
type dw_contacts from datawindow within w_window_scroll
end type
end forward

global type w_window_scroll from w_center
int X=232
int Y=327
int Width=2450
int Height=1261
boolean TitleBar=true
string Title="Window Scrolling"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean VScrollBar=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
int LinesPerPage=10
int UnitsPerLine=16
cb_apply cb_apply
st_display st_display
cb_help cb_help
cb_close cb_close
em_lines em_lines
em_units em_units
st_2 st_2
st_1 st_1
dw_contacts dw_contacts
end type
global w_window_scroll w_window_scroll

type variables

end variables

on open;// initialization

dw_contacts.InsertRow (0)
em_lines.text = '10'
em_units.text = '16'

end on

on close;w_main.Show()
end on

on w_window_scroll.create
this.cb_apply=create cb_apply
this.st_display=create st_display
this.cb_help=create cb_help
this.cb_close=create cb_close
this.em_lines=create em_lines
this.em_units=create em_units
this.st_2=create st_2
this.st_1=create st_1
this.dw_contacts=create dw_contacts
this.Control[]={ this.cb_apply,&
this.st_display,&
this.cb_help,&
this.cb_close,&
this.em_lines,&
this.em_units,&
this.st_2,&
this.st_1,&
this.dw_contacts}
end on

on w_window_scroll.destroy
destroy(this.cb_apply)
destroy(this.st_display)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.em_lines)
destroy(this.em_units)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_contacts)
end on

type cb_apply from commandbutton within w_window_scroll
int X=2052
int Y=49
int Width=264
int Height=109
int TabOrder=30
string Text="Apply"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_display from statictext within w_window_scroll
int X=132
int Y=276
int Width=246
int Height=71
boolean Enabled=false
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_help from commandbutton within w_window_scroll
int X=2052
int Y=317
int Width=264
int Height=109
int TabOrder=60
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// show help for this example

f_open_help ('w_window_scroll')
end on

type cb_close from commandbutton within w_window_scroll
int X=2052
int Y=173
int Width=264
int Height=109
int TabOrder=50
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type em_lines from editmask within w_window_scroll
int X=641
int Y=109
int Width=278
int Height=100
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
boolean Spin=true
double Increment=1
string MinMax="0~~"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;// change the window attribute LinesPerPage which specifies the
// number of lines on a page.

parent.LinesPerPage = Integer (this.text)
end on

type em_units from editmask within w_window_scroll
int X=1558
int Y=109
int Width=278
int Height=100
int TabOrder=20
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
boolean Spin=true
double Increment=1
string MinMax="0~~"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;// change the window attribute UnitsPerLine, which specifies the 
// number of PowerBuilder units to scroll when the arrow of the vertical
// scroll bar is clicked.

parent.UnitsPerLine = Integer (this.text)
end on

type st_2 from statictext within w_window_scroll
int X=985
int Y=116
int Width=548
int Height=71
boolean Enabled=false
string Text="Units per Scroll Line:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_window_scroll
int X=33
int Y=116
int Width=584
int Height=71
boolean Enabled=false
string Text="Scroll Lines Per Page:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_contacts from datawindow within w_window_scroll
int X=473
int Y=333
int Width=1273
int Height=2145
int TabOrder=40
string DataObject="d_contact_long"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

