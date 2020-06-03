$PBExportHeader$w_nested_ancestor.srw
$PBExportComments$Ancestor sheet for Nested Reports example.
forward
global type w_nested_ancestor from w_center
end type
type dw_1 from datawindow within w_nested_ancestor
end type
end forward

global type w_nested_ancestor from w_center
int X=19
int Y=197
int Width=2899
int Height=1541
boolean TitleBar=true
string Title="Nested Reports Ancestor"
string MenuName="m_nest"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_print pbm_custom01
event ue_first pbm_custom02
event ue_prior pbm_custom03
event ue_next pbm_custom04
event ue_last pbm_custom05
event ue_rulers pbm_custom06
event ue_zoom_down pbm_custom07
event ue_zoom_up pbm_custom08
event ue_zoom pbm_custom09
dw_1 dw_1
end type
global w_nested_ancestor w_nested_ancestor

on ue_print;dw_1.Print()
end on

event ue_first;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Go to the first page of the report 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_row

dw_1.SetRedraw (false)

do 
	ll_row = dw_1.ScrollPriorPage()
loop until ll_row <= 1

dw_1.SetRedraw (true)

end event

event ue_prior;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Go to the prior page of the report 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Int i

i = dw_1.ScrollPriorPage()
i ++

end event

event ue_next;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Go to the next page of the report 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
Int i

i = dw_1.ScrollNextPage()
i ++
end event

on ue_last;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Go to the last page of the report 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long	ll_row, ll_prev_row

dw_1.SetRedraw (false)
do 
	ll_prev_row = ll_row
	ll_row = dw_1.ScrollNextPage()
loop until ll_row = ll_prev_row or ll_row <= 0
dw_1.SetRedraw (true)

end on

event ue_rulers;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Toggle the display of rulers on the datawindow.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

m_nest		lm_menu

lm_menu = this.menuid
if lm_menu.m_display.m_rulers.checked then
	dw_1.Object.DataWindow.print.preview.rulers = 'yes'
else
	dw_1.Object.DataWindow.print.preview.rulers = 'no'
end if
end event

event ue_zoom_down;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Zoom the display area of the datawindow down
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string		ls_factor
integer		li_factor
m_nest		lm_menu

// get the current zoom
ls_factor = dw_1.Object.DataWindow.print.preview.zoom
li_factor = integer (ls_factor)

// only zoom down if magnification is greater than 20%
if li_factor >=40 and li_factor <= 100 then
	li_factor = li_factor - 20
else
	// if magnification is currently 200%, zoom down to 100%
	if li_factor = 200 then
		li_factor = 100
	end if
end if

// set the new zoom level
dw_1.Object.DataWindow.print.preview.zoom = li_factor


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Check/uncheck the zoom menu items
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
lm_menu = this.menuid

lm_menu.m_display.m_zoom.m_20%.checked = false
lm_menu.m_display.m_zoom.m_40%.checked = false
lm_menu.m_display.m_zoom.m_60%.checked = false
lm_menu.m_display.m_zoom.m_80%.checked = false
lm_menu.m_display.m_zoom.m_100%.checked = false
lm_menu.m_display.m_zoom.m_200%.checked = false

choose case li_factor

	case 20
		lm_menu.m_display.m_zoom.m_20%.checked = true

	case 40
		lm_menu.m_display.m_zoom.m_40%.checked = true

	case 60
		lm_menu.m_display.m_zoom.m_60%.checked = true

	case 80
		lm_menu.m_display.m_zoom.m_80%.checked = true

	case 100
		lm_menu.m_display.m_zoom.m_100%.checked = true

	case 200
		lm_menu.m_display.m_zoom.m_200%.checked = true

end choose

end event

event ue_zoom_up;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Zoom the display area of the datawindow down
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string		ls_factor
integer		li_factor
m_nest		lm_menu

// get the current zoom
ls_factor = dw_1.Object.DataWindow.print.preview.zoom
li_factor = Integer (ls_factor)

// zoom up by a factor of 20% if current magnification is between 20% - 80%
if li_factor >=20 and li_factor <=80 then
	li_factor = li_factor + 20
else
	// if magnification is currently 100%, zoom to 200%
	if li_factor = 100 then
		li_factor = 200
	end if
end if

// set the new zoom level
dw_1.Object.DataWindow.print.preview.zoom = li_factor


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Check/uncheck the zoom menu items
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
lm_menu = this.menuid

lm_menu.m_display.m_zoom.m_20%.checked = false
lm_menu.m_display.m_zoom.m_40%.checked = false
lm_menu.m_display.m_zoom.m_60%.checked = false
lm_menu.m_display.m_zoom.m_80%.checked = false
lm_menu.m_display.m_zoom.m_100%.checked = false
lm_menu.m_display.m_zoom.m_200%.checked = false

choose case li_factor

	case 20
		lm_menu.m_display.m_zoom.m_20%.checked = true

	case 40
		lm_menu.m_display.m_zoom.m_40%.checked = true

	case 60
		lm_menu.m_display.m_zoom.m_60%.checked = true

	case 80
		lm_menu.m_display.m_zoom.m_80%.checked = true

	case 100
		lm_menu.m_display.m_zoom.m_100%.checked = true

	case 200
		lm_menu.m_display.m_zoom.m_200%.checked = true

end choose
end event

event ue_zoom;/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Zoom the display size of the report to the size specified on the menu.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int			li_factor
m_nest		lm_menu

lm_menu = this.menuid

// Initialize li_factor to zero
li_factor = 0

if lm_menu.m_display.m_zoom.m_20%.checked then 	
	li_factor = 20
elseif lm_menu.m_display.m_zoom.m_40%.checked then
	li_factor = 40
elseif lm_menu.m_display.m_zoom.m_60%.checked then
	li_factor = 60
elseif lm_menu.m_display.m_zoom.m_80%.checked then
	li_factor = 80
elseif lm_menu.m_display.m_zoom.m_100%.checked then
	li_factor = 100
elseif lm_menu.m_display.m_zoom.m_200%.checked then
	li_factor = 200
end if

if li_factor > 0 Then
	dw_1.Object.DataWindow.print.preview.zoom = li_factor
end if
end event

event open;call super::open;dw_1.SetTransObject (sqlca)
dw_1.Retrieve()

end event

event resize;// Resize the datawindow to match the size of the window.
dw_1.Resize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
end event

on w_nested_ancestor.create
if this.MenuName = "m_nest" then this.MenuID = create m_nest
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_nested_ancestor.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_nested_ancestor
int Width=2661
int Height=1697
int TabOrder=1
boolean Border=false
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

on rbuttondown;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Have the Display menu pop-up when the right mouse button is clicked
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

m_nest		lm_menuid


lm_menuid = parent.menuid
lm_menuid.m_display.PopMenu (parent.PointerX(), parent.PointerY())
end on

