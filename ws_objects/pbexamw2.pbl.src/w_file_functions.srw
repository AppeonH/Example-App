$PBExportHeader$w_file_functions.srw
$PBExportComments$Shows examples of how to Run other programs and check to see if other programs are running.
forward
global type w_file_functions from w_center
end type
type st_5 from statictext within w_file_functions
end type
type st_4 from statictext within w_file_functions
end type
type sle_windowname from singlelineedit within w_file_functions
end type
type st_3 from statictext within w_file_functions
end type
type st_2 from statictext within w_file_functions
end type
type st_1 from statictext within w_file_functions
end type
type sle_result from singlelineedit within w_file_functions
end type
type sle_file from singlelineedit within w_file_functions
end type
type rb_normal from radiobutton within w_file_functions
end type
type rb_min from radiobutton within w_file_functions
end type
type rb_max from radiobutton within w_file_functions
end type
type cb_close from commandbutton within w_file_functions
end type
type cb_2 from commandbutton within w_file_functions
end type
type cb_run from commandbutton within w_file_functions
end type
type sle_filename from singlelineedit within w_file_functions
end type
type rb_user from radiobutton within w_file_functions
end type
type rb_pre from radiobutton within w_file_functions
end type
type lb_desktop from picturelistbox within w_file_functions
end type
type gb_2 from groupbox within w_file_functions
end type
type gb_run from groupbox within w_file_functions
end type
type gb_1 from groupbox within w_file_functions
end type
end forward

shared variables
boolean flag_window1
boolean flag_fish
boolean flag_train
boolean flag_colors
boolean flag_multwin
end variables

global type w_file_functions from w_center
integer x = 544
integer y = 340
integer width = 1847
integer height = 1576
string title = "Working with Executables"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
st_5 st_5
st_4 st_4
sle_windowname sle_windowname
st_3 st_3
st_2 st_2
st_1 st_1
sle_result sle_result
sle_file sle_file
rb_normal rb_normal
rb_min rb_min
rb_max rb_max
cb_close cb_close
cb_2 cb_2
cb_run cb_run
sle_filename sle_filename
rb_user rb_user
rb_pre rb_pre
lb_desktop lb_desktop
gb_2 gb_2
gb_run gb_run
gb_1 gb_1
end type
global w_file_functions w_file_functions

type prototypes

end prototypes

forward prototypes
public function string of_getrunnable ()
public function string of_getwindowname ()
public function windowstate of_getwindowstate ()
end prototypes

public function string of_getrunnable ();string	ls_selected

if rb_pre.checked then
	ls_selected = lb_desktop.selecteditem()
	
	choose case ls_selected
		case "Calculator"
			return "calc"
		case "Notepad"
			return "notepad"
		case "Task Manager"
			return "taskmgr"
		case "Word Pad"
			return "write"
		case "Paint"
			return "mspaint"
		case "DVD Player"
			return "dvdplay"
		case else
			return ""
	end choose
else
	return (sle_filename.text)
end if
end function

public function string of_getwindowname ();string	ls_selected 
if rb_pre.checked then
	ls_selected = lb_desktop.selecteditem()
	choose case ls_selected
		case "Calculator"
			return "Calculator"
		case "Notepad"
			return "Untitled - Notepad"
		case "Task Manager"
			return "Windows Task Manager"
		case "Word Pad"
			return "Document - WordPad"
		case "Paint"
			return "Untitled - Paint"
		case "DVD Player"
			return "Windows Media Player"
		case else
			return ""
	end choose
else
	return (sle_windowname.text)
end if

end function

public function windowstate of_getwindowstate ();//Check state of three radio button on screen and
//return the appropriate enumerated windowstate type

if rb_max.checked then
	return maximized!
elseif rb_min.checked then
	return minimized!
else
	return normal!
end if
end function

event open;//open event
//  Populate the picturelistbox
lb_desktop.additem ( "Calculator", 1)
lb_desktop.additem ( "Notepad", 2)
lb_desktop.additem ( "Task Manager", 3)
lb_desktop.additem ( "Word Pad", 4)
lb_desktop.additem ( "Paint", 5)
lb_desktop.additem ( "DVD Player", 6)

//select first item
lb_desktop.selectitem(1)
end event

on close;//Close script for w_run_others

w_main.Show( )

end on

on w_file_functions.create
int iCurrent
call super::create
this.st_5=create st_5
this.st_4=create st_4
this.sle_windowname=create sle_windowname
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_result=create sle_result
this.sle_file=create sle_file
this.rb_normal=create rb_normal
this.rb_min=create rb_min
this.rb_max=create rb_max
this.cb_close=create cb_close
this.cb_2=create cb_2
this.cb_run=create cb_run
this.sle_filename=create sle_filename
this.rb_user=create rb_user
this.rb_pre=create rb_pre
this.lb_desktop=create lb_desktop
this.gb_2=create gb_2
this.gb_run=create gb_run
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_5
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.sle_windowname
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.sle_result
this.Control[iCurrent+8]=this.sle_file
this.Control[iCurrent+9]=this.rb_normal
this.Control[iCurrent+10]=this.rb_min
this.Control[iCurrent+11]=this.rb_max
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.cb_run
this.Control[iCurrent+15]=this.sle_filename
this.Control[iCurrent+16]=this.rb_user
this.Control[iCurrent+17]=this.rb_pre
this.Control[iCurrent+18]=this.lb_desktop
this.Control[iCurrent+19]=this.gb_2
this.Control[iCurrent+20]=this.gb_run
this.Control[iCurrent+21]=this.gb_1
end on

on w_file_functions.destroy
call super::destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.sle_windowname)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_result)
destroy(this.sle_file)
destroy(this.rb_normal)
destroy(this.rb_min)
destroy(this.rb_max)
destroy(this.cb_close)
destroy(this.cb_2)
destroy(this.cb_run)
destroy(this.sle_filename)
destroy(this.rb_user)
destroy(this.rb_pre)
destroy(this.lb_desktop)
destroy(this.gb_2)
destroy(this.gb_run)
destroy(this.gb_1)
end on

type st_5 from statictext within w_file_functions
integer x = 750
integer y = 484
integer width = 645
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Window Name (from title bar):"
boolean focusrectangle = false
end type

type st_4 from statictext within w_file_functions
integer x = 754
integer y = 280
integer width = 645
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Executable File Name:"
boolean focusrectangle = false
end type

type sle_windowname from singlelineedit within w_file_functions
integer x = 750
integer y = 568
integer width = 645
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean enabled = false
end type

type st_3 from statictext within w_file_functions
integer x = 18
integer y = 16
integer width = 1408
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Choose a program and hit the Run or Running buttons."
boolean focusrectangle = false
end type

type st_2 from statictext within w_file_functions
integer x = 50
integer y = 972
integer width = 256
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Program:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_file_functions
integer x = 50
integer y = 1156
integer width = 242
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Status:"
boolean focusrectangle = false
end type

type sle_result from singlelineedit within w_file_functions
integer x = 50
integer y = 1248
integer width = 727
integer height = 84
integer taborder = 90
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean autohscroll = false
boolean displayonly = true
end type

type sle_file from singlelineedit within w_file_functions
integer x = 50
integer y = 1056
integer width = 727
integer height = 84
integer taborder = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean displayonly = true
end type

type rb_normal from radiobutton within w_file_functions
integer x = 951
integer y = 792
integer width = 384
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Norma&l"
boolean checked = true
end type

type rb_min from radiobutton within w_file_functions
integer x = 503
integer y = 792
integer width = 384
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Minimi&zed"
end type

type rb_max from radiobutton within w_file_functions
integer x = 37
integer y = 792
integer width = 398
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Maximized"
end type

type cb_close from commandbutton within w_file_functions
integer x = 1472
integer y = 404
integer width = 306
integer height = 100
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

on clicked;close(parent)
end on

type cb_2 from commandbutton within w_file_functions
integer x = 1472
integer y = 268
integer width = 306
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Ru&nning ?"
end type

event clicked;ulong 	lul_applhandle 
string 	ls_filename
string	ls_selected

ls_filename = of_GetWindowName()
lul_applhandle = gu_ext_func.uf_FindWindow(0, ls_filename)

sle_file.text = ls_filename

if lul_applhandle > 0 then
	sle_result.text = "Is Running"
else
	sle_result.text = "Is Not Running"
end if


end event

type cb_run from commandbutton within w_file_functions
integer x = 1472
integer y = 132
integer width = 306
integer height = 100
integer taborder = 100
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Run"
end type

event clicked;// use the powerscript function RUN to execute the selected filename.
string	ls_filename

ls_filename = of_GetRunnable()

if ls_filename = "" then
	Messagebox ("Filename Required","Please Choose a File to Run")
	return
end if

sle_file.text = ls_filename

if Run(ls_filename, of_getwindowstate()) <> 1 then
	Messagebox("File not found","Could not find filename " + upper(ls_filename) +&
		".  Try specifying the fully qualified path.", Exclamation!)
	sle_result.text = "Did Not Run"
else
	sle_result.text = "Successfully Ran"
end if


end event

type sle_filename from singlelineedit within w_file_functions
integer x = 754
integer y = 360
integer width = 645
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
boolean enabled = false
end type

on losefocus;//when sle loses focus, move user entered filename to display at bottom
//and blank out the results line.

sle_file.text = sle_filename.text
sle_result.text = ""

end on

type rb_user from radiobutton within w_file_functions
integer x = 750
integer y = 160
integer width = 549
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&User Supplied"
end type

event clicked;//Allow typeing in the sle and erase out results boxes 

sle_filename.enabled = true
sle_windowname.enabled = true
sle_file.text = ""
sle_result.text = ""
end event

type rb_pre from radiobutton within w_file_functions
integer x = 64
integer y = 160
integer width = 421
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "&Pre-defined"
boolean checked = true
end type

on clicked;//disallow changing the user filename box anymore

sle_filename.enabled = false
end on

type lb_desktop from picturelistbox within w_file_functions
integer x = 73
integer y = 256
integer width = 622
integer height = 416
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
string picturename[] = {"calc.bmp","notepad.bmp","taskmgr.bmp","wordpad.bmp","paint.bmp","dvd.bmp"}
long picturemaskcolor = 16777215
end type

on selectionchanged;//whenever the user changes selected items, move that filename to the text box
//and blank out the results area.

sle_file.text = lb_desktop.SelectedItem( )
sle_result.text = ""
rb_pre.checked = true
end on

type gb_2 from groupbox within w_file_functions
integer x = 14
integer y = 932
integer width = 1426
integer height = 480
integer taborder = 70
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
end type

type gb_run from groupbox within w_file_functions
integer x = 14
integer y = 736
integer width = 1426
integer height = 148
integer taborder = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Run State"
end type

type gb_1 from groupbox within w_file_functions
integer x = 14
integer y = 96
integer width = 1426
integer height = 608
integer taborder = 10
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Programs to work with:"
end type

