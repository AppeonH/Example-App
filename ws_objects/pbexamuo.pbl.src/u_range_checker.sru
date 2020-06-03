$PBExportHeader$u_range_checker.sru
$PBExportComments$Single line edit which accepts numeric input within a specific range
forward
global type u_range_checker from singlelineedit
end type
end forward

global type u_range_checker from singlelineedit
int Width=665
int Height=87
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type
global u_range_checker u_range_checker

type variables
long    il_lower = 0, il_upper = 100
end variables

forward prototypes
public subroutine uf_set_range (long al_lower, long al_upper)
end prototypes

public subroutine uf_set_range (long al_lower, long al_upper);//////////////////////////////////////////////////////////////////////
//
// Function: uf_set_range
//
// Purpose: sets the lower and upper limits that are valid for input
//
//	Scope: public
//
//	Arguments: al_lower	the lower limit allowed
//				  al_upper	the upper limit allowed
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

il_lower = al_lower
il_upper = al_upper
end subroutine

on modified;//////////////////////////////////////////////////////////////////////
// Disallow numbers that are not in the valid range 
//////////////////////////////////////////////////////////////////////

if Len (this.text) > 0 then
	if not IsNumber (this.text) then
		this.text = "Invalid number"
		this.SelectText (1, Len (this.text))
	else
		if Dec (this.text) < il_lower or Dec (this.text) > il_upper then
			this.text = "Number out of valid range"
			this.SelectText (1, Len (this.text))
			Beep (1)
		end if
	end if
end if
end on

