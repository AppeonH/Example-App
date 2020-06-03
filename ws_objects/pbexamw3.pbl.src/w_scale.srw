$PBExportHeader$w_scale.srw
$PBExportComments$Shows how to scan the control array of a window and then resize all of the controls on the window when the window is resized
forward
global type w_scale from w_center
end type
type cb_2 from commandbutton within w_scale
end type
type cb_exit from commandbutton within w_scale
end type
type cbx_1 from checkbox within w_scale
end type
type st_9 from statictext within w_scale
end type
type st_11 from statictext within w_scale
end type
type rb_2 from radiobutton within w_scale
end type
type rb_1 from radiobutton within w_scale
end type
type st_8 from statictext within w_scale
end type
type st_7 from statictext within w_scale
end type
type st_6 from statictext within w_scale
end type
type st_5 from statictext within w_scale
end type
type st_4 from statictext within w_scale
end type
type st_3 from statictext within w_scale
end type
type st_2 from statictext within w_scale
end type
type dw_freeform from datawindow within w_scale
end type
type vsb_1 from vscrollbar within w_scale
end type
type hsb_1 from hscrollbar within w_scale
end type
type gr_1 from graph within w_scale
end type
type p_1 from picture within w_scale
end type
type dw_1 from datawindow within w_scale
end type
type lb_1 from listbox within w_scale
end type
type mle_1 from multilineedit within w_scale
end type
type em_2 from editmask within w_scale
end type
type sle_1 from singlelineedit within w_scale
end type
type st_1 from statictext within w_scale
end type
type cb_1 from commandbutton within w_scale
end type
type em_1 from editmask within w_scale
end type
type gb_1 from groupbox within w_scale
end type
end forward

global type w_scale from w_center
int X=8
int Y=132
int Width=2927
int Height=1681
boolean TitleBar=true
string Title="Resizing Controls on a Window"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
boolean ToolBarVisible=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_2 cb_2
cb_exit cb_exit
cbx_1 cbx_1
st_9 st_9
st_11 st_11
rb_2 rb_2
rb_1 rb_1
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
dw_freeform dw_freeform
vsb_1 vsb_1
hsb_1 hsb_1
gr_1 gr_1
p_1 p_1
dw_1 dw_1
lb_1 lb_1
mle_1 mle_1
em_2 em_2
sle_1 sle_1
st_1 st_1
cb_1 cb_1
em_1 em_1
gb_1 gb_1
end type
global w_scale w_scale

type variables
int ii_win_width, ii_win_height, ii_win_frame_w, ii_win_frame_h
str_size size_ctrl [] 

//Boolean variable to stop recursion
boolean ib_exec = false

end variables

forward prototypes
public function integer wf_size_it ()
public function integer wf_resize_it (double size_factor)
end prototypes

public function integer wf_size_it ();////////////////////////////////////////////////////////////////////////////////////////////////////
// function: wf_size_it
////////////////////////////////////////////////////////////////////////////////////////////////////

// save the original sizes of the window and all of the objects on the window
// NOTE !!!! this process does not work on objects that are not descended
// from the dragobject class.

dragobject temp
int cnt,i
ii_win_width  = this.width
ii_win_height = this.height
ii_win_frame_w = this.width - this.WorkSpaceWidth()
ii_win_frame_h = this.height - this.WorkSpaceHeight()

cnt = upperbound(this.control)
for i = cnt to 1 step -1
	temp = this.control[i]
	
	// everything has a x,y,width and height
	size_ctrl[i].x = temp.x 
	size_ctrl[i].width = temp.width 
	size_ctrl[i].y = temp.y
	size_ctrl[i].height = temp.height 

	// now go get text size information
	choose case typeof(temp)
		case commandbutton!
			commandbutton cb
			cb = temp
			size_ctrl[i].fontsize = cb.textsize 

		case singlelineedit!
			singlelineedit sle
			sle = temp
			size_ctrl[i].fontsize = sle.textsize 

		case editmask!
			editmask em
			em = temp
			size_ctrl[i].fontsize  	=	em.textsize 

		case statictext!
			statictext st
			st = temp
			size_ctrl[i].fontsize  	=	st.textsize 
	
		case picturebutton!
			picturebutton pb
			pb = temp
			size_ctrl[i].fontsize = pb.textsize 

		case checkbox!
			checkbox cbx
			cbx = temp
			size_ctrl[i].fontsize  	=	cbx.textsize 

		case dropdownlistbox!
			dropdownlistbox ddlb
			ddlb = temp
			size_ctrl[i].fontsize  	=	ddlb.textsize 

		case groupbox!
			groupbox gb
			gb = temp
			size_ctrl[i].fontsize  	=	gb.textsize 

		case listbox!
			listbox lb
			lb = temp
			size_ctrl[i].fontsize  	=	lb.textsize 

		case multilineedit!
			multilineedit mle
			mle = temp
			size_ctrl[i].fontsize  	=	mle.textsize 
		case radiobutton!
			radiobutton rb
			rb = temp
			size_ctrl[i].fontsize  	=	rb.textsize 
	end choose
next

return 1
end function

public function integer wf_resize_it (double size_factor);////////////////////////////////////////////////////////////////////////////////////////////////////
// function: wf_resize_it
////////////////////////////////////////////////////////////////////////////////////////////////////


// loop through off of the objects captured in the wf_size_it function and resize them
// Note !! radio buttons and checkboxes do not size properly as they are of fixed size.

dragobject temp
int cnt,i

ib_exec = false // keep the function from being called recursively
this.hide()

// resize the window
this.width = ((  ii_win_width - ii_win_frame_w) * size_factor) + ii_win_frame_w

this.height = ((  ii_win_height - ii_win_frame_h) * size_factor) + ii_win_frame_h

// for each control in the list, resize it and it's textsize (as applicable)
cnt = upperbound(this.control)
for i = cnt to 1 step -1
	temp = this.control[i]
	temp.x		 = size_ctrl[i].x * size_factor
	temp.width   = size_ctrl[i].width  * size_factor
	temp.y		 = size_ctrl[i].y * size_factor
	temp.height  = size_ctrl[i].height * size_factor 
	

	choose case typeof(temp)
		case commandbutton!
			commandbutton cb
			cb = temp
			cb.textsize =  size_ctrl[i].fontsize * size_factor 

		case singlelineedit!
			singlelineedit sle
			sle = temp
			sle.textsize =  size_ctrl[i].fontsize * size_factor 
		
		case editmask!
			editmask em
			em = temp
			em.textsize =  size_ctrl[i].fontsize * size_factor 
		
		case statictext!
			statictext st
			st = temp
			st.textsize =  size_ctrl[i].fontsize * size_factor 

		case datawindow! // datawindows get zoomed
			datawindow dw
			dw = temp
			dw.Object.DataWindow.zoom = string(int(size_factor*100))

		case picturebutton!
			picturebutton pb
			pb = temp
			pb.textsize =  size_ctrl[i].fontsize * size_factor 

		case checkbox!
			checkbox cbx
			cbx = temp
			cbx.textsize =  size_ctrl[i].fontsize * size_factor 

		case dropdownlistbox!
			dropdownlistbox ddlb
			ddlb = temp
			ddlb.textsize =  size_ctrl[i].fontsize * size_factor 

		case groupbox!
			groupbox gb
			gb = temp
			gb.textsize =  size_ctrl[i].fontsize * size_factor 

		case listbox!
			listbox lb
			lb = temp
			lb.textsize  =  size_ctrl[i].fontsize * size_factor 

		case multilineedit!
			multilineedit mle
			mle = temp
			mle.textsize =  size_ctrl[i].fontsize * size_factor 

		case radiobutton!
			radiobutton rb
			rb = temp
			rb.textsize =  size_ctrl[i].fontsize * size_factor 

	end choose
next

	
this.Show()
ib_exec = true
return 1
end function

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_scale
////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////////
// This example is included as more of an oddity than something that you would 
// want to put into a production application
////////////////////////////////////////////////////////////////////////////////////////////////////

int	rc
int	series_nbr

// add some random data to the graph
series_nbr = gr_1.Addseries("Costs")
randomize(0)
gr_1.AddData(Series_Nbr, rand(1000), "Jan")
gr_1.AddData(Series_Nbr, rand(1000), "Feb")
gr_1.AddData(Series_Nbr, rand(1000), "Mar")
gr_1.AddData(Series_Nbr, rand(1000), "Apr")
gr_1.AddData(Series_Nbr, rand(1000), "May")
dw_freeform.insertrow(0)

// save off the size data
rc = wf_size_it()
ib_exec = true




end event

event close;////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_scale
////////////////////////////////////////////////////////////////////////////////////////////////////

w_main.show()
end event

event resize;////////////////////////////////////////////////////////////////////////////////////////////////////
// resize script for w_scale
////////////////////////////////////////////////////////////////////////////////////////////////////

double ratiow, ratio, ratioh
int rc

// recalculate the new ratios and then use the minimum
if ib_exec then  // Check to see if wf_resize_it is already running.
	ratioh = this.height /ii_win_height
	ratiow = this.width / ii_win_width
	ratio = min (ratioh, ratiow)
	rc = wf_resize_it(ratio)
end if

end event

on w_scale.create
this.cb_2=create cb_2
this.cb_exit=create cb_exit
this.cbx_1=create cbx_1
this.st_9=create st_9
this.st_11=create st_11
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_freeform=create dw_freeform
this.vsb_1=create vsb_1
this.hsb_1=create hsb_1
this.gr_1=create gr_1
this.p_1=create p_1
this.dw_1=create dw_1
this.lb_1=create lb_1
this.mle_1=create mle_1
this.em_2=create em_2
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_1=create cb_1
this.em_1=create em_1
this.gb_1=create gb_1
this.Control[]={ this.cb_2,&
this.cb_exit,&
this.cbx_1,&
this.st_9,&
this.st_11,&
this.rb_2,&
this.rb_1,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.dw_freeform,&
this.vsb_1,&
this.hsb_1,&
this.gr_1,&
this.p_1,&
this.dw_1,&
this.lb_1,&
this.mle_1,&
this.em_2,&
this.sle_1,&
this.st_1,&
this.cb_1,&
this.em_1,&
this.gb_1}
end on

on w_scale.destroy
destroy(this.cb_2)
destroy(this.cb_exit)
destroy(this.cbx_1)
destroy(this.st_9)
destroy(this.st_11)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_freeform)
destroy(this.vsb_1)
destroy(this.hsb_1)
destroy(this.gr_1)
destroy(this.p_1)
destroy(this.dw_1)
destroy(this.lb_1)
destroy(this.mle_1)
destroy(this.em_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_scale
int X=2568
int Y=196
int Width=246
int Height=109
int TabOrder=40
string Text="Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help(parent.classname())
end on

type cb_exit from commandbutton within w_scale
int X=2568
int Y=55
int Width=246
int Height=109
int TabOrder=10
string Text="Close"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type cbx_1 from checkbox within w_scale
int X=726
int Y=346
int Width=424
int Height=71
string Text="Checkbox"
BorderStyle BorderStyle=StyleLowered!
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_9 from statictext within w_scale
int X=2120
int Y=1460
int Width=729
int Height=97
boolean Enabled=false
boolean Border=true
string Text="Resize the Window"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=74481808
long BorderColor=16711680
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_11 from statictext within w_scale
int X=25
int Y=884
int Width=630
int Height=61
boolean Enabled=false
string Text="Data Window (Freeform)"
boolean FocusRectangle=false
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_2 from radiobutton within w_scale
int X=808
int Y=221
int Width=246
int Height=71
string Text="No"
BorderStyle BorderStyle=StyleLowered!
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_1 from radiobutton within w_scale
int X=808
int Y=154
int Width=246
int Height=71
string Text="Yes"
BorderStyle BorderStyle=StyleLowered!
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_8 from statictext within w_scale
int X=1892
int Y=740
int Width=246
int Height=55
boolean Enabled=false
string Text="Graph"
boolean FocusRectangle=false
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_scale
int X=153
int Y=439
int Width=338
int Height=55
boolean Enabled=false
string Text="Multiline Edit"
boolean FocusRectangle=false
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_scale
int X=1167
int Y=881
int Width=630
int Height=61
boolean Enabled=false
string Text="Data Window (Tabular)"
boolean FocusRectangle=false
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_scale
int X=722
int Y=436
int Width=246
int Height=55
boolean Enabled=false
string Text="List Box"
boolean FocusRectangle=false
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_scale
int X=1305
int Y=250
int Width=246
int Height=55
boolean Enabled=false
string Text="Edit Mask"
boolean FocusRectangle=false
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_scale
int X=1305
int Y=458
int Width=317
int Height=71
boolean Enabled=false
string Text="Spin Control"
boolean FocusRectangle=false
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_scale
int X=1305
int Y=20
int Width=246
int Height=52
boolean Enabled=false
string Text="Picture"
boolean FocusRectangle=false
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_freeform from datawindow within w_scale
int X=33
int Y=954
int Width=1092
int Height=497
int TabOrder=100
string DataObject="d_empl_address_data"
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type vsb_1 from vscrollbar within w_scale
int X=36
int Y=17
int Width=57
int Height=833
boolean Enabled=false
int MinPosition=1
int MaxPosition=100
int Position=50
end type

type hsb_1 from hscrollbar within w_scale
int X=225
int Y=17
int Width=985
int Height=52
boolean Enabled=false
int MinPosition=1
int MaxPosition=100
int Position=50
end type

type gr_1 from graph within w_scale
int X=1892
int Y=781
int Width=961
int Height=647
boolean Enabled=false
grGraphType GraphType=Pie3D!
grLegendType Legend=AtLeft!
string Title="Sales"
BorderStyle BorderStyle=StyleLowered!
int Depth=50
int Elevation=-60
boolean FocusRectangle=false
int Perspective=1
int Rotation=-20
int Spacing=100
long BackColor=74481808
long ShadeColor=6316128
end type

on gr_1.create
TitleDispAttr = create grDispAttr
LegendDispAttr = create grDispAttr
PieDispAttr = create grDispAttr
Series = create grAxis
Series.DispAttr = create grDispAttr
Series.LabelDispAttr = create grDispAttr
Category = create grAxis
Category.DispAttr = create grDispAttr
Category.LabelDispAttr = create grDispAttr
Values = create grAxis
Values.DispAttr = create grDispAttr
Values.LabelDispAttr = create grDispAttr
TitleDispAttr.Weight=700
TitleDispAttr.FaceName="MS Sans Serif"
TitleDispAttr.FontFamily=Swiss!
TitleDispAttr.FontPitch=Variable!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=553648127
TitleDispAttr.Format="[General]"
TitleDispAttr.DisplayExpression="title"
TitleDispAttr.AutoSize=true
Category.Label="(None)"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Outside!
Category.DataType=adtText!
Category.DispAttr.Weight=400
Category.DispAttr.FaceName="Arial"
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Center!
Category.DispAttr.BackColor=536870912
Category.DispAttr.Format="[General]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=400
Category.LabelDispAttr.FaceName="Arial"
Category.LabelDispAttr.FontFamily=Swiss!
Category.LabelDispAttr.FontPitch=Variable!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=553648127
Category.LabelDispAttr.Format="[General]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Values.Label="(None)"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MajorGridLine=transparent!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Outside!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="Arial"
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Right!
Values.DispAttr.BackColor=536870912
Values.DispAttr.Format="[General]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=400
Values.LabelDispAttr.FaceName="Arial"
Values.LabelDispAttr.FontFamily=Swiss!
Values.LabelDispAttr.FontPitch=Variable!
Values.LabelDispAttr.Alignment=Center!
Values.LabelDispAttr.BackColor=553648127
Values.LabelDispAttr.Format="[General]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Values.LabelDispAttr.Escapement=900
Series.Label="(None)"
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="Arial"
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=536870912
Series.DispAttr.Format="[General]"
Series.DispAttr.DisplayExpression="series"
Series.DispAttr.AutoSize=true
Series.LabelDispAttr.Weight=400
Series.LabelDispAttr.FaceName="Arial"
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=549503168
Series.LabelDispAttr.Format="[General]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="MS Sans Serif"
LegendDispAttr.FontFamily=Swiss!
LegendDispAttr.FontPitch=Variable!
LegendDispAttr.BackColor=553648127
LegendDispAttr.Format="[General]"
LegendDispAttr.DisplayExpression="category"
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="MS Sans Serif"
PieDispAttr.FontFamily=Swiss!
PieDispAttr.FontPitch=Variable!
PieDispAttr.BackColor=553648127
PieDispAttr.Format="[General]"
PieDispAttr.DisplayExpression="if(seriescount > 1, series,string(percentofseries,~"0.00%~"))"
PieDispAttr.AutoSize=true
end on

on gr_1.destroy
destroy TitleDispAttr
destroy LegendDispAttr
destroy PieDispAttr
destroy Series.DispAttr
destroy Series.LabelDispAttr
destroy Series
destroy Category.DispAttr
destroy Category.LabelDispAttr
destroy Category
destroy Values.DispAttr
destroy Values.LabelDispAttr
destroy Values
end on

type p_1 from picture within w_scale
int X=1305
int Y=74
int Width=150
int Height=132
string PictureName="beach.bmp"
boolean FocusRectangle=false
end type

type dw_1 from datawindow within w_scale
int X=1167
int Y=951
int Width=491
int Height=359
int TabOrder=70
string DataObject="d_cust_id"
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type lb_1 from listbox within w_scale
int X=722
int Y=506
int Width=502
int Height=295
int TabOrder=80
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Line 1",&
"line 2",&
"line 3",&
"line 4",&
"line 5"}
end type

type mle_1 from multilineedit within w_scale
int X=153
int Y=506
int Width=491
int Height=295
int TabOrder=90
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
string Text="slfj sdlfhjsdf lsfkhjs flskhfj slfhksf lskfh slfhsd flhsd flsdh"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_2 from editmask within w_scale
int X=1305
int Y=324
int Width=246
int Height=93
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_1 from singlelineedit within w_scale
int X=150
int Y=330
int Width=434
int Height=87
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="Single Line Edit"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_scale
int X=150
int Y=234
int Width=377
int Height=71
boolean Enabled=false
boolean Border=true
string Text="Static text"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_scale
int X=146
int Y=100
int Width=473
int Height=109
int TabOrder=30
string Text="Command Button"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_1 from editmask within w_scale
int X=1305
int Y=535
int Width=232
int Height=87
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
boolean Spin=true
string MinMax="10~~100"
string Text="50"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_scale
int X=722
int Y=93
int Width=434
int Height=228
int TabOrder=110
string Text="Group Box"
BorderStyle BorderStyle=StyleLowered!
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

