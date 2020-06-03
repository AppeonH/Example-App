$PBExportHeader$w_master_dddw.srw
$PBExportComments$Window containing DataWindows that can be shared as DropDownDataWindows on other windows.
forward
global type w_master_dddw from w_center
end type
type st_3 from statictext within w_master_dddw
end type
type st_2 from statictext within w_master_dddw
end type
type st_1 from statictext within w_master_dddw
end type
type dw_fin_codes from datawindow within w_master_dddw
end type
type dw_sales_reps from datawindow within w_master_dddw
end type
type dw_customers from datawindow within w_master_dddw
end type
end forward

global type w_master_dddw from w_center
int X=804
int Y=497
int Width=1277
int Height=1402
boolean TitleBar=true
string Title="Primary DropDownDataWindows"
long BackColor=74481808
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowState WindowState=minimized!
WindowType WindowType=popup!
event ue_open pbm_custom01
st_3 st_3
st_2 st_2
st_1 st_1
dw_fin_codes dw_fin_codes
dw_sales_reps dw_sales_reps
dw_customers dw_customers
end type
global w_master_dddw w_master_dddw

event ue_open;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_open script for w_shared_dddw
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Purpose:
// 	Retrieve DataWindows.  These DataWindows will serve as the primary DataWindows for
//	the DropDownDataWindows on the w_shared_dddw window. 
//	(If this technique was used in an application, this window would be hidden from the user.)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Set the transaction objects
dw_customers.SetTransObject (sqlca)
dw_sales_reps.SetTransObject (sqlca)
dw_fin_codes.SetTransObject (sqlca)

// Retrieve the datawindows
dw_customers.Retrieve()
dw_sales_reps.Retrieve()
dw_fin_codes.Retrieve()



end event

on w_master_dddw.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_fin_codes=create dw_fin_codes
this.dw_sales_reps=create dw_sales_reps
this.dw_customers=create dw_customers
this.Control[]={ this.st_3,&
this.st_2,&
this.st_1,&
this.dw_fin_codes,&
this.dw_sales_reps,&
this.dw_customers}
end on

on w_master_dddw.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_fin_codes)
destroy(this.dw_sales_reps)
destroy(this.dw_customers)
end on

event open;call super::open;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_master_dddw
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Post open event to speed up opening of window
this.PostEvent ("ue_open")
end event

type st_3 from statictext within w_master_dddw
int X=50
int Y=865
int Width=427
int Height=71
boolean Enabled=false
string Text="Financial Codes:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_master_dddw
int X=50
int Y=445
int Width=310
int Height=71
boolean Enabled=false
string Text="Sales Reps:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_master_dddw
int X=50
int Y=17
int Width=313
int Height=71
boolean Enabled=false
string Text="Customers:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_fin_codes from datawindow within w_master_dddw
int X=50
int Y=941
int Width=1149
int Height=324
string DataObject="d_dddw_fin_code"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_sales_reps from datawindow within w_master_dddw
int X=50
int Y=519
int Width=1149
int Height=324
string DataObject="d_dddw_sales_reps"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_customers from datawindow within w_master_dddw
int X=50
int Y=93
int Width=1149
int Height=324
string DataObject="d_cust_id"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

