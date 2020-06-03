$PBExportHeader$w_highlight_dw_rows.srw
$PBExportComments$How to highlight DataWindow rows depending on the combination of Mouse click and the shift or control key being pressed.
forward
global type w_highlight_dw_rows from w_center
end type
type st_1 from statictext within w_highlight_dw_rows
end type
type cb_help from commandbutton within w_highlight_dw_rows
end type
type cb_close from commandbutton within w_highlight_dw_rows
end type
type dw_highlight from datawindow within w_highlight_dw_rows
end type
end forward

global type w_highlight_dw_rows from w_center
int X=257
int Y=263
int Width=2913
int Height=1898
boolean TitleBar=true
string Title="Row Selection Techniques"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
event ue_postopen pbm_custom01
st_1 st_1
cb_help cb_help
cb_close cb_close
dw_highlight dw_highlight
end type
global w_highlight_dw_rows w_highlight_dw_rows

type variables

boolean ib_action_on_buttonup = false

long  il_LastClickedRow


end variables

forward prototypes
public function int wf_shift_highlight (long al_aclickedrow)
end prototypes

event ue_postopen;//////////////////////////////////////////////////////////////////////////////////////////////////
// ue_PostOpen script for w_hightlight_dw_rows
//////////////////////////////////////////////////////////////////////////////////////////////////

// Set the transaction object
dw_highlight.settransobject (sqlca)

// Retrieve the data
dw_highlight.retrieve()



end event

public function int wf_shift_highlight (long al_aclickedrow);
//**********************************************************************
//		This function will verify that there is a prior selected row and
//		then highlight all Rows between the two.  If there is no previously
//		Selected row then it will highlight only the row clicked.  
//		This function will not unhighlight any other rows to allow for a 
//		mix of shift and Control key inter mingling.  This will have to be
//		aware of the relation between the rows to know which way to 
//		highlight.
//
//		The arguement passed will be the currently clicked row.  This 
//		function will use the existing DataWindow and the instance variable
//		iLastClickedRow to perform it's scrolling.
//**********************************************************************
integer	li_Idx

//file manager functionality ... turn off all rows then select new range
dw_highlight.setredraw(false)
dw_highlight.selectrow(0,false)

If il_lastclickedrow = 0 then
//	dw_highlight.SelectRow(al_aclickedrow,TRUE)
	dw_highlight.setredraw(true)
	Return 1
end if


//selection moving backward
if il_lastclickedrow > al_aclickedrow then
	For li_Idx = il_lastclickedrow to al_aclickedrow STEP -1
		DW_highlight.selectrow(li_Idx,TRUE)	
	end for	
else
//selection moving forward
	For li_Idx = il_lastclickedrow to al_aclickedrow 
		DW_highlight.selectrow(li_Idx,TRUE)	
	next	
end if

dw_highlight.setredraw(true)
Return 1

end function

event open;call super::open;/////////////////////////////////////////////////////////////////////////////////////////////////
// Open script for w_highlight_dw_rows
//////////////////////////////////////////////////////////////////////////////////////////////////

// Post event to retrieve data on postopen (allow window to open faster)
this.postevent("ue_postopen")


end event

event close;//////////////////////////////////////////////////////////////////////////////////////////////////
// Close script for w_hightlight_dw_rows
//////////////////////////////////////////////////////////////////////////////////////////////////

W_main.Show()


end event

on w_highlight_dw_rows.create
this.st_1=create st_1
this.cb_help=create cb_help
this.cb_close=create cb_close
this.dw_highlight=create dw_highlight
this.Control[]={ this.st_1,&
this.cb_help,&
this.cb_close,&
this.dw_highlight}
end on

on w_highlight_dw_rows.destroy
destroy(this.st_1)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.dw_highlight)
end on

type st_1 from statictext within w_highlight_dw_rows
int X=121
int Y=13
int Width=2713
int Height=71
boolean Enabled=false
string Text="This will show methods of selecting multiple rows similar to File Manager. See help for more information."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_help from commandbutton within w_highlight_dw_rows
int X=1362
int Y=1645
int Width=289
int Height=109
int TabOrder=20
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help(parent.ClassName( ))
end on

type cb_close from commandbutton within w_highlight_dw_rows
int X=1028
int Y=1645
int Width=289
int Height=109
int TabOrder=10
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close(parent)
end on

type dw_highlight from datawindow within w_highlight_dw_rows
event ue_lbuttonup pbm_dwnlbuttonup
int X=132
int Y=148
int Width=2440
int Height=1444
int TabOrder=30
string DataObject="d_contact_list_protected"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event ue_lbuttonup;//////////////////////////////////////////////////////////////////////////////////////////////////
// ue_LButtonUp script for dw_highlight
//////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////
//		This event will be the controlling event for all of the types of
//		Highlighting that will be done.
//////////////////////////////////////////////////////////////////////////////////////////////////
long	  ll_ClickedRow
string	  ls_KeyDownType


//////////////////////////////////////////////////////////////////////////////////////////////////
//		First make sure the user clicked on a Row.  Clicking on WhiteSpace
//		or in the header will return a clicked row value of 0.  If that 
//		occurs, just leave this event.
//////////////////////////////////////////////////////////////////////////////////////////////////


//In filemanager style, the the click and ctrl-click events on a selected row take place
//on the button up event.
If ib_action_on_buttonup Then
	ib_action_on_buttonup = false

	// (CTRL KEY) keep other rows highlighted and highlight a new row or
	// turn off the currint row highlight
	If Keydown(KeyControl!) then
		this.selectrow(il_lastclickedrow,FALSE)
	Else
		this.SelectRow(0,FALSE)
		this.SelectRow(il_lastclickedrow,TRUE)
	End If

	//last action was deselecting a row , an anchor row is no longer defined
	il_lastclickedrow = 0
End If


end event

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for dw_highlight
//////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////
//		This event will be the controlling event for all of the types of
//		Highlighting that will be done.
//////////////////////////////////////////////////////////////////////////////////////////////////
string	  ls_KeyDownType


//////////////////////////////////////////////////////////////////////////////////////////////////
//		First make sure the user clicked on a Row.  Clicking on WhiteSpace
//		or in the header will return a clicked row value of 0.  If that 
//		occurs, just leave this event.
//////////////////////////////////////////////////////////////////////////////////////////////////

//check for a valid row
If row = 0 then Return

//case of select multiple rows range using the shift key
If Keydown(KeyShift!) then
	wf_Shift_Highlight(row)
	//In filemanager style, the click and ctrl-click events on a selected row take 
	//place on the button up event.

ElseIf this.IsSelected(row) Then
	il_LastClickedRow = row
	ib_action_on_buttonup = true
	
ElseIf Keydown(KeyControl!) then
	// (CTRL KEY) keep other rows highlighted and highlight a new row or
	// turn off the currint row highlight
	il_LastClickedRow = row
	this.SelectRow(row,TRUE)
	
Else
	il_LastClickedRow = row
	this.SelectRow(0,FALSE)
	this.SelectRow(row,TRUE)
	
End If  //selected row

end event

