$PBExportHeader$w_date_sort.srw
$PBExportComments$Window for Year 2000 sorting example
forward
global type w_date_sort from w_center
end type
type rb_2 from radiobutton within w_date_sort
end type
type rb_1 from radiobutton within w_date_sort
end type
type dw_1 from datawindow within w_date_sort
end type
type gb_1 from groupbox within w_date_sort
end type
end forward

global type w_date_sort from w_center
int X=5
int Y=8
int Width=2706
int Height=1612
boolean TitleBar=true
string Title="Date Sorting"
string MenuName="m_date_sort"
long BackColor=80242744
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
rb_2 rb_2
rb_1 rb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_date_sort w_date_sort

type variables

end variables

forward prototypes
public subroutine of_sort (string as_Column, string as_Order)
end prototypes

public subroutine of_sort (string as_Column, string as_Order);dw_1.SetSort(as_Column + " " + as_Order)
dw_1.Sort()

end subroutine

on w_date_sort.create
if this.MenuName = "m_date_sort" then this.MenuID = create m_date_sort
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={ this.rb_2,&
this.rb_1,&
this.dw_1,&
this.gb_1}
end on

on w_date_sort.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type rb_2 from radiobutton within w_date_sort
int X=882
int Y=64
int Width=471
int Height=76
string Text="Four-digit year"
boolean Checked=true
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_1.Object.start_date.Edit.Format="MM/DD/YYYY"
dw_1.Object.start_date.Format="MM/DD/YYYY"
dw_1.Object.vesting_date.Format="mm/dd/yyyy"
end event

type rb_1 from radiobutton within w_date_sort
int X=1422
int Y=64
int Width=453
int Height=76
string Text="Two-digit year"
long TextColor=33554432
long BackColor=80242744
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;
dw_1.Object.start_date.Edit.Format="mm/dd/yy"
dw_1.Object.start_date.Format="mm/dd/yy"
dw_1.Object.vesting_date.Format="mm/dd/yy"
end event

type dw_1 from datawindow within w_date_sort
int X=18
int Y=180
int Width=2638
int Height=1232
int TabOrder=20
string DataObject="d_date_dept"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type gb_1 from groupbox within w_date_sort
int X=800
int Y=4
int Width=1088
int Height=164
int TabOrder=10
string Text="Date Display Format:"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

