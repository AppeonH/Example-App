$PBExportHeader$u_progress_bar.sru
$PBExportComments$Progress meter, similar to the ones found in the Setup programs.
forward
global type u_progress_bar from UserObject
end type
type st_1 from statictext within u_progress_bar
end type
type rc_2 from rectangle within u_progress_bar
end type
end forward

global type u_progress_bar from UserObject
int Width=1213
int Height=77
boolean Border=true
long BackColor=16777215
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
st_1 st_1
rc_2 rc_2
end type
global u_progress_bar u_progress_bar

type variables
// Determines if the progress bar has touched the 
// percentage text
boolean    ib_invert
end variables

forward prototypes
public subroutine uf_set_position (decimal ac_pct_complete)
end prototypes

public subroutine uf_set_position (decimal ac_pct_complete);//////////////////////////////////////////////////////////////////////
//
// Function: uf_set_position
//
// Purpose: expands the progress meter and updates the percentage
//				to the percentage argument passed to this function
//
//	Scope: public
//
//	Arguments: ac_pct_complete		the percentage that the progress meter
//											should be set to
//	
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

long	ll_color


//////////////////////////////////////////////////////////////////////
// Reset instance variable and colors if progress meter has been restarted
//////////////////////////////////////////////////////////////////////
if Int (ac_pct_complete) = 0 then
	ib_invert = false
	st_1.TextColor = RGB (0, 0, 255)
	st_1.BackColor = RGB (255, 255, 255)	
end if


//////////////////////////////////////////////////////////////////////
// expand the progess bar
//////////////////////////////////////////////////////////////////////
rc_2.width = ac_pct_complete / 100.0 * this.width
rc_2.visible = true

//////////////////////////////////////////////////////////////////////
// update the percentage text
//////////////////////////////////////////////////////////////////////
st_1.text = String (ac_pct_complete / 100.0, "##0%")


//////////////////////////////////////////////////////////////////////
// check to see if the progress bar touches the percentage text.  
// If so, invert the percentage text colors.
//////////////////////////////////////////////////////////////////////
if not ib_invert then
	if rc_2.width >= st_1.x then
		ib_invert = true
		ll_color = st_1.textcolor
		st_1.TextColor = st_1.BackColor
		st_1.BackColor = ll_color
	end if
end if
end subroutine

on u_progress_bar.create
this.st_1=create st_1
this.rc_2=create rc_2
this.Control[]={ this.st_1,&
this.rc_2}
end on

on u_progress_bar.destroy
destroy(this.st_1)
destroy(this.rc_2)
end on

type st_1 from statictext within u_progress_bar
int X=516
int Y=4
int Width=136
int Height=65
string Text="0%"
boolean FocusRectangle=false
long TextColor=16711680
long BackColor=16777215
long BorderColor=16711680
int TextSize=-9
int Weight=700
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rc_2 from rectangle within u_progress_bar
int Width=33
int Height=145
boolean Visible=false
boolean Enabled=false
int LineThickness=4
long LineColor=16711680
long FillColor=16711680
end type

