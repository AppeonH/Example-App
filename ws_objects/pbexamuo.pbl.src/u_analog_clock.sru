$PBExportHeader$u_analog_clock.sru
$PBExportComments$Graphic analog clock
forward
global type u_analog_clock from UserObject
end type
type st_7 from statictext within u_analog_clock
end type
type st_4 from statictext within u_analog_clock
end type
type st_10 from statictext within u_analog_clock
end type
type st_1 from statictext within u_analog_clock
end type
type st_5 from statictext within u_analog_clock
end type
type st_3 from statictext within u_analog_clock
end type
type st_6 from statictext within u_analog_clock
end type
type st_2 from statictext within u_analog_clock
end type
type st_11 from statictext within u_analog_clock
end type
type st_9 from statictext within u_analog_clock
end type
type st_12 from statictext within u_analog_clock
end type
type st_8 from statictext within u_analog_clock
end type
type ln_hours from line within u_analog_clock
end type
type ln_minutes from line within u_analog_clock
end type
type ln_seconds from line within u_analog_clock
end type
end forward

global type u_analog_clock from UserObject
int Width=923
int Height=732
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event timer pbm_timer
st_7 st_7
st_4 st_4
st_10 st_10
st_1 st_1
st_5 st_5
st_3 st_3
st_6 st_6
st_2 st_2
st_11 st_11
st_9 st_9
st_12 st_12
st_8 st_8
ln_hours ln_hours
ln_minutes ln_minutes
ln_seconds ln_seconds
end type
global u_analog_clock u_analog_clock

type prototypes

end prototypes

type variables
int         ii_midx, ii_midy
boolean ib_showing
int         ii_oldx2, ii_oldx3, ii_oldy2, ii_oldy3
end variables

forward prototypes
public subroutine uf_start_ticking ()
public subroutine uf_stop_ticking ()
end prototypes

event timer;//////////////////////////////////////////////////////////////////////
// Timer script for u_analog_clock
//////////////////////////////////////////////////////////////////////

Real		xx 
Integer	x2, y2, x3, y3


//////////////////////////////////////////////////////////////////////
// initialize first time in
//////////////////////////////////////////////////////////////////////
If Not ib_showing Then
	// Save midpoint of workspace in instance variables ii_midx and midy.
	// This is the center of the clock. 
	ii_midy = This.height/2
	ii_midx = This.width/2

	// Set begining x & y for second, minute & hour hands
	ln_seconds.beginx = ii_midx
	ln_seconds.beginy = ii_midy

	ln_minutes.beginx = ii_midx 
	ln_minutes.beginy = ii_midy 

	ln_hours.beginx = ii_midx 
	ln_hours.beginy = ii_midy 
End If

//////////////////////////////////////////////////////////////////////
// Compute and set the end x,y for seconds
//////////////////////////////////////////////////////////////////////
xx = 2 * Second (Now())
xx = xx / 60
xx = Pi (xx)

//////////////////////////////////////////////////////////////////////
// Adjust so hand is shorter than outer edge of clock 
//////////////////////////////////////////////////////////////////////
ln_seconds.endx  = ii_midx + 250 * sin (xx)	
ln_seconds.endy  = ii_midy - 220 * Cos (xx)

//////////////////////////////////////////////////////////////////////
// Compute and set the end x,y for minutes
//////////////////////////////////////////////////////////////////////
xx = 2 * (60 * Minute (Now()) + Second (Now()))
xx = xx / 3600
xx = Pi (xx)

//////////////////////////////////////////////////////////////////////
// Move minute hand only when minute has changed
//////////////////////////////////////////////////////////////////////
x2 = Int (ii_midx + 240 * sin(xx))
If x2 <> ii_oldx2 or y2 <> ii_oldy2 Then
	ln_minutes.endx = x2
	ii_oldx2        = x2
	y2              = Int (ii_midy - 210 * Cos(xx))
	ln_minutes.endy = y2
	ii_oldy2        = y2
End If

//////////////////////////////////////////////////////////////////////
// Compute and set the end x,y for hours
//////////////////////////////////////////////////////////////////////
xx = 2 * (3600 * Hour(Now()) + 60 * Minute (Now()) + Second(Now()))
xx = xx / 3600
xx = xx / 12
xx = Pi (xx)

//////////////////////////////////////////////////////////////////////
// Move hour hand only when hour has changed
//////////////////////////////////////////////////////////////////////
x3 = Int (ii_midx + 175 * sin (xx))
If x3 <> ii_oldx3 Then
	ln_hours.endx = x3
	ii_oldx3 = x3
End If

y3=Int (ii_midy - 155 * Cos(xx))
If y3 <> ii_oldy3 Then
	ln_hours.endy = y3
	ii_oldy3 = y3
End If

//////////////////////////////////////////////////////////////////////
// Make hands visible first time in
//////////////////////////////////////////////////////////////////////
If ib_showing = False Then
	ib_showing = True
	ln_seconds.Show()
	ln_minutes.Show()
	ln_hours.Show()
End If

end event

public subroutine uf_start_ticking ();//////////////////////////////////////////////////////////////////////
//
// Function: uf_start_ticking
//
// Purpose: set the timer for the analog clock
//
//	Scope: public
//
//	Arguments: none
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////


int	li_id

li_id = gu_ext_func.uf_SetTimer (Handle (this), 1, 1000)
if li_id = 0 then
	MessageBox ("Error!", "Unable to start timer!")
end if
end subroutine

public subroutine uf_stop_ticking ();//////////////////////////////////////////////////////////////////////
//
// Function: uf_stop_ticking
//
// Purpose: stop the timer for the analog clock
//
//	Scope: public
//
//	Arguments: none
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

boolean	lb_ret

lb_ret = gu_ext_func.uf_KillTimer (Handle(this), 1)
if lb_ret = false then
	 MessageBox ("Error!", "Specified timer not active!")
end if
end subroutine

on u_analog_clock.create
this.st_7=create st_7
this.st_4=create st_4
this.st_10=create st_10
this.st_1=create st_1
this.st_5=create st_5
this.st_3=create st_3
this.st_6=create st_6
this.st_2=create st_2
this.st_11=create st_11
this.st_9=create st_9
this.st_12=create st_12
this.st_8=create st_8
this.ln_hours=create ln_hours
this.ln_minutes=create ln_minutes
this.ln_seconds=create ln_seconds
this.Control[]={this.st_7,&
this.st_4,&
this.st_10,&
this.st_1,&
this.st_5,&
this.st_3,&
this.st_6,&
this.st_2,&
this.st_11,&
this.st_9,&
this.st_12,&
this.st_8,&
this.ln_hours,&
this.ln_minutes,&
this.ln_seconds}
end on

on u_analog_clock.destroy
destroy(this.st_7)
destroy(this.st_4)
destroy(this.st_10)
destroy(this.st_1)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.st_6)
destroy(this.st_2)
destroy(this.st_11)
destroy(this.st_9)
destroy(this.st_12)
destroy(this.st_8)
destroy(this.ln_hours)
destroy(this.ln_minutes)
destroy(this.ln_seconds)
end on

type st_7 from statictext within u_analog_clock
int X=407
int Y=580
int Width=87
int Height=72
boolean Enabled=false
string Text="6"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within u_analog_clock
int X=722
int Y=308
int Width=87
int Height=72
boolean Enabled=false
string Text="3"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_10 from statictext within u_analog_clock
int X=82
int Y=308
int Width=87
int Height=72
boolean Enabled=false
string Text="9"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within u_analog_clock
int X=407
int Y=60
int Width=87
int Height=72
boolean Enabled=false
string Text="12"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within u_analog_clock
int X=681
int Y=444
int Width=87
int Height=72
boolean Enabled=false
string Text="4"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within u_analog_clock
int X=681
int Y=180
int Width=87
int Height=72
boolean Enabled=false
string Text="2"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within u_analog_clock
int X=567
int Y=548
int Width=87
int Height=72
boolean Enabled=false
string Text="5"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within u_analog_clock
int X=567
int Y=92
int Width=87
int Height=72
boolean Enabled=false
string Text="1"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within u_analog_clock
int X=128
int Y=444
int Width=87
int Height=72
boolean Enabled=false
string Text="8"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within u_analog_clock
int X=128
int Y=180
int Width=87
int Height=72
boolean Enabled=false
string Text="10"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_12 from statictext within u_analog_clock
int X=247
int Y=548
int Width=87
int Height=72
boolean Enabled=false
string Text="7"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within u_analog_clock
int X=247
int Y=92
int Width=87
int Height=72
boolean Enabled=false
string Text="11"
Alignment Alignment=Center!
long TextColor=33554432
long BackColor=78682240
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ln_hours from line within u_analog_clock
boolean Visible=false
boolean Enabled=false
int BeginX=471
int BeginY=332
int EndX=471
int EndY=188
int LineThickness=12
long LineColor=41943040
end type

type ln_minutes from line within u_analog_clock
boolean Visible=false
boolean Enabled=false
int BeginX=485
int BeginY=340
int EndX=677
int EndY=420
int LineThickness=8
long LineColor=41943040
end type

type ln_seconds from line within u_analog_clock
boolean Visible=false
boolean Enabled=false
int BeginX=466
int BeginY=332
int EndX=640
int EndY=492
int LineThickness=4
long LineColor=41943040
end type

