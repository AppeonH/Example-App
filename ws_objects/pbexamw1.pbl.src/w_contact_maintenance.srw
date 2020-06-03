$PBExportHeader$w_contact_maintenance.srw
$PBExportComments$Window displaying DataWindow using buttons
forward
global type w_contact_maintenance from w_center
end type
type dw_contact from datawindow within w_contact_maintenance
end type
end forward

global type w_contact_maintenance from w_center
int X=832
int Y=360
int Width=2249
int Height=1344
boolean TitleBar=true
string Title="Contact Maintenance Using DataWindow Buttons"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_contact dw_contact
end type
global w_contact_maintenance w_contact_maintenance

event open;call super::open;dw_contact.SetTransObject(sqlca)
dw_contact.Retrieve()

end event

on w_contact_maintenance.create
this.dw_contact=create dw_contact
this.Control[]={this.dw_contact}
end on

on w_contact_maintenance.destroy
destroy(this.dw_contact)
end on

event close;w_main.Show()
end event

type dw_contact from datawindow within w_contact_maintenance
int X=14
int Y=44
int Width=2094
int Height=1160
int TabOrder=1
string DataObject="d_contact_maintenance"
boolean Border=false
end type

event buttonclicked;String	ls_Object
String				ls_Win

ls_Object = String(dwo.name)

If ls_Object = "cb_close" Then
	Close(Parent)
ElseIf ls_Object = "cb_help" Then
	ls_win = parent.ClassName()
	f_open_help(ls_win)
End If

end event

