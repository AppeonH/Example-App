$PBExportHeader$w_dw_criteria.srw
$PBExportComments$Provide Query (Criteria) Mode for DataWindow
forward
global type w_dw_criteria from w_center
end type
type st_dw_mode from statictext within w_dw_criteria
end type
type cb_reset from commandbutton within w_dw_criteria
end type
type cb_help from commandbutton within w_dw_criteria
end type
type st_3 from statictext within w_dw_criteria
end type
type cb_action from commandbutton within w_dw_criteria
end type
type st_2 from statictext within w_dw_criteria
end type
type mle_sql from multilineedit within w_dw_criteria
end type
type st_1 from statictext within w_dw_criteria
end type
type sle_rows from singlelineedit within w_dw_criteria
end type
type cb_close from commandbutton within w_dw_criteria
end type
type dw_1 from datawindow within w_dw_criteria
end type
end forward

global type w_dw_criteria from w_center
int X=360
int Y=65
int Width=2934
int Height=1921
boolean TitleBar=true
string Title="DataWindow Query Mode"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=maximized!
st_dw_mode st_dw_mode
cb_reset cb_reset
cb_help cb_help
st_3 st_3
cb_action cb_action
st_2 st_2
mle_sql mle_sql
st_1 st_1
sle_rows sle_rows
cb_close cb_close
dw_1 dw_1
end type
global w_dw_criteria w_dw_criteria

type variables
string is_original_sql_statement
end variables

forward prototypes
public subroutine wf_dw_query_mode ()
public subroutine wf_dw_retrieve_mode ()
end prototypes

public subroutine wf_dw_query_mode ();//  (Query Mode)

//Clear old SQL Select and row count, if any, from display
mle_sql.Text = ""
sle_rows.Text = ""

//Turn on DataWindow Query (Criteria Specification) Mode
dw_1.Object.datawindow.querymode= 'yes'

//Show the resulting SQL Select statement
mle_sql.Text = dw_1.GetSQLSelect ()

//Set focus into the DataWindow
dw_1.SetFocus ()

//Change Text of Button to allow Retrieval
cb_action.Text = "Retrieve"

//change datawindow heading to reflect query mode
st_dw_mode.text  = "Query Mode"
end subroutine

public subroutine wf_dw_retrieve_mode ();// Retrieve from Criteria

// Don't redraw until retrieval is finished
dw_1.SetRedraw (FALSE)

//	Turn off DataWindow Query (Criteria-specification) Mode
dw_1.Object.datawindow.querymode = 'no'

//	Show the resulting SQL Select statement
mle_sql.text = dw_1.GetSQLSelect ()
	
//	Retrieve, then redraw
dw_1.Retrieve ()
dw_1.SetRedraw (TRUE)

//	Display count of retrieved rows
sle_rows.text = String (dw_1.RowCount() )

//Change Text of Button to allow Query Mode Again 
cb_action.Text = "Query"

//change datawindow heading to reflect retrieved data
st_dw_mode.text = "Data Retrieved Based on Query Criteria:"
end subroutine

on open;// Open script for w_dw_criteria

//Causes datawindow DW1 to use the programmer-specified transaction object specified in 
//transaction as defiend by the contents of SQLCA).
dw_1.SetTransObject (sqlca)

//Causes the event clicked to be exected for CB_ACTION. This will simulate someone 
//pressing the key on open of the window. That script will cause the datawindow to go
//into query mode.
cb_action.TriggerEvent("clicked")


end on

on w_dw_criteria.create
this.st_dw_mode=create st_dw_mode
this.cb_reset=create cb_reset
this.cb_help=create cb_help
this.st_3=create st_3
this.cb_action=create cb_action
this.st_2=create st_2
this.mle_sql=create mle_sql
this.st_1=create st_1
this.sle_rows=create sle_rows
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={ this.st_dw_mode,&
this.cb_reset,&
this.cb_help,&
this.st_3,&
this.cb_action,&
this.st_2,&
this.mle_sql,&
this.st_1,&
this.sle_rows,&
this.cb_close,&
this.dw_1}
end on

on w_dw_criteria.destroy
destroy(this.st_dw_mode)
destroy(this.cb_reset)
destroy(this.cb_help)
destroy(this.st_3)
destroy(this.cb_action)
destroy(this.st_2)
destroy(this.mle_sql)
destroy(this.st_1)
destroy(this.sle_rows)
destroy(this.cb_close)
destroy(this.dw_1)
end on

on close;// Close script for w_dw_criteria

w_main.Show ()
end on

type st_dw_mode from statictext within w_dw_criteria
int X=178
int Y=145
int Width=950
int Height=71
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="Datawindow Mode:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_reset from commandbutton within w_dw_criteria
int X=2550
int Y=253
int Width=289
int Height=100
int TabOrder=30
string Text="&Reset"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// This will reset (reload) the datawindow object , in effect reseting it.
dw_1.dataobject = dw_1.dataobject
dw_1.settransobject (sqlca)

// Reinitalize the datawindow
wf_dw_query_mode ()
end on

type cb_help from commandbutton within w_dw_criteria
int X=2550
int Y=516
int Width=289
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

type st_3 from statictext within w_dw_criteria
int X=50
int Width=1686
int Height=125
boolean Enabled=false
string Text="Use the Query Mode to give examples of data you want retrieved. As the criteria is entered, the SQL is built below."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_action from commandbutton within w_dw_criteria
int X=2550
int Y=141
int Width=289
int Height=100
int TabOrder=20
string Text="Query"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Call retrieve or query mode functions (local window funcitons) based on the
//current text within the button. The button text is being used a "state" variable.

If cb_action.Text = "Retrieve" then 

	wf_dw_retrieve_mode ()

Else

	wf_dw_query_mode ()

End If
end on

type st_2 from statictext within w_dw_criteria
int X=178
int Y=1261
int Width=1096
int Height=71
boolean Enabled=false
string Text="SQL Syntax Generated from Query Mode:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_sql from multilineedit within w_dw_criteria
int X=171
int Y=1341
int Width=2212
int Height=420
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean DisplayOnly=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_dw_criteria
int X=1896
int Width=306
int Height=116
boolean Enabled=false
string Text="Rows Retrieved:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_rows from singlelineedit within w_dw_criteria
int X=2201
int Y=36
int Width=278
int Height=81
int TabOrder=70
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
boolean DisplayOnly=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_close from commandbutton within w_dw_criteria
int X=2550
int Y=385
int Width=289
int Height=100
int TabOrder=40
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Clicked script for cb_done

Close (Parent)
end on

type dw_1 from datawindow within w_dw_criteria
int X=178
int Y=231
int Width=2248
int Height=1021
int TabOrder=10
string DataObject="d_contact_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

on itemchanged;/**************************************************************
Show the resulting SQL Select statement
 **************************************************************/
//mle_sql.text = dw_1.Describe ("datawindow.table.select")
mle_sql.text = dw_1.GetSQLSelect()
end on

