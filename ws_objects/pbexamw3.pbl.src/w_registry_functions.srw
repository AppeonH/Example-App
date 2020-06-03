$PBExportHeader$w_registry_functions.srw
$PBExportComments$Window to demonstrate the use of the registry functions
forward
global type w_registry_functions from w_center
end type
type cb_close from commandbutton within w_registry_functions
end type
type cb_help from commandbutton within w_registry_functions
end type
type cb_delete from commandbutton within w_registry_functions
end type
type cb_binary from commandbutton within w_registry_functions
end type
type cb_ulong from commandbutton within w_registry_functions
end type
type cb_multistring from commandbutton within w_registry_functions
end type
type cb_expstring from commandbutton within w_registry_functions
end type
type cb_string from commandbutton within w_registry_functions
end type
type lv_values from listview within w_registry_functions
end type
end forward

global type w_registry_functions from w_center
int X=9
int Y=12
int Width=2651
int Height=1676
boolean TitleBar=true
string Title="Registry Functions"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event ue_getvalues ( )
cb_close cb_close
cb_help cb_help
cb_delete cb_delete
cb_binary cb_binary
cb_ulong cb_ulong
cb_multistring cb_multistring
cb_expstring cb_expstring
cb_string cb_string
lv_values lv_values
end type
global w_registry_functions w_registry_functions

forward prototypes
public subroutine of_addvalue (string as_type, string as_Name)
public subroutine of_addvalue (string as_type)
public function string of_gettype (string as_Name)
public subroutine of_insert_defaults ()
end prototypes

event ue_getvalues;String	ls_Key, ls_Values[], ls_Type, ls_Val, ls_AVal[], ls_Empty[], ls_Label
Integer	li_Values, li_Cnt, li_Strings, li_Cnt2
ULong	lul_Val
Blob		lb_Val
ListViewItem		llvi_Item

lv_values.DeleteItems()

ls_Key = sREGKEY + "\Code Examples\Registry Functions"
RegistryValues(ls_Key, ls_Values)

li_Values = UpperBound(ls_Values)
If li_Values = 0 Then
	of_insert_defaults()
	RegistryValues(ls_Key, ls_Values)
	li_Values = UpperBound(ls_Values)
End If

For li_Cnt = 1 To li_Values
	// Add values to the ListView
	// First determine what data type
	// The data type must be within the value name (in parentheses)
	ls_Type = of_gettype(ls_Values[li_Cnt])
	If ls_Type <> "" Then
		Choose Case ls_Type
			Case "String"
				RegistryGet(ls_Key, ls_Values[li_Cnt], RegString!, ls_Val)
				ls_Label = ls_Values[li_Cnt] + "~t" + ls_Val
				llvi_Item.PictureIndex = 1
			Case "Expanded String"
				RegistryGet(ls_Key, ls_Values[li_Cnt], RegExpandString!, ls_Val)
				ls_Label = ls_Values[li_Cnt] + "~t" + ls_Val
				llvi_Item.PictureIndex = 1
			Case "Multi String"
				ls_AVal = ls_Empty
				RegistryGet(ls_Key, ls_Values[li_Cnt], RegMultiString!, ls_AVal)
				ls_Label = ls_Values[li_Cnt] + "~t"
				li_Strings = UpperBound(ls_AVal)
				For li_Cnt2 = 1 To li_Strings
					ls_Label += ls_AVal[li_Cnt2] + ";"
				Next
				llvi_Item.PictureIndex = 1
			Case "Unsigned Long"
				RegistryGet(ls_Key, ls_Values[li_Cnt], ReguLong!, lul_Val)
				ls_Label = ls_Values[li_Cnt] + "~t" + String(lul_Val)
				llvi_Item.PictureIndex = 2
			Case "Binary"
				RegistryGet(ls_Key, ls_Values[li_Cnt], RegBinary!, lb_Val)
				ls_Label = ls_Values[li_Cnt] + "~t" + String(lb_Val)
				llvi_Item.PictureIndex = 2
			Case Else
				ls_Label = ""
				llvi_Item.PictureIndex = 0
		End Choose
		
		llvi_Item.Label = ls_Label
		lv_values.AddItem(llvi_Item)
	End If
Next

end event

public subroutine of_addvalue (string as_type, string as_Name);String	ls_Parm

ls_Parm = as_Type

If Trim(as_Name) <> "" Then ls_Parm += "~t" + as_Name

OpenWithParm(w_registry_add, ls_Parm)

If Trim(Message.StringParm) <> "" Then
	Post Event ue_getvalues()
End If

end subroutine

public subroutine of_addvalue (string as_type);of_addvalue(as_Type, "")

end subroutine

public function string of_gettype (string as_Name);Integer	li_Pos1, li_Pos2

li_Pos1 = Pos(as_Name, "(")
li_Pos2 = Pos(as_Name, ")", li_Pos1)
If (li_Pos1 > 0) And (li_Pos2 > 0) Then
	Return Mid(as_Name, (li_Pos1 + 1), (li_Pos2 - (li_Pos1 + 1)))
Else
	Return ""
End If

end function

public subroutine of_insert_defaults ();String	ls_Val[]
ULong	lul_Val
Blob		lblb_Val
Long		ll_FileNo
Constant String	sKEY = sREGKEY + "\Code Examples\Registry Functions"

RegistrySet(sKEY, "Test String (String)", RegString!, "This is a test.")
RegistrySet(sKEY, "Test Expanded String (Expanded String)", RegExpandString!, "Your Path is %PATH%")

ls_Val[1] = "MultiString Line 1"
ls_Val[2] = "MultiString Line 2"
ls_Val[3] = "MultiString Line 3"
RegistrySet(sKEY, "Test Multi String (Multi String)", RegMultiString!, ls_Val)

lul_Val = 65534
RegistrySet(sKEY, "Test Unsigned Long (Unsigned Long)", ReguLong!, lul_Val)


ll_FileNo = FileOpen("beach.bmp", StreamMode!)
If ll_FileNo = -1 Then
	MessageBox("Error", "Error reading bmp file.", Exclamation!)
Else
	FileRead(ll_FileNo, lblb_Val)
	FileClose(ll_FileNo)

	RegistrySet(sKEY, "Test Binary - beach.bmp (Binary)", RegBinary!, lblb_Val)
End If

end subroutine

event open;call super::open;lv_values.AddColumn("Name", Left!, 1000)
lv_Values.AddColumn("Data", Left!, 1500)

Post Event ue_GetValues()

end event

on w_registry_functions.create
this.cb_close=create cb_close
this.cb_help=create cb_help
this.cb_delete=create cb_delete
this.cb_binary=create cb_binary
this.cb_ulong=create cb_ulong
this.cb_multistring=create cb_multistring
this.cb_expstring=create cb_expstring
this.cb_string=create cb_string
this.lv_values=create lv_values
this.Control[]={this.cb_close,&
this.cb_help,&
this.cb_delete,&
this.cb_binary,&
this.cb_ulong,&
this.cb_multistring,&
this.cb_expstring,&
this.cb_string,&
this.lv_values}
end on

on w_registry_functions.destroy
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.cb_delete)
destroy(this.cb_binary)
destroy(this.cb_ulong)
destroy(this.cb_multistring)
destroy(this.cb_expstring)
destroy(this.cb_string)
destroy(this.lv_values)
end on

event close;w_main.Show()

end event

type cb_close from commandbutton within w_registry_functions
int X=2309
int Y=1352
int Width=247
int Height=108
int TabOrder=90
string Text="Close"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_help from commandbutton within w_registry_functions
int X=2309
int Y=1112
int Width=247
int Height=108
int TabOrder=80
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String	ls_Win

ls_win = parent.ClassName()

f_open_help(ls_win)
end event

type cb_delete from commandbutton within w_registry_functions
int X=2309
int Y=880
int Width=247
int Height=108
int TabOrder=70
string Text="Delete"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer		li_Current
String		ls_Name
String		ls_Key

ls_Key = sREGKEY + "\Code Examples\Registry Functions"

li_Current = lv_values.FindItem(0, DirectionAll!, False, True, False, False)

lv_values.GetItem(li_Current, 1, ls_Name)

If MessageBox("Warning", "Are you sure you want to delete this entry:  " + ls_Name + "?", Question!, YesNo!) = 1 Then
	RegistryDelete(ls_Key, ls_Name)
	lv_values.DeleteItem(li_Current)
End If

end event

type cb_binary from commandbutton within w_registry_functions
int X=50
int Y=1352
int Width=709
int Height=108
int TabOrder=60
string Text="Add a Binary Value"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_addvalue("Binary")

end event

type cb_ulong from commandbutton within w_registry_functions
int X=50
int Y=1232
int Width=709
int Height=108
int TabOrder=50
string Text="Add an Unsigned Long Value"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_addvalue("Unsigned Long")

end event

type cb_multistring from commandbutton within w_registry_functions
int X=50
int Y=1112
int Width=709
int Height=108
int TabOrder=40
string Text="Add a Multi String Value"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_addvalue("Multi String")

end event

type cb_expstring from commandbutton within w_registry_functions
int X=50
int Y=996
int Width=709
int Height=108
int TabOrder=30
string Text="Add an Expanded String Value"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_addvalue("Expanded String")

end event

type cb_string from commandbutton within w_registry_functions
int X=50
int Y=880
int Width=709
int Height=108
int TabOrder=20
string Text="Add a String Value"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_addvalue("String")

end event

type lv_values from listview within w_registry_functions
int X=5
int Y=20
int Width=2551
int Height=780
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean HideSelection=false
ListViewView View=ListViewReport!
int LargePictureWidth=32
int LargePictureHeight=32
long LargePictureMaskColor=12632256
string SmallPictureName[]={"icostr.bmp",&
"iconum.bmp"}
int SmallPictureWidth=16
int SmallPictureHeight=16
long SmallPictureMaskColor=12632256
long StatePictureMaskColor=553648127
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event doubleclicked;String	ls_Type, ls_Name

If index < 1 Then Return

GetItem(index, 1, ls_Name)

ls_Type = of_gettype(ls_Name)
ls_Name = Left(ls_Name, (Pos(ls_Name, " (") - 1))

of_addvalue(ls_Type, ls_Name)

end event

