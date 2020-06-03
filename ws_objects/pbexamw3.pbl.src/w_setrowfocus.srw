$PBExportHeader$w_setrowfocus.srw
$PBExportComments$Demonstrates the use of the rowfocus indicator in a datawindow
forward
global type w_setrowfocus from w_center
end type
type st_1 from statictext within w_setrowfocus
end type
type dw_bitmap from datawindow within w_setrowfocus
end type
type rb_right from radiobutton within w_setrowfocus
end type
type rb_left from radiobutton within w_setrowfocus
end type
type rb_none from radiobutton within w_setrowfocus
end type
type p_1 from picture within w_setrowfocus
end type
type cb_close from commandbutton within w_setrowfocus
end type
type rb_rect from radiobutton within w_setrowfocus
end type
type rb_hand from radiobutton within w_setrowfocus
end type
type dw_1 from datawindow within w_setrowfocus
end type
type rb_pic from radiobutton within w_setrowfocus
end type
type gb_1 from groupbox within w_setrowfocus
end type
type gb_2 from groupbox within w_setrowfocus
end type
end forward

global type w_setrowfocus from w_center
int X=1
int Y=132
int Width=2998
int Height=2125
boolean TitleBar=true
string Title="Row Focus Indicators"
long BackColor=74481808
boolean ControlMenu=true
boolean Resizable=true
boolean ToolBarVisible=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
event ue_postopen pbm_custom01
st_1 st_1
dw_bitmap dw_bitmap
rb_right rb_right
rb_left rb_left
rb_none rb_none
p_1 p_1
cb_close cb_close
rb_rect rb_rect
rb_hand rb_hand
dw_1 dw_1
rb_pic rb_pic
gb_1 gb_1
gb_2 gb_2
end type
global w_setrowfocus w_setrowfocus

type variables

end variables

forward prototypes
public subroutine wf_set_row_focus_indicator ()
public subroutine wf_disable_picture_dw ()
end prototypes

event ue_postopen;//Open script for w_setrowfocus
dw_1.SetTransObject(sqlca)

//defualt indicator for this window will be the Focus Rectange
rb_rect.triggerevent("clicked")

//populate datawindow
dw_1.Retrieve( )

//initialize the datawindow for selecting bitmaps
dw_bitmap.InsertRow(0)
dw_bitmap.Object.bitmapname[1] = "indicatr.bmp"

end event

public subroutine wf_set_row_focus_indicator ();//Clicked script for rb_left

// If hand or picture is checked, set them to the left
// (x =0, y = 0 is default, relative to row)

//hand is row indicator (two cases left and right positions)
if rb_hand.checked then
	if rb_left.checked then 
		dw_1.SetRowFocusIndicator(Hand!, 50)
	else
		dw_1.SetRowFocusIndicator (hand!,dw_1.x + dw_1.width - p_1.width - 150)
	End If
//picture is row indicator (two cases left and right positions)
//note: p_1 is a hidden picture used to hold the bitmap that will be used as the indicator
//A hidden picture must be used because the SetRowFocusIndicator requires a picture
//to be passed to it.
Elseif rb_pic.checked then
	if rb_left.checked then 
		dw_1.SetRowFocusIndicator(p_1)
	Else
		SetRowFocusIndicator (dw_1,p_1,dw_1.x + dw_1.width - p_1.width - 150)
	End If
End If


dw_1.Setfocus( )
dw_1.ReselectRow(dw_1.GetRow( ))


end subroutine

public subroutine wf_disable_picture_dw ();//disable bitmap

//This will disable the actual datawindow containing the bitmaps
//The text will be grayed so as to visually simulate the dis-enabled datawindow
dw_bitmap.enabled = false
dw_bitmap.Object.bitmapname.color = ' 8421504'  // Gray
end subroutine

on open;this.postevent("ue_postopen")

end on

on close;//Close script for w_setrowfocus

w_main.Show( )

end on

on w_setrowfocus.create
this.st_1=create st_1
this.dw_bitmap=create dw_bitmap
this.rb_right=create rb_right
this.rb_left=create rb_left
this.rb_none=create rb_none
this.p_1=create p_1
this.cb_close=create cb_close
this.rb_rect=create rb_rect
this.rb_hand=create rb_hand
this.dw_1=create dw_1
this.rb_pic=create rb_pic
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={ this.st_1,&
this.dw_bitmap,&
this.rb_right,&
this.rb_left,&
this.rb_none,&
this.p_1,&
this.cb_close,&
this.rb_rect,&
this.rb_hand,&
this.dw_1,&
this.rb_pic,&
this.gb_1,&
this.gb_2}
end on

on w_setrowfocus.destroy
destroy(this.st_1)
destroy(this.dw_bitmap)
destroy(this.rb_right)
destroy(this.rb_left)
destroy(this.rb_none)
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.rb_rect)
destroy(this.rb_hand)
destroy(this.dw_1)
destroy(this.rb_pic)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type st_1 from statictext within w_setrowfocus
int X=65
int Y=29
int Width=2113
int Height=68
boolean Enabled=false
string Text="Try Different Focus Indicators by clicking the radio buttons in the Focus Style Box."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_bitmap from datawindow within w_setrowfocus
int X=1611
int Y=180
int Width=836
int Height=180
int TabOrder=40
boolean Enabled=false
string DataObject="d_bitmap_dddw"
boolean Border=false
boolean LiveScroll=true
end type

on itemchanged;string ls_filename


//Get the filename of the bitmap from the dropdown datawindow 
ls_filename = dw_bitmap.GetText( )

//Set a hidden picture to use the bitmap that has been selected
p_1.picturename = ls_filename

//Local window function to change to appropriate indicator
wf_set_row_focus_indicator ()
end on

type rb_right from radiobutton within w_setrowfocus
int X=1010
int Y=365
int Width=257
int Height=68
boolean Enabled=false
string Text="Right"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//// If hand or picture is checked, set them to the right

//Local window function to change to appropriate indicator/indicator location
wf_set_row_focus_indicator ()
end on

type rb_left from radiobutton within w_setrowfocus
int X=1010
int Y=276
int Width=257
int Height=68
boolean Enabled=false
string Text="Left"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;////Clicked script for rb_left

//Local window function to change to appropriate indicator/indicator location
wf_set_row_focus_indicator ()
end on

type rb_none from radiobutton within w_setrowfocus
int X=129
int Y=276
int Width=257
int Height=68
string Text="None"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for rb_none

dw_1.SetRowFocusIndicator(off!)

// Set focus to datawindow & force re-paint of row
dw_1.Setfocus( )
dw_1.ReselectRow(dw_1.GetRow( ))

//disable picture ddlb
wf_disable_picture_dw ( )

//left and right buttons are not applicable to this choice
rb_left.Enabled = False
rb_right.Enabled = False
end on

type p_1 from picture within w_setrowfocus
int X=2571
int Y=881
int Width=150
int Height=87
boolean Visible=false
string PictureName="indicatr.bmp"
end type

type cb_close from commandbutton within w_setrowfocus
int X=2539
int Y=513
int Width=310
int Height=97
int TabOrder=50
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_close

Close(parent)
end on

type rb_rect from radiobutton within w_setrowfocus
int X=466
int Y=276
int Width=385
int Height=68
string Text="Rectangle"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for rb_rect

dw_1.SetRowFocusIndicator(FocusRect!)

// Set focus to datawindow & force re-paint of row
dw_1.Setfocus( )
dw_1.ReselectRow(dw_1.GetRow( ))


//disable picture dw
wf_disable_picture_dw ( )

//left and right buttons are not applicable to this choice
rb_left.Enabled = False
rb_right.Enabled = False


end on

type rb_hand from radiobutton within w_setrowfocus
int X=129
int Y=365
int Width=257
int Height=68
string Text="Hand"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;////Clicked script for rb_hand
wf_set_row_focus_indicator ()

//disable picture dw
wf_disable_picture_dw ( )

//enable left and right radio buttons for this type of selection
rb_left.Enabled = True
rb_right.Enabled = True
end on

type dw_1 from datawindow within w_setrowfocus
int X=36
int Y=513
int Width=2418
int Height=1245
int TabOrder=10
string DataObject="d_setrowfocus"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

type rb_pic from radiobutton within w_setrowfocus
int X=466
int Y=365
int Width=292
int Height=68
string Text="Picture"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////Clicked script for rb_pic

//Local window function to change to appropriate indicator/indicator location
wf_set_row_focus_indicator ( )

//Enable the bitmap selection datawindow 
dw_bitmap.Enabled = True

//The Text must visiually appear enabled because these are elements in a datawindow
dw_bitmap.Object.bitmapname.color = '0'  // Black

//enable left and right radio buttons for this type of selection
rb_left.Enabled = True
rb_right.Enabled = True
end event

type gb_1 from groupbox within w_setrowfocus
int X=50
int Y=180
int Width=836
int Height=289
int TabOrder=20
string Text="Focus Indicator Style"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_setrowfocus
int X=961
int Y=180
int Width=616
int Height=289
int TabOrder=30
string Text="Indicator Location"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

