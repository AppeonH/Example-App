$PBExportHeader$w_shared_dw_graph.srw
$PBExportComments$Shared DW/Diff Graph Views
forward
global type w_shared_dw_graph from w_center
end type
type cb_help from commandbutton within w_shared_dw_graph
end type
type dw_pie from datawindow within w_shared_dw_graph
end type
type cb_close from commandbutton within w_shared_dw_graph
end type
type dw_3dcolumn from datawindow within w_shared_dw_graph
end type
type dw_bar from datawindow within w_shared_dw_graph
end type
type cb_2 from commandbutton within w_shared_dw_graph
end type
type cb_1 from commandbutton within w_shared_dw_graph
end type
type dw_raw_data from datawindow within w_shared_dw_graph
end type
end forward

global type w_shared_dw_graph from w_center
int X=40
int Y=1
int Width=2952
int Height=1946
boolean TitleBar=true
string Title="Graphs using Shared DataWindows"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
event ue_postopen pbm_custom01
cb_help cb_help
dw_pie dw_pie
cb_close cb_close
dw_3dcolumn dw_3dcolumn
dw_bar dw_bar
cb_2 cb_2
cb_1 cb_1
dw_raw_data dw_raw_data
end type
global w_shared_dw_graph w_shared_dw_graph

on ue_postopen;int li_rc

this.setredraw(false)

//sharedata
//Shares data between a primary DataWindow control and a secondary DataWindow control. The 
//controls do not share formatting; only the data is shared, including data in the primary buffer, the 
//delete buffer, the filter buffer, and the sort order. Therefore, when you call a function in either the 
//primary or secondary DataWindow control that changes the data in a primary or secondary 
//DataWindow control, the data in the primary and all secondary DataWindow controls are affected. 

//set up the 2Dpie graph secondary
li_rc = dw_raw_data.ShareData(dw_pie)		
IF li_rc <> 1 THEN MessageBox("Share DW Failed",li_rc)

//set up the 2Dbar graph secondary
li_rc = dw_raw_data.ShareData(dw_bar)		
IF li_rc <> 1 THEN MessageBox("Share DW Failed",li_rc)

//set up the 2Dbar graph secondary
li_rc = dw_raw_data.ShareData(dw_3dcolumn)	
IF li_rc <> 1 THEN MessageBox("Share DW Failed",li_rc)

//retrieve data into the primary datawindow
dw_raw_data.SetTransObject(sqlca)	
dw_raw_data.Retrieve()			

this.setredraw(true)





end on

on open;

//This will open the window faster, then populate it
this.postevent("ue_postopen")


end on

on w_shared_dw_graph.create
this.cb_help=create cb_help
this.dw_pie=create dw_pie
this.cb_close=create cb_close
this.dw_3dcolumn=create dw_3dcolumn
this.dw_bar=create dw_bar
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_raw_data=create dw_raw_data
this.Control[]={ this.cb_help,&
this.dw_pie,&
this.cb_close,&
this.dw_3dcolumn,&
this.dw_bar,&
this.cb_2,&
this.cb_1,&
this.dw_raw_data}
end on

on w_shared_dw_graph.destroy
destroy(this.cb_help)
destroy(this.dw_pie)
destroy(this.cb_close)
destroy(this.dw_3dcolumn)
destroy(this.dw_bar)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_raw_data)
end on

on close;w_main.Show( )

end on

type cb_help from commandbutton within w_shared_dw_graph
int X=1796
int Y=1732
int Width=267
int Height=93
int TabOrder=40
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help ( "w_shared_dw_graph" )
end on

type dw_pie from datawindow within w_shared_dw_graph
int X=11
int Y=801
int Width=953
int Height=919
int TabOrder=60
string DataObject="d_graph_salaries_by_department"
boolean TitleBar=true
string Title="Total Salary By Dept."
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
boolean LiveScroll=true
string Icon="None!"
end type

on getfocus;// make sure that this datawindow comes to the top as soon as it gets focus
this.BringToTop=True
end on

type cb_close from commandbutton within w_shared_dw_graph
int X=1483
int Y=1732
int Width=267
int Height=93
int TabOrder=30
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(Parent)
end on

type dw_3dcolumn from datawindow within w_shared_dw_graph
int X=1924
int Y=801
int Width=978
int Height=919
int TabOrder=80
string DataObject="d_graph_employee_status_by_dept"
boolean TitleBar=true
string Title="Total Employees By Dept. By Status"
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
boolean LiveScroll=true
string Icon="None!"
end type

on getfocus;// make sure that this datawindow comes to the top as soon as it gets focus
this.BringToTop=True
end on

type dw_bar from datawindow within w_shared_dw_graph
int X=968
int Y=801
int Width=953
int Height=919
int TabOrder=70
string DataObject="d_graph_average_employee_age_by_dept"
boolean TitleBar=true
string Title="Average Age By Dept."
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
boolean LiveScroll=true
string Icon="None!"
end type

on getfocus;// make sure that this datawindow comes to the top as soon as it gets focus
this.BringToTop=True
end on

type cb_2 from commandbutton within w_shared_dw_graph
int X=1074
int Y=1732
int Width=370
int Height=93
int TabOrder=20
string Text="&Prior Page"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_raw_data.ScrollPriorPage()
end on

type cb_1 from commandbutton within w_shared_dw_graph
int X=683
int Y=1732
int Width=370
int Height=93
int TabOrder=10
string Text="&Next Page"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;dw_raw_data.ScrollNextPage()
end on

type dw_raw_data from datawindow within w_shared_dw_graph
int X=11
int Y=13
int Width=2884
int Height=772
int TabOrder=50
string DataObject="d_graph_primary"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

