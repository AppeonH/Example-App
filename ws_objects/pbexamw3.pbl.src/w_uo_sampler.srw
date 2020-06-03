$PBExportHeader$w_uo_sampler.srw
$PBExportComments$Contains user objects for checking input, date scroller, and a progress indicator.
forward
global type w_uo_sampler from w_center
end type
type cb_help from commandbutton within w_uo_sampler
end type
type st_8 from statictext within w_uo_sampler
end type
type cb_1 from commandbutton within w_uo_sampler
end type
type cb_close from commandbutton within w_uo_sampler
end type
type st_overtype from statictext within w_uo_sampler
end type
type sle_overtype from u_overtype_edit within w_uo_sampler
end type
type uo_progress_bar from u_progress_bar within w_uo_sampler
end type
type uo_date_scroller from u_date_scroller within w_uo_sampler
end type
type st_5 from statictext within w_uo_sampler
end type
type uo_range_checker from u_range_checker within w_uo_sampler
end type
type sle_from from singlelineedit within w_uo_sampler
end type
type sle_to from singlelineedit within w_uo_sampler
end type
type st_3 from statictext within w_uo_sampler
end type
type st_2 from statictext within w_uo_sampler
end type
type st_1 from statictext within w_uo_sampler
end type
type st_6 from statictext within w_uo_sampler
end type
type uo_3 from u_numeric_edit within w_uo_sampler
end type
type uo_2 from u_date_edit within w_uo_sampler
end type
type st_7 from statictext within w_uo_sampler
end type
end forward

global type w_uo_sampler from w_center
int X=192
int Y=376
int Width=2537
int Height=1176
boolean TitleBar=true
string Title="User Object Examples"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_help cb_help
st_8 st_8
cb_1 cb_1
cb_close cb_close
st_overtype st_overtype
sle_overtype sle_overtype
uo_progress_bar uo_progress_bar
uo_date_scroller uo_date_scroller
st_5 st_5
uo_range_checker uo_range_checker
sle_from sle_from
sle_to sle_to
st_3 st_3
st_2 st_2
st_1 st_1
st_6 st_6
uo_3 uo_3
uo_2 uo_2
st_7 st_7
end type
global w_uo_sampler w_uo_sampler

type variables
dec {2}  ic_pct_complete

end variables

on timer;//////////////////////////////////////////////////////////////////////
// Update the progress meter each time the timer event is triggered.
// When the progress meter is at 100%, stop triggering the timer evetn.
//////////////////////////////////////////////////////////////////////

ic_pct_complete = ic_pct_complete + 10
uo_progress_bar.uf_set_position (ic_pct_complete)

if ic_pct_complete >= 100.0  then 
	Timer (0)
	Beep (1)
end if
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// Initialize date scroller to today
//////////////////////////////////////////////////////////////////////
uo_date_scroller.uf_set_date (Today())


//////////////////////////////////////////////////////////////////////
// Initialize range checker default values
//////////////////////////////////////////////////////////////////////
uo_range_checker.uf_set_range (Long (sle_from.text), Long (sle_to.text))

//////////////////////////////////////////////////////////////////////
// Overtype mode example only works on Windows
//////////////////////////////////////////////////////////////////////
If (ge_Environment.OSType <> windows!) And (ge_Environment.OSType <> windowsnt!) Then
	st_overtype.Visible = False
	sle_overtype.Visible = False
End If

end event

on close;w_main.Show()
end on

on w_uo_sampler.create
this.cb_help=create cb_help
this.st_8=create st_8
this.cb_1=create cb_1
this.cb_close=create cb_close
this.st_overtype=create st_overtype
this.sle_overtype=create sle_overtype
this.uo_progress_bar=create uo_progress_bar
this.uo_date_scroller=create uo_date_scroller
this.st_5=create st_5
this.uo_range_checker=create uo_range_checker
this.sle_from=create sle_from
this.sle_to=create sle_to
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_6=create st_6
this.uo_3=create uo_3
this.uo_2=create uo_2
this.st_7=create st_7
this.Control[]={ this.cb_help,&
this.st_8,&
this.cb_1,&
this.cb_close,&
this.st_overtype,&
this.sle_overtype,&
this.uo_progress_bar,&
this.uo_date_scroller,&
this.st_5,&
this.uo_range_checker,&
this.sle_from,&
this.sle_to,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_6,&
this.uo_3,&
this.uo_2,&
this.st_7}
end on

on w_uo_sampler.destroy
destroy(this.cb_help)
destroy(this.st_8)
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.st_overtype)
destroy(this.sle_overtype)
destroy(this.uo_progress_bar)
destroy(this.uo_date_scroller)
destroy(this.st_5)
destroy(this.uo_range_checker)
destroy(this.sle_from)
destroy(this.sle_to)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_6)
destroy(this.uo_3)
destroy(this.uo_2)
destroy(this.st_7)
end on

type cb_help from commandbutton within w_uo_sampler
int X=2217
int Y=180
int Width=247
int Height=108
int TabOrder=100
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help (parent.ClassName())
end on

type st_8 from statictext within w_uo_sampler
int X=562
int Y=924
int Width=489
int Height=72
boolean Enabled=false
string Text="Percent Complete:"
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

type cb_1 from commandbutton within w_uo_sampler
int X=41
int Y=904
int Width=480
int Height=108
int TabOrder=80
string Text="&Progress Meter"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//////////////////////////////////////////////////////////////////////
// Start the progress meter by setting the timer event on the window
//////////////////////////////////////////////////////////////////////

ic_pct_complete = 0.0
uo_progress_bar.uf_set_position (ic_pct_complete)

Timer (0.7)


end on

type cb_close from commandbutton within w_uo_sampler
int X=2217
int Y=40
int Width=247
int Height=108
int TabOrder=90
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type st_overtype from statictext within w_uo_sampler
int X=169
int Y=364
int Width=530
int Height=72
boolean Enabled=false
string Text="Overtype Mode SLE:"
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

type sle_overtype from u_overtype_edit within w_uo_sampler
int X=722
int Y=356
int TabOrder=30
long TextColor=41943040
long BackColor=1086902488
end type

type uo_progress_bar from u_progress_bar within w_uo_sampler
int X=1079
int Y=924
int Width=1175
end type

on uo_progress_bar.destroy
call u_progress_bar::destroy
end on

type uo_date_scroller from u_date_scroller within w_uo_sampler
int X=709
int Y=636
int Width=416
int TabOrder=70
long BackColor=74481808
end type

on uo_date_scroller.destroy
call u_date_scroller::destroy
end on

type st_5 from statictext within w_uo_sampler
int X=325
int Y=672
int Width=375
int Height=60
string Text="Date Scroller:"
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

type uo_range_checker from u_range_checker within w_uo_sampler
int X=722
int Y=504
int Width=727
int TabOrder=40
long TextColor=41943040
long BackColor=1086902488
end type

on uo_range_checker.destroy
call u_range_checker::destroy
end on

type sle_from from singlelineedit within w_uo_sampler
int X=1669
int Y=504
int Width=311
int Height=88
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="0"
string Pointer="arrow!"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;//////////////////////////////////////////////////////////////////////
// Call user object function to set the lower and upper range limits.
//////////////////////////////////////////////////////////////////////

uo_range_checker.uf_set_range (Long (sle_from.text), Long (sle_to.text))
end on

type sle_to from singlelineedit within w_uo_sampler
int X=2153
int Y=504
int Width=311
int Height=88
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="100"
string Pointer="arrow!"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;//////////////////////////////////////////////////////////////////////
// Call user object function to set the lower and upper range limits.
//////////////////////////////////////////////////////////////////////

uo_range_checker.uf_set_range (Long (sle_from.text), Long (sle_to.text))
end on

type st_3 from statictext within w_uo_sampler
int X=114
int Y=224
int Width=585
int Height=56
string Text="Enter a valid numeric:"
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

type st_2 from statictext within w_uo_sampler
int X=160
int Y=84
int Width=535
int Height=60
string Text="Enter a valid Friday:"
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

type st_1 from statictext within w_uo_sampler
int X=37
int Y=520
int Width=663
int Height=60
string Text="Numeric Range Checker:"
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

type st_6 from statictext within w_uo_sampler
int X=1504
int Y=508
int Width=151
int Height=80
string Text="From:"
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

type uo_3 from u_numeric_edit within w_uo_sampler
int X=704
int Y=192
int Width=503
int Height=124
int TabOrder=20
long BackColor=74481808
end type

on uo_3.destroy
call u_numeric_edit::destroy
end on

type uo_2 from u_date_edit within w_uo_sampler
int X=704
int Y=52
int Width=480
int TabOrder=10
long BackColor=74481808
end type

on uo_2.destroy
call u_date_edit::destroy
end on

type st_7 from statictext within w_uo_sampler
int X=2039
int Y=508
int Width=101
int Height=80
string Text="To:"
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

