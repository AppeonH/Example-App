$PBExportHeader$w_cancel_retrieval.srw
$PBExportComments$Cancel DataWindow retrieval, printing
forward
global type w_cancel_retrieval from w_center
end type
type cbx_print_cancel from checkbox within w_cancel_retrieval
end type
type cb_print from commandbutton within w_cancel_retrieval
end type
type cb_help from commandbutton within w_cancel_retrieval
end type
type cb_close from commandbutton within w_cancel_retrieval
end type
type st_2 from statictext within w_cancel_retrieval
end type
type cb_retrieve from commandbutton within w_cancel_retrieval
end type
type dw_1 from datawindow within w_cancel_retrieval
end type
end forward

global type w_cancel_retrieval from w_center
int X=168
int Y=109
int Width=3016
int Height=1962
boolean TitleBar=true
string Title="Cancel Retrieval & Printing"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
event cancel_requested pbm_custom01
cbx_print_cancel cbx_print_cancel
cb_print cb_print
cb_help cb_help
cb_close cb_close
st_2 st_2
cb_retrieve cb_retrieve
dw_1 dw_1
end type
global w_cancel_retrieval w_cancel_retrieval

type variables
boolean ib_cancelbut_open
boolean ib_cancel_print_valid
end variables

on cancel_requested;//Cancel_requested(user defined) script for w_cancel_retrieval
//This will set the boolean flag that a request to cancel
//the datawindow retrieve has taken place.
ib_cancelbut_open = false


end on

on open;/////////////////////////////////////////////////////////////////
//
// Purpose:
//Open script for w_cancel_retrieval
//
// This window demonstrates the ability to cancel a datawindow 
// retrieve in progress.
//
//
// Log:
//
//   DATE       WHO      WHAT
//   ----       ---      -------------------------------
//  4/15/94     crm      Initial
/////////////////////////////////////////////////////////////////


//Causes datawindowname DW1 to use the programmer-specified 
//transaction object specified in transaction. This gives you
//more control over the transaction (for example, you can COMMIT 
//from a script).

dw_1.SetTransObject(sqlca)


ib_cancel_print_valid = True
end on

on close;//Close script for w_cancel_retrieval
//Bring the main menu up
w_main.Show( )

end on

on w_cancel_retrieval.create
this.cbx_print_cancel=create cbx_print_cancel
this.cb_print=create cb_print
this.cb_help=create cb_help
this.cb_close=create cb_close
this.st_2=create st_2
this.cb_retrieve=create cb_retrieve
this.dw_1=create dw_1
this.Control[]={ this.cbx_print_cancel,&
this.cb_print,&
this.cb_help,&
this.cb_close,&
this.st_2,&
this.cb_retrieve,&
this.dw_1}
end on

on w_cancel_retrieval.destroy
destroy(this.cbx_print_cancel)
destroy(this.cb_print)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.st_2)
destroy(this.cb_retrieve)
destroy(this.dw_1)
end on

type cbx_print_cancel from checkbox within w_cancel_retrieval
int X=2361
int Y=4
int Width=609
int Height=71
string Text="&Allow Print Cancel"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// if this check box is checked then it is valid to cancel printing
ib_cancel_print_valid = cbx_print_cancel.checked
end on

type cb_print from commandbutton within w_cancel_retrieval
int X=2553
int Y=257
int Width=331
int Height=100
int TabOrder=30
string Text="&Print"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Depending if the print cancel switch is on or off, you will or will not be able 
//to cancel a print job in process
SetPointer(Hourglass!)
dw_1.Print(ib_cancel_print_valid)
end on

type cb_help from commandbutton within w_cancel_retrieval
int X=2553
int Y=500
int Width=331
int Height=100
int TabOrder=50
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help(parent.ClassName( ))

end on

type cb_close from commandbutton within w_cancel_retrieval
int X=2553
int Y=369
int Width=331
int Height=100
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_close

Close(parent)
end on

type st_2 from statictext within w_cancel_retrieval
int X=57
int Width=2145
int Height=125
boolean Enabled=false
string Text="Press Retrieve: Then Press Cancel Button to Cancel Retrieval in Progress Press Print: Notice the difference if the Print Cancel box is checked"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_retrieve from commandbutton within w_cancel_retrieval
int X=2553
int Y=145
int Width=331
int Height=100
int TabOrder=20
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_retrieve
int	li_returncode

//clear contents of datawindow before retrieval
dw_1.Reset( )

//disable other functions while retrieve is in progress
cb_retrieve.enabled = false
cb_close.enabled = false
cb_help.enabled = false
cb_print.enabled = false

li_returncode = dw_1.Retrieve( )

//reenable other function buttons after retrieve is complete
cb_retrieve.enabled = true
cb_close.enabled = true
cb_help.enabled = true
cb_print.enabled = true
dw_1.setfocus()

end on

type dw_1 from datawindow within w_cancel_retrieval
int X=57
int Y=145
int Width=2436
int Height=1533
int TabOrder=10
string DataObject="d_retrieve_cust"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on retrieveend;//Retrieveend script for dw_1

if ib_cancelbut_open then
	ib_cancelbut_open = false
end if

Close(w_cancel_button)
end on

on retrievestart;//Retrievestart script for dw_1

// Display the cancel window at start of retrieval. This window 
// contains a Cancel button, which sets the instance 
// ib_cancelbut_open false, when clicked.
ib_cancelbut_open = true

Open(w_cancel_button)


end on

event retrieverow;//Retrieverow script for dw_1

// ScrollNextRow displays rows as they are retrieved
this.ScrollNextRow( )

// Display a running count of rows retrieved
if IsValid(w_cancel_button) then	
	w_cancel_button.st_count.text = String(This.RowCount( ))
end if

// If the Cancel button has been clicked, set the action code to
// terminate the retrieval. Note: It is the SetActionCode function
// that actually terminates the retrieve
if ib_cancelbut_open = false then 
	return 1
end if
end event

