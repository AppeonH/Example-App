$PBExportHeader$u_dw_ribbon_2.sru
$PBExportComments$DataWindow button bar
forward
global type u_dw_ribbon_2 from UserObject
end type
type cb_apply from commandbutton within u_dw_ribbon_2
end type
type cb_delete from commandbutton within u_dw_ribbon_2
end type
type cb_new from commandbutton within u_dw_ribbon_2
end type
type cb_last from commandbutton within u_dw_ribbon_2
end type
type cb_prior from commandbutton within u_dw_ribbon_2
end type
type cb_next from commandbutton within u_dw_ribbon_2
end type
type cb_first from commandbutton within u_dw_ribbon_2
end type
type cb_retrieve from commandbutton within u_dw_ribbon_2
end type
type pb_exit from picturebutton within u_dw_ribbon_2
end type
end forward

shared variables

end variables

global type u_dw_ribbon_2 from UserObject
int Width=2692
int Height=205
boolean Border=true
long BackColor=78682240
long PictureMaskColor=25166016
long TabTextColor=33554432
long TabBackColor=67108864
event close pbm_custom01
cb_apply cb_apply
cb_delete cb_delete
cb_new cb_new
cb_last cb_last
cb_prior cb_prior
cb_next cb_next
cb_first cb_first
cb_retrieve cb_retrieve
pb_exit pb_exit
end type
global u_dw_ribbon_2 u_dw_ribbon_2

type variables
datawindow   idw_udo

end variables

forward prototypes
public subroutine uf_setdw (datawindow adw_parm)
public subroutine uf_set_buttons (boolean ab_retrieve, boolean ab_first, boolean ab_next, boolean ab_prior, boolean ab_last, boolean ab_new, boolean ab_delete, boolean ab_apply)
end prototypes

public subroutine uf_setdw (datawindow adw_parm);//////////////////////////////////////////////////////////////////////
//
// Function: uf_setdw
//
// Purpose: set the instance variable idw_udo equal to the datawindow
//				argument passed to this function
//
//	Scope: public
//
//	Arguments: adw_parm	the datawindow that you want to use with this
//								user object
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

// "Grab" the identity of whatever DataWindow parameter was passed,
// and retain it in an instance variable (dw_udo) within this
// user object.  That way, all of the CommandButton clicked-event
// scripts can refer to the passed DataWindow.

idw_udo = adw_parm
end subroutine

public subroutine uf_set_buttons (boolean ab_retrieve, boolean ab_first, boolean ab_next, boolean ab_prior, boolean ab_last, boolean ab_new, boolean ab_delete, boolean ab_apply);//////////////////////////////////////////////////////////////////////
//
// Function: uf_set_buttons
//
// Purpose: enables/disables the command buttons based on the boolean
//				arguments that are passed
//
//	Scope: public
//
//	Arguments: for all arguments, true = enable button
//											false = disable button
//					
//				  ab_retrieve	enable/disable 'retrieve' command button
//				  ab_first		enable/disable 'first' command button
//				  ab_next		enable/disable 'next' command button
//				  ab_prior		enable/disable 'prior' command button
//				  ab_last		enable/disable 'last' command button
//				  ab_new			enable/disable 'new' command button
//				  ab_delete		enable/disable 'delete' command button
//				  ab_apply		enable/disable 'apply' command button		
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

cb_retrieve.enabled = ab_retrieve
cb_first.enabled = ab_first
cb_next.enabled = ab_next
cb_prior.enabled = ab_prior
cb_last.enabled = ab_last
cb_new.enabled = ab_new
cb_delete.enabled = ab_delete
cb_apply.enabled = ab_apply
end subroutine

on u_dw_ribbon_2.create
this.cb_apply=create cb_apply
this.cb_delete=create cb_delete
this.cb_new=create cb_new
this.cb_last=create cb_last
this.cb_prior=create cb_prior
this.cb_next=create cb_next
this.cb_first=create cb_first
this.cb_retrieve=create cb_retrieve
this.pb_exit=create pb_exit
this.Control[]={ this.cb_apply,&
this.cb_delete,&
this.cb_new,&
this.cb_last,&
this.cb_prior,&
this.cb_next,&
this.cb_first,&
this.cb_retrieve,&
this.pb_exit}
end on

on u_dw_ribbon_2.destroy
destroy(this.cb_apply)
destroy(this.cb_delete)
destroy(this.cb_new)
destroy(this.cb_last)
destroy(this.cb_prior)
destroy(this.cb_next)
destroy(this.cb_first)
destroy(this.cb_retrieve)
destroy(this.pb_exit)
end on

type cb_apply from commandbutton within u_dw_ribbon_2
int X=2137
int Y=29
int Width=292
int Height=116
int TabOrder=90
string Text="&Apply"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Update the datawindow with any changes that have been made

if idw_udo.Update() = 1 then
	commit;
else
	rollback;
end if

idw_udo.SetFocus()
end on

type cb_delete from commandbutton within u_dw_ribbon_2
int X=1835
int Y=29
int Width=292
int Height=116
int TabOrder=80
string Text="&Delete"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Delete the current row of the datawindow and select the current row

idw_udo.DeleteRow (0)
idw_udo.TriggerEvent (rowfocuschanged!)
idw_udo.SetFocus()
end on

type cb_new from commandbutton within u_dw_ribbon_2
int X=1533
int Y=29
int Width=292
int Height=116
int TabOrder=60
string Text="&New"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// insert a new row in the datawindow before the current row

int	li_row, &
		li_cur_row

li_cur_row = idw_udo.GetRow()
li_row = idw_udo.InsertRow (li_cur_row)
idw_udo.ScrollToRow (li_row)
idw_udo.SetFocus()

end on

type cb_last from commandbutton within u_dw_ribbon_2
int X=1231
int Y=29
int Width=292
int Height=116
int TabOrder=40
string Text="&Last"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// scroll to the last row of the datawindow

idw_udo.ScrollToRow (idw_udo.RowCount())
idw_udo.SetFocus()
end on

type cb_prior from commandbutton within u_dw_ribbon_2
int X=929
int Y=29
int Width=292
int Height=116
int TabOrder=70
string Text="&Prior"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// scroll to the prior row of the datawindow

idw_udo.ScrollPriorRow()
idw_udo.SetFocus()
end on

type cb_next from commandbutton within u_dw_ribbon_2
int X=626
int Y=29
int Width=292
int Height=116
int TabOrder=20
string Text="Ne&xt"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// scroll to the next row of the datawindow

idw_udo.ScrollNextRow()
idw_udo.SetFocus()
end on

type cb_first from commandbutton within u_dw_ribbon_2
int X=324
int Y=29
int Width=292
int Height=116
int TabOrder=30
string Text="&First"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// scroll to the first row of the datawindow

idw_udo.ScrollToRow (1)
idw_udo.SetFocus()

end on

type cb_retrieve from commandbutton within u_dw_ribbon_2
int X=22
int Y=29
int Width=292
int Height=116
int TabOrder=50
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// retrieve the datawindow

idw_udo.Retrieve()
idw_udo.TriggerEvent (rowfocuschanged!)
idw_udo.SetFocus()

end on

type pb_exit from picturebutton within u_dw_ribbon_2
int X=2440
int Y=29
int Width=221
int Height=116
int TabOrder=10
string PictureName="exit.bmp"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// exit this example

parent.TriggerEvent ("close")
end on

