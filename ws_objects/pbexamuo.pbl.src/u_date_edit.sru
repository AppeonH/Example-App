$PBExportHeader$u_date_edit.sru
$PBExportComments$Edit mask which checks for a valid Friday
forward
global type u_date_edit from UserObject
end type
type em_1 from editmask within u_date_edit
end type
end forward

global type u_date_edit from UserObject
int Width=466
int Height=125
long BackColor=78682240
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
em_1 em_1
end type
global u_date_edit u_date_edit

on u_date_edit.create
this.em_1=create em_1
this.Control[]={ this.em_1}
end on

on u_date_edit.destroy
destroy(this.em_1)
end on

type em_1 from editmask within u_date_edit
int X=11
int Y=13
int Width=434
int Height=97
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
long TextColor=33554432
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on modified;//////////////////////////////////////////////////////////////////////
//
// Test if the date entered is a Friday
//
//////////////////////////////////////////////////////////////////////

date	ld_friday

this.GetData (ld_friday)

if not DayName (ld_friday) = "Friday" then
	Beep (1)
	this.text = ""
	this.SelectText (1, Len (this.text))
end if


	
end on

