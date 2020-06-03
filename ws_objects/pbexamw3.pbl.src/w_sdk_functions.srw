$PBExportHeader$w_sdk_functions.srw
$PBExportComments$Calls SDK functions as PB external functions
forward
global type w_sdk_functions from w_center
end type
type cb_cur_dir from commandbutton within w_sdk_functions
end type
type st_cur_directory from statictext within w_sdk_functions
end type
type st_6 from statictext within w_sdk_functions
end type
type plb_drives from picturelistbox within w_sdk_functions
end type
type lb_hidden from listbox within w_sdk_functions
end type
type cb_drives from commandbutton within w_sdk_functions
end type
type st_5 from statictext within w_sdk_functions
end type
type cb_sys_dir from commandbutton within w_sdk_functions
end type
type cb_win_dir from commandbutton within w_sdk_functions
end type
type st_sys_directory from statictext within w_sdk_functions
end type
type st_win_directory from statictext within w_sdk_functions
end type
type st_4 from statictext within w_sdk_functions
end type
type st_3 from statictext within w_sdk_functions
end type
type cb_tasks from commandbutton within w_sdk_functions
end type
type st_2 from statictext within w_sdk_functions
end type
type lb_tasks from listbox within w_sdk_functions
end type
type st_memory from statictext within w_sdk_functions
end type
type st_1 from statictext within w_sdk_functions
end type
type cb_flash from commandbutton within w_sdk_functions
end type
type cb_mem from commandbutton within w_sdk_functions
end type
type cb_close from commandbutton within w_sdk_functions
end type
end forward

global type w_sdk_functions from w_center
integer x = 146
integer y = 336
integer width = 2555
integer height = 1280
string title = "Windows SDK Functions Example"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
cb_cur_dir cb_cur_dir
st_cur_directory st_cur_directory
st_6 st_6
plb_drives plb_drives
lb_hidden lb_hidden
cb_drives cb_drives
st_5 st_5
cb_sys_dir cb_sys_dir
cb_win_dir cb_win_dir
st_sys_directory st_sys_directory
st_win_directory st_win_directory
st_4 st_4
st_3 st_3
cb_tasks cb_tasks
st_2 st_2
lb_tasks lb_tasks
st_memory st_memory
st_1 st_1
cb_flash cb_flash
cb_mem cb_mem
cb_close cb_close
end type
global w_sdk_functions w_sdk_functions

type prototypes

end prototypes

type variables
// determines if window is flashing
boolean  ib_flash

end variables

event open;call super::open;If ge_Environment.OSType = sol2! Then
	plb_drives.visible = False
	st_5.visible = False
	cb_flash.visible = False
	cb_drives.visible = False
End if

If ge_Environment.Win16 Then
	st_6.visible = False
	st_cur_directory.visible = False
	cb_cur_dir.visible = False
	cb_drives.y = cb_tasks.y
	cb_tasks.y = cb_cur_dir.y
End If

end event

on timer;//////////////////////////////////////////////////////////////////////
//
// Make an external function call to flash the window.  The FlashWindow
// function is passed the handle of the window.
//
//////////////////////////////////////////////////////////////////////

int	li_hwnd


li_hwnd = Handle (this)
gu_ext_func.uf_Flash_Window (li_hwnd, true)

end on

on w_sdk_functions.create
int iCurrent
call super::create
this.cb_cur_dir=create cb_cur_dir
this.st_cur_directory=create st_cur_directory
this.st_6=create st_6
this.plb_drives=create plb_drives
this.lb_hidden=create lb_hidden
this.cb_drives=create cb_drives
this.st_5=create st_5
this.cb_sys_dir=create cb_sys_dir
this.cb_win_dir=create cb_win_dir
this.st_sys_directory=create st_sys_directory
this.st_win_directory=create st_win_directory
this.st_4=create st_4
this.st_3=create st_3
this.cb_tasks=create cb_tasks
this.st_2=create st_2
this.lb_tasks=create lb_tasks
this.st_memory=create st_memory
this.st_1=create st_1
this.cb_flash=create cb_flash
this.cb_mem=create cb_mem
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cur_dir
this.Control[iCurrent+2]=this.st_cur_directory
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.plb_drives
this.Control[iCurrent+5]=this.lb_hidden
this.Control[iCurrent+6]=this.cb_drives
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.cb_sys_dir
this.Control[iCurrent+9]=this.cb_win_dir
this.Control[iCurrent+10]=this.st_sys_directory
this.Control[iCurrent+11]=this.st_win_directory
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.cb_tasks
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.lb_tasks
this.Control[iCurrent+17]=this.st_memory
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.cb_flash
this.Control[iCurrent+20]=this.cb_mem
this.Control[iCurrent+21]=this.cb_close
end on

on w_sdk_functions.destroy
call super::destroy
destroy(this.cb_cur_dir)
destroy(this.st_cur_directory)
destroy(this.st_6)
destroy(this.plb_drives)
destroy(this.lb_hidden)
destroy(this.cb_drives)
destroy(this.st_5)
destroy(this.cb_sys_dir)
destroy(this.cb_win_dir)
destroy(this.st_sys_directory)
destroy(this.st_win_directory)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_tasks)
destroy(this.st_2)
destroy(this.lb_tasks)
destroy(this.st_memory)
destroy(this.st_1)
destroy(this.cb_flash)
destroy(this.cb_mem)
destroy(this.cb_close)
end on

on close;w_main.Show()
end on

type cb_cur_dir from commandbutton within w_sdk_functions
event clicked pbm_bnclicked
integer x = 1920
integer y = 452
integer width = 553
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Current Directory"
end type

event clicked;//////////////////////////////////////////////////////////////////////
//
// Make an external function call to get the path name of the
// Windows system directory.
//
//////////////////////////////////////////////////////////////////////

st_cur_directory.Text = gu_ext_func.uf_GetCurrentDirectory()
end event

type st_cur_directory from statictext within w_sdk_functions
integer x = 667
integer y = 408
integer width = 1152
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_sdk_functions
integer x = 27
integer y = 412
integer width = 594
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Current working directory"
alignment alignment = right!
boolean focusrectangle = false
end type

type plb_drives from picturelistbox within w_sdk_functions
integer x = 987
integer y = 596
integer width = 832
integer height = 536
integer taborder = 110
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
string picturename[] = {"diskdriv.bmp","harddriv.bmp","netdriv.bmp","cdrom.bmp"}
long picturemaskcolor = 553648127
end type

type lb_hidden from listbox within w_sdk_functions
boolean visible = false
integer x = 1239
integer y = 240
integer width = 489
integer height = 356
integer taborder = 90
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type cb_drives from commandbutton within w_sdk_functions
integer x = 1920
integer y = 652
integer width = 553
integer height = 84
integer taborder = 70
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Drives"
end type

event clicked;//////////////////////////////////////////////////////////////////////
//
// Display the available drives (network, floppy, hard drive)
//
//////////////////////////////////////////////////////////////////////

Uint		lui_Ret, lui_Drive
Integer	li_Row, li_Cnt, li_Count
String	ls_Drive


/////////////////////////////////////////////////////////////////////
// Reset the available drives listbox (hidden) and datawindow (visible)
/////////////////////////////////////////////////////////////////////
lb_hidden.Reset()
Do
	li_Count = plb_drives.DeleteItem(1)
Loop Until li_Count < 1

/////////////////////////////////////////////////////////////////////
// Populate a hidden listbox with the available drives
/////////////////////////////////////////////////////////////////////
lb_hidden.DirList('*.*', 49152)
li_Count = lb_hidden.TotalItems()


/////////////////////////////////////////////////////////////////////
// For each drive, add a row to the datawindow and make an external
// function call to determine the drive type.
/////////////////////////////////////////////////////////////////////
For li_Cnt = 1 To li_Count

	// Add drive letter to datawindow row
	ls_Drive = Mid(lb_hidden.Text(li_Cnt), 3, 1)

	// Determine drive description based on return value from external function.
	lui_Ret = gu_ext_func.uf_GetDriveType(Asc (ls_Drive) - 97)
	Choose Case lui_Ret
		Case 0
			ls_Drive = " " + Upper(ls_Drive) + ":    Unknown"

		Case 1
			ls_Drive = " " + Upper(ls_Drive) + ":    Does Not exist"

		Case 2
			ls_Drive = " " + Upper(ls_Drive) + ":    Floppy drive"

		Case 3
			ls_Drive = " " + Upper(ls_Drive) + ":    Hard drive"

		Case 4
			ls_Drive = " " + Upper(ls_Drive) + ":    Network drive"

		Case 5
			ls_Drive = " " + Upper(ls_Drive) + ":    CD-ROM drive"

		Case 6
			ls_Drive = " " + Upper(ls_Drive) + ":    RAM drive"
	End Choose
	
	plb_drives.AddItem(ls_Drive, (lui_Ret - 1))
Next

end event

type st_5 from statictext within w_sdk_functions
integer x = 987
integer y = 528
integer width = 183
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Drives:"
boolean focusrectangle = false
end type

type cb_sys_dir from commandbutton within w_sdk_functions
integer x = 1920
integer y = 352
integer width = 553
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&System Directory"
end type

on clicked;//////////////////////////////////////////////////////////////////////
//
// Make an external function call to get the path name of the
// Windows system directory.
//
//////////////////////////////////////////////////////////////////////

string	ls_dir
int		li_size


ls_dir = Space (40)
li_size = gu_ext_func.uf_GetSystemDirectory (ls_dir, 60)
if li_size > 0 then
	st_sys_directory.text = ls_dir
end if
end on

type cb_win_dir from commandbutton within w_sdk_functions
integer x = 1920
integer y = 256
integer width = 553
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Windows Directory"
end type

on clicked;//////////////////////////////////////////////////////////////////////
//
// Make an external function call to get the path name of the
// Windows directory.
//
//////////////////////////////////////////////////////////////////////

string	ls_dir
int		li_size


ls_dir = Space (40)
li_size = gu_ext_func.uf_GetWindowsDirectory (ls_dir, 60)
if li_size > 0 then
	st_win_directory.text = ls_dir
end if
end on

type st_sys_directory from statictext within w_sdk_functions
integer x = 667
integer y = 292
integer width = 1152
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_win_directory from statictext within w_sdk_functions
integer x = 667
integer y = 176
integer width = 1152
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_sdk_functions
integer x = 27
integer y = 296
integer width = 594
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Windows system directory:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_sdk_functions
integer x = 105
integer y = 180
integer width = 517
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Windows directory:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_tasks from commandbutton within w_sdk_functions
integer x = 1920
integer y = 552
integer width = 553
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Tasks"
end type

on clicked;////////////////////////////////////////////////////////////////////
//
//  Display tasks that are currently running by making external 
//  function calls
//
///////////////////////////////////////////////////////////////////

uint		lui_hwnd, &
			lui_hwndnext
string	ls_ptr


lb_tasks.SetRedraw (false)
lb_tasks.Reset()

ls_ptr = space (40)

lui_hwnd = Handle (parent)

// loop through current tasks and add each one to the tasks listbox
lui_hwndnext = gu_ext_func.uf_GetWindow (lui_hwnd, 0)
Do While lui_hwndnext > 0
	if (lui_hwndnext <> lui_hwnd) and gu_ext_func.uf_IsWindowVisible (lui_hwndnext) &
		 and (gu_ext_func.uf_GetWindow (lui_hwndNext, 4) = 0 ) then
		if gu_ext_func.uf_GetWindowText (lui_hwndnext, ls_ptr, 40) > 0 then
			lb_tasks.AddItem (ls_ptr)
		end if
	end if
	lui_hwndnext = gu_ext_func.uf_GetWindow (lui_hwndnext, 2)
Loop

lb_tasks.SetRedraw (true)

end on

type st_2 from statictext within w_sdk_functions
integer x = 73
integer y = 528
integer width = 183
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Tasks:"
boolean focusrectangle = false
end type

type lb_tasks from listbox within w_sdk_functions
integer x = 73
integer y = 596
integer width = 832
integer height = 536
integer taborder = 100
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type st_memory from statictext within w_sdk_functions
integer x = 667
integer y = 60
integer width = 677
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_sdk_functions
integer x = 133
integer y = 64
integer width = 489
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Available memory:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_flash from commandbutton within w_sdk_functions
integer x = 1920
integer y = 56
integer width = 553
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Flash Window"
end type

on clicked;//////////////////////////////////////////////////////////////////////
//
// Toggle a timer interval on or off. The window timer event uses
// the FlashWindow SDK function to make the window flash each time the
// timer goes off.
//
//////////////////////////////////////////////////////////////////////

if ib_flash then
	Timer (0)
	ib_flash = false
	this.text = '&Flash Window'
else
	Timer (.25)
	ib_flash = true
	this.text = 'Stop &Flash'
end if
end on

type cb_mem from commandbutton within w_sdk_functions
integer x = 1920
integer y = 156
integer width = 553
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Available &Memory"
end type

event clicked;//////////////////////////////////////////////////////////////////////
//
// Display the available memory by calling an external function.
//
//////////////////////////////////////////////////////////////////////

longlong	ll_mem


ll_mem = gu_ext_func.uf_GetFreememory ()
st_memory.text = String (ll_mem, '###,###,###,###') + ' bytes'

end event

type cb_close from commandbutton within w_sdk_functions
integer x = 1920
integer y = 844
integer width = 553
integer height = 84
integer taborder = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

on clicked;close (parent)
end on

