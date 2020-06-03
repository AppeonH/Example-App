$PBExportHeader$w_date_datawindow.srw
$PBExportComments$Window for Year 2000 DataWindow example
forward
global type w_date_datawindow from w_center
end type
type dw_1 from datawindow within w_date_datawindow
end type
end forward

global type w_date_datawindow from w_center
int X=9
int Y=4
int Width=1742
int Height=1484
boolean TitleBar=true
string Title="Date Entry DataWindow"
string MenuName="m_date_datawindow"
long BackColor=80242744
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
end type
global w_date_datawindow w_date_datawindow

type variables


end variables

forward prototypes
public subroutine of_insertrow ()
end prototypes

public subroutine of_insertrow ();Long		ll_Row

ll_Row = dw_1.InsertRow(0)
dw_1.Object.id[ll_Row] = ll_Row

dw_1.SetFocus()
dw_1.ScrollToRow(ll_Row)

end subroutine

on w_date_datawindow.create
if this.MenuName = "m_date_datawindow" then this.MenuID = create m_date_datawindow
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_date_datawindow.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_date_datawindow
int X=5
int Y=12
int Width=1664
int Height=1272
int TabOrder=10
string DataObject="d_date_datawindow"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

event itemerror;string date_error
date_error= "Please enter a valid date in this column"

dw_1.Object.date_4_digit_year.ValidationMsg =date_error
end event

