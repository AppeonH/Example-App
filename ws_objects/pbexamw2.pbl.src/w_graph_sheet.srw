$PBExportHeader$w_graph_sheet.srw
$PBExportComments$Generalized maintenance ancestor for a graph in a window.
forward
global type w_graph_sheet from w_center
end type
type gr_1 from graph within w_graph_sheet
end type
type dw_1 from datawindow within w_graph_sheet
end type
end forward

global type w_graph_sheet from w_center
int X=23
int Y=56
int Width=2857
int Height=1660
boolean TitleBar=true
string MenuName="m_graph_sheet"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event graph_type pbm_custom01
event graph_title pbm_custom02
event copy_to_clipboard pbm_custom03
event spacing pbm_custom04
event graph_color pbm_custom06
gr_1 gr_1
dw_1 dw_1
end type
global w_graph_sheet w_graph_sheet

event graph_type;SetPointer(HourGlass!)

// Open the response window to set the graph type. Pass it the graph
// object and it will do the rest.
OpenWithParm (w_graph_type, gr_1)

end event

event graph_title;SetPointer(HourGlass!)

// Open a response window to prompt for the new graph title. Pass the
// graph object as a parameter. The response window will handle the 
// rest.
OpenWithParm (w_graph_title, gr_1)



end event

on copy_to_clipboard;// Copy the graph to the Windows Clipboard.
gr_1.ClipBoard ( )
end on

event spacing;SetPointer(HourGlass!)

// Open the response window to set spacing. Pass it the graph so it
// can make changes.
OpenWithParm (w_graph_spacing, gr_1)


end event

event graph_color;SetPointer(HourGlass!)

//open the change color window and pass the graph to it in the 
//message.powerobjectparm
OpenWithParm (w_graph_color, gr_1)
end event

event close;f_save_toolbar_profile (This)

end event

event open;call super::open;int li_row, li_index

// In the descendant, you must override the ancestor, create a new 
// series and then call this script. This allows the setting of
// specific series names. The following code is an example of what
// should go in the descendant script.
//int series_num
//series_num = gr_1.graddseries ( "Total Salaries" )
//if series_num < 1 then return
//Call super::open

// Retrieve data for DataWindow
dw_1.SetTransObject (sqlca)
dw_1.Retrieve ()

gr_1.SetRedraw(FALSE)

// Loop through the rows of the DataWindow adding data points to graph.
li_row = RowCount (dw_1)
for li_index = 1 to li_row
	gr_1.adddata ( 1, dw_1.getitemnumber (li_index, 2), &
					GetItemString (dw_1, li_index, 1 ))
next

gr_1.SetRedraw(TRUE)

f_get_toolbar_profile(This, 1)



end event

on w_graph_sheet.create
if this.MenuName = "m_graph_sheet" then this.MenuID = create m_graph_sheet
this.gr_1=create gr_1
this.dw_1=create dw_1
this.Control[]={this.gr_1,&
this.dw_1}
end on

on w_graph_sheet.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gr_1)
destroy(this.dw_1)
end on

type gr_1 from graph within w_graph_sheet
int X=32
int Y=576
int Width=2665
int Height=860
boolean Enabled=false
grGraphType GraphType=Col3DObjGraph!
grLegendType Legend=AtBottom!
string Title="Total Salary by Department"
int Depth=100
int Elevation=20
int Perspective=2
int Rotation=-20
int Spacing=100
long BackColor=12632256
long ShadeColor=12632256
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
TitleDispAttr.TextSize=-16
TitleDispAttr.Weight=700
TitleDispAttr.FaceName="MS Sans Serif"
TitleDispAttr.FontFamily=Swiss!
TitleDispAttr.FontPitch=Variable!
TitleDispAttr.Alignment=Center!
TitleDispAttr.BackColor=12632256
TitleDispAttr.Format="[general]"
TitleDispAttr.DisplayExpression="title"
Category.Label="Departments"
Category.AutoScale=true
Category.ShadeBackEdge=true
Category.SecondaryLine=transparent!
Category.MajorGridLine=transparent!
Category.MinorGridLine=transparent!
Category.DropLines=transparent!
Category.OriginLine=transparent!
Category.MajorTic=Straddle!
Category.DataType=adtText!
Category.DispAttr.Weight=400
Category.DispAttr.FaceName="MS Sans Serif"
Category.DispAttr.FontFamily=Swiss!
Category.DispAttr.FontPitch=Variable!
Category.DispAttr.Alignment=Center!
Category.DispAttr.BackColor=12632256
Category.DispAttr.Format="[general]"
Category.DispAttr.DisplayExpression="category"
Category.DispAttr.AutoSize=true
Category.LabelDispAttr.Weight=700
Category.LabelDispAttr.FaceName="MS Sans Serif"
Category.LabelDispAttr.FontFamily=Swiss!
Category.LabelDispAttr.FontPitch=Variable!
Category.LabelDispAttr.Alignment=Center!
Category.LabelDispAttr.BackColor=12632256
Category.LabelDispAttr.Format="[general]"
Category.LabelDispAttr.DisplayExpression="categoryaxislabel"
Category.LabelDispAttr.AutoSize=true
Values.Label="Dollars"
Values.AutoScale=true
Values.SecondaryLine=transparent!
Values.MinorGridLine=transparent!
Values.DropLines=transparent!
Values.MajorTic=Straddle!
Values.DataType=adtDouble!
Values.DispAttr.Weight=400
Values.DispAttr.FaceName="MS Sans Serif"
Values.DispAttr.FontFamily=Swiss!
Values.DispAttr.FontPitch=Variable!
Values.DispAttr.Alignment=Right!
Values.DispAttr.BackColor=12632256
Values.DispAttr.Format="[general]"
Values.DispAttr.DisplayExpression="value"
Values.DispAttr.AutoSize=true
Values.LabelDispAttr.Weight=700
Values.LabelDispAttr.FaceName="MS Sans Serif"
Values.LabelDispAttr.FontFamily=Swiss!
Values.LabelDispAttr.FontPitch=Variable!
Values.LabelDispAttr.Alignment=Center!
Values.LabelDispAttr.BackColor=12632256
Values.LabelDispAttr.Format="[general]"
Values.LabelDispAttr.DisplayExpression="valuesaxislabel"
Values.LabelDispAttr.AutoSize=true
Values.LabelDispAttr.Escapement=900
Series.AutoScale=true
Series.SecondaryLine=transparent!
Series.MajorGridLine=transparent!
Series.MinorGridLine=transparent!
Series.DropLines=transparent!
Series.OriginLine=transparent!
Series.MajorTic=Outside!
Series.DataType=adtText!
Series.DispAttr.TextSize=-11
Series.DispAttr.Weight=400
Series.DispAttr.FaceName="MS Sans Serif"
Series.DispAttr.FontFamily=Swiss!
Series.DispAttr.FontPitch=Variable!
Series.DispAttr.BackColor=553648127
Series.DispAttr.Format="[general]"
Series.DispAttr.DisplayExpression="series"
Series.LabelDispAttr.Weight=700
Series.LabelDispAttr.FaceName="System"
Series.LabelDispAttr.FontFamily=Swiss!
Series.LabelDispAttr.FontPitch=Variable!
Series.LabelDispAttr.Alignment=Center!
Series.LabelDispAttr.BackColor=553648127
Series.LabelDispAttr.Format="[general]"
Series.LabelDispAttr.DisplayExpression="seriesaxislabel"
Series.LabelDispAttr.AutoSize=true
LegendDispAttr.Weight=400
LegendDispAttr.FaceName="MS Sans Serif"
LegendDispAttr.FontFamily=Swiss!
LegendDispAttr.FontPitch=Variable!
LegendDispAttr.BackColor=12632256
LegendDispAttr.Format="[general]"
LegendDispAttr.DisplayExpression="series"
LegendDispAttr.AutoSize=true
PieDispAttr.Weight=400
PieDispAttr.FaceName="Arial"
PieDispAttr.FontFamily=Swiss!
PieDispAttr.FontPitch=Variable!
PieDispAttr.BackColor=12632256
PieDispAttr.Format="[general]"
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

type dw_1 from datawindow within w_graph_sheet
int X=23
int Y=20
int Width=1801
int Height=532
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

