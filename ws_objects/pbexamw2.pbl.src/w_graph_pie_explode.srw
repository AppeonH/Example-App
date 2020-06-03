$PBExportHeader$w_graph_pie_explode.srw
$PBExportComments$Retrieves a datawindow containing a pie graph with enhanced features. The pie graph can also be rotated in presentation style.
forward
global type w_graph_pie_explode from w_center
end type
type em_explode from editmask within w_graph_pie_explode
end type
type cb_cancel from commandbutton within w_graph_pie_explode
end type
type cb_ok from commandbutton within w_graph_pie_explode
end type
end forward

global type w_graph_pie_explode from w_center
int X=104
int Y=215
int Width=1401
int Height=532
boolean TitleBar=true
string Title="Select Spacing Percent"
long BackColor=74481808
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
em_explode em_explode
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_graph_pie_explode w_graph_pie_explode

type variables
object io_passed
graph igr_parm
datawindow idw_parm
int ii_original_explode
int ii_series
int ii_datapoint
end variables

on open;graphicobject lgro_hold
grobjecttype lgrot_clickedtype
str_graphobjectatpoint lstr_graph
string ls_category

  
lstr_graph = Message.PowerObjectParm
lgro_hold = lstr_graph.graphicobject
ii_series = lstr_graph.series
ii_datapoint = lstr_graph.datapoint

If lgro_hold.TypeOf() = Graph! Then
	io_passed = Graph!
	igr_parm = lgro_hold
	igr_parm.GetDataPieExplode(ii_series,ii_datapoint,ii_original_explode)
	ls_category = igr_parm.categoryname(ii_datapoint)
Elseif lgro_hold.TypeOf() = Datawindow! Then
	io_passed = Datawindow!
	idw_parm = lstr_graph.graphicobject
	idw_parm.GetDataPieExplode("gr_1",ii_series,ii_datapoint,ii_original_explode)
	ls_category = idw_parm.categoryname("gr_1",ii_datapoint)
End If

If ii_original_explode = 0 Then
	em_explode.text = "50"
	em_explode.triggerevent("ue_enchange")
Else
	em_explode.text = string(ii_original_explode)
End If

//set window name to category
this.title = "Set Pie Explosion % for ~"" + ls_category + "~""
end on

on w_graph_pie_explode.create
this.em_explode=create em_explode
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={ this.em_explode,&
this.cb_cancel,&
this.cb_ok}
end on

on w_graph_pie_explode.destroy
destroy(this.em_explode)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

type em_explode from editmask within w_graph_pie_explode
event ue_enchange pbm_enchange
int X=424
int Y=103
int Width=459
int Height=100
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="####0"
boolean Spin=true
double Increment=10
string MinMax="0~~100"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on ue_enchange;If io_passed = Graph! Then
      igr_parm.SetDataPieExplode(ii_series,ii_datapoint,integer(em_explode.text))
Elseif io_passed = Datawindow! Then
      idw_parm.SetDataPieExplode("gr_1",ii_series,ii_datapoint,integer(em_explode.text))
End If

end on

type cb_cancel from commandbutton within w_graph_pie_explode
int X=740
int Y=269
int Width=267
int Height=97
int TabOrder=20
string Text="&Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;If io_passed = Graph! Then
      igr_parm.SetDataPieExplode(ii_series,ii_datapoint,ii_original_explode)
Elseif io_passed = Datawindow! Then
      idw_parm.SetDataPieExplode("gr_1",ii_series,ii_datapoint,ii_original_explode)
End If

Close (parent)
end on

type cb_ok from commandbutton within w_graph_pie_explode
int X=274
int Y=269
int Width=267
int Height=97
int TabOrder=30
string Text="&OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
Close (parent) 
end on

