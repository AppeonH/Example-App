$PBExportHeader$w_sheet_1_dw.srw
$PBExportComments$Ancestor:  MDI Sheet with 1 DataWindow
forward
global type w_sheet_1_dw from w_center
end type
type dw_1 from datawindow within w_sheet_1_dw
end type
end forward

global type w_sheet_1_dw from w_center
int X=296
int Y=269
int Width=2329
int Height=1316
boolean TitleBar=true
string Title="Untitled"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_tile pbm_custom01
event ue_layer pbm_custom02
event ue_cascade pbm_custom03
event ue_icons pbm_custom04
event ue_exit pbm_custom05
event ue_dept pbm_custom06
event ue_dept_salary pbm_custom07
event ue_cust pbm_custom08
event ue_cust_order pbm_custom09
event ue_emp pbm_custom10
event ue_htile pbm_custom11
dw_1 dw_1
end type
global w_sheet_1_dw w_sheet_1_dw

type variables
// contains a reference to the parent window (frame)
w_frame_queries  iw_frame

boolean   ib_highlight_row
integer   i_row
end variables

on ue_tile;// tile open sheets

iw_frame.ArrangeSheets (tile!)
end on

on ue_layer;// layer open sheets

iw_frame.ArrangeSheets (layer!)
end on

on ue_cascade;// cascade open sheets

iw_frame.ArrangeSheets (cascade!)
end on

on ue_icons;// arrange icons

iw_frame.ArrangeSheets (icons!)
end on

on ue_exit;// exit example by closing the frame

Close (iw_frame)
end on

on ue_dept;// open the department list window

window	lw_win

OpenSheet (lw_win, 'w_sheet_1_dept', iw_frame, 0, layered!)
end on

on ue_dept_salary;// open the department list with salaries window

window	lw_win

OpenSheet (lw_win, 'w_sheet_2_depts_salary_sum', iw_frame, 0, layered!)
end on

on ue_cust;// open the customers window

window	lw_win

OpenSheet (lw_win, 'w_sheet_1_cust', iw_frame, 0, layered!)
end on

on ue_cust_order;// open the customer orders window

window	lw_win

OpenSheet (lw_win, 'w_sheet_2_orders_for_customer', iw_frame, 0, layered!)
end on

on ue_emp;// open the employee address info window

window	lw_win

OpenSheet (lw_win, 'w_sheet_2_employee_address_info', iw_frame, 0, layered!)
end on

on ue_htile;// horizontall tile open sheets

iw_frame.ArrangeSheets (TileHorizontal!)
end on

on deactivate;// call user object function to disable the command buttons


iw_frame.uo_1.uf_set_buttons (false, false, false, false, false, false, false, false)
end on

on activate;// tell the user object that we are currently using the datawindow
// on this window (the active window)

iw_frame.uo_1.uf_setdw (dw_1)
end on

on resize;// Make the DataWindow fit neatly in the window when the window is resized

dw_1.Resize (this.WorkSpaceWidth() - 25, this.WorkSpaceHeight() - 25)
end on

on open;// assign a reference to the parent window (which will be the frame window)
iw_frame = this.ParentWindow()

dw_1.SetTransObject (sqlca)




end on

on w_sheet_1_dw.create
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_sheet_1_dw.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_sheet_1_dw
int X=18
int Y=17
int Width=2251
int Height=871
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
end type

on rowfocuschanged;i_row = this.GetRow()
if i_row < 1 then return
this.SelectRow (0, false)			// Turn off previous highlight
this.SelectRow (i_row, true)		// Highlight current row

end on

