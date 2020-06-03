$PBExportHeader$w_select_from_list.srw
$PBExportComments$UO:  Find closest entry in list as user enters search string
forward
global type w_select_from_list from w_center
end type
type uo_1 from u_selection_list within w_select_from_list
end type
type st_return from statictext within w_select_from_list
end type
type st_2 from statictext within w_select_from_list
end type
type st_1 from statictext within w_select_from_list
end type
type rb_states from radiobutton within w_select_from_list
end type
type rb_customer from radiobutton within w_select_from_list
end type
type cb_close from commandbutton within w_select_from_list
end type
type gb_1 from groupbox within w_select_from_list
end type
end forward

global type w_select_from_list from w_center
int X=469
int Y=213
int Width=1985
int Height=1517
boolean TitleBar=true
string Title="Quick Search"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
uo_1 uo_1
st_return st_return
st_2 st_2
st_1 st_1
rb_states rb_states
rb_customer rb_customer
cb_close cb_close
gb_1 gb_1
end type
global w_select_from_list w_select_from_list

event open;call super::open;sqlca.AutoCommit = True

rb_customer.Triggerevent("clicked")
end event

event close;// Close script for w_select_from_list

sqlca.AutoCommit = False

w_main.Show( )
end event

on w_select_from_list.create
this.uo_1=create uo_1
this.st_return=create st_return
this.st_2=create st_2
this.st_1=create st_1
this.rb_states=create rb_states
this.rb_customer=create rb_customer
this.cb_close=create cb_close
this.gb_1=create gb_1
this.Control[]={ this.uo_1,&
this.st_return,&
this.st_2,&
this.st_1,&
this.rb_states,&
this.rb_customer,&
this.cb_close,&
this.gb_1}
end on

on w_select_from_list.destroy
destroy(this.uo_1)
destroy(this.st_return)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.rb_states)
destroy(this.rb_customer)
destroy(this.cb_close)
destroy(this.gb_1)
end on

type uo_1 from u_selection_list within w_select_from_list
int X=9
int Y=101
end type

on ue_entry_chosen;call u_selection_list::ue_entry_chosen;// Entry_Chosen Script for UO_1

string	ls_selected_value

ls_selected_value = return_selected ()

if Len (ls_selected_value) = 0  then  ls_selected_value = "Nothing"

st_return.text =  ls_selected_value
end on

on uo_1.destroy
call u_selection_list::destroy
end on

type st_return from statictext within w_select_from_list
int X=1349
int Y=1061
int Width=553
int Height=85
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_select_from_list
int X=33
int Y=13
int Width=1233
int Height=69
boolean Enabled=false
string Text="General-purpose Select-from-a-list User Object"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_select_from_list
int X=1329
int Y=997
int Width=585
int Height=69
boolean Enabled=false
string Text="User Object Returned:"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_states from radiobutton within w_select_from_list
int X=1441
int Y=193
int Width=249
int Height=69
string Text="States"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Clicked script for cb_search_parts

uo_1.create_datawindow(sqlca, &
	"SELECT state_name FROM states")



end on

type rb_customer from radiobutton within w_select_from_list
int X=1441
int Y=117
int Width=417
int Height=69
string Text="Customer"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=41943040
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;// Clicked script for cb_search_emps
CHOOSE CASE Lower(Left(sqlca.dbms,2))
	CASE "sy"
		uo_1.create_datawindow(sqlca, &
			"Select  ~"Customer Name~" = (lname + ', ' +  fname) from customer")
	CASE "or"
		uo_1.create_datawindow(sqlca, &
			"Select  (lname || ', ' ||  fname) ~"Customer Name~" from customer")
	CASE ELSE 
		uo_1.create_datawindow(sqlca, &
			"Select string(lname,', ', fname) ~"Customer Name~" from customer")
END CHOOSE

end on

type cb_close from commandbutton within w_select_from_list
int X=1525
int Y=389
int Width=309
int Height=97
int TabOrder=10
string Text="&Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;//Clicked script for cb_1

Close(parent)
end on

type gb_1 from groupbox within w_select_from_list
int X=1413
int Y=53
int Width=481
int Height=261
int TabOrder=20
string Text="Example Tables"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

