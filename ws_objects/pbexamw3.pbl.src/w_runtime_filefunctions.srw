$PBExportHeader$w_runtime_filefunctions.srw
$PBExportComments$PB 8 - New File Functions
forward
global type w_runtime_filefunctions from w_center
end type
type st_results from statictext within w_runtime_filefunctions
end type
type cb_run from commandbutton within w_runtime_filefunctions
end type
type lv_functions from listview within w_runtime_filefunctions
end type
type cb_close from commandbutton within w_runtime_filefunctions
end type
end forward

shared variables
string ss_return 
end variables

global type w_runtime_filefunctions from w_center
integer width = 2565
integer height = 1012
string title = "File System Functions"
boolean center = true
st_results st_results
cb_run cb_run
lv_functions lv_functions
cb_close cb_close
end type
global w_runtime_filefunctions w_runtime_filefunctions

type variables

end variables

on w_runtime_filefunctions.create
int iCurrent
call super::create
this.st_results=create st_results
this.cb_run=create cb_run
this.lv_functions=create lv_functions
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_results
this.Control[iCurrent+2]=this.cb_run
this.Control[iCurrent+3]=this.lv_functions
this.Control[iCurrent+4]=this.cb_close
end on

on w_runtime_filefunctions.destroy
call super::destroy
destroy(this.st_results)
destroy(this.cb_run)
destroy(this.lv_functions)
destroy(this.cb_close)
end on

event close;call super::close;Show ( w_main )
end event

event open;listviewitem lvi_item

lv_functions.AddColumn ("Description", Left!, 800 )
lv_functions.AddColumn ("Function", Left!, 3000 )
lv_functions.AddItem ( "Get the Current Directory~tstring GetCurrentDirectory ( )", 1 )
lv_functions.AddItem ( "Does Directory Exist~tboolean DirectoryExists ( string directoryname )", 1 )
lv_functions.AddItem ( "Change the Current Directory~tinteger ChangeDirectory ( string directoryname )", 1 )
lv_functions.AddItem ( "Create a Directory~tinteger CreateDirectory ( string directoryname )", 1 )
lv_functions.AddItem ( "Remove a Directory~tinteger RemoveDirectory ( string directoryname )", 1 )
lv_functions.AddItem ( "Copy a File~tinteger FileCopy ( string sourcefile, string targetfile {,boolean replace} )", 1 )
lv_functions.AddItem ( "Move a File~tinteger FileMove ( string sourcefile, string targetfile )", 1 )
end event

type st_results from statictext within w_runtime_filefunctions
integer x = 727
integer y = 736
integer width = 1714
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_run from commandbutton within w_runtime_filefunctions
integer x = 32
integer y = 744
integer width = 325
integer height = 92
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Run"
end type

event clicked;integer li_index, li_rc
string ls_copyto

li_index = lv_functions.SelectedIndex ( ) 

Choose Case li_index
	Case 1
		ss_return = GetCurrentDirectory ( ) 
		st_results.Text = "The Current Directory is: " + ss_return
	Case 2
		OpenWithParm ( w_runtime_filefunctions_popup, "Specify Directory~t" + &
			ss_return + "~tSpecify the name of a directory to determine if it exists.~tno" )
			
		ss_return = Message.StringParm 
		If DirectoryExists ( ss_return ) Then 
			st_results.Text = "The Directory '" + ss_return + "' does exist."
		Else
			st_results.Text = "The Directory '" + ss_return + "' does Not exist."
		End If

	Case 3
		OpenWithParm ( w_runtime_filefunctions_popup, "Specify Change Directory~t" + &
			ss_return + "~tSpecify the name of a directory to change to.~tno" )
		ss_return = Message.StringParm 
		If ChangeDirectory ( ss_return ) = 1 Then 
			st_results.Text = "The Directory '" + ss_return + "' has been changed."
		Else
			st_results.Text = "The Directory '" + ss_return + "' could not be changed."
		End If
		
	Case 4
		OpenWithParm ( w_runtime_filefunctions_popup, "Specify New Directory~t" + &
			ss_return + "~tSpecify the name of a directory to be created.~tno" )
		ss_return = Message.StringParm 
		If CreateDirectory ( ss_return ) = 1 Then 
			st_results.Text = "The Directory '" + ss_return + "' has been created."
		Else
			st_results.Text = "The Directory '" + ss_return + "' could not be created."
		End If
	Case 5
		OpenWithParm ( w_runtime_filefunctions_popup, "Specify Remove Directory~t" + &
			ss_return + "~tSpecify the name of a directory to be removed.~tno" )
		ss_return = Message.StringParm 
		li_rc = MessageBox ( "Remove Directory", "Are you sure you want to remove " + ss_return + &
			" and its contents?", Question!, YesNo!, 2 ) 
		If li_rc = 1 Then
			If RemoveDirectory ( ss_return ) = 1 Then 
				st_results.Text = "The Directory '" + ss_return + "' has been removed."
			Else
				st_results.Text = "The Directory '" + ss_return + "' could not be removed."
			End If
		End If
	Case 6
		OpenWithParm ( w_runtime_filefunctions_popup, "Specify Copy File~t" + &
			ss_return + "~tSpecify the name of a file to be copied.~tyes" )
		ss_return = Message.StringParm
		OpenWithParm ( w_runtime_filefunctions_popup, "Specify Destination File~t" + &
			ss_return + "~tSpecify the name of the file to be copied to.~tyes" )
		ls_copyto = Message.StringParm
		li_rc = 1
		If FileExists ( ls_copyto ) Then
			li_rc = MessageBox ( "Copy File", "Are you sure you want to replace " + ss_return + &
				"?", Question!, YesNo!, 2 ) 
		End If
		If li_rc = 1 Then
			If FileCopy ( ss_return, ls_copyto, True ) = 1 Then 
				st_results.Text = "The File '" + ss_return + "' has been copied."
			Else
				st_results.Text = "The File '" + ss_return + "' could not be copied."
			End If
		End If

	Case 7
		OpenWithParm ( w_runtime_filefunctions_popup, "Specify Move File~t" + &
			ss_return + "~tSpecify the name of a file to be moved.~tyes" )
		ss_return = Message.StringParm
		OpenWithParm ( w_runtime_filefunctions_popup, "Specify Destination File~t" + &
			ss_return + "~tSpecify the name of the file to be moved to.~tyes" )
		ls_copyto = Message.StringParm
		li_rc = 1
		If FileExists ( ls_copyto ) Then
			li_rc = MessageBox ( "Move File", "Are you sure you want to replace " + ss_return + &
				"?", Question!, YesNo!, 2 ) 
		End If
		If li_rc = 1 Then
			If FileMove ( ss_return, ls_copyto ) = 1 Then 
				st_results.Text = "The File '" + ss_return + "' has been moved."
			Else
				st_results.Text = "The File '" + ss_return + "' could not be moved."
			End If
		End If

End Choose
end event

type lv_functions from listview within w_runtime_filefunctions
integer x = 23
integer y = 28
integer width = 2469
integer height = 684
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
listviewview view = listviewreport!
string largepicturename[] = {"Function!"}
long largepicturemaskcolor = 536870912
string smallpicturename[] = {"Function!"}
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

type cb_close from commandbutton within w_runtime_filefunctions
integer x = 366
integer y = 744
integer width = 325
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "E&xit"
end type

event clicked;Close ( Parent )
end event

