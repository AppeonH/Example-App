$PBExportHeader$w_dynamic_uo_work_area.srw
$PBExportComments$MDI Sheet that is the work area for the Dynamic User Object Example.
forward
global type w_dynamic_uo_work_area from w_center
end type
type uo_dw from u_dyn_datawindow within w_dynamic_uo_work_area
end type
end forward

global type w_dynamic_uo_work_area from w_center
int X=87
int Y=200
int Width=2743
int Height=1492
boolean TitleBar=true
string Title="Dynamic User Object Work Area"
string MenuName="m_dynamic_uo_sheet"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_retrieve pbm_custom14
event ue_apply pbm_custom15
event ue_deleterow pbm_custom16
event ue_openwindow pbm_custom17
event ue_firstrow pbm_custom18
event ue_insertrow pbm_custom19
event ue_lastrow pbm_custom20
event ue_nextrow pbm_custom21
event ue_priorrow pbm_custom22
event ue_resetdw pbm_custom23
event ue_close_udo pbm_custom24
event ue_printdw pbm_custom25
event ue_exitapp pbm_custom26
uo_dw uo_dw
end type
global w_dynamic_uo_work_area w_dynamic_uo_work_area

type variables
integer ii_PointerXOffset, ii_PointerYOffset
w_dynamic_uo_open_uo_frame iw_parent_win
u_dyn_cb iu_being_dragged
m_dynamic_uo_open_udo im_menu
boolean      ib_Place
integer ii_UDO_nmbr 

end variables

on ue_retrieve;	uo_dw.retrieve()

//***********************************************************************
// 		The last thing that we want to do in every script that would 
//			move focus away from the datawindow is to set the focus back
//			to the datawindow and thus make it appear that control never 
//			left the DataWindow.
//************************************************************************
	uo_dw.setfocus()

	
end on

on ue_apply;uo_dw.update()


//***********************************************************************
// 		The last thing that we want to do in every script that would 
//			move focus away from the datawindow is to set the focus back
//			to the datawindow and thus make it appear that control never 
//			left the DataWindow.
//************************************************************************
uo_dw.SetFocus()
end on

on ue_deleterow;//***********************************************************************
// 		Using a row number of 0 as an arguement to DeleteRow will cause
//			the current row to be deleted.  This will make the total row 
//			count for the DataWindow go down by one.
//			
//************************************************************************
uo_dw.deleterow(0)


//***********************************************************************
// 		The last thing that we want to do in every script that would 
//			move focus away from the datawindow is to set the focus back
//			to the datawindow and thus make it appear that control never 
//			left the DataWindow.
//************************************************************************
uo_dw.setfocus()
end on

event ue_openwindow;// cause the uo_dw control to get a new datawindowobject that we have just created.
string ls_response, ls_table, ls_style, ls_error
int li_posi

open(w_dynamic_uo_table_list)
ls_response = message.stringparm

li_posi = pos(ls_response,'|')
if li_posi > 0 then
	ls_table = left(ls_response, li_posi - 1)
	ls_style = mid(ls_response, li_posi + 1)
	uo_dw.Create(SyntaxFromSql(sqlca,"Select * from "+ls_table,"style(type=" + ls_style + ")",ls_error))
	uo_dw.title	=	upper(ls_table)
	uo_dw.SetTransObject(sqlca)
	this.title = 'Dynamic User Object Work Area ('+ls_table+')'
end if

end event

on ue_firstrow;uo_dw.ScrollToRow (1)


//***********************************************************************
// 		The last thing that we want to do in every script that would 
//			move focus away from the datawindow is to set the focus back
//			to the datawindow and thus make it appear that control never 
//			left the DataWindow.
//************************************************************************
uo_dw.setfocus()
end on

on ue_insertrow;
int lReturnCode

lReturnCode = uo_dw.insertrow(uo_dw.getrow())
//***********************************************************************
// 		If lReturnCode = 0 then something went wrong with the insert
//			row funtion and we should not try to scroll to row 0.  
//			In a true application an error message of some kind would be 
//			displayed by the programmer
//************************************************************************
if lReturnCode <> 0 then 
	uo_dw.scrolltorow(lReturnCode)
end if


//***********************************************************************
// 		The last thing that we want to do in every script that would 
//			move focus away from the datawindow is to set the focus back
//			to the datawindow and thus make it appear that control never 
//			left the DataWindow.
//************************************************************************
	uo_dw.SetFocus()
end on

on ue_lastrow;//***********************************************************************
// 		The use of the Function RowCount will return the number of 
//			rows in the datawindow thus any rows inserted or deleted will be
//			reflected.  Thus by nesting the RowCount inside the ScrollToRow
//			functions it is guarenteed to find the last row.
//************************************************************************
uo_dw.ScrollToRow (uo_dw.RowCount())


//***********************************************************************
// 		The last thing that we want to do in every script that would 
//			move focus away from the datawindow is to set the focus back
//			to the datawindow and thus make it appear that control never 
//			left the DataWindow.
//************************************************************************
uo_dw.setfocus()
end on

on ue_nextrow;//***********************************************************************
// 		Using variables for current row and last row will stop the
//			script from trying to scroll past the last row.  When the 
//			last row is the current row the script will beep
//************************************************************************

int lCurrentRow, lLastRow

lCurrentRow = uo_dw.GetRow()
lLastRow		= uo_dw.RowCount()

	if lCurrentRow < lLastRow then
		uo_dw.ScrollToRow (lCurrentRow + 1)
	else
		Beep (1)
	end if

//***********************************************************************
// 		The last thing that we want to do in every script that would 
//			move focus away from the datawindow is to set the focus back
//			to the datawindow and thus make it appear that control never 
//			left the DataWindow.
//************************************************************************
	uo_dw.SetFocus()
end on

on ue_priorrow;//***********************************************************************
// 		Using variables for current row will stop the
//			script from trying to scroll past the first row.  When the 
//			first row is the current row the script will beep
//************************************************************************


int lCurrentRow

lCurrentRow = uo_dw.GetRow()


	if lCurrentRow > 1 then
		uo_dw.ScrollToRow (lCurrentRow - 1)
	else
		Beep (1)
	end if


//***********************************************************************
// 		The last thing that we want to do in every script that would 
//			move focus away from the datawindow is to set the focus back
//			to the datawindow and thus make it appear that control never 
//			left the DataWindow.
//************************************************************************
	uo_dw.SetFocus()
end on

on ue_resetdw;uo_dw.reset()
end on

on ue_close_udo;// make sure that the appropriate menu item is turned back on and then close the 
// user object
CHOOSE CASE iu_being_dragged.ii_object_number
	CASE 2
		m_dynamic_uo_open_udo.m_UDOs.m_retrieve.enabled	=	TRUE
	CASE 3
		m_dynamic_uo_open_udo.m_UDOs.m_insert.enabled		=	TRUE
	CASE 4
		m_dynamic_uo_open_udo.m_UDOs.m_delete.enabled		=	TRUE
	CASE 5
		m_dynamic_uo_open_udo.m_UDOs.m_update.enabled		=	TRUE
	CASE 6
		m_dynamic_uo_open_udo.m_UDOs.m_first.enabled		=	TRUE
	CASE 7
		m_dynamic_uo_open_udo.m_UDOs.m_last.enabled			=	TRUE
	CASE 8
		m_dynamic_uo_open_udo.m_UDOs.m_next.enabled			=	TRUE
	CASE 9
		m_dynamic_uo_open_udo.m_UDOs.m_prior.enabled		=	TRUE
	CASE 10
		m_dynamic_uo_open_udo.m_UDOs.m_reset.enabled		=	TRUE
	CASE 11
		m_dynamic_uo_open_udo.m_UDOs.m_print.enabled		=	TRUE
	CASE 12
		m_dynamic_uo_open_udo.m_UDOs.m_exit.enabled		=	TRUE
END CHOOSE
closeUserObject(iu_being_dragged)

end on

on ue_printdw;uo_dw.print()

//***********************************************************************
// 		The last thing that we want to do in every script that would 
//			move focus away from the datawindow is to set the focus back
//			to the datawindow and thus make it appear that control never 
//			left the DataWindow.
//************************************************************************
uo_dw.setfocus()
end on

on ue_exitapp;close(iw_parent_win)
end on

on clicked;integer i , j
u_dyn_struct parm
u_dyn_cb uo_placed

i	=	PointerX()
j	=	PointerY()
// determine which button is to be created and then create and place it. 

if ib_Place then
	If ge_Environment.OSType <> sol2! Then
		// This statement is not valid on PB for Unix
		this.pointer = ""
	End if

	parm.code= ii_UDO_nmbr
	parm.win = this
	CHOOSE CASE ii_UDO_nmbr
		CASE 1
			uo_dw.x	=	i
			uo_dw.y	=	j
			uo_dw.visible	=	TRUE
			im_menu.m_UDOs.m_dw.enabled	=	FALSE
			this.postevent('ue_openwindow')
		CASE 2
			parm.label = '&Retrieve'
			parm.clicked = 'ue_retrieve'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_retrieve.enabled	=	FALSE
		CASE 3
			parm.label = '&Insert'
			parm.clicked = 'ue_insertrow'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_insert.enabled		=	FALSE
		CASE 4
			parm.label = '&Delete'
			parm.clicked = 'ue_deleterow'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_delete.enabled		=	FALSE
		CASE 5
			parm.label = '&Update'
			parm.clicked = 'ue_apply'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_update.enabled		=	FALSE
		CASE 6
			parm.label = '&First'
			parm.clicked = 'ue_firstrow'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_first.enabled		=	FALSE
		CASE 7
			parm.label = '&Last'
			parm.clicked = 'ue_lastrow'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_last.enabled		=	FALSE
		CASE 8
			parm.label = '&Next'
			parm.clicked = 'ue_nextrow'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_next.enabled		=	FALSE
		CASE 9
			parm.label = 'Pri&or'
			parm.clicked = 'ue_priorrow'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_prior.enabled		=	FALSE
		CASE 10
			parm.label = 'Re&set'
			parm.clicked = 'ue_resetdw'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_reset.enabled		=	FALSE
		CASE 11
			parm.label = '&Print'
			parm.clicked = 'ue_printdw'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_print.enabled		=	FALSE
		CASE 12
			parm.label = 'E&xit'
			parm.clicked = 'ue_exitapp'
			parm.size = 353
			OpenUserObjectwithparm(uo_placed,parm , i , j)
			im_menu.m_UDOs.m_exit.enabled		=	FALSE
	END CHOOSE
	ib_Place = FALSE
end if
	
end on

event open;call super::open;// keep instance variables that point to the frame, the menu and 

// on the menu it's active sheet.

im_menu = menuid
im_menu.iw_sheet = this
iw_parent_win = parentwindow()

end event

on dragdrop;
//**************************************************************
// drag and drop event script for sheet
// the following statements change the location of a 
// UDO as the user drags the UDO and drops it somewhere else 
// on the sheet.
//***************************************************************


	integer i , j, lHeight, lWidth

	i	=	PointerX() 
	j	=	PointerY() 

	lHeight 	= iu_being_dragged.Height
	lWidth	= iu_being_dragged.Width
	iu_being_dragged.move(i - lWidth/2 , j - lHeight/2)


end on

on w_dynamic_uo_work_area.create
if this.MenuName = "m_dynamic_uo_sheet" then this.MenuID = create m_dynamic_uo_sheet
this.uo_dw=create uo_dw
this.Control[]={ this.uo_dw}
end on

on w_dynamic_uo_work_area.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_dw)
end on

type uo_dw from u_dyn_datawindow within w_dynamic_uo_work_area
int X=640
int Y=176
boolean Visible=false
string DataObject="d_dyn_uo_tables_list"
boolean TitleBar=true
string Title=""
boolean HSplitScroll=true
end type

