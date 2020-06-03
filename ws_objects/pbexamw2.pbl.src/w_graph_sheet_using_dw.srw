$PBExportHeader$w_graph_sheet_using_dw.srw
$PBExportComments$Generalized maintenance ancestor for graph in a datawindow
forward
global type w_graph_sheet_using_dw from w_center
end type
type dw_1 from datawindow within w_graph_sheet_using_dw
end type
end forward

global type w_graph_sheet_using_dw from w_center
int X=25
int Y=55
int Width=2873
int Height=1892
boolean TitleBar=true
string Title="Total Salary by Department"
string MenuName="m_graph_sheet"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
boolean ToolBarVisible=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event graph_type pbm_custom01
event graph_title pbm_custom02
event copy_to_clipboard pbm_custom03
event spacing pbm_custom04
event graph_color pbm_custom06
dw_1 dw_1
end type
global w_graph_sheet_using_dw w_graph_sheet_using_dw

on graph_type;// Open the response window to set the graph type. Pass it the 
// datawindow object and it will do the rest.
OpenWithParm (w_graph_type, dw_1)

end on

on graph_title;// Set the graph title. This is set in the child window w_graph_title.
// The window tag attribute is used as a communication mechanism. If
// the tag attribute is used for other things (e.g. context sensitive
// help), a global variable may be used.

OpenWithParm (w_graph_title, dw_1)



end on

on copy_to_clipboard;// Copy the graph to the Windows Clipboard.
dw_1.ClipBoard ("gr_1" )
end on

on spacing;OpenWithParm (w_graph_spacing, dw_1)


end on

on graph_color;OpenWithParm (w_graph_color, dw_1)
end on

event open;call super::open;// Retrieve data for DataWindow
SetTransObject (dw_1, sqlca)
Retrieve (dw_1)

// Initialize the toolbar alignment and visible attributes from
// example.ini.
f_get_toolbar_profile(This, 1)

end event

event close;f_save_toolbar_profile(This)

end event

on w_graph_sheet_using_dw.create
if this.MenuName = "m_graph_sheet" then this.MenuID = create m_graph_sheet
this.dw_1=create dw_1
this.Control[]={ this.dw_1}
end on

on w_graph_sheet_using_dw.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_graph_sheet_using_dw
int X=4
int Y=36
int Width=2660
int Height=1415
int TabOrder=10
string DataObject="d_total_employee_salary_with_graph"
boolean Border=false
boolean VScrollBar=true
boolean LiveScroll=true
end type

