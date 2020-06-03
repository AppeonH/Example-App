$PBExportHeader$w_dynamic_uo_table_list.srw
$PBExportComments$MDI Sheet to define the datawindow that will be used in the Dynamic User Object Example.
forward
global type w_dynamic_uo_table_list from w_center
end type
type rb_free from radiobutton within w_dynamic_uo_table_list
end type
type rb_tabular from radiobutton within w_dynamic_uo_table_list
end type
type rb_grid from radiobutton within w_dynamic_uo_table_list
end type
type cb_cancel from commandbutton within w_dynamic_uo_table_list
end type
type mle_dscrption from multilineedit within w_dynamic_uo_table_list
end type
type cb_ok from commandbutton within w_dynamic_uo_table_list
end type
type dw_tbls_lst from datawindow within w_dynamic_uo_table_list
end type
type gb_1 from groupbox within w_dynamic_uo_table_list
end type
end forward

global type w_dynamic_uo_table_list from w_center
int X=644
int Y=327
int Width=1629
int Height=1274
boolean TitleBar=true
string Title="Tables List"
long BackColor=74481808
boolean ControlMenu=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
WindowType WindowType=response!
rb_free rb_free
rb_tabular rb_tabular
rb_grid rb_grid
cb_cancel cb_cancel
mle_dscrption mle_dscrption
cb_ok cb_ok
dw_tbls_lst dw_tbls_lst
gb_1 gb_1
end type
global w_dynamic_uo_table_list w_dynamic_uo_table_list

type variables
string is_table,is_style
end variables

on open;
	dw_tbls_lst.settransobject(sqlca)
	dw_tbls_lst.retrieve()

//************************************************************************
//			The first Radio Button in the Group box of DataWindow type will
//			be automatically checked.  If the user does not mouse click on 
//			any radio button the following line of code will make the 
//			DataWindow come up in a Grid Style, otherwise it would default 
//			to tabular and confuse the user.
//************************************************************************
rb_grid.postevent(clicked!)


end on

on w_dynamic_uo_table_list.create
this.rb_free=create rb_free
this.rb_tabular=create rb_tabular
this.rb_grid=create rb_grid
this.cb_cancel=create cb_cancel
this.mle_dscrption=create mle_dscrption
this.cb_ok=create cb_ok
this.dw_tbls_lst=create dw_tbls_lst
this.gb_1=create gb_1
this.Control[]={ this.rb_free,&
this.rb_tabular,&
this.rb_grid,&
this.cb_cancel,&
this.mle_dscrption,&
this.cb_ok,&
this.dw_tbls_lst,&
this.gb_1}
end on

on w_dynamic_uo_table_list.destroy
destroy(this.rb_free)
destroy(this.rb_tabular)
destroy(this.rb_grid)
destroy(this.cb_cancel)
destroy(this.mle_dscrption)
destroy(this.cb_ok)
destroy(this.dw_tbls_lst)
destroy(this.gb_1)
end on

type rb_free from radiobutton within w_dynamic_uo_table_list
int X=900
int Y=865
int Width=395
int Height=68
int TabOrder=50
string Text="Free Form"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
	IF this.checked THEN is_style	=	"form"
end on

type rb_tabular from radiobutton within w_dynamic_uo_table_list
int X=552
int Y=865
int Width=281
int Height=68
int TabOrder=40
string Text="Tabular"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;
	IF this.checked THEN is_style	=	"tabular"

end on

type rb_grid from radiobutton within w_dynamic_uo_table_list
int X=278
int Y=865
int Width=210
int Height=68
int TabOrder=30
string Text="Grid"
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

on clicked;
	if this.checked then is_style	=	"grid"
end on

type cb_cancel from commandbutton within w_dynamic_uo_table_list
int X=811
int Y=1028
int Width=289
int Height=97
int TabOrder=70
string Text="&Cancel"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// pass back an empty string since the user did not select a table
	closewithreturn(parent,'')
end on

type mle_dscrption from multilineedit within w_dynamic_uo_table_list
int X=54
int Y=20
int Width=1480
int Height=196
boolean Border=false
boolean DisplayOnly=true
string Text="To create a DataWindow, select a table name from the table list, Select a DataWindow style, and then click OK . Or to accept the defaults just DoubleClick the table name."
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_ok from commandbutton within w_dynamic_uo_table_list
int X=484
int Y=1028
int Width=289
int Height=97
int TabOrder=60
boolean Enabled=false
string Text="&OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;	Closewithreturn(parent,is_table+'|'+is_style)

end on

type dw_tbls_lst from datawindow within w_dynamic_uo_table_list
int X=466
int Y=301
int Width=651
int Height=397
int TabOrder=10
string DataObject="d_table_list"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;/////////////////////////////////////////////////////////////////////////////////////////////
// Clicked script for dw_tbls_lst
/////////////////////////////////////////////////////////////////////////////////////////////

If row > 0 Then
	//get the table name
	is_table = this.object.data[row, 1]

	//highlight the clicked row
	this.selectrow(0, FALSE)
	this.selectrow(row,TRUE)
	
	//the OK button is now available
	cb_ok.enabled = true
End If

end event

event doubleclicked;/////////////////////////////////////////////////////////////////////////////////////////////
// DoubleClicked script for dw_tbls_lst
/////////////////////////////////////////////////////////////////////////////////////////////

if row > 0 then
	//get the table name
	is_table = this.object.data[row, 1]
		
	//the OK button is now available
	cb_ok.enabled = true
	
	//complete processing by executing the clicked event
	cb_ok.postevent(clicked!)
end if
end event

type gb_1 from groupbox within w_dynamic_uo_table_list
int X=217
int Y=788
int Width=1156
int Height=180
int TabOrder=20
string Text="Style"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

