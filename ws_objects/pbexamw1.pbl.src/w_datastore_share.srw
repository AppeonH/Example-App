$PBExportHeader$w_datastore_share.srw
$PBExportComments$Window showing a DataWindow sharing data with DataStores
forward
global type w_datastore_share from w_center
end type
type mle_inst from multilineedit within w_datastore_share
end type
type rb_4 from radiobutton within w_datastore_share
end type
type rb_3 from radiobutton within w_datastore_share
end type
type rb_2 from radiobutton within w_datastore_share
end type
type rb_1 from radiobutton within w_datastore_share
end type
type cb_help from commandbutton within w_datastore_share
end type
type cb_close from commandbutton within w_datastore_share
end type
type dw_1 from datawindow within w_datastore_share
end type
type gb_1 from groupbox within w_datastore_share
end type
end forward

global type w_datastore_share from w_center
int X=4
int Y=65
int Width=2962
int Height=1418
boolean TitleBar=true
string Title="Share Data With DataStores"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_postopen ( )
mle_inst mle_inst
rb_4 rb_4
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_help cb_help
cb_close cb_close
dw_1 dw_1
gb_1 gb_1
end type
global w_datastore_share w_datastore_share

type variables
DataStore	ids_1, ids_2, ids_3, ids_4
end variables

event ue_postopen;SetPointer(HourGlass!)

ids_1.SetTransObject(sqlca)
ids_1.Retrieve()
ids_2.SetTransObject(sqlca)
ids_2.Retrieve()
ids_3.SetTransObject(sqlca)
ids_3.Retrieve()
ids_4.SetTransObject(sqlca)
ids_4.Retrieve()

mle_inst.Visible = False

end event

event open;call super::open;ids_1 = Create DataStore
ids_2 = Create DataStore
ids_3 = Create DataStore
ids_4 = Create DataStore

ids_1.DataObject = "d_compute_in_attribute"
ids_2.DataObject = "d_contact_list_protected"
ids_3.DataObject = "d_empl_employment_data"
ids_4.DataObject = "d_employees_by_dept"

Post Event ue_postopen()

end event

event close;Destroy ids_1
Destroy ids_2
Destroy ids_3
Destroy ids_4

Show(w_main)

end event

on w_datastore_share.create
this.mle_inst=create mle_inst
this.rb_4=create rb_4
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_help=create cb_help
this.cb_close=create cb_close
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={ this.mle_inst,&
this.rb_4,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_help,&
this.cb_close,&
this.dw_1,&
this.gb_1}
end on

on w_datastore_share.destroy
destroy(this.mle_inst)
destroy(this.rb_4)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type mle_inst from multilineedit within w_datastore_share
int X=811
int Y=439
int Width=790
int Height=148
int TabOrder=30
BorderStyle BorderStyle=StyleRaised!
boolean DisplayOnly=true
string Text="Retrieving data into DataStores, please wait..."
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_4 from radiobutton within w_datastore_share
event clicked pbm_bnclicked
int X=2194
int Y=321
int Width=630
int Height=65
string Text="d_employees_by_dept"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.DataObject = ids_4.DataObject

ids_4.ShareData(dw_1)
dw_1.HScrollBar = True

end event

type rb_3 from radiobutton within w_datastore_share
event clicked pbm_bnclicked
int X=2194
int Y=241
int Width=673
int Height=65
string Text="d_empl_employment_data"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;DataWindowChild	ldwc_Target, ldwc_Source

dw_1.DataObject = ids_3.DataObject

ids_3.ShareData(dw_1)
dw_1.HScrollBar = False

// Share the DropDownDataWindow
ids_3.GetChild("dept_id", ldwc_Source)
dw_1.GetChild("dept_id", ldwc_Target)

ldwc_Source.ShareData(ldwc_Target)

end event

type rb_2 from radiobutton within w_datastore_share
event clicked pbm_bnclicked
int X=2194
int Y=164
int Width=626
int Height=65
string Text="d_contact_list_protected"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.DataObject = ids_2.DataObject

ids_2.ShareData(dw_1)
dw_1.HScrollBar = True

end event

type rb_1 from radiobutton within w_datastore_share
int X=2194
int Y=87
int Width=594
int Height=65
string Text="d_compute_in_attribute"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.DataObject = ids_1.DataObject

ids_1.ShareData(dw_1)
dw_1.HScrollBar = True

end event

type cb_help from commandbutton within w_datastore_share
int X=2361
int Y=644
int Width=324
int Height=84
int TabOrder=50
string Text="&Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_datastore_share")

end event

type cb_close from commandbutton within w_datastore_share
int X=2361
int Y=500
int Width=324
int Height=84
int TabOrder=40
string Text="&Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type dw_1 from datawindow within w_datastore_share
int X=8
int Y=20
int Width=2137
int Height=1236
int TabOrder=10
boolean VScrollBar=true
boolean LiveScroll=true
end type

type gb_1 from groupbox within w_datastore_share
int X=2169
int Y=20
int Width=712
int Height=407
int TabOrder=20
string Text="DataStore"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

