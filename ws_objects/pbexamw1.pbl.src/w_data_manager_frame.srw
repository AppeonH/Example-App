$PBExportHeader$w_data_manager_frame.srw
$PBExportComments$Data Manager Frame
forward
global type w_data_manager_frame from w_center
end type
type mdi_1 from mdiclient within w_data_manager_frame
end type
end forward

global type w_data_manager_frame from w_center
int X=0
int Y=4
int Width=2930
int Height=1828
boolean TitleBar=true
string Title="Data Manager"
long BackColor=273962025
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=mdihelp!
mdi_1 mdi_1
end type
global w_data_manager_frame w_data_manager_frame

type variables
boolean	          ib_autoarrange = false
boolean	          ib_minimizeonuse = false
listviewview       ilvv_defaultstyle = listviewlargeicon!
end variables

event open;call super::open;n_cst_parms	lnv_parm

lnv_parm.is_dataobject = "d_sales_reps"
lnv_parm.iw_frame = this

OpenSheetWithParm(w_data_manager, lnv_parm, this, 3, original!)

end event

on w_data_manager_frame.create
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_data_manager_frame.destroy
destroy(this.mdi_1)
end on

event close;Show(w_main)

end event

type mdi_1 from mdiclient within w_data_manager_frame
long BackColor=273962025
end type

