$PBExportHeader$w_graph_dynamic_series.srw
$PBExportComments$Example showing dynamically adding a series to a graph
forward
global type w_graph_dynamic_series from w_center
end type
type cb_help from commandbutton within w_graph_dynamic_series
end type
type cb_close from commandbutton within w_graph_dynamic_series
end type
type cb_mod from commandbutton within w_graph_dynamic_series
end type
type dw_1 from datawindow within w_graph_dynamic_series
end type
end forward

global type w_graph_dynamic_series from w_center
int X=78
int Y=189
int Width=2762
int Height=1545
boolean TitleBar=true
string Title="Graph Dynamic Series"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_help cb_help
cb_close cb_close
cb_mod cb_mod
dw_1 dw_1
end type
global w_graph_dynamic_series w_graph_dynamic_series

event open;call super::open;dw_1.SetTransObject(sqlca)
dw_1.Retrieve()

end event

on w_graph_dynamic_series.create
this.cb_help=create cb_help
this.cb_close=create cb_close
this.cb_mod=create cb_mod
this.dw_1=create dw_1
this.Control[]={ this.cb_help,&
this.cb_close,&
this.cb_mod,&
this.dw_1}
end on

on w_graph_dynamic_series.destroy
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.cb_mod)
destroy(this.dw_1)
end on

event close;Show(w_main)

end event

type cb_help from commandbutton within w_graph_dynamic_series
int X=2332
int Y=181
int Width=385
int Height=85
int TabOrder=4
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_graph_dynamic_series")

end event

type cb_close from commandbutton within w_graph_dynamic_series
int X=2332
int Y=309
int Width=385
int Height=85
int TabOrder=10
string Text="Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_mod from commandbutton within w_graph_dynamic_series
int X=2332
int Y=57
int Width=385
int Height=85
int TabOrder=30
string Text="Add Series"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;If This.Text = "Add Series" Then
	// add the series to the graph
	dw_1.Modify("gr_1.series = 'quarter' ")
	This.Text = "Remove Series"

Else
	// remove series from graph
	dw_1.Modify("gr_1.series = '~"noseries ~" ' ")
	This.Text = "Add Series"
End If

end event

type dw_1 from datawindow within w_graph_dynamic_series
int X=10
int Y=21
int Width=2286
int Height=1401
int TabOrder=20
string DataObject="d_graph_dynamic_series"
BorderStyle BorderStyle=StyleShadowBox!
boolean LiveScroll=true
end type

