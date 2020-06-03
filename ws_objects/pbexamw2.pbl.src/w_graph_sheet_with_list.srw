$PBExportHeader$w_graph_sheet_with_list.srw
$PBExportComments$Second level ancestor to w_graph_sheet; adds capability to select category and value from a list.
forward
global type w_graph_sheet_with_list from w_graph_sheet
end type
type lb_category from listbox within w_graph_sheet_with_list
end type
type lb_value from listbox within w_graph_sheet_with_list
end type
type st_1 from statictext within w_graph_sheet_with_list
end type
type st_2 from statictext within w_graph_sheet_with_list
end type
type st_3 from statictext within w_graph_sheet_with_list
end type
end forward

global type w_graph_sheet_with_list from w_graph_sheet
int Width=2777
int Height=1665
lb_category lb_category
lb_value lb_value
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_graph_sheet_with_list w_graph_sheet_with_list

type variables

end variables

forward prototypes
public subroutine wf_set_a_series (string as_title, string as_value, string as_category)
end prototypes

public subroutine wf_set_a_series (string as_title, string as_value, string as_category);long ll_row, ll_index
int 	 li_series_num

li_series_num = gr_1.addseries (as_title )
if li_series_num < 1 Then Return
ll_row = RowCount (dw_1)
For ll_index = 1 to ll_row
	gr_1.adddata (li_series_num, dw_1.GetItemNumber (ll_index , as_value), &
					dw_1.GetItemString (ll_index, as_category))
Next



end subroutine

event open;call super::open;string	 ls_names, ls_names_list
string	 ls_object_name, ls_datatype

//Populate datawindow
dw_1.SetTransObject (sqlca)
dw_1.Retrieve ()

// Get list and number of columns from the datawindow
ls_names_list = dw_1.Object.DataWindow.objects

// Get each object from the list and add it to the objects listbox
//The character fields are added to the category list box and the
//number fields are added to the value listbox
ls_names = ls_names_list

do 
	ls_object_name = f_get_token (ls_names, "~t")
	if dw_1.Describe(ls_object_name + ".type") = "column" then
		ls_datatype = dw_1.Describe(ls_object_name + ".coltype")
		if left(ls_datatype, 4) = "char"  then
			lb_category.AddItem (ls_object_name)
		elseif ls_datatype = "number" or left(ls_datatype,7) = "decimal" then
			lb_value.AddItem (ls_object_name)
		end if

	end if
loop until ls_names = ""

//select initial values (defaults is first selections)
lb_value.SetState (1, True)


lb_value.TriggerEvent (selectionchanged!)

f_get_toolbar_profile(This, 1)





end event

on w_graph_sheet_with_list.create
int iCurrent
call w_graph_sheet::create
this.lb_category=create lb_category
this.lb_value=create lb_value
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=lb_category
this.Control[iCurrent+2]=lb_value
this.Control[iCurrent+3]=st_1
this.Control[iCurrent+4]=st_2
this.Control[iCurrent+5]=st_3
end on

on w_graph_sheet_with_list.destroy
call w_graph_sheet::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lb_category)
destroy(this.lb_value)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

type gr_1 from w_graph_sheet`gr_1 within w_graph_sheet_with_list
int X=36
boolean Enabled=true
string Title="Totals By Order"
end type

on gr_1.create
call w_graph_sheet`gr_1::create
Category.DispAttr.TextSize=-11
Category.DispAttr.AutoSize=false
Category.LabelDispAttr.TextSize=-15
Category.LabelDispAttr.AutoSize=false
Values.Label=""
Values.LabelDispAttr.TextSize=-12
Values.LabelDispAttr.AutoSize=false
LegendDispAttr.TextSize=-11
LegendDispAttr.AutoSize=false
end on

type dw_1 from w_graph_sheet`dw_1 within w_graph_sheet_with_list
boolean Visible=false
end type

type lb_category from listbox within w_graph_sheet_with_list
int X=40
int Y=135
int Width=665
int Height=369
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on selectionchanged;// When the category changes, we need to reconfigure everything on
// the graph. The selectionchanged event for the value list does this.
TriggerEvent (lb_value, selectionchanged!)
end on

type lb_value from listbox within w_graph_sheet_with_list
int X=769
int Y=135
int Width=665
int Height=369
int TabOrder=30
boolean BringToTop=true
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean MultiSelect=true
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on selectionchanged;int itemcount,i,r
string ls_colname

gr_1.SetRedraw (False)

// Clear out all categories, series and data from the graph
gr_1.reset ( all! )

// Loop through all selected values and create as many series as the
// user specified.
for i = 1 to lb_value.totalitems ( )
	If lb_value.state ( i ) = 1 then
		ls_colname = lb_value.text ( i )
		wf_set_a_series (ls_colname, ls_colname, lb_category.text(1))
	end if
next

gr_1.SetRedraw (True)



end on

type st_1 from statictext within w_graph_sheet_with_list
int X=43
int Y=45
int Width=296
int Height=71
boolean Enabled=false
boolean BringToTop=true
string Text="Category"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_graph_sheet_with_list
int X=772
int Y=45
int Width=438
int Height=71
boolean Enabled=false
boolean BringToTop=true
string Text="Values To Graph"
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_graph_sheet_with_list
int X=1494
int Y=45
int Width=1081
int Height=183
boolean Enabled=false
boolean BringToTop=true
string Text="The valid values are pulled from a hidden DataWindow and loaded into a graph object."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

