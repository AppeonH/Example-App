$PBExportHeader$w_show_retrieve_arg.srw
$PBExportComments$Allows user to specify retrieval arguments and retrieve a DataWindow.  The DataWindow shows their retrieval arguments that they entered.
forward
global type w_show_retrieve_arg from w_center
end type
type cb_close from commandbutton within w_show_retrieve_arg
end type
type cb_retrieve from commandbutton within w_show_retrieve_arg
end type
type em_end_date from editmask within w_show_retrieve_arg
end type
type em_start_date from editmask within w_show_retrieve_arg
end type
type st_4 from statictext within w_show_retrieve_arg
end type
type st_3 from statictext within w_show_retrieve_arg
end type
type st_2 from statictext within w_show_retrieve_arg
end type
type ddlb_customer from dropdownlistbox within w_show_retrieve_arg
end type
type st_1 from statictext within w_show_retrieve_arg
end type
type dw_1 from datawindow within w_show_retrieve_arg
end type
end forward

global type w_show_retrieve_arg from w_center
int X=168
int Y=23
int Width=2593
int Height=1869
boolean TitleBar=true
string Title="Referencing Retrieval Arguments in a DataWindow"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_open pbm_custom01
cb_close cb_close
cb_retrieve cb_retrieve
em_end_date em_end_date
em_start_date em_start_date
st_4 st_4
st_3 st_3
st_2 st_2
ddlb_customer ddlb_customer
st_1 st_1
dw_1 dw_1
end type
global w_show_retrieve_arg w_show_retrieve_arg

on ue_open;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Load the ddlb with customer names from the customer table.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string	ls_select, ls_lname,ls_fname,ls_add


dw_1.SetTransObject (sqlca)
dw_1.InsertRow (0)

em_start_date.text = "01/01/" + String (Year (Today()))
em_end_date.text = String (Today())

declare lcur_cust cursor for
  SELECT distinct fname,lname 
    FROM customer,   
         sales_order  
   WHERE ( customer.id = sales_order.cust_id )   ;
open lcur_cust;

if sqlca.sqlcode < 0 then
	MessageBox ("DataBase Error!", sqlca.sqlerrtext, exclamation!)
	return
end if 

ddlb_customer.SetRedraw(false)

do while sqlca.sqlcode = 0
	fetch lcur_cust into :ls_lname,:ls_fname;
	if sqlca.sqlcode = 0 then
		ls_add = ls_lname + ', '+ls_fname
		ddlb_customer.AddItem (ls_add)
	elseif sqlca.sqlcode < 0 then
		MessageBox ("DataBase Error", sqlca.sqlerrtext, exclamation!)
		return
	else
		exit
	end if
loop

ddlb_customer.SetRedraw(true)
close lcur_cust;

end on

on close;w_main.Show()
end on

on open;this.PostEvent ("ue_open")


end on

on w_show_retrieve_arg.create
this.cb_close=create cb_close
this.cb_retrieve=create cb_retrieve
this.em_end_date=create em_end_date
this.em_start_date=create em_start_date
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.ddlb_customer=create ddlb_customer
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={ this.cb_close,&
this.cb_retrieve,&
this.em_end_date,&
this.em_start_date,&
this.st_4,&
this.st_3,&
this.st_2,&
this.ddlb_customer,&
this.st_1,&
this.dw_1}
end on

on w_show_retrieve_arg.destroy
destroy(this.cb_close)
destroy(this.cb_retrieve)
destroy(this.em_end_date)
destroy(this.em_start_date)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.ddlb_customer)
destroy(this.st_1)
destroy(this.dw_1)
end on

type cb_close from commandbutton within w_show_retrieve_arg
int X=2184
int Y=167
int Width=278
int Height=109
int TabOrder=50
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;close (parent)
end on

type cb_retrieve from commandbutton within w_show_retrieve_arg
int X=2184
int Y=39
int Width=278
int Height=109
int TabOrder=40
string Text="Retrieve"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Verify that the customer name retrieval argument has been entered, and then retrieve the
// DataWindow with arguments the user entered.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

date	ld_start, &
		ld_end
integer posi
string lname,fname


if Len (ddlb_customer.text) = 0 then
	MessageBox ("Required Field", "Please specify a value for the Customer Name retrieval argument.")
else
	em_start_date.GetData (ld_start)
	em_end_date.GetData (ld_end)
	posi = pos(ddlb_customer.text,',')
	lname = trim(left(ddlb_customer.text,posi -1))
	fname = trim(mid(ddlb_customer.text,posi +1))
	dw_1.Retrieve (ld_start, ld_end,fname,lname)
end if
end on

type em_end_date from editmask within w_show_retrieve_arg
int X=808
int Y=388
int Width=264
int Height=93
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
string Text="01/01/94"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_start_date from editmask within w_show_retrieve_arg
int X=808
int Y=276
int Width=264
int Height=93
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
string Mask="mm/dd/yy"
MaskDataType MaskDataType=DateMask!
string Text="01/01/94"
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_show_retrieve_arg
int X=43
int Y=20
int Width=1675
int Height=71
boolean Enabled=false
string Text="Please enter the retrieval arguments for the DataWindow below."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_show_retrieve_arg
int X=100
int Y=397
int Width=683
int Height=71
boolean Enabled=false
string Text="Sales Order End Date:"
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

type st_2 from statictext within w_show_retrieve_arg
int X=68
int Y=285
int Width=715
int Height=71
boolean Enabled=false
string Text="Sales Order Start Date:"
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

type ddlb_customer from dropdownlistbox within w_show_retrieve_arg
int X=808
int Y=167
int Width=712
int Height=388
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_show_retrieve_arg
int X=260
int Y=173
int Width=523
int Height=71
boolean Enabled=false
string Text="Customer Name:"
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

type dw_1 from datawindow within w_show_retrieve_arg
int X=75
int Y=535
int Width=2411
int Height=1156
int TabOrder=60
string DataObject="d_sales_orders_args"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

