$PBExportHeader$w_pie_graph.srw
$PBExportComments$Will retrieve data into a DataWindow that contains an enhanched PieGraph. The graph can be rotated in a presentation style.
forward
global type w_pie_graph from w_center
end type
type st_2 from statictext within w_pie_graph
end type
type st_1 from statictext within w_pie_graph
end type
type cb_present from commandbutton within w_pie_graph
end type
type cb_print from commandbutton within w_pie_graph
end type
type cb_close from commandbutton within w_pie_graph
end type
type dw_1 from datawindow within w_pie_graph
end type
end forward

global type w_pie_graph from w_center
int X=171
int Y=132
int Width=2582
int Height=1668
boolean TitleBar=true
string Title="Enhanced Pie Graph"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_2 st_2
st_1 st_1
cb_present cb_present
cb_print cb_print
cb_close cb_close
dw_1 dw_1
end type
global w_pie_graph w_pie_graph

type variables
int ii_explode_percent
int ii_rotation
int ii_rotate_incr = 10
int ii_direction
boolean ib_rotate 
end variables

on timer;//Timer event for the "presentation mode"
//Presentation mode just give an example of what you can do
//to spice you graphs with a little movement to make them more
//exciting and maybe keep the interest of the audicence.

 //exploding...
//After explostin hits a certain point, chage direction of explosing
	dw_1.SetDataPieExplode("gr_1",1,1,ii_explode_percent)
	ii_explode_percent = ii_explode_percent + 10 * ii_direction
	If ii_explode_percent = 40 Then ii_direction = ii_direction * -1
	If ii_explode_percent = 0 Then  ii_direction = ii_direction * -1






end on

on open;dw_1.settransobject(sqlca)
dw_1.retrieve()

end on

on close;//Close script 


w_main.Show( )

end on

on w_pie_graph.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_present=create cb_present
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={ this.st_2,&
this.st_1,&
this.cb_present,&
this.cb_print,&
this.cb_close,&
this.dw_1}
end on

on w_pie_graph.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_present)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type st_2 from statictext within w_pie_graph
int X=65
int Y=68
int Width=1284
int Height=71
boolean Enabled=false
string Text="Click Start Presentation to animate the pie graph."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_pie_graph
int X=65
int Y=4
int Width=2276
int Height=71
boolean Enabled=false
string Text="Double Click on a pie graph slice to explode it or change the slice's explode percentage."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_present from commandbutton within w_pie_graph
int X=200
int Y=1393
int Width=779
int Height=100
int TabOrder=20
string Text="&Start Presentation Example"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_rotation

ls_rotation = dw_1.Object.gr_1.rotation

ii_explode_percent = 0
ib_rotate = false
ii_direction = 1
ii_rotation = Integer(ls_rotation)

//ii_rotation = Integer(dw_1.describe("gr_1.rotation"))

If left(this.text,6) = "&Start" Then
	this.text = "&Stop Presentation Example"
	Timer (.035)
Else
	this.text = "&Start Presentation Example"
	Timer (0)
End If
end event

type cb_print from commandbutton within w_pie_graph
int X=1078
int Y=1393
int Width=278
int Height=100
int TabOrder=40
string Text="&Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//print datawindow
dw_1.print() 
end on

type cb_close from commandbutton within w_pie_graph
int X=1433
int Y=1393
int Width=278
int Height=100
int TabOrder=30
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close(parent)
end on

type dw_1 from datawindow within w_pie_graph
int X=4
int Y=141
int Width=2529
int Height=1201
int TabOrder=10
string DataObject="d_pie_graph"
boolean LiveScroll=true
end type

event doubleclicked;//double clicked event for datawindow

int 	li_series, li_datapoint
grobjecttype lgro_clickedtype
string ls_graphtype
int   li_graphtype
str_graphobjectatpoint lstr_graph

//test for pie or pie3d graph types
ls_graphtype = dw_1.Object.gr_1.graphtype
li_graphtype  = Integer(ls_graphtype)
If (li_graphtype <> 13) and (li_graphtype <> 17) Then Return

//If a valid series and department then open explode set window
//get the series and datapoint and object that was doublclicked and
//pass this information in the lstr_graph structure.  
lgro_clickedtype = dw_1.ObjectAtPointer("gr_1",li_series,li_datapoint)
If (li_series > 0 and li_datapoint>0) and &
	lgro_clickedtype = TypeData! Then
	lstr_graph.graphicobject = dw_1
	lstr_graph.series = li_series
	lstr_graph.datapoint = li_datapoint	
	OpenWithParm(w_graph_pie_explode,lstr_graph)
End If

end event

