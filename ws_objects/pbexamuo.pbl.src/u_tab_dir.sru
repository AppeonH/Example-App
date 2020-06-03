$PBExportHeader$u_tab_dir.sru
$PBExportComments$Phone directory tab page
forward
global type u_tab_dir from UserObject
end type
type dw_dir from datawindow within u_tab_dir
end type
end forward

global type u_tab_dir from UserObject
int Width=1769
int Height=1052
long BackColor=73955432
long PictureMaskColor=553648127
long TabTextColor=33554432
long TabBackColor=73955432
string Text="A"
dw_dir dw_dir
end type
global u_tab_dir u_tab_dir

type variables
Boolean	ib_Retrieved
end variables

forward prototypes
public function integer of_retrieve_data (string as_Parm)
end prototypes

public function integer of_retrieve_data (string as_Parm);If Not ib_Retrieved Then
	dw_dir.SetTransObject(sqlca)
	dw_dir.Retrieve(as_Parm)
	ib_Retrieved = True
End if

Return dw_dir.RowCount()	

end function

on u_tab_dir.create
this.dw_dir=create dw_dir
this.Control[]={ this.dw_dir}
end on

on u_tab_dir.destroy
destroy(this.dw_dir)
end on

type dw_dir from datawindow within u_tab_dir
int X=9
int Width=1719
int Height=996
int TabOrder=1
string DataObject="d_cust_phone_dir2"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

