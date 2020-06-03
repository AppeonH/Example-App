$PBExportHeader$w_dberror_event.srw
$PBExportComments$Example which shows how to supress default dberror message, and display custom message.
forward
global type w_dberror_event from w_center
end type
type cb_add from commandbutton within w_dberror_event
end type
type rb_none from radiobutton within w_dberror_event
end type
type rb_custom from radiobutton within w_dberror_event
end type
type rb_default from radiobutton within w_dberror_event
end type
type cb_retrieve from commandbutton within w_dberror_event
end type
type cb_update from commandbutton within w_dberror_event
end type
type cb_close from commandbutton within w_dberror_event
end type
type cb_help from commandbutton within w_dberror_event
end type
type dw_1 from datawindow within w_dberror_event
end type
type gb_1 from groupbox within w_dberror_event
end type
end forward

global type w_dberror_event from w_center
int X=456
int Y=375
int Width=2017
int Height=1172
boolean TitleBar=true
string Title="DBError Event"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_add cb_add
rb_none rb_none
rb_custom rb_custom
rb_default rb_default
cb_retrieve cb_retrieve
cb_update cb_update
cb_close cb_close
cb_help cb_help
dw_1 dw_1
gb_1 gb_1
end type
global w_dberror_event w_dberror_event

on w_dberror_event.create
this.cb_add=create cb_add
this.rb_none=create rb_none
this.rb_custom=create rb_custom
this.rb_default=create rb_default
this.cb_retrieve=create cb_retrieve
this.cb_update=create cb_update
this.cb_close=create cb_close
this.cb_help=create cb_help
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={ this.cb_add,&
this.rb_none,&
this.rb_custom,&
this.rb_default,&
this.cb_retrieve,&
this.cb_update,&
this.cb_close,&
this.cb_help,&
this.dw_1,&
this.gb_1}
end on

on w_dberror_event.destroy
destroy(this.cb_add)
destroy(this.rb_none)
destroy(this.rb_custom)
destroy(this.rb_default)
destroy(this.cb_retrieve)
destroy(this.cb_update)
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event close;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_dberror_event
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Show front-end to Code Examples
w_main.Show()
end event

event open;call super::open;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_dberror_event
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Set Transaction Object for the DataWindow
dw_1.SetTransObject (sqlca)
end event

type cb_add from commandbutton within w_dberror_event
int X=1650
int Y=157
int Width=306
int Height=100
int TabOrder=20
string Text="&Add Row"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for cb_add
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Add a new row into the DataWindow
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_row

ll_row = dw_1.InsertRow (0)
dw_1.ScrollToRow(ll_row)
dw_1.SetColumn(1)
dw_1.SetFocus()
end event

type rb_none from radiobutton within w_dberror_event
int X=97
int Y=263
int Width=552
int Height=71
string Text="No error message"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_custom from radiobutton within w_dberror_event
int X=97
int Y=193
int Width=808
int Height=71
string Text="Customized error message"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_default from radiobutton within w_dberror_event
int X=97
int Y=119
int Width=779
int Height=71
string Text="Default PB error message"
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

type cb_retrieve from commandbutton within w_dberror_event
int X=1650
int Y=36
int Width=306
int Height=100
int TabOrder=40
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_retrieve
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Retrieve the DataWindow.
// If the Retrieve function fails (return code of -1), the dberror event of the DataWindow will be triggered.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_1.Retrieve()
end event

type cb_update from commandbutton within w_dberror_event
int X=1650
int Y=276
int Width=306
int Height=100
int TabOrder=60
string Text="&Update"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_update
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Update the DataWindow.
// If the Update function fails (return code of -1), the dberror event of the DataWindow will be triggered.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if dw_1.Update() = 1 then
	commit;
else
	rollback;
end if
end event

type cb_close from commandbutton within w_dberror_event
int X=1650
int Y=397
int Width=306
int Height=100
int TabOrder=70
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_close 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

close (parent)
end event

type cb_help from commandbutton within w_dberror_event
int X=1650
int Y=532
int Width=306
int Height=100
int TabOrder=50
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for cb_help
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Display help for this example
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

f_open_help (parent.ClassName())
end event

type dw_1 from datawindow within w_dberror_event
int X=50
int Y=433
int Width=1537
int Height=596
int TabOrder=30
string DataObject="d_departments"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event dberror;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// dberror script for dw_1
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Depending on which error message option is checked, display appropriate error message.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If custom error message is checked, then display an error message with the specific
// database error code and error message that occurred.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if rb_custom.checked then
	MessageBox ("Database Error", "Database Error Code:  " + String (sqldbcode) + &
						"~r~nDatabase Error Message:  " + sqlerrtext, exclamation!)
end if


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Setting the return code to 1 in the dberror event will stop PowerBuilder from displaying
// the default error message
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
if not rb_default.checked then
	return 1
end if

end event

type gb_1 from groupbox within w_dberror_event
int X=50
int Y=45
int Width=1540
int Height=337
int TabOrder=10
string Text="On dberror event, display:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

