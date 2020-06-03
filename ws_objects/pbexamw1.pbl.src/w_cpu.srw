$PBExportHeader$w_cpu.srw
$PBExportComments$Use CPU function to show execution time of loop
forward
global type w_cpu from w_center
end type
type st_6 from statictext within w_cpu
end type
type st_5 from statictext within w_cpu
end type
type cbx_yield from checkbox within w_cpu
end type
type st_elapsed from statictext within w_cpu
end type
type st_count from statictext within w_cpu
end type
type cb_stop from commandbutton within w_cpu
end type
type st_4 from statictext within w_cpu
end type
type em_counter from editmask within w_cpu
end type
type cb_close from commandbutton within w_cpu
end type
type cb_start from commandbutton within w_cpu
end type
type st_3 from statictext within w_cpu
end type
type st_2 from statictext within w_cpu
end type
type st_1 from statictext within w_cpu
end type
end forward

global type w_cpu from w_center
int X=494
int Y=389
int Width=1793
int Height=765
boolean TitleBar=true
string Title="CPU and Yield Functions"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_6 st_6
st_5 st_5
cbx_yield cbx_yield
st_elapsed st_elapsed
st_count st_count
cb_stop cb_stop
st_4 st_4
em_counter em_counter
cb_close cb_close
cb_start cb_start
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_cpu w_cpu

type variables
boolean ib_break_requested
end variables

on open;// initial value
em_counter.text = '5000'
em_counter.setfocus()
end on

on w_cpu.create
this.st_6=create st_6
this.st_5=create st_5
this.cbx_yield=create cbx_yield
this.st_elapsed=create st_elapsed
this.st_count=create st_count
this.cb_stop=create cb_stop
this.st_4=create st_4
this.em_counter=create em_counter
this.cb_close=create cb_close
this.cb_start=create cb_start
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={ this.st_6,&
this.st_5,&
this.cbx_yield,&
this.st_elapsed,&
this.st_count,&
this.cb_stop,&
this.st_4,&
this.em_counter,&
this.cb_close,&
this.cb_start,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_cpu.destroy
destroy(this.st_6)
destroy(this.st_5)
destroy(this.cbx_yield)
destroy(this.st_elapsed)
destroy(this.st_count)
destroy(this.cb_stop)
destroy(this.st_4)
destroy(this.em_counter)
destroy(this.cb_close)
destroy(this.cb_start)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

on close;Show (w_main)
end on

type st_6 from statictext within w_cpu
int X=37
int Y=125
int Width=1267
int Height=69
boolean Enabled=false
string Text="Stop button will not work with Yielding turned off."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_cpu
int X=33
int Y=65
int Width=1034
int Height=69
boolean Enabled=false
string Text="Try Loop with and without Yielding. "
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_yield from checkbox within w_cpu
int X=1217
int Y=13
int Width=494
int Height=69
string Text="Yield() During Loop"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
boolean LeftText=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_elapsed from statictext within w_cpu
int X=718
int Y=525
int Width=371
int Height=101
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
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

type st_count from statictext within w_cpu
int X=718
int Y=389
int Width=371
int Height=101
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
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

type cb_stop from commandbutton within w_cpu
int X=1354
int Y=349
int Width=330
int Height=109
int TabOrder=20
boolean Enabled=false
string Text="S&top"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;ib_break_requested = True
end on

type st_4 from statictext within w_cpu
int X=234
int Y=533
int Width=471
int Height=69
boolean Enabled=false
string Text="Elapsed Seconds:"
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

type em_counter from editmask within w_cpu
int X=718
int Y=253
int Width=439
int Height=101
int TabOrder=10
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,##0."
boolean Spin=true
string MinMax="01~~999999"
string Text="0"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_cpu
int X=1354
int Y=513
int Width=330
int Height=109
int TabOrder=40
string Text="&Close"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type cb_start from commandbutton within w_cpu
int X=1354
int Y=221
int Width=330
int Height=109
int TabOrder=30
string Text="&Start"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Remember the start cpu time in the long variable 'start'
// Loop from 1 to the number in sle_counter, updating the number of
// iterations in sle_total every 10 iterations.
// At the end of the loop, set used to the ending CPU time minus
// the time in 'start' and display seconds used in a message box.
int 		li_ret
long 	ll_index, ll_limit
long 	ll_start,ll_used

ll_limit = Long(em_counter.Text)
st_elapsed.text = ""
ib_break_requested = false
cb_stop.enabled = true
cb_close.enabled = false
cb_start.enabled = false

if ll_limit > 10000 then
	li_ret = messagebox("Careful!", "Do you really want that long a loop?", &
					Exclamation!,yesno!)
	If li_ret = 2 then return
End If

ll_start = cpu()
for ll_index = 1 to ll_limit
	If mod(ll_index,10) = 0 Then st_count.text = string( ll_index, "###,##0")

	// This yield function will take place any time the check box is turned on.
	// NOTE: if the checkbox is turned off, The STOP button will not be functional 
	// during the loop, because its message will not be processed until the loop
	// completes.

	If cbx_yield.checked Then Yield ( )
	If ib_break_requested Then EXIT
next

ll_used = Cpu() - ll_start
 
cb_stop.enabled = false
cb_close.enabled = true
cb_start.enabled = true
st_elapsed.text = string(ll_used/1000)
end on

type st_3 from statictext within w_cpu
int X=37
int Y=5
int Width=855
int Height=73
boolean Enabled=false
string Text="Enter loop limit and press Start."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_cpu
int X=225
int Y=405
int Width=481
int Height=69
string Text="Running Count: "
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

type st_1 from statictext within w_cpu
int X=106
int Y=269
int Width=599
int Height=69
string Text="Enter Loop Limit: "
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

