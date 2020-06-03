$PBExportHeader$w_compute_in_attribute.srw
$PBExportComments$Min and max salaries by department are different text colors using attribute expressions that reference computed fields.
forward
global type w_compute_in_attribute from w_center
end type
type cb_help from commandbutton within w_compute_in_attribute
end type
type dw_1 from datawindow within w_compute_in_attribute
end type
type cb_close from commandbutton within w_compute_in_attribute
end type
type cb_update from commandbutton within w_compute_in_attribute
end type
type cb_retrieve from commandbutton within w_compute_in_attribute
end type
end forward

global type w_compute_in_attribute from w_center
int X=168
int Y=39
int Width=2589
int Height=1850
boolean TitleBar=true
string Title="Referencing Computed Fields in Attribute Expressions"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_help cb_help
dw_1 dw_1
cb_close cb_close
cb_update cb_update
cb_retrieve cb_retrieve
end type
global w_compute_in_attribute w_compute_in_attribute

on open;dw_1.SetTransObject (sqlca)

// Post an event that retrieves the DataWindow.
cb_retrieve.PostEvent (clicked!)
end on

on close;w_main.Show()
end on

on w_compute_in_attribute.create
this.cb_help=create cb_help
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.Control[]={ this.cb_help,&
this.dw_1,&
this.cb_close,&
this.cb_update,&
this.cb_retrieve}
end on

on w_compute_in_attribute.destroy
destroy(this.cb_help)
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.cb_retrieve)
end on

type cb_help from commandbutton within w_compute_in_attribute
int X=1601
int Y=1629
int Width=267
int Height=100
int TabOrder=50
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help (parent.ClassName())
end on

type dw_1 from datawindow within w_compute_in_attribute
int X=36
int Y=45
int Width=2482
int Height=1533
int TabOrder=10
string DataObject="d_compute_in_attribute"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on retrieveend;cb_update.enabled = true
end on

on retrievestart;cb_update.enabled = false
end on

type cb_close from commandbutton within w_compute_in_attribute
int X=1281
int Y=1629
int Width=267
int Height=100
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type cb_update from commandbutton within w_compute_in_attribute
int X=982
int Y=1629
int Width=267
int Height=100
int TabOrder=30
string Text="&Update"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Update the DataWindow
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if dw_1.Update() = 1 then
	commit;
else
	rollback;
end if
end on

type cb_retrieve from commandbutton within w_compute_in_attribute
int X=683
int Y=1629
int Width=267
int Height=100
int TabOrder=20
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Retrieve the DataWindow
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_1.Retrieve()
end on

