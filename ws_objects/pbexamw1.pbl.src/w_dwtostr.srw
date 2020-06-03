$PBExportHeader$w_dwtostr.srw
$PBExportComments$DataWindow to Structure Utility example
forward
global type w_dwtostr from w_center
end type
type cb_help from commandbutton within w_dwtostr
end type
type cb_createsyntax from commandbutton within w_dwtostr
end type
type rb_autonvo from radiobutton within w_dwtostr
end type
type rb_structure from radiobutton within w_dwtostr
end type
type cb_close from commandbutton within w_dwtostr
end type
type st_7 from statictext within w_dwtostr
end type
type st_6 from statictext within w_dwtostr
end type
type st_5 from statictext within w_dwtostr
end type
type sle_filename from singlelineedit within w_dwtostr
end type
type cb_savesyntax from commandbutton within w_dwtostr
end type
type mle_comment from multilineedit within w_dwtostr
end type
type dw_datatype from datawindow within w_dwtostr
end type
type st_4 from statictext within w_dwtostr
end type
type st_3 from statictext within w_dwtostr
end type
type ddplb_dw from dropdownpicturelistbox within w_dwtostr
end type
type st_2 from statictext within w_dwtostr
end type
type st_1 from statictext within w_dwtostr
end type
type sle_prefix from singlelineedit within w_dwtostr
end type
type sle_lib from singlelineedit within w_dwtostr
end type
type mle_syntax from multilineedit within w_dwtostr
end type
type cb_openpbl from commandbutton within w_dwtostr
end type
type gb_1 from groupbox within w_dwtostr
end type
end forward

global type w_dwtostr from w_center
int X=0
int Y=4
int Width=1710
int Height=1444
boolean TitleBar=true
string Title="Datawindow to Structure"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_help cb_help
cb_createsyntax cb_createsyntax
rb_autonvo rb_autonvo
rb_structure rb_structure
cb_close cb_close
st_7 st_7
st_6 st_6
st_5 st_5
sle_filename sle_filename
cb_savesyntax cb_savesyntax
mle_comment mle_comment
dw_datatype dw_datatype
st_4 st_4
st_3 st_3
ddplb_dw ddplb_dw
st_2 st_2
st_1 st_1
sle_prefix sle_prefix
sle_lib sle_lib
mle_syntax mle_syntax
cb_openpbl cb_openpbl
gb_1 gb_1
end type
global w_dwtostr w_dwtostr

type variables
datastore ids_lib_string, ids_create
string       is_lib
string       is_struct_name
string       is_str_syntax
string	is_file_ext=".srs"
string       is_comment
string       is_prefix="str"

end variables

forward prototypes
public function integer of_save_syntax ()
public function integer of_create_structure_export ()
public function integer of_create_auto_nvo_export ()
public function integer of_set_new (integer ai_index)
end prototypes

public function integer of_save_syntax ();int		li_file_handle

if sle_filename.text = "" then
	messagebox("Invalid File Name", "Please enter a file name.", Exclamation!)
	return -1
end if

setpointer(hourglass!)

li_file_handle = fileopen(sle_filename.text, linemode!, write!, lockwrite!, replace!)

filewrite(li_file_handle, is_str_syntax)

fileclose(li_file_handle)

return 1

end function

public function integer of_create_structure_export ();string ls_header="$PBExportHeader$"
string ls_comment="$PBExportComments$"
string ls_file_ext=".srs"
string ls_type = "global type "
string ls_name 
string ls_type_end = " from structure"
string ls_end = "end type"
string ls_tab = "~t"
string ls_return ="~r~n"
string ls_export_txt
string ls_filename
int    li_i, li_count, li_file_handle
string ls_data_type
long   ll_pos
int    li_len

// set header
ls_export_txt = ls_header+is_prefix+is_struct_name+ls_file_ext+ls_return

if is_comment <> "" THEN
	ls_export_txt += ls_comment+is_comment+ls_return
end if

ls_export_txt += ls_type+ls_tab+is_prefix+is_struct_name+ls_type_end+ls_return

li_count = dw_datatype.rowcount()

for li_i=1 to li_count
	// set data type value
	ls_data_type = dw_datatype.object.coltype[li_i]
	if  pos(ls_data_type, "decimal") > 0 then
		li_len = (pos(ls_data_type, ")") - pos(ls_data_type,"(")) -1
		ls_data_type = "decimal {" + mid(ls_data_type, pos(ls_data_type,"(")+1, li_len) + "}"
		
	elseif pos(ls_data_type, "char") > 0 then
		ls_data_type="string"
	elseif pos(ls_data_type, "num") > 0 then
		ls_data_type="integer"
	end if
	ls_export_txt += ls_tab+ls_data_type+ls_tab+dw_datatype.object.colname[li_i]+ls_return

next

ls_export_txt += ls_end

is_str_syntax = ls_export_txt

mle_syntax.text = ls_export_txt

return 1

end function

public function integer of_create_auto_nvo_export ();string ls_header="$PBExportHeader$"
string ls_comment="$PBExportComments$"
string ls_file_ext=".sru"
string ls_global_type = "global type "
string ls_global = "global "
string ls_forward = "forward"
string ls_end_forward = "end forward"
string ls_global_type_auto = " from nonvisualobject autoinstantiate"
string ls_type_vars = "type variables"
string ls_end_vars = "end variables"
string ls_event_con = "TriggerEvent( this, ~"constructor~" )"
string ls_event_des = "TriggerEvent( this, ~"destructor~" )"
string ls_name 
string ls_type_end = " from nonvisualobject"
string ls_end_type = "end type"
string ls_tab = "~t"
string ls_return ="~r~n"
string ls_export_txt
string ls_data_type
int    li_i, li_count
int    li_file_handle
int    li_len
long   ll_pos

// set header
ls_export_txt = ls_header+is_prefix+is_struct_name+ls_file_ext+ls_return

if is_comment <> "" THEN
	ls_export_txt += ls_comment+is_comment+ls_return
end if

// forward
ls_export_txt += ls_return
ls_export_txt += ls_forward+ls_return
ls_export_txt += ls_global_type+is_prefix+is_struct_name+ls_type_end+ls_return
ls_export_txt += ls_end_type+ls_return
ls_export_txt += ls_end_forward+ls_return

// global
ls_export_txt += ls_return
ls_export_txt += ls_global_type+is_prefix+is_struct_name+ls_global_type_auto+ls_return
ls_export_txt += ls_end_type+ls_return

// global definition
ls_export_txt += ls_global+is_prefix+is_struct_name+" "+is_prefix+is_struct_name+ls_return

// type variables
ls_export_txt += ls_return
ls_export_txt += ls_type_vars+ls_return

// set data types
li_count = dw_datatype.rowcount()

for li_i=1 to li_count
	// set data type value
	ls_data_type = dw_datatype.object.coltype[li_i]
	
	if  pos(ls_data_type, "decimal") > 0 then
		li_len = (pos(ls_data_type, ")") - pos(ls_data_type,"(")) -1
		ls_data_type = "decimal {" + mid(ls_data_type, pos(ls_data_type,"(")+1, li_len) + "}"
		
	elseif pos(ls_data_type, "char") > 0 then
		ls_data_type="string"
	elseif pos(ls_data_type, "num") > 0 then
		ls_data_type="integer"
	end if
	ls_export_txt += ls_tab+ls_data_type+ls_tab+dw_datatype.object.colname[li_i]+ls_return
next
// end type variables
ls_export_txt += ls_end_vars+ls_return

// constructor event
ls_export_txt += ls_return
ls_export_txt += "on "+is_prefix+is_struct_name+".create"+ls_return
ls_export_txt += ls_event_con+ls_return
ls_export_txt += "end on"+ls_return

// destructor event
ls_export_txt += ls_return
ls_export_txt += "on "+is_prefix+is_struct_name+".destroy"+ls_return
ls_export_txt += ls_event_des+ls_return
ls_export_txt += "end on"+ls_return

// set instance variable
is_str_syntax = ls_export_txt

// set mle text
mle_syntax.text = ls_export_txt

return 1

end function

public function integer of_set_new (integer ai_index);// this function is called to set up everything for a new datawindow selection
string ls_colname[]
string ls_coltype[]
string ls_colcomment
string ls_syntax
string ls_dw
int   li_i, li_count

ls_dw = ids_lib_string.object.name[ai_index]

// set object name
is_struct_name = mid(ls_dw, (pos(ls_dw,"_") +1))
// set prefix for object
is_prefix = sle_prefix.text

// create the DataWindow
ls_syntax = LibraryExport(is_lib, ls_dw, ExportDataWindow!)
if ids_create.create(ls_syntax) < 0 then
	messagebox("Syntax Error", "Error creating DataWindow.")
	return -1
end if

// set comment
if not isnull(ids_lib_string.object.comments[ai_index]) THEN
	is_comment = ids_lib_string.object.comments[ai_index]
	mle_comment.text = is_comment
end if

// parse datawindow for column names and data types
dw_datatype.reset()

li_count = Integer(ids_create.describe("datawindow.column.count"))
if li_count < 1 THEN
	return -1
end if

for li_i=1 to li_count
	ls_colname[li_i] = ids_create.describe("#" + String(li_i) + ".name")
	ls_coltype[li_i] = ids_create.describe(ls_colname[li_i]+".coltype")
	dw_datatype.object.colname[li_i] = ls_colname[li_i]
	dw_datatype.object.coltype[li_i] = ls_coltype[li_i]
next

return 1

end function

on w_dwtostr.create
this.cb_help=create cb_help
this.cb_createsyntax=create cb_createsyntax
this.rb_autonvo=create rb_autonvo
this.rb_structure=create rb_structure
this.cb_close=create cb_close
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.sle_filename=create sle_filename
this.cb_savesyntax=create cb_savesyntax
this.mle_comment=create mle_comment
this.dw_datatype=create dw_datatype
this.st_4=create st_4
this.st_3=create st_3
this.ddplb_dw=create ddplb_dw
this.st_2=create st_2
this.st_1=create st_1
this.sle_prefix=create sle_prefix
this.sle_lib=create sle_lib
this.mle_syntax=create mle_syntax
this.cb_openpbl=create cb_openpbl
this.gb_1=create gb_1
this.Control[]={ this.cb_help,&
this.cb_createsyntax,&
this.rb_autonvo,&
this.rb_structure,&
this.cb_close,&
this.st_7,&
this.st_6,&
this.st_5,&
this.sle_filename,&
this.cb_savesyntax,&
this.mle_comment,&
this.dw_datatype,&
this.st_4,&
this.st_3,&
this.ddplb_dw,&
this.st_2,&
this.st_1,&
this.sle_prefix,&
this.sle_lib,&
this.mle_syntax,&
this.cb_openpbl,&
this.gb_1}
end on

on w_dwtostr.destroy
destroy(this.cb_help)
destroy(this.cb_createsyntax)
destroy(this.rb_autonvo)
destroy(this.rb_structure)
destroy(this.cb_close)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.sle_filename)
destroy(this.cb_savesyntax)
destroy(this.mle_comment)
destroy(this.dw_datatype)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.ddplb_dw)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_prefix)
destroy(this.sle_lib)
destroy(this.mle_syntax)
destroy(this.cb_openpbl)
destroy(this.gb_1)
end on

event open;call super::open;ids_lib_string = create datastore
ids_lib_string.dataobject = "d_lib_string"

ids_create = create datastore

end event

event close;Destroy ids_lib_string
Destroy ids_create
show(w_main)

end event

type cb_help from commandbutton within w_dwtostr
int X=1184
int Y=1152
int Width=338
int Height=84
int TabOrder=100
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help("w_dwtostr")

end event

type cb_createsyntax from commandbutton within w_dwtostr
int X=1184
int Y=720
int Width=338
int Height=84
int TabOrder=70
string Text="Create Syntax"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string		ls_filename

// set output filename
ls_filename = is_prefix+is_struct_name+is_file_ext
// set filename sle
sle_filename.text = ls_filename

//check the type of sysntax to create
if rb_structure.checked THEN
	of_create_structure_export ( )
else
	of_create_auto_nvo_export ( )
end if

// stretch window to additional info
parent.width = 2975
end event

type rb_autonvo from radiobutton within w_dwtostr
int X=1102
int Y=364
int Width=526
int Height=76
string Text="Autoinstantiate NVO"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_prefix = "n_cst_"
is_file_ext=".sru"

sle_prefix.text = is_prefix

end event

type rb_structure from radiobutton within w_dwtostr
int X=1097
int Y=292
int Width=320
int Height=76
string Text="Structure"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=78682240
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_prefix = "str_"
is_file_ext=".srs"

sle_prefix.text = is_prefix

end event

type cb_close from commandbutton within w_dwtostr
int X=1184
int Y=1008
int Width=338
int Height=84
int TabOrder=90
string Text="Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close(parent)
end event

type st_7 from statictext within w_dwtostr
int X=1696
int Y=240
int Width=416
int Height=48
boolean Enabled=false
string Text="Syntax:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_6 from statictext within w_dwtostr
int X=9
int Y=964
int Width=233
int Height=64
boolean Enabled=false
string Text="Comment:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_dwtostr
int X=1696
int Y=48
int Width=338
int Height=48
boolean Enabled=false
string Text="File Name:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_filename from singlelineedit within w_dwtostr
int X=1696
int Y=112
int Width=1221
int Height=80
int TabOrder=110
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_savesyntax from commandbutton within w_dwtostr
int X=1184
int Y=864
int Width=338
int Height=84
int TabOrder=80
string Text="Save Syntax"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;of_save_syntax()

end event

type mle_comment from multilineedit within w_dwtostr
int X=9
int Y=1028
int Width=1033
int Height=300
int TabOrder=60
BorderStyle BorderStyle=StyleLowered!
boolean AutoVScroll=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_datatype from datawindow within w_dwtostr
int X=9
int Y=452
int Width=1033
int Height=480
string DataObject="d_datatype"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type st_4 from statictext within w_dwtostr
int X=1129
int Y=512
int Width=137
int Height=60
boolean Enabled=false
string Text="Prefix:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_dwtostr
int X=9
int Y=388
int Width=489
int Height=64
boolean Enabled=false
string Text="Data type:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type ddplb_dw from dropdownpicturelistbox within w_dwtostr
int X=9
int Y=244
int Width=1033
int Height=512
int TabOrder=30
BorderStyle BorderStyle=StyleLowered!
boolean Sorted=false
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string PictureName[]={"DataWindow5!"}
long PictureMaskColor=553648127
end type

event selectionchanged;setpointer(hourglass!)

// call function to set everything
of_set_new(index)

end event

type st_2 from statictext within w_dwtostr
int X=9
int Y=180
int Width=361
int Height=64
boolean Enabled=false
string Text="Datawindow:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_dwtostr
int X=9
int Y=20
int Width=174
int Height=64
boolean Enabled=false
string Text="PBL:"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_prefix from singlelineedit within w_dwtostr
int X=1280
int Y=500
int Width=201
int Height=80
int TabOrder=50
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
string Text="str_"
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;is_prefix = this.text
end event

type sle_lib from singlelineedit within w_dwtostr
int X=9
int Y=84
int Width=1033
int Height=80
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

event modified;int    li_i, li_count
string ls_objects

setpointer(hourglass!)

if Trim(This.Text) <> "" THEN
	dw_datatype.reset()
	ids_lib_string.reset()
	ddplb_dw.reset()
	mle_comment.text = ""
	
	ls_objects = LibraryDirectory ( This.Text, dirdatawindow!)
	If IsNull(This.Text) Or Trim(This.Text) = "" THEN return
	
	is_lib = This.Text
	
	if ls_objects <> "" THEN
		ids_lib_string.importstring(ls_objects)
		ids_lib_string.sort()
		li_count = ids_lib_string.rowcount()
		// add datawindow to list box
		if li_count > 0 THEN
			for  li_i=1 to li_count
			     ddplb_dw.additem(ids_lib_string.object.name[li_i], 1)
			next
		end if
			
	end if
end if

end event

type mle_syntax from multilineedit within w_dwtostr
int X=1696
int Y=304
int Width=1221
int Height=1028
int TabOrder=120
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

type cb_openpbl from commandbutton within w_dwtostr
int X=1184
int Y=84
int Width=338
int Height=84
int TabOrder=20
string Text="Select PBL"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_file, ls_path

GetFileOpenName ( "Select Library to Open", ls_path, ls_file, "PBL",&
"Library Files (*.pbl),*.pbl")  

sle_lib.text = ls_path
sle_lib.post event modified()

end event

type gb_1 from groupbox within w_dwtostr
int X=1079
int Y=228
int Width=558
int Height=240
int TabOrder=40
string Text="Object Type"
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

