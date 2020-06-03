$PBExportHeader$w_retrieve_asneeded.srw
$PBExportComments$Compares performance times of retrieve vs. retrieve as needed using aggregate functions.
forward
global type w_retrieve_asneeded from w_center
end type
type st_8 from statictext within w_retrieve_asneeded
end type
type st_7 from statictext within w_retrieve_asneeded
end type
type st_elapsed2 from statictext within w_retrieve_asneeded
end type
type st_elapsed1 from statictext within w_retrieve_asneeded
end type
type st_4 from statictext within w_retrieve_asneeded
end type
type st_3 from statictext within w_retrieve_asneeded
end type
type st_2 from statictext within w_retrieve_asneeded
end type
type st_1 from statictext within w_retrieve_asneeded
end type
type cb_help from commandbutton within w_retrieve_asneeded
end type
type cb_close from commandbutton within w_retrieve_asneeded
end type
type cb_retrieve2 from commandbutton within w_retrieve_asneeded
end type
type cb_retrieve1 from commandbutton within w_retrieve_asneeded
end type
type dw_retrieve_asneeded from datawindow within w_retrieve_asneeded
end type
type dw_retrieve from datawindow within w_retrieve_asneeded
end type
end forward

global type w_retrieve_asneeded from w_center
int X=577
int Y=7
int Width=1785
int Height=1921
boolean TitleBar=true
string Title="Retrieve as Needed with Aggregate Functions"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_8 st_8
st_7 st_7
st_elapsed2 st_elapsed2
st_elapsed1 st_elapsed1
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_help cb_help
cb_close cb_close
cb_retrieve2 cb_retrieve2
cb_retrieve1 cb_retrieve1
dw_retrieve_asneeded dw_retrieve_asneeded
dw_retrieve dw_retrieve
end type
global w_retrieve_asneeded w_retrieve_asneeded

type variables
transaction   itr_trans
end variables

event open;call super::open;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_retrieve_asneeded
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Create a transaction object for the Retrieve as Needed DataWindow.  Use the same values
// for the transaction object that SQLCA has.
itr_trans = create transaction

itr_trans.DBMS = sqlca.DBMS
itr_trans.database = sqlca.database
itr_trans.dbparm = sqlca.dbparm
itr_trans.userid = sqlca.userid
itr_trans.dbpass = sqlca.dbpass
itr_trans.logid = sqlca.logid
itr_trans.logpass = sqlca.logpass
itr_trans.servername = sqlca.servername

connect using itr_trans;

if itr_trans.SQLCode = -1 then
	MessageBox ("Error", "Connect failed", exclamation!)
	cb_retrieve2.enabled = false
end if

// Set the transaction objects for the DataWindows
dw_retrieve_asneeded.SetTransObject (itr_trans)
dw_retrieve.SetTransObject (sqlca)


end event

event close;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_retrieve_asneeded
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Disconnect the instance transaction from the database.
disconnect using itr_trans;

// Destroy the instance transaction.
destroy itr_trans

// Show the main window
w_main.Show()

end event

on w_retrieve_asneeded.create
this.st_8=create st_8
this.st_7=create st_7
this.st_elapsed2=create st_elapsed2
this.st_elapsed1=create st_elapsed1
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_help=create cb_help
this.cb_close=create cb_close
this.cb_retrieve2=create cb_retrieve2
this.cb_retrieve1=create cb_retrieve1
this.dw_retrieve_asneeded=create dw_retrieve_asneeded
this.dw_retrieve=create dw_retrieve
this.Control[]={ this.st_8,&
this.st_7,&
this.st_elapsed2,&
this.st_elapsed1,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_help,&
this.cb_close,&
this.cb_retrieve2,&
this.cb_retrieve1,&
this.dw_retrieve_asneeded,&
this.dw_retrieve}
end on

on w_retrieve_asneeded.destroy
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_elapsed2)
destroy(this.st_elapsed1)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.cb_retrieve2)
destroy(this.cb_retrieve1)
destroy(this.dw_retrieve_asneeded)
destroy(this.dw_retrieve)
end on

type st_8 from statictext within w_retrieve_asneeded
int X=1483
int Y=1188
int Width=136
int Height=71
boolean Enabled=false
string Text="sec."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_7 from statictext within w_retrieve_asneeded
int X=1480
int Y=365
int Width=136
int Height=71
boolean Enabled=false
string Text="sec."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_elapsed2 from statictext within w_retrieve_asneeded
int X=1259
int Y=1188
int Width=203
int Height=71
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_elapsed1 from statictext within w_retrieve_asneeded
int X=1259
int Y=365
int Width=203
int Height=71
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_retrieve_asneeded
int X=1259
int Y=1111
int Width=385
int Height=71
boolean Enabled=false
string Text="Retrieve Time:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_retrieve_asneeded
int X=1259
int Y=289
int Width=385
int Height=71
boolean Enabled=false
string Text="Retrieve Time:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_retrieve_asneeded
int X=89
int Y=881
int Width=1028
int Height=71
boolean Enabled=false
string Text="DataWindow using Retrieve as Needed:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_retrieve_asneeded
int X=89
int Y=55
int Width=1153
int Height=71
boolean Enabled=false
string Text="DataWindow NOT using Retrieve as Needed:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_help from commandbutton within w_retrieve_asneeded
int X=889
int Y=1681
int Width=278
int Height=100
int TabOrder=40
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_help
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


f_open_help (parent.ClassName())
end event

type cb_close from commandbutton within w_retrieve_asneeded
int X=548
int Y=1681
int Width=278
int Height=100
int TabOrder=50
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_close
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


close (parent)
end event

type cb_retrieve2 from commandbutton within w_retrieve_asneeded
int X=1259
int Y=977
int Width=278
int Height=100
int TabOrder=30
string Text="R&etrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_retrieve2
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Retrieve the DataWindow that USES Retrieve as Needed
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_start, &
		ll_used, &
		ll_count

//Start tracking time
st_elapsed2.text = "0"
ll_start = CPU()

//Perform data retrieve
	// Because Retrieve as Needed will be overriden when aggregate functions are used, we need
	// to use embedded SQL to retrieve any aggregate values that are needed.
select count(*)
into :ll_count
from sales_order;
	// Retrieve the datawindow
dw_retrieve_asneeded.Retrieve()

//Display the total number of rows that can be retrieved.
dw_retrieve_asneeded.Object.count_t.text = String (ll_count)

//Stop tracking time
ll_used = CPU() - ll_start

//Report tracked time
st_elapsed2.text = String (ll_used / 1000, "#,##0.000")
end event

type cb_retrieve1 from commandbutton within w_retrieve_asneeded
int X=1259
int Y=151
int Width=278
int Height=100
int TabOrder=20
string Text="&Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_retrieve1
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Retrieve the DataWindow that does NOT use Retrieve as Needed, calculating elapsed time
// with the CPU function.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_start, &
		ll_used


//Start tracking time
st_elapsed1.text = "0"
ll_start = CPU()

//Perform data retrieve
dw_retrieve.Retrieve()

//Stop tracking time
ll_used = CPU() - ll_start

//Report on tracked time
st_elapsed1.text = String (ll_used / 1000, "#,##0.000")
end event

type dw_retrieve_asneeded from datawindow within w_retrieve_asneeded
int X=89
int Y=961
int Width=1064
int Height=637
int TabOrder=60
string DataObject="d_sales_asneeded"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_retrieve from datawindow within w_retrieve_asneeded
int X=89
int Y=135
int Width=1064
int Height=637
int TabOrder=10
string DataObject="d_sales"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

