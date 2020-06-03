$PBExportHeader$w_registry_add.srw
$PBExportComments$Window to add a value to the registry
forward
global type w_registry_add from w_center
end type
type p_binary from picture within w_registry_add
end type
type st_binary3 from statictext within w_registry_add
end type
type st_binary2 from statictext within w_registry_add
end type
type cb_browse from commandbutton within w_registry_add
end type
type sle_binary from singlelineedit within w_registry_add
end type
type st_binary1 from statictext within w_registry_add
end type
type st_ulong2 from statictext within w_registry_add
end type
type st_ulong1 from statictext within w_registry_add
end type
type st_expandedstring from statictext within w_registry_add
end type
type mle_multistring from multilineedit within w_registry_add
end type
type st_multistring3 from statictext within w_registry_add
end type
type st_multistring2 from statictext within w_registry_add
end type
type st_multistring1 from statictext within w_registry_add
end type
type sle_string from singlelineedit within w_registry_add
end type
type st_string from statictext within w_registry_add
end type
type sle_name from singlelineedit within w_registry_add
end type
type st_1 from statictext within w_registry_add
end type
type cb_cancel from commandbutton within w_registry_add
end type
type cb_ok from commandbutton within w_registry_add
end type
end forward

global type w_registry_add from w_center
int X=283
int Y=300
int Width=1998
int Height=1208
boolean TitleBar=true
string Title="Add/Update Registry Entries"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
p_binary p_binary
st_binary3 st_binary3
st_binary2 st_binary2
cb_browse cb_browse
sle_binary sle_binary
st_binary1 st_binary1
st_ulong2 st_ulong2
st_ulong1 st_ulong1
st_expandedstring st_expandedstring
mle_multistring mle_multistring
st_multistring3 st_multistring3
st_multistring2 st_multistring2
st_multistring1 st_multistring1
sle_string sle_string
st_string st_string
sle_name sle_name
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_registry_add w_registry_add

type variables
String	sKEY
String	is_Type
end variables

forward prototypes
public function integer of_readblob (string as_filename, ref blob ab_Picture)
end prototypes

public function integer of_readblob (string as_filename, ref blob ab_Picture);Long		ll_FileNo

ll_FileNo = FileOpen(as_FileName, StreamMode!)
If ll_FileNo = -1 Then
	Return -1
End If

FileRead(ll_FileNo, ab_Picture)

FileClose(ll_FileNo)

Return 1

end function

on w_registry_add.create
this.p_binary=create p_binary
this.st_binary3=create st_binary3
this.st_binary2=create st_binary2
this.cb_browse=create cb_browse
this.sle_binary=create sle_binary
this.st_binary1=create st_binary1
this.st_ulong2=create st_ulong2
this.st_ulong1=create st_ulong1
this.st_expandedstring=create st_expandedstring
this.mle_multistring=create mle_multistring
this.st_multistring3=create st_multistring3
this.st_multistring2=create st_multistring2
this.st_multistring1=create st_multistring1
this.sle_string=create sle_string
this.st_string=create st_string
this.sle_name=create sle_name
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.p_binary,&
this.st_binary3,&
this.st_binary2,&
this.cb_browse,&
this.sle_binary,&
this.st_binary1,&
this.st_ulong2,&
this.st_ulong1,&
this.st_expandedstring,&
this.mle_multistring,&
this.st_multistring3,&
this.st_multistring2,&
this.st_multistring1,&
this.sle_string,&
this.st_string,&
this.sle_name,&
this.st_1,&
this.cb_cancel,&
this.cb_ok}
end on

on w_registry_add.destroy
destroy(this.p_binary)
destroy(this.st_binary3)
destroy(this.st_binary2)
destroy(this.cb_browse)
destroy(this.sle_binary)
destroy(this.st_binary1)
destroy(this.st_ulong2)
destroy(this.st_ulong1)
destroy(this.st_expandedstring)
destroy(this.mle_multistring)
destroy(this.st_multistring3)
destroy(this.st_multistring2)
destroy(this.st_multistring1)
destroy(this.sle_string)
destroy(this.st_string)
destroy(this.sle_name)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;call super::open;String	ls_Parm, ls_Name, ls_Val, ls_AVal[]
Integer	li_Pos, li_Strings, li_Cnt
ULong	lul_Val
Blob		lb_Val

sKey  = sREGKEY + "\Code Examples\Registry Functions"
 
ls_Parm = Message.StringParm
li_Pos = Pos(ls_Parm, "~t")

If li_Pos = 0 Then
	is_Type = ls_Parm
	ls_Name = ""
Else
	is_Type = Left (ls_Parm, (li_Pos - 1))
	sle_name.Text = Right(ls_Parm, (Len(ls_Parm) - li_Pos))
	sle_name.BackColor = This.BackColor
	sle_name.Enabled = False
	ls_Name = sle_name.Text + " (" + is_Type + ")"
End If

Choose Case is_Type
	Case "String"
		st_string.Visible = True
		sle_string.Visible = True
		If ls_Name <> "" Then
			RegistryGet(sKEY, ls_Name, RegString!, ls_Val)
			sle_string.Text = ls_Val
		End If
			
	Case "Expanded String"
		st_expandedstring.Visible = True
		sle_string.Visible = True
		If ls_Name <> "" Then
			RegistryGet(sKEY, ls_Name, RegExpandString!, ls_Val)
			sle_string.Text = ls_Val
		End If

	Case "Multi String"
		st_multistring1.Visible = True
		st_multistring2.Visible = True
		st_multistring3.Visible = True
		mle_multistring.Visible = True
		If ls_Name <> "" Then
			RegistryGet(sKEY, ls_Name, RegMultiString!, ls_AVal)
			li_Strings = UpperBound(ls_AVal)
			For li_Cnt = 1 To li_Strings
				mle_multistring.Text += ls_AVal[li_Cnt] + "~r~n"
			Next
		End If

	Case "Unsigned Long"
		st_ulong1.Visible = True
		st_ulong2.Visible = True
		sle_string.Visible = True
		If ls_Name <> "" Then
			RegistryGet(sKEY, ls_Name, ReguLong!, lul_Val)
			sle_string.Text = String(lul_Val)
		End If

	Case "Binary"
		st_binary1.Visible = True
		st_binary2.Visible = True
		st_binary3.Visible = True
		sle_binary.Visible = True
		cb_browse.Visible = True
		p_binary.Visible = True
		If ls_Name <> "" Then
			RegistryGet(sKEY, ls_Name, RegBinary!, lb_Val)
			p_binary.SetPicture(lb_Val)
		End If
End Choose

end event

type p_binary from picture within w_registry_add
int X=741
int Y=476
int Width=553
int Height=400
boolean Visible=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
boolean FocusRectangle=false
end type

type st_binary3 from statictext within w_registry_add
int X=526
int Y=396
int Width=489
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="stored in your registry."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_binary2 from statictext within w_registry_add
int X=526
int Y=332
int Width=1120
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Enter the name of a BMP file and the image will be"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_browse from commandbutton within w_registry_add
int X=1632
int Y=204
int Width=247
int Height=108
int TabOrder=50
boolean Visible=false
string Text="Browse..."
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Path, ls_File

GetFileOpenName("Select a Bitmap File", ls_Path, ls_File, "BMP", "Bitmap Files (*.BMP),*.BMP")

sle_binary.Text = ls_Path
sle_binary.Post Event modified()

end event

type sle_binary from singlelineedit within w_registry_add
int X=526
int Y=216
int Width=1093
int Height=92
int TabOrder=40
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;Blob		lb_Picture

If of_readblob(This.Text, lb_Picture) = -1 Then
	MessageBox("Error", "Error reading file, please select another.", StopSign!)
	Return
End If

If p_binary.SetPicture(lb_Picture) = -1 Then
	MessageBox("Error", "Error displaying picture, please select another.", StopSign!)
	Return
End If

end event

type st_binary1 from statictext within w_registry_add
int X=183
int Y=224
int Width=334
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Binary Data:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_ulong2 from statictext within w_registry_add
int X=55
int Y=312
int Width=443
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="(Any 32-bit number)"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_ulong1 from statictext within w_registry_add
int Y=224
int Width=517
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Unsigned Long Data:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_expandedstring from statictext within w_registry_add
int Y=224
int Width=507
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Expanded String Data:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type mle_multistring from multilineedit within w_registry_add
int X=530
int Y=220
int Width=1403
int Height=640
int TabOrder=30
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean AutoHScroll=true
boolean AutoVScroll=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_multistring3 from statictext within w_registry_add
int X=18
int Y=388
int Width=311
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="with a CR."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_multistring2 from statictext within w_registry_add
int X=18
int Y=320
int Width=485
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Separate each string"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_multistring1 from statictext within w_registry_add
int X=105
int Y=228
int Width=411
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="Multi String Data:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_string from singlelineedit within w_registry_add
int X=526
int Y=220
int Width=1422
int Height=92
int TabOrder=20
boolean Visible=false
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_string from statictext within w_registry_add
int X=201
int Y=228
int Width=288
int Height=76
boolean Visible=false
boolean Enabled=false
string Text="String Data:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_name from singlelineedit within w_registry_add
int X=526
int Y=24
int Width=855
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_registry_add
int X=201
int Y=32
int Width=315
int Height=76
boolean Enabled=false
string Text="Value Name:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancel from commandbutton within w_registry_add
int X=1047
int Y=924
int Width=247
int Height=108
int TabOrder=70
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, "")

end event

type cb_ok from commandbutton within w_registry_add
int X=562
int Y=924
int Width=247
int Height=108
int TabOrder=60
string Text="OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Name, ls_AVal[], ls_Strings
Integer	li_Pos, li_Cnt
ULong	lul_Val
Blob		lb_Val

If Trim(sle_name.Text) = "" Then
	MessageBox("Error", "You must enter a value name.", Exclamation!)
	Return
End If

// Add/update the value
ls_Name = sle_name.Text + " (" + is_Type + ")"

Choose Case is_Type
	Case "String"
		If Trim(sle_string.Text) = "" Then
			MessageBox("Error", "You must enter a value.", Exclamation!)
			Return
		End If
		RegistrySet(sKEY, ls_Name, RegString!, sle_string.Text)
			
	Case "Expanded String"
		If Trim(sle_string.Text) = "" Then
			MessageBox("Error", "You must enter a value.", Exclamation!)
			Return
		End If
		RegistrySet(sKEY, ls_Name, RegExpandString!, sle_string.Text)

	Case "Multi String"
		If Trim(mle_multistring.Text) = "" Then
			MessageBox("Error", "You must enter a value.", Exclamation!)
			Return
		End If
		
		ls_Strings = mle_multistring.Text
		li_Cnt = 0
		Do
			li_Pos = Pos(ls_Strings, "~r~n")
			li_Cnt ++
			If li_Pos > 0 Then
				ls_AVal[li_Cnt] = Left(ls_Strings, (li_Pos - 1))
				ls_Strings = Right(ls_Strings, (Len(ls_Strings) - (li_Pos + 1)))
			Else
				ls_AVal[li_Cnt] = ls_Strings
			End If
		Loop Until (li_Pos = 0)
		
		RegistrySet(sKEY, ls_Name, RegMultiString!, ls_AVal)

	Case "Unsigned Long"
		If Trim(sle_string.Text) = "" Then
			MessageBox("Error", "You must enter a value.", Exclamation!)
			Return
		End If
		If Not IsNumber(sle_String.Text) Then
			MessageBox("Error", "You must enter a numeric value.", Exclamation!)
			Return
		End If
		
		lul_Val = Long(sle_String.Text)
		RegistrySet(sKEY, ls_Name, ReguLong!, lul_Val)

	Case "Binary"
		If Trim(sle_binary.Text) = "" Then
			MessageBox("Error", "You must enter a filename.", Exclamation!)
			Return
		End If

		If of_readblob(sle_binary.Text, lb_Val) = -1 Then
			MessageBox("Error", "Error reading file, please select another.", StopSign!)
			Return
		End If
		RegistrySet(sKEY, ls_Name, RegBinary!, lb_Val)
End Choose

CloseWithReturn(Parent, sle_name.Text)

end event

