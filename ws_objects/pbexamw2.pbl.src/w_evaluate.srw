$PBExportHeader$w_evaluate.srw
$PBExportComments$Uses ItemError event and dwdescribe(evaluate) to evaluate a math expression in a DataWindow field.
forward
global type w_evaluate from w_center
end type
type cb_close from commandbutton within w_evaluate
end type
type cb_help from commandbutton within w_evaluate
end type
type dw_evaluate from datawindow within w_evaluate
end type
end forward

global type w_evaluate from w_center
int X=321
int Y=161
int Width=2308
int Height=1636
boolean TitleBar=true
string Title="Evaluate & ItemError"
long BackColor=74481808
boolean ControlMenu=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_postopen pbm_custom01
cb_close cb_close
cb_help cb_help
dw_evaluate dw_evaluate
end type
global w_evaluate w_evaluate

type variables
string is_result
end variables

event ue_postopen;///////////////////////////////////////////////////////////////////////////////////////////////
// ue_postopen script for w_evaluate
///////////////////////////////////////////////////////////////////////////////////////////////

// set the transaction object
dw_evaluate.SetTransObject(sqlca)

//load the datawindow
dw_evaluate.retrieve()


end event

event close;///////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_evaluate
///////////////////////////////////////////////////////////////////////////////////////////////

show(w_main)
end event

event open;call super::open;///////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_evaluate
///////////////////////////////////////////////////////////////////////////////////////////////

//post event
this.PostEvent("ue_postopen")
end event

on w_evaluate.create
this.cb_close=create cb_close
this.cb_help=create cb_help
this.dw_evaluate=create dw_evaluate
this.Control[]={ this.cb_close,&
this.cb_help,&
this.dw_evaluate}
end on

on w_evaluate.destroy
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.dw_evaluate)
end on

type cb_close from commandbutton within w_evaluate
int X=776
int Y=1348
int Width=246
int Height=109
int TabOrder=30
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_close
///////////////////////////////////////////////////////////////////////////////////////////////

Close(parent)
end event

type cb_help from commandbutton within w_evaluate
int X=1049
int Y=1348
int Width=246
int Height=109
int TabOrder=20
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_help
///////////////////////////////////////////////////////////////////////////////////////////////

f_open_help(parent.classname())
end event

type dw_evaluate from datawindow within w_evaluate
int X=22
int Y=36
int Width=2145
int Height=1271
int TabOrder=10
string DataObject="d_evaluate"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemerror;///////////////////////////////////////////////////////////////////////////////////////////////
//itemerror script for dw_evaluate
///////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////
//A datawindow field is evaluated in the following manner.
//		1) Is the new data a valid type for this field
//		2) Does it pass the validation rule in the datawindow for that field
//If 1 or 2 does not pass PowerBuilder will run the ItemError Datawindow Event.
///////////////////////////////////////////////////////////////////////////////////////////////

//Assumption: Only the numeric field is updatable in this datawindow.
//If other fields are editable, addition of logic is required to check them.

string	ls_result
string	ls_item
int		li_rc

//get the current text in the field that failed
ls_item = this.gettext()

If this.GetColumnName() = 'employee_salary' Then
	If isNumber(ls_item) Then
		//data type is ok, but failed validation 
		Return 0  // (Default) Reject the data value and show a system error screen.
	End If

	///////////////////////////////////////////////////////////////////////////////////////////////
	// data type is bad
	// Check to see if it is a formula that needs to be evaluated
	///////////////////////////////////////////////////////////////////////////////////////////////

	// evaluate possible formula
	ls_result = this.describe("evaluate('" + this.gettext() + "',0)")

	// check for result being a valid number
	If isNumber(ls_result) Then
		//its a formula that evaluates to a valid result
		//put result into the field replacing the formula the user typed in
		this.object.employee_salary[row] = long(ls_result)
		return 3 //Replace the column value just entered with the value originally in the column.
					//The value just entered is the actual formula, in this case the original
					//  value is the result due to the previous line of code.
	End If

	return 1  // Reject the data value but do not show a system error screen.
End If
end event

