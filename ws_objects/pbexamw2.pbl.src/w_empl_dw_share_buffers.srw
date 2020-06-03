$PBExportHeader$w_empl_dw_share_buffers.srw
$PBExportComments$Three DWs sharing one set of buffers
forward
global type w_empl_dw_share_buffers from w_center
end type
type tab_emp from tab within w_empl_dw_share_buffers
end type
type tabpage_employment from userobject within tab_emp
end type
type dw_emp from datawindow within tabpage_employment
end type
type tabpage_address from userobject within tab_emp
end type
type dw_addr from datawindow within tabpage_address
end type
type cb_close from commandbutton within w_empl_dw_share_buffers
end type
type cb_update from commandbutton within w_empl_dw_share_buffers
end type
type cb_retrieve from commandbutton within w_empl_dw_share_buffers
end type
type cb_next from commandbutton within w_empl_dw_share_buffers
end type
type cb_prior from commandbutton within w_empl_dw_share_buffers
end type
type dw_basic from datawindow within w_empl_dw_share_buffers
end type
type tabpage_employment from userobject within tab_emp
dw_emp dw_emp
end type
type tabpage_address from userobject within tab_emp
dw_addr dw_addr
end type
type tab_emp from tab within w_empl_dw_share_buffers
tabpage_employment tabpage_employment
tabpage_address tabpage_address
end type
end forward

global type w_empl_dw_share_buffers from w_center
int X=398
int Y=48
int Width=2135
int Height=1768
boolean TitleBar=true
string Title="Shared DataWindow Buffers"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
tab_emp tab_emp
cb_close cb_close
cb_update cb_update
cb_retrieve cb_retrieve
cb_next cb_next
cb_prior cb_prior
dw_basic dw_basic
end type
global w_empl_dw_share_buffers w_empl_dw_share_buffers

type variables
long   ii_row, ii_num_of_rows
int     ii_window_height
end variables

event open;call super::open;// Open script for w_empl_dw_share_buffers
integer li_ret

DataWindowChild	dwc

/****************************************************************
	Set Transaction Object ONLY for the primary DataWindow
 ***************************************************************/
dw_basic.SetTransObject (sqlca)

/****************************************************************
	Since the secondary DataWindows do not retrieve their
	DropDownDataWindows, do that now
 ***************************************************************/
tab_emp.tabpage_employment.dw_emp.GetChild ("dept_id", dwc)
dwc.SetTransObject (sqlca)
dwc.Retrieve ()

tab_emp.tabpage_address.dw_addr.GetChild ("state", dwc)
dwc.SetTransObject (sqlca)
dwc.Retrieve ()

//  get original size of window
ii_window_height = this.height

// Share the optional datawindows
li_ret = dw_basic.ShareData (tab_emp.tabpage_address.dw_addr)
if li_ret <> 1 then messagebox("Sharedata error","Error Sharing to address DW",exclamation!)

li_ret = dw_basic.ShareData (tab_emp.tabpage_employment.dw_emp)
if li_ret <> 1 then messagebox("Sharedata error","Error Sharing employment DW",exclamation!)

/****************************************************************
	Now, go retrieve data in the primary DataWindow
 ***************************************************************/
cb_retrieve.TriggerEvent (clicked!)

end event

on w_empl_dw_share_buffers.create
this.tab_emp=create tab_emp
this.cb_close=create cb_close
this.cb_update=create cb_update
this.cb_retrieve=create cb_retrieve
this.cb_next=create cb_next
this.cb_prior=create cb_prior
this.dw_basic=create dw_basic
this.Control[]={this.tab_emp,&
this.cb_close,&
this.cb_update,&
this.cb_retrieve,&
this.cb_next,&
this.cb_prior,&
this.dw_basic}
end on

on w_empl_dw_share_buffers.destroy
destroy(this.tab_emp)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.cb_retrieve)
destroy(this.cb_next)
destroy(this.cb_prior)
destroy(this.dw_basic)
end on

on close;// Close script for w_empl_dw_share_buffers
w_main.Show ()

close(this)
end on

type tab_emp from tab within w_empl_dw_share_buffers
event create ( )
event destroy ( )
int X=55
int Y=528
int Width=2007
int Height=1092
int TabOrder=20
boolean ShowPicture=false
boolean RaggedRight=true
int SelectedTab=1
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
tabpage_employment tabpage_employment
tabpage_address tabpage_address
end type

on tab_emp.create
this.tabpage_employment=create tabpage_employment
this.tabpage_address=create tabpage_address
this.Control[]={this.tabpage_employment,&
this.tabpage_address}
end on

on tab_emp.destroy
destroy(this.tabpage_employment)
destroy(this.tabpage_address)
end on

type tabpage_employment from userobject within tab_emp
event create ( )
event destroy ( )
int X=18
int Y=100
int Width=1970
int Height=976
long BackColor=74481808
string Text="Employment"
long TabBackColor=74481808
long TabTextColor=41943040
long PictureMaskColor=536870912
dw_emp dw_emp
end type

on tabpage_employment.create
this.dw_emp=create dw_emp
this.Control[]={this.dw_emp}
end on

on tabpage_employment.destroy
destroy(this.dw_emp)
end on

type dw_emp from datawindow within tabpage_employment
int Y=56
int Width=1925
int Height=936
int TabOrder=41
string DataObject="d_empl_employment_data"
boolean Border=false
boolean LiveScroll=true
end type

type tabpage_address from userobject within tab_emp
event create ( )
event destroy ( )
int X=18
int Y=100
int Width=1970
int Height=976
long BackColor=74481808
string Text="Address"
long TabBackColor=74481808
long TabTextColor=41943040
long PictureMaskColor=536870912
dw_addr dw_addr
end type

on tabpage_address.create
this.dw_addr=create dw_addr
this.Control[]={this.dw_addr}
end on

on tabpage_address.destroy
destroy(this.dw_addr)
end on

type dw_addr from datawindow within tabpage_address
int X=9
int Y=48
int Width=1929
int Height=472
int TabOrder=60
string DataObject="d_empl_address_data"
boolean Border=false
boolean LiveScroll=true
end type

type cb_close from commandbutton within w_empl_dw_share_buffers
int X=1577
int Y=388
int Width=489
int Height=88
int TabOrder=70
string Text="Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Clicked script for cb_close

Close (Parent)

end event

type cb_update from commandbutton within w_empl_dw_share_buffers
int X=1577
int Y=284
int Width=489
int Height=88
int TabOrder=60
string Text="Update"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Clicked script for cb_update
int	li_rtn

li_rtn = dw_basic.Update ()

//check condition status of the update
//commit if ok .. Using Settransobject...
If li_rtn = 1 then
	COMMIT using SQLCA ;
else
	ROLLBACK using SQLCA ;
end if 

end event

type cb_retrieve from commandbutton within w_empl_dw_share_buffers
int X=1577
int Y=184
int Width=489
int Height=88
int TabOrder=50
string Text="Retrieve"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Clicked script for CB_RETRIEVE
//reload primary datawindow
ii_num_of_rows = dw_basic.Retrieve ()
ii_row = 1

end event

type cb_next from commandbutton within w_empl_dw_share_buffers
int X=1723
int Y=60
int Width=338
int Height=88
int TabOrder=40
string Text="Next"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Clicked script for CB_NEXT
// scroll all datawindows to next row
If ii_row < ii_num_of_rows Then
	ii_row = ii_row + 1
	dw_basic.ScrollToRow (ii_row)
	tab_emp.tabpage_address.dw_addr.ScrollToRow (ii_row)
	tab_emp.tabpage_employment.dw_emp.ScrollToRow (ii_row)
Else
	Beep (1)
End If


end event

type cb_prior from commandbutton within w_empl_dw_share_buffers
int X=1362
int Y=60
int Width=338
int Height=88
int TabOrder=30
string Text="Prior"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;// Clicked script for cb_prior
// scroll all datawindows to prior row
If ii_row > 1 Then
	ii_row = ii_row - 1
	dw_basic.ScrollToRow (ii_row)
	tab_emp.tabpage_address.dw_addr.ScrollToRow (ii_row)
	tab_emp.tabpage_employment.dw_emp.ScrollToRow (ii_row)
Else
	Beep (1)
End If

end event

type dw_basic from datawindow within w_empl_dw_share_buffers
int X=78
int Y=12
int Width=1193
int Height=516
int TabOrder=10
string DataObject="d_empl_basic_data"
boolean Border=false
boolean LiveScroll=true
end type

