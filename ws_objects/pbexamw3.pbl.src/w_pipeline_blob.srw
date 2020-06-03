$PBExportHeader$w_pipeline_blob.srw
$PBExportComments$Data pipeline example using a blob
forward
global type w_pipeline_blob from w_center
end type
type st_errors from statictext within w_pipeline_blob
end type
type st_written from statictext within w_pipeline_blob
end type
type st_read from statictext within w_pipeline_blob
end type
type st_4 from statictext within w_pipeline_blob
end type
type st_3 from statictext within w_pipeline_blob
end type
type st_2 from statictext within w_pipeline_blob
end type
type st_1 from statictext within w_pipeline_blob
end type
type dw_errors from datawindow within w_pipeline_blob
end type
type dw_result from datawindow within w_pipeline_blob
end type
type cb_help from commandbutton within w_pipeline_blob
end type
type cb_close from commandbutton within w_pipeline_blob
end type
type cb_execute from commandbutton within w_pipeline_blob
end type
end forward

global type w_pipeline_blob from w_center
int X=281
int Y=4
int Width=2369
int Height=1857
boolean TitleBar=true
string Title="Blob Columns in a Data Pipeline"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_errors st_errors
st_written st_written
st_read st_read
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
dw_errors dw_errors
dw_result dw_result
cb_help cb_help
cb_close cb_close
cb_execute cb_execute
end type
global w_pipeline_blob w_pipeline_blob

forward prototypes
public function integer of_drop_table ()
end prototypes

public function integer of_drop_table ();// Drop the new table if it already exists

Execute Immediate "DROP TABLE ole_copy";
If sqlca.SQLCode <> 0 Then
	If sqlca.SQLDBCode <> -141 Then
		// -141 means the table did not already exist
		MessageBox("Error","Could not drop the new table.  Error:  " + &
							String(sqlca.SQLDBCode) + " - " + sqlca.SQLErrText);
		Return sqlca.SQLCode
	End If
End If

commit;

Return 0

end function

on w_pipeline_blob.create
this.st_errors=create st_errors
this.st_written=create st_written
this.st_read=create st_read
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_errors=create dw_errors
this.dw_result=create dw_result
this.cb_help=create cb_help
this.cb_close=create cb_close
this.cb_execute=create cb_execute
this.Control[]={ this.st_errors,&
this.st_written,&
this.st_read,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_errors,&
this.dw_result,&
this.cb_help,&
this.cb_close,&
this.cb_execute}
end on

on w_pipeline_blob.destroy
destroy(this.st_errors)
destroy(this.st_written)
destroy(this.st_read)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_errors)
destroy(this.dw_result)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.cb_execute)
end on

event close;of_drop_table()

Show(w_main)

end event

event open;call super::open;dw_result.SetTrans(sqlca)

end event

type st_errors from statictext within w_pipeline_blob
int X=1384
int Y=4
int Width=150
int Height=65
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_written from statictext within w_pipeline_blob
int X=1003
int Y=4
int Width=150
int Height=65
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_read from statictext within w_pipeline_blob
int X=491
int Y=4
int Width=150
int Height=65
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_4 from statictext within w_pipeline_blob
int X=1170
int Y=7
int Width=200
int Height=65
boolean Enabled=false
string Text="Errors:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_3 from statictext within w_pipeline_blob
int X=648
int Y=7
int Width=345
int Height=65
boolean Enabled=false
string Text="Rows Written:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_2 from statictext within w_pipeline_blob
int X=171
int Y=7
int Width=299
int Height=65
boolean Enabled=false
string Text="Rows Read:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_pipeline_blob
int X=8
int Y=93
int Width=356
int Height=65
boolean Enabled=false
string Text="Pipeline Errors:"
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
long BorderColor=8388608
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_errors from datawindow within w_pipeline_blob
int X=8
int Y=161
int Width=1913
int Height=276
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_result from datawindow within w_pipeline_blob
int X=8
int Y=455
int Width=1913
int Height=1265
string DataObject="d_ole_blob"
BorderStyle BorderStyle=StyleShadowBox!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_help from commandbutton within w_pipeline_blob
int X=1985
int Y=231
int Width=328
int Height=84
int TabOrder=30
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_pipeline_blob")

end event

type cb_close from commandbutton within w_pipeline_blob
int X=1985
int Y=119
int Width=328
int Height=84
int TabOrder=20
string Text="Close"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close(Parent)

end event

type cb_execute from commandbutton within w_pipeline_blob
int X=1985
int Y=7
int Width=328
int Height=84
int TabOrder=10
string Text="Execute Pipe"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer			li_RC
Transaction	lt_Source
p_pipe_wmeter	lp_Create

SetPointer(HourGlass!)

This.Enabled = False
cb_close.Enabled = False

If of_drop_table() <> 0 Then Return
dw_result.Reset()

// lt_Source will be the source transaction, sqlca is the destination.
lt_Source = CREATE Transaction

lt_Source.dbms   = sqlca.dbms
lt_Source.database = sqlca.database
lt_Source.userid   = sqlca.userid
lt_Source.dbpass = sqlca.dbpass
lt_Source.logid  = sqlca.logid
lt_Source.logpass  = sqlca.logpass
lt_Source.servername   = sqlca.servername
lt_Source.dbparm = sqlca.dbparm

Connect using lt_Source;
If lt_Source.sqlcode <> 0 Then 
	Messagebox("Source Connect Err", lt_Source.sqlerrtext)
	Return
End If

// Create the local pipeline object to create the new table.
lp_Create = CREATE p_pipe_wmeter
lp_Create.st_read = st_read
lp_Create.st_written = st_written
lp_Create.st_errors = st_errors

// Open a status window.
OpenWithParm(w_pipe_status, "Creating/Loading New Table")

lp_Create.DataObject = "p_create_ole_blob" 

// Execute the pipe.
li_RC = lp_Create.Start(lt_Source, sqlca, dw_errors)

If li_RC <> 1 Then 
	MessageBox("Create New Table","Error return code: " + string(li_rc))
End if

Commit;

DESTROY lp_Create

Disconnect Using lt_Source;
DESTROY lt_Source

w_pipe_status.st_msg.Text = "Displaying Results"

// Retrieve data into display DataWindow
dw_result.Retrieve()

Close(w_pipe_status)

This.Enabled = True
cb_close.Enabled = True

end event

