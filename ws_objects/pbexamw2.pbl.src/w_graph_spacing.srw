$PBExportHeader$w_graph_spacing.srw
$PBExportComments$General response window to set graph spacing.
forward
global type w_graph_spacing from w_center
end type
type em_spacing from editmask within w_graph_spacing
end type
type cb_cancel from commandbutton within w_graph_spacing
end type
type cb_ok from commandbutton within w_graph_spacing
end type
end forward

global type w_graph_spacing from w_center
int X=1078
int Y=369
int Width=1057
int Height=538
boolean TitleBar=true
string Title="Select Spacing Percent"
long BackColor=74481808
boolean ControlMenu=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
em_spacing em_spacing
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_graph_spacing w_graph_spacing

type variables
object io_passed
graph igr_parm
datawindow idw_parm
int ii_original_spacing
end variables

event open;call super::open;///////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_graph_spacing
///////////////////////////////////////////////////////////////////////////////////////////////////////

graphicobject lgro_hold

lgro_hold = Message.PowerObjectParm

If lgro_hold.TypeOf() = Graph! Then
	io_passed = Graph!
	igr_parm = Message.PowerObjectParm
	em_spacing.text = string(igr_parm.spacing)
	ii_original_spacing = igr_parm.spacing
Elseif lgro_hold.TypeOf() = Datawindow! Then
	io_passed = Datawindow!
	idw_parm = Message.PowerObjectParm
	em_spacing.text = idw_parm.Object.gr_1.spacing
	ii_original_spacing = Integer(em_spacing.text)
End If
end event

on w_graph_spacing.create
this.em_spacing=create em_spacing
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={ this.em_spacing,&
this.cb_cancel,&
this.cb_ok}
end on

on w_graph_spacing.destroy
destroy(this.em_spacing)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

type em_spacing from editmask within w_graph_spacing
event ue_enchange pbm_enchange
int X=260
int Y=77
int Width=459
int Height=100
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
string Mask="#####"
boolean Spin=true
double Increment=10
string MinMax="0	100"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event ue_enchange;///////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_enchange script for em_spacing
///////////////////////////////////////////////////////////////////////////////////////////////////////

If io_passed = Graph! Then
	igr_parm.spacing = integer (em_spacing.text)
Elseif io_passed = Datawindow! Then
	idw_parm.Object.gr_1.spacing = em_spacing.text
End If

end event

type cb_cancel from commandbutton within w_graph_spacing
int X=513
int Y=244
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

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_cancel
///////////////////////////////////////////////////////////////////////////////////////////////////////

// Reset the spacing since the user hit the Cancel button.
If io_passed = Graph! Then
	igr_parm.spacing = ii_original_spacing
Elseif io_passed = Datawindow! Then
	idw_parm.Object.gr_1.spacing= string(ii_original_spacing)
End If

Close (parent)
end event

type cb_ok from commandbutton within w_graph_spacing
int X=214
int Y=244
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

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for cb_ok
///////////////////////////////////////////////////////////////////////////////////////////////////////

Close (parent) 
end event

