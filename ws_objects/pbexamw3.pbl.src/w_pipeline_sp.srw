$PBExportHeader$w_pipeline_sp.srw
$PBExportComments$Stored procedure source data pipeline example
forward
global type w_pipeline_sp from w_center
end type
type st_6 from statictext within w_pipeline_sp
end type
type st_5 from statictext within w_pipeline_sp
end type
type st_time from statictext within w_pipeline_sp
end type
type st_errors from statictext within w_pipeline_sp
end type
type st_written from statictext within w_pipeline_sp
end type
type st_read from statictext within w_pipeline_sp
end type
type st_4 from statictext within w_pipeline_sp
end type
type st_3 from statictext within w_pipeline_sp
end type
type st_2 from statictext within w_pipeline_sp
end type
type st_1 from statictext within w_pipeline_sp
end type
type dw_errors from datawindow within w_pipeline_sp
end type
type dw_result from datawindow within w_pipeline_sp
end type
type cb_help from commandbutton within w_pipeline_sp
end type
type cb_close from commandbutton within w_pipeline_sp
end type
type cb_execute from commandbutton within w_pipeline_sp
end type
type rb_sp from radiobutton within w_pipeline_sp
end type
type rb_query from radiobutton within w_pipeline_sp
end type
type gb_1 from groupbox within w_pipeline_sp
end type
end forward

global type w_pipeline_sp from w_center
int X=129
int Y=5
int Width=2677
int Height=1857
boolean TitleBar=true
string Title="Stored Procedure Source Data Pipeline"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
st_6 st_6
st_5 st_5
st_time st_time
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
rb_sp rb_sp
rb_query rb_query
gb_1 gb_1
end type
global w_pipeline_sp w_pipeline_sp

forward prototypes
public function integer of_drop_table ()
end prototypes

public function integer of_drop_table ();Integer	li_NotExist

Choose Case Lower(Left(sqlca.DBMS, 3))
	Case "odb"
		li_NotExist = -141
	Case "syb"
		li_NotExist = 3701
	Case "syc"
		li_NotExist = 3701
	Case "ora"
		li_NotExist = 3701
End Choose

// Drop the new table if it already exists
sqlca.AutoCommit = True
Execute Immediate "DROP TABLE full_sales_orders";
If sqlca.SQLCode <> 0 Then
	If sqlca.SQLDBCode <> li_NotExist Then
		// -141 means the table did not already exist
		sqlca.AutoCommit = False
		MessageBox("Error","Could not drop the new table.  Error:  " + &
							String(sqlca.SQLDBCode) + " - " + sqlca.SQLErrText);
		Return sqlca.SQLCode
	End If
End If
sqlca.AutoCommit = False

commit;

Return 0

end function

on w_pipeline_sp.create
this.st_6=create st_6
this.st_5=create st_5
this.st_time=create st_time
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
this.rb_sp=create rb_sp
this.rb_query=create rb_query
this.gb_1=create gb_1
this.Control[]={ this.st_6,&
this.st_5,&
this.st_time,&
this.st_errors,&
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
this.cb_execute,&
this.rb_sp,&
this.rb_query,&
this.gb_1}
end on

on w_pipeline_sp.destroy
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_time)
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
destroy(this.rb_sp)
destroy(this.rb_query)
destroy(this.gb_1)
end on

event close;of_drop_table()

Show(w_main)

end event

event open;call super::open;dw_result.SetTrans(sqlca)

end event

type st_6 from statictext within w_pipeline_sp
int X=2129
int Y=629
int Width=193
int Height=65
boolean Enabled=false
string Text="secs."
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_5 from statictext within w_pipeline_sp
int X=1745
int Y=629
int Width=193
int Height=65
boolean Enabled=false
string Text="Time:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_time from statictext within w_pipeline_sp
int X=1965
int Y=629
int Width=149
int Height=65
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_errors from statictext within w_pipeline_sp
int X=1581
int Y=629
int Width=149
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

type st_written from statictext within w_pipeline_sp
int X=1201
int Y=629
int Width=149
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

type st_read from statictext within w_pipeline_sp
int X=689
int Y=629
int Width=149
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

type st_4 from statictext within w_pipeline_sp
int X=1373
int Y=629
int Width=201
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

type st_3 from statictext within w_pipeline_sp
int X=845
int Y=629
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

type st_2 from statictext within w_pipeline_sp
int X=373
int Y=629
int Width=297
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

type st_1 from statictext within w_pipeline_sp
int X=9
int Y=277
int Width=357
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

type dw_errors from datawindow within w_pipeline_sp
int X=9
int Y=349
int Width=2601
int Height=245
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

type dw_result from datawindow within w_pipeline_sp
int X=9
int Y=709
int Width=2601
int Height=1021
string DataObject="d_full_sales_orders"
BorderStyle BorderStyle=StyleShadowBox!
boolean VScrollBar=true
boolean LiveScroll=true
end type

type cb_help from commandbutton within w_pipeline_sp
int X=2281
int Y=101
int Width=329
int Height=85
int TabOrder=40
string Text="Help"
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;f_open_help ("w_pipeline_sp")

end event

type cb_close from commandbutton within w_pipeline_sp
int X=1921
int Y=101
int Width=329
int Height=85
int TabOrder=30
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

type cb_execute from commandbutton within w_pipeline_sp
int X=577
int Y=101
int Width=329
int Height=85
int TabOrder=20
string Text="Execute Pipe"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Integer			li_RC
Long				ll_Start, ll_End
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

// Set the data object based on the radio button checked.
If rb_query.Checked Then
	lp_Create.DataObject = "p_create_full_sales_orders" 
Else
	lp_Create.DataObject = "p_create_full_sales_orders_sp" 
End If

// Execute the pipe.
// Get the time for a total elapsed time.
ll_Start = CPU()

li_RC = lp_Create.Start(lt_Source, sqlca, dw_errors)

// Get the ending time.
ll_End = CPU()
st_time.Text = String((ll_End - ll_Start)/1000,"##0.0")

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

type rb_sp from radiobutton within w_pipeline_sp
int X=41
int Y=93
int Width=481
int Height=65
string Text="Stored Procedure"
boolean Checked=true
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_query from radiobutton within w_pipeline_sp
int X=41
int Y=157
int Width=345
int Height=65
string Text="SQL Query"
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_pipeline_sp
int X=17
int Y=29
int Width=513
int Height=225
int TabOrder=10
string Text="Data Source"
BorderStyle BorderStyle=StyleLowered!
long TextColor=41943040
long BackColor=74481808
int TextSize=-8
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

