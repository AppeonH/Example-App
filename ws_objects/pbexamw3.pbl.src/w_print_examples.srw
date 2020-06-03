$PBExportHeader$w_print_examples.srw
$PBExportComments$Show use of the print object and print screen functions.
forward
global type w_print_examples from w_center
end type
type cb_window2 from commandbutton within w_print_examples
end type
type cb_help from commandbutton within w_print_examples
end type
type st_y_text from statictext within w_print_examples
end type
type st_x_text from statictext within w_print_examples
end type
type em_y from editmask within w_print_examples
end type
type em_x from editmask within w_print_examples
end type
type cb_window from commandbutton within w_print_examples
end type
type cb_close from commandbutton within w_print_examples
end type
type cb_printobject from commandbutton within w_print_examples
end type
type lb_controls from listbox within w_print_examples
end type
type st_height from statictext within w_print_examples
end type
type em_height from editmask within w_print_examples
end type
type st_width from statictext within w_print_examples
end type
type em_width from editmask within w_print_examples
end type
type cb_setup from commandbutton within w_print_examples
end type
type st_bitmap_text from statictext within w_print_examples
end type
type p_bitmap from picture within w_print_examples
end type
type cb_printscreen from commandbutton within w_print_examples
end type
type gb_object_group from groupbox within w_print_examples
end type
type gb_size from groupbox within w_print_examples
end type
end forward

global type w_print_examples from w_center
int X=395
int Y=93
int Width=2123
int Height=1748
boolean TitleBar=true
string Title="Print Examples"
long BackColor=74481808
boolean ControlMenu=true
boolean Resizable=true
boolean ToolBarVisible=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_window2 cb_window2
cb_help cb_help
st_y_text st_y_text
st_x_text st_x_text
em_y em_y
em_x em_x
cb_window cb_window
cb_close cb_close
cb_printobject cb_printobject
lb_controls lb_controls
st_height st_height
em_height em_height
st_width st_width
em_width em_width
cb_setup cb_setup
st_bitmap_text st_bitmap_text
p_bitmap p_bitmap
cb_printscreen cb_printscreen
gb_object_group gb_object_group
gb_size gb_size
end type
global w_print_examples w_print_examples

type prototypes

end prototypes

on close;//show the main menu again
show(w_main)
end on

on open;int	li_index

//Load the list box with names of all the objects on the window
for li_index = 1 to UpperBound(control[])
	lb_controls.insertitem(control[li_index].ClassName(),li_index)
Next
end on

on w_print_examples.create
this.cb_window2=create cb_window2
this.cb_help=create cb_help
this.st_y_text=create st_y_text
this.st_x_text=create st_x_text
this.em_y=create em_y
this.em_x=create em_x
this.cb_window=create cb_window
this.cb_close=create cb_close
this.cb_printobject=create cb_printobject
this.lb_controls=create lb_controls
this.st_height=create st_height
this.em_height=create em_height
this.st_width=create st_width
this.em_width=create em_width
this.cb_setup=create cb_setup
this.st_bitmap_text=create st_bitmap_text
this.p_bitmap=create p_bitmap
this.cb_printscreen=create cb_printscreen
this.gb_object_group=create gb_object_group
this.gb_size=create gb_size
this.Control[]={ this.cb_window2,&
this.cb_help,&
this.st_y_text,&
this.st_x_text,&
this.em_y,&
this.em_x,&
this.cb_window,&
this.cb_close,&
this.cb_printobject,&
this.lb_controls,&
this.st_height,&
this.em_height,&
this.st_width,&
this.em_width,&
this.cb_setup,&
this.st_bitmap_text,&
this.p_bitmap,&
this.cb_printscreen,&
this.gb_object_group,&
this.gb_size}
end on

on w_print_examples.destroy
destroy(this.cb_window2)
destroy(this.cb_help)
destroy(this.st_y_text)
destroy(this.st_x_text)
destroy(this.em_y)
destroy(this.em_x)
destroy(this.cb_window)
destroy(this.cb_close)
destroy(this.cb_printobject)
destroy(this.lb_controls)
destroy(this.st_height)
destroy(this.em_height)
destroy(this.st_width)
destroy(this.em_width)
destroy(this.cb_setup)
destroy(this.st_bitmap_text)
destroy(this.p_bitmap)
destroy(this.cb_printscreen)
destroy(this.gb_object_group)
destroy(this.gb_size)
end on

type cb_window2 from commandbutton within w_print_examples
event clicked pbm_bnclicked
int X=1618
int Y=967
int Width=402
int Height=97
int TabOrder=100
string Text="Print &Window"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Script for printing a window

Long ll_Job

SetPointer(Hourglass!)

// Open a print job and give it a title
ll_Job = PrintOpen()
If ll_Job = -1 Then
	Messagebox("Print Job Open Error","Could not open a print job. Check printer " + &
	"setting and Print Manager")
	Return
End If

SetPointer(Hourglass!)

// Prints the window image at the location specified by x and y and in the size specified by 
// width and height. If you do not specify the width and height PowerBuilder uses the original 
// size of the object
parent.Print(ll_Job, 10, 10)

// Close the print job which will send the data to the printer
PrintClose(ll_Job)

end event

type cb_help from commandbutton within w_print_examples
int X=1625
int Y=1511
int Width=402
int Height=97
int TabOrder=120
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help(Parent.ClassName( ))
end event

type st_y_text from statictext within w_print_examples
int X=978
int Y=1009
int Width=267
int Height=71
boolean Enabled=false
string Text="Y Position"
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

type st_x_text from statictext within w_print_examples
int X=978
int Y=893
int Width=267
int Height=71
boolean Enabled=false
string Text="X position"
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

type em_y from editmask within w_print_examples
int X=1256
int Y=996
int Width=310
int Height=100
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###."
boolean Spin=true
double Increment=100
string MinMax="1~~8500"
string Text="10"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_x from editmask within w_print_examples
int X=1256
int Y=881
int Width=310
int Height=100
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###."
boolean Spin=true
double Increment=100
string MinMax="1~~11000"
string Text="10"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_window from commandbutton within w_print_examples
int X=1625
int Y=721
int Width=402
int Height=97
int TabOrder=40
string Text="Print &Window"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Script for printing a window

Long ll_Job

SetPointer(Hourglass!)

// Open a print job and give it a title
ll_Job = PrintOpen("Print Window Example")
If ll_Job = -1 Then
	Messagebox("Print Job Open Error","Could not open a print job. Check printer " + &
	"setting and Print Manager")
	Return
End If

SetPointer(Hourglass!)

// Prints the window image at the location specified by x and y and in the size specified by 
// width and height. If you do not specify the width and height PowerBuilder uses the original 
// size of the object
Parent.Print (ll_Job, Integer(em_x.Text), Integer(em_y.Text), &
		Integer(em_width.Text), Integer(em_height.Text))

// Close the print job which will send the data to the printer
PrintClose(ll_Job)

end event

type cb_close from commandbutton within w_print_examples
int X=1625
int Y=1373
int Width=402
int Height=97
int TabOrder=110
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//Close Script

Close(Parent)
end event

type cb_printobject from commandbutton within w_print_examples
int X=1625
int Y=113
int Width=402
int Height=97
int TabOrder=20
string Text="Print &Objects"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer	li_Index, li_Index2, li_State, li_NumObjects, li_PrintCount, li_Pos
Long		ll_Job
String	ls_ControlName[ ], ls_Header
DragObject ldo_Object

SetPointer(Hourglass!)

// Open a print job and give it a title
ll_Job = PrintOpen("Print Object Example")
If ll_Job = -1 Then
	Messagebox("Print Job Open Error","Could not open a print job. Check printer " + &
	"setting and Print Manager")
	Return
End If

li_NumObjects = Upperbound(Control[])

// Find selected object in lisbox
For li_Index = 1 To li_NumObjects
	li_State = lb_controls.State(li_Index)
	If li_State = 1 Then 
		For li_Index2 = 1 To li_NumObjects
			If Control[li_Index2].ClassName() = lb_Controls.Text(li_Index) Then
				ldo_Object = Control[li_index2]
				ls_Header = "Object:  " + ldo_Object.ClassName() + "    Width = " + &
								String(ldo_Object.Width) + "    Height = " + String(ldo_Object.Height)
				
				PrintText(ll_Job, ls_Header, 10, li_Pos)
				ldo_Object.Print (ll_Job, 10, li_Pos + 130)
				
				li_Pos = li_Pos + 2000
				li_PrintCount ++
				If li_PrintCount = 5 Then
					PrintPage(ll_Job)
					li_PrintCount = 1
					li_Pos = 0
				End If
			End If
		Next
	End If
Next


// Close print job
PrintClose (ll_Job)

end event

type lb_controls from listbox within w_print_examples
int X=1014
int Y=109
int Width=594
int Height=311
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean MultiSelect=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_height from statictext within w_print_examples
int X=1067
int Y=717
int Width=178
int Height=71
boolean Enabled=false
string Text="Height"
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

type em_height from editmask within w_print_examples
int X=1256
int Y=705
int Width=310
int Height=100
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###."
boolean Spin=true
double Increment=100
string MinMax="01~~11000"
string Text="5000"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_width from statictext within w_print_examples
int X=1081
int Y=609
int Width=164
int Height=71
boolean Enabled=false
string Text="Width"
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

type em_width from editmask within w_print_examples
int X=1256
int Y=589
int Width=310
int Height=100
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###."
boolean Spin=true
double Increment=100
string MinMax="1~~11000"
string Text="8000"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_setup from commandbutton within w_print_examples
int X=1625
int Y=1233
int Width=402
int Height=97
int TabOrder=90
string Text="&Printer Setup"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;PrintSetup()

end event

type st_bitmap_text from statictext within w_print_examples
int X=68
int Y=87
int Width=601
int Height=71
boolean Enabled=false
string Text="This is a bitmap below:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type p_bitmap from picture within w_print_examples
int X=65
int Y=173
int Width=836
int Height=737
string PictureName="greycol2.bmp"
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type cb_printscreen from commandbutton within w_print_examples
int X=1625
int Y=589
int Width=402
int Height=97
int TabOrder=80
string Text="Print &Screen"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Script for printing a screen

Long	ll_Job

SetPointer(Hourglass!)

// Open a print job and give it a title
ll_Job = PrintOpen("Print Screen Example")
If ll_Job = -1 Then
	Messagebox("Print Job Open Error","Could not open a print job. Check printer " + &
	"setting and Print Manager")
	Return
End If

SetPointer(Hourglass!)

// Prints the screen image at the location specified by x and y and in the size specified by 
// width and height. If you do not specify the width and height, PowerBuilder uses the original 
// size of the screen.
PrintScreen(ll_Job, Integer(em_x.Text), Integer(em_y.Text), &
		Integer(em_width.Text), Integer(em_height.Text))

// Close the print job which will send the data to the printer
PrintClose(ll_Job)

end event

type gb_object_group from groupbox within w_print_examples
int X=953
int Y=49
int Width=1096
int Height=391
string Text="Select Objects to Print"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_size from groupbox within w_print_examples
int X=953
int Y=487
int Width=1096
int Height=717
string Text="Select Sizes in 1/1000~""
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

