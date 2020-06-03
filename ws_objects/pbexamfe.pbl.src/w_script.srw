$PBExportHeader$w_script.srw
$PBExportComments$Window to display a script
forward
global type w_script from w_center
end type
type mle_script from multilineedit within w_script
end type
end forward

global type w_script from w_center
integer x = 416
integer y = 364
integer width = 2199
integer height = 1612
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 80242744
mle_script mle_script
end type
global w_script w_script

type variables
String	is_ObjectName
end variables

forward prototypes
public subroutine of_print ()
public subroutine of_select_all ()
public subroutine of_copy ()
end prototypes

public subroutine of_print ();Long		ll_PrintJob

ll_PrintJob = PrintOpen()

// Print Header
Print(ll_PrintJob, "////////////////////////////////////////////////////////////////////////////////////////////////////////")
Print(ll_PrintJob, "//~tPowerBuilder " + sVersionName + " Code Examples")
Print(ll_PrintJob, "//~tObject: " + is_ObjectName)
Print(ll_PrintJob, "//~t" + This.Title)
Print(ll_PrintJob, "////////////////////////////////////////////////////////////////////////////////////////////////////////~n~r")

Print(ll_PrintJob, mle_script.Text)

PrintClose(ll_PrintJob)
end subroutine

public subroutine of_select_all ();mle_script.SelectText(1, Len(mle_script.Text))
end subroutine

public subroutine of_copy ();mle_script.Copy()
end subroutine

event open;call super::open;Integer		li_Pos
String		ls_Script

ls_Script = Message.StringParm

// Get Object Name
li_Pos = Pos(ls_Script, "~t")
If li_Pos > 1 Then
	is_ObjectName = Left(ls_Script, (li_Pos - 1))
	ls_Script = Right(ls_Script, (Len(ls_Script) - li_Pos))
End If

// Strip off event/function declaration
li_Pos = Pos(ls_Script, ";")
If li_Pos > 1 Then
	This.Title = Left(ls_Script, (li_Pos - 1))
	ls_Script = Right(ls_Script, (Len(ls_Script) - li_Pos))
End If

// Strip off end
li_Pos = Pos(ls_Script, "~r~nend event")
If li_Pos = 0 Then
	li_Pos = Pos(ls_Script, "~r~nend function")
	If li_Pos = 0 Then
		li_Pos = Pos(ls_Script, "~r~nend subroutine")
	End If
End If
If li_Pos > 0 Then
	ls_Script = Left(ls_Script, li_Pos) + "~r~n"
End If

mle_script.Text = ls_Script

end event

on w_script.create
int iCurrent
call super::create
this.mle_script=create mle_script
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_script
end on

on w_script.destroy
call super::destroy
destroy(this.mle_script)
end on

event resize;mle_script.Width = newwidth - 20
mle_script.Height = newheight - 20
end event

type mle_script from multilineedit within w_script
integer x = 9
integer y = 12
integer width = 2139
integer height = 1040
integer taborder = 1
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

