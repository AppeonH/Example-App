$PBExportHeader$w_datawindow_style_frame.srw
$PBExportComments$MDI Frame for Datawindow style examples
forward
global type w_datawindow_style_frame from w_center
end type
type mdi_1 from mdiclient within w_datawindow_style_frame
end type
end forward

global type w_datawindow_style_frame from w_center
int X=676
int Y=269
int Width=1750
int Height=1265
boolean TitleBar=true
string Title="DataWindow Presentation Styles"
string MenuName="m_datawindow_style"
long BackColor=268435456
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=maximized!
WindowType WindowType=mdihelp!
event ue_postopen pbm_custom01
mdi_1 mdi_1
end type
global w_datawindow_style_frame w_datawindow_style_frame

type variables
Datastore  ids_Data
end variables

event ue_postopen;w_datawindow_style_sheet		lw_Sheet1, lw_Sheet2, lw_Sheet3, lw_Sheet4, lw_Sheet5, lw_Sheet6, lw_Sheet7

//open all sheets w/datawindow examples
//passing the name of the datawindow object as a string parameter.
OpenSheetWithParm(lw_Sheet1, "d_dwexample_crosstab", "w_datawindow_style_sheet", This, 0, Cascaded!)
OpenSheetWithParm(lw_Sheet2, "d_dwexample_label", "w_datawindow_style_sheet", This, 0, Cascaded!)
OpenSheetWithParm(lw_Sheet3, "d_dwexample_graph", "w_datawindow_style_sheet", This, 0, Cascaded!)
OpenSheetWithParm(lw_Sheet4, "d_dwexample_grid", "w_datawindow_style_sheet", This, 0, Cascaded!)
OpenSheetWithParm(lw_Sheet5, "d_dwexample_freeform", "w_datawindow_style_sheet", This, 0, Cascaded!)
OpenSheetWithParm(lw_Sheet6, "d_dwexample_group", "w_datawindow_style_sheet", This, 0, Cascaded!)
OpenSheetWithParm(lw_Sheet7, "d_dwexample_tabular", "w_datawindow_style_sheet", This, 0, Cascaded!)

//retrieve data into each datawindow on the sheets...
//only the crosstab datwindow and the datastore actually retrieve data, the others share data with the datastore
//the crosstab will not share data with other datawindows.
lw_Sheet1.dw_1.SetTransObject(sqlca)
lw_Sheet1.dw_1.Retrieve()

ids_Data.SetTransObject(sqlca)
ids_Data.Retrieve()

ids_Data.sharedata(lw_Sheet2.dw_1)
ids_Data.sharedata(lw_Sheet3.dw_1)
ids_Data.sharedata(lw_Sheet4.dw_1)
ids_Data.sharedata(lw_Sheet5.dw_1)
ids_Data.sharedata(lw_Sheet6.dw_1)
ids_Data.sharedata(lw_Sheet7.dw_1)

end event

event open;call super::open;ids_Data = Create Datastore
ids_Data.DataObject = "d_dwexample_tabular"

this.postevent("ue_postopen")

end event

event close;Destroy ids_Data

show(w_main)
end event

on w_datawindow_style_frame.create
if this.MenuName = "m_datawindow_style" then this.MenuID = create m_datawindow_style
this.mdi_1=create mdi_1
this.Control[]={ this.mdi_1}
end on

on w_datawindow_style_frame.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

type mdi_1 from mdiclient within w_datawindow_style_frame
long BackColor=268435456
end type

