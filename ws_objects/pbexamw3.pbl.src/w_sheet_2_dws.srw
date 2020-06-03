$PBExportHeader$w_sheet_2_dws.srw
$PBExportComments$Ancestor:  MDI Sheet with 2 DataWindows
forward
global type w_sheet_2_dws from w_sheet_1_dw
end type
type dw_2 from datawindow within w_sheet_2_dws
end type
end forward

global type w_sheet_2_dws from w_sheet_1_dw
int X=33
int Y=161
int Width=2542
int Height=1541
dw_2 dw_2
end type
global w_sheet_2_dws w_sheet_2_dws

type variables
string	col1_name, col1_type

end variables

on open;call w_sheet_1_dw::open;//////////////////////////////////////////////////////////////////////
//
// col1_name must be set in the descendant to the column name to be
// used as the retrieval argument for the detail data window. The
// descendant must override, set the argument column name and
// call this script explicitly. 
//
// Example:		  col1_name = "emp_id"
//					  Call super::open
//
//////////////////////////////////////////////////////////////////////

col1_type = dw_1.Describe (col1_name + ".coltype")
col1_type = f_get_token (col1_type, "(")

dw_2.SetTransObject (sqlca)

end on

on w_sheet_2_dws.create
int iCurrent
call w_sheet_1_dw::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_2
end on

on w_sheet_2_dws.destroy
call w_sheet_1_dw::destroy
destroy(this.dw_2)
end on

on resize;// Resize script for W_SHEET_2_DWS

/*  Note:  Ancestor script (in W_SHEET_1_DW) is overridden here,
    because it always resizes dw_1 to fill the entire available
    space within the window (which obscures dw_2 here)
*/
end on

type dw_1 from w_sheet_1_dw`dw_1 within w_sheet_2_dws
int Y=33
int Width=2442
int Height=529
int TabOrder=10
boolean HScrollBar=false
end type

on dw_1::rowfocuschanged;call w_sheet_1_dw`dw_1::rowfocuschanged;//////////////////////////////////////////////////////////////////////
//
// Don't retrieve if no row selected. This line added with Release 3.0
// since return in an ancestor no longer terminates execution of 
// descendant scripts.
//
//////////////////////////////////////////////////////////////////////

if i_row < 1 then return

choose case col1_type

	case "number"
		dw_2.Retrieve (dw_1.GetItemNumber (i_row, col1_name))

	case "char"
		dw_2.Retrieve (dw_1.GetItemString (i_row, col1_name))

	case "date"
		dw_2.Retrieve (dw_1.GetItemDate (i_row, col1_name))

	case "time"
		dw_2.Retrieve (dw_1.GetItemTime (i_row, col1_name))

	case "datetime"
		dw_2.Retrieve (dw_1.GetItemDateTime (i_row, col1_name))

end choose

end on

type dw_2 from datawindow within w_sheet_2_dws
int X=23
int Y=589
int Width=2442
int Height=717
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

