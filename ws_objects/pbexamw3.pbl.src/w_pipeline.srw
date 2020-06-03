$PBExportHeader$w_pipeline.srw
$PBExportComments$Main window of the pipeline example
forward
global type w_pipeline from w_center
end type
type cb_reset from commandbutton within w_pipeline
end type
type st_5 from statictext within w_pipeline
end type
type st_4 from statictext within w_pipeline
end type
type st_3 from statictext within w_pipeline
end type
type dw_dept from datawindow within w_pipeline
end type
type cb_close from commandbutton within w_pipeline
end type
type cb_help from commandbutton within w_pipeline
end type
type st_2 from statictext within w_pipeline
end type
type st_1 from statictext within w_pipeline
end type
type st_time from statictext within w_pipeline
end type
type dw_transaction from datawindow within w_pipeline
end type
type dw_master from datawindow within w_pipeline
end type
type st_inerror from statictext within w_pipeline
end type
type st_written from statictext within w_pipeline
end type
type st_read from statictext within w_pipeline
end type
type cb_cancel from commandbutton within w_pipeline
end type
type cb_repair from commandbutton within w_pipeline
end type
type cb_execute from commandbutton within w_pipeline
end type
type dw_1 from datawindow within w_pipeline
end type
type gb_4 from groupbox within w_pipeline
end type
type gb_3 from groupbox within w_pipeline
end type
type gb_2 from groupbox within w_pipeline
end type
type gb_1 from groupbox within w_pipeline
end type
end forward

global type w_pipeline from w_center
integer x = 18
integer y = 84
integer width = 2912
integer height = 1828
string title = "Pipeline Test"
long backcolor = 79416533
toolbaralignment toolbaralignment = alignatleft!
event ue_postopen pbm_custom01
cb_reset cb_reset
st_5 st_5
st_4 st_4
st_3 st_3
dw_dept dw_dept
cb_close cb_close
cb_help cb_help
st_2 st_2
st_1 st_1
st_time st_time
dw_transaction dw_transaction
dw_master dw_master
st_inerror st_inerror
st_written st_written
st_read st_read
cb_cancel cb_cancel
cb_repair cb_repair
cb_execute cb_execute
dw_1 dw_1
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_pipeline w_pipeline

type variables
Transaction i_src, i_dst
p_pipe_wmeter i_pipe
end variables

forward prototypes
public subroutine wf_disconnect_db ()
public subroutine wf_connect_db ()
public subroutine wf_reset_window ()
end prototypes

event ue_postopen;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// ue_postopen script for w_pipeline
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


//function to connect to source & destination transactions to the database
wf_connect_db()

//create a instance scope pipeline and set its output objects
//the output objects will allow you to monitor the status during the pipeline 
//execution
i_pipe = create p_pipe_wmeter
i_pipe.st_read    = st_read
i_pipe.st_written = st_written
i_pipe.st_errors  = st_inerror

//pipe object to do the transaction to master updates
i_pipe.dataobject = "p_emp_master_transaction_update"

//this function will create the tables necessary for the example
//and load the datawindow monitors views.
wf_reset_window()

end event

public subroutine wf_disconnect_db ();disconnect using i_src;
disconnect using i_dst;

end subroutine

public subroutine wf_connect_db ();//wf_connect_db

//create transactions and connect to the database


//i_src will be the source transaction
i_src = create transaction

i_src.dbms   = sqlca.dbms
i_src.database = sqlca.database
i_src.userid   = sqlca.userid
i_src.dbpass = sqlca.dbpass
i_src.logid  = sqlca.logid
i_src.logpass  = sqlca.logpass
i_src.servername   = sqlca.servername
i_src.dbparm = sqlca.dbparm

connect using i_src;
If i_src.sqlcode <> 0 then 
	Messagebox("Source Connect Err",i_src.sqlerrtext)
	Return
End If

//i_src will be the destination transaction
i_dst = create transaction

i_dst.dbms   = sqlca.dbms
i_dst.database = sqlca.database
i_dst.userid   = sqlca.userid
i_dst.dbpass = sqlca.dbpass
i_dst.logid  = sqlca.logid
i_dst.logpass  = sqlca.logpass
i_dst.servername   = sqlca.servername
i_dst.dbparm = sqlca.dbparm

connect using i_dst;
If i_dst.sqlcode <> 0 then 
	Messagebox("Destination Connect Err",i_dst.sqlerrtext)
	Return
End If

end subroutine

public subroutine wf_reset_window ();p_pipe_wometer lp_setup
string ls_sql
int li_rc

//this will create two new tables (or drop and create, if already exists) using pipeline 
//objects

//The contents of the the two new tables will be loaded in the two datawindows

SetPointer(Hourglass!)

//disable all buttons during process
cb_close.enabled = False
cb_cancel.enabled = False
cb_repair.enabled = False
cb_execute.enabled = False
cb_reset.enabled = False

//create a local pipeline object. This object (a user object inherited from the pipeline object)
//will not have meters. The meters are used to keep track of records read and written.

lp_setup = create p_pipe_wometer

//open window showing whats going on
openwithparm(w_pipe_status,"Creating/Loading Master Employee Table")

//create / reset master table
//this assigns the pipeline object that was created in the pipeline painter to the local
//instance of the pipe object. The struture and data for this table is the employee table 
//in the example database.
lp_setup.dataobject = "p_emp_master_create" 

li_rc = lp_setup.Start(i_src, i_dst, dw_1)
If li_rc <> 1 then 
	messagebox("Create Master Error","Err return code: " + string(li_rc))
End if
commit using i_src;
commit using i_dst;

//create a foreign key between employee master and dept table
//this will allow us to simulate an error during the update of the example
Choose Case Left(Lower(i_src.dbms), 3)
	Case "syb"
		Execute Immediate "EXEC sp_foreignkey emp_pipe_master, department, dept_id" Using i_dst;
	Case "odb"
//		Execute Immediate "ALTER TABLE ~"dba~".~"department~" DELETE FOREIGN KEY ~"fk1~"" Using i_dst;
//		Execute Immediate "ALTER TABLE ~"dba~".~"department~" ADD FOREIGN KEY ~"fk1~"(~"dept_id~") REFERENCES ~"dba~".~"employee~""
//		Using i_dst;
	Case Else
		i_dst.AutoCommit = TRUE
		Execute Immediate "Alter table emp_pipe_master add constraint fk1_ep_master foreign key (dept_id) references department (dept_id)"
		Using i_dst;
		i_dst.AutoCommit = FALSE
End Choose

If i_dst.SQLCode <> 0 then 
	MessageBox("Error",i_dst.SQLErrText);
End If


//load dw of master data
dw_master.settransobject(i_dst)
dw_master.retrieve()

//this is the status window
close(w_pipe_status)

SetPointer(Hourglass!)
//open window showing whats going on
openwithparm(w_pipe_status,"Creating/Loading Transaction Employee Table")

//create / reset transaction table
//this assigns the pipeline object that was created in the pipeline painter to the local
//instance of the pipe object. The structure for this is the employee table in the example
//database. Note:The data to populate the transaction table is stored in the pipeline 
//object itself.
lp_setup.dataobject = "p_emp_transaction_create"
li_rc = lp_setup.Start(i_src,i_dst,dw_1)
If li_rc <> 1 then messagebox("Create Transaction Error","Err return code " + string(li_rc))

//load transactions datawindow with new table contents.
dw_transaction.settransobject(i_dst)
dw_transaction.retrieve()


//valid choices of departments for the transaction file
dw_dept.settransobject(i_dst)
dw_dept.retrieve()



//renable all buttons during process
cb_close.enabled = True
cb_cancel.enabled = True
cb_repair.enabled = True
cb_execute.enabled = True
cb_reset.enabled = True


close(w_pipe_status)


end subroutine

event close;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// close script for w_pipeline
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


//delete tables created during the example

//commit any prior transactions that may have taken place that would
//prevent a delete from being successful.
commit using i_dst;
commit using i_src;
commit using sqlca;

//using the Execute Immediate delete the two tables created
i_dst.AutoCommit = TRUE
Execute Immediate "DROP TABLE emp_pipe_master" Using i_dst;
If i_dst.SQLCode <> 0 then 
	MessageBox("Error","Could not drop the emp_pipe_master table");
End If

Execute Immediate "DROP TABLE emp_pipe_transaction" Using i_dst;
If i_dst.SQLCode <> 0 then 
	MessageBox("Error","Could not drop the emp_pipe_transaction table");
End If
i_dst.AutoCommit = FALSE

//close pipeline transactions
wf_disconnect_db()

//free space from the creations
destroy i_pipe
destroy i_src
destroy i_dst

show (w_main)
end event

event open;call super::open;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// open script for w_pipeline
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

setpointer (hourglass!)

this.postevent("ue_postopen")
end event

on w_pipeline.create
int iCurrent
call super::create
this.cb_reset=create cb_reset
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.dw_dept=create dw_dept
this.cb_close=create cb_close
this.cb_help=create cb_help
this.st_2=create st_2
this.st_1=create st_1
this.st_time=create st_time
this.dw_transaction=create dw_transaction
this.dw_master=create dw_master
this.st_inerror=create st_inerror
this.st_written=create st_written
this.st_read=create st_read
this.cb_cancel=create cb_cancel
this.cb_repair=create cb_repair
this.cb_execute=create cb_execute
this.dw_1=create dw_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reset
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_dept
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_help
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_time
this.Control[iCurrent+11]=this.dw_transaction
this.Control[iCurrent+12]=this.dw_master
this.Control[iCurrent+13]=this.st_inerror
this.Control[iCurrent+14]=this.st_written
this.Control[iCurrent+15]=this.st_read
this.Control[iCurrent+16]=this.cb_cancel
this.Control[iCurrent+17]=this.cb_repair
this.Control[iCurrent+18]=this.cb_execute
this.Control[iCurrent+19]=this.dw_1
this.Control[iCurrent+20]=this.gb_4
this.Control[iCurrent+21]=this.gb_3
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.gb_1
end on

on w_pipeline.destroy
call super::destroy
destroy(this.cb_reset)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.dw_dept)
destroy(this.cb_close)
destroy(this.cb_help)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_time)
destroy(this.dw_transaction)
destroy(this.dw_master)
destroy(this.st_inerror)
destroy(this.st_written)
destroy(this.st_read)
destroy(this.cb_cancel)
destroy(this.cb_repair)
destroy(this.cb_execute)
destroy(this.dw_1)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_reset from commandbutton within w_pipeline
integer x = 1518
integer y = 1612
integer width = 416
integer height = 92
integer taborder = 120
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Re&set Example"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_reset
//////////////////////////////////////////////////////////////////////////////////////////////////////////


//Commit any pending transactions 
Commit using i_dst;
Commit using i_src;
Commit using sqlca;

//call function to reset database tables.
wf_reset_window()
end event

type st_5 from statictext within w_pipeline
integer x = 14
integer y = 864
integer width = 370
integer height = 64
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Pipe Errors:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_pipeline
integer x = 23
integer y = 1184
integer width = 366
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Dept to Update:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pipeline
integer x = 517
integer y = 20
integer width = 869
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "--------------------------------------------->"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_dept from datawindow within w_pipeline
integer x = 393
integer y = 1184
integer width = 430
integer height = 396
integer taborder = 40
string dataobject = "d_pipe_deptlist"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for dw_dept
///////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Highlight the clicked row
If row > 0 Then
	dw_dept.selectrow(0,False)
	dw_dept.selectrow(row,True)
End If
end event

type cb_close from commandbutton within w_pipeline
integer x = 1989
integer y = 1612
integer width = 274
integer height = 92
integer taborder = 110
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_close
//////////////////////////////////////////////////////////////////////////////////////////////////////////

close(parent)
end event

type cb_help from commandbutton within w_pipeline
integer x = 2327
integer y = 1612
integer width = 274
integer height = 92
integer taborder = 140
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Help"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_help
//////////////////////////////////////////////////////////////////////////////////////////////////////////

f_open_help(parent.classname())
end event

type st_2 from statictext within w_pipeline
integer x = 14
integer y = 20
integer width = 503
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Transaction Table: "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pipeline
integer x = 1417
integer y = 20
integer width = 366
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
string text = "Master Table:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_time from statictext within w_pipeline
integer x = 2400
integer y = 1372
integer width = 320
integer height = 68
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_transaction from datawindow within w_pipeline
integer x = 14
integer y = 96
integer width = 1362
integer height = 752
integer taborder = 20
string dataobject = "d_employee_transaction"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for dw_transaction
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


long	ll_find_row
int	li_trans_id, &
		li_master_id


//If you click on an employee  in the transaction dw, 
//find that same employee on the master dw

If row > 0 Then
	this.selectrow(0,False)
	this.selectrow(row,True)
	dw_master.SelectRow(0,False)
	li_trans_id = this.object.emp_id[row]
	ll_find_row = dw_master.Find( 'emp_id' + '=' + string(li_trans_id),0,dw_master.RowCount())
	If ll_find_row > 0 Then 
		li_master_id = dw_master.object.emp_id[ll_find_row]
		If li_trans_id = li_master_id Then
			dw_master.ScrollToRow(ll_find_row)
			dw_master.SelectRow(ll_find_row, True)
		End If
	End If
End If
end event

type dw_master from datawindow within w_pipeline
integer x = 1422
integer y = 96
integer width = 1362
integer height = 752
integer taborder = 10
string dataobject = "d_employee_master"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_inerror from statictext within w_pipeline
integer x = 1984
integer y = 1372
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
alignment alignment = center!
boolean focusrectangle = false
end type

type st_written from statictext within w_pipeline
integer x = 1518
integer y = 1372
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
alignment alignment = center!
boolean focusrectangle = false
end type

type st_read from statictext within w_pipeline
integer x = 1056
integer y = 1372
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
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_pipeline
integer x = 1056
integer y = 1612
integer width = 398
integer height = 92
integer taborder = 130
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "C&ancel Pipe"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_cancel
//////////////////////////////////////////////////////////////////////////////////////////////////////////


//pipeline function to cancel the pipeline in execution.
i_pipe.cancel ()

dw_master.retrieve()
end event

type cb_repair from commandbutton within w_pipeline
integer x = 640
integer y = 1612
integer width = 389
integer height = 92
integer taborder = 100
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Repair Pipe"
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_repair
//////////////////////////////////////////////////////////////////////////////////////////////////////////


//this is the function to grab any changes to the error datawindow (Dw_1) and
//try to commit the changes again.
i_pipe.repair (i_dst)

//update the master table in case some errors were corrected.
dw_master.retrieve()
end event

type cb_execute from commandbutton within w_pipeline
integer x = 183
integer y = 1612
integer width = 430
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "E&xecute Pipe"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for cb_execute
//////////////////////////////////////////////////////////////////////////////////////////////////////////

int 		li_rc 
int 		li_dept, li_id
long  	ll_selectrow, ll_selected_row, ll_find_row
long 	ll_stime, ll_etime

//This script will execute the pipeline update for whichever department is 
//highlighted.


//find out which dept is selected to update. if no dept is selected, don't do an update
ll_selectrow = dw_dept.GetSelectedRow(0)
If ll_selectrow > 0 Then
	li_dept = dw_dept.object.department_dept_id[ll_selectrow]
Else
	Messagebox("Execute Pipeline","You must first select a department to update.~n~r"+&
		"Use the department list  to select a department")
	Return
End IF

//disable other update functions while the update is in process
cb_repair.enabled = false
//cb_execute.enabled = false

//get time for a total elapsed time
ll_stime = Cpu ()

//execute pipeline using the dept selected as a parameter. This pipeline is setup
//to only update whichever dept is passed to it
li_rc = i_pipe.start (i_src, i_dst, dw_1,li_dept)

//get ending time
ll_etime = Cpu ()
st_time.text = string((ll_etime - ll_stime)/1000,"##0.0") + " secs"

//retrieve from master table to show changes
dw_master.SetRedraw(false)
dw_master.retrieve()


//If user had selected a row in the transaction datawindow to find in the master datawindow
//Reissue the find to highlight the row again after the pipe execution has completed.

ll_selected_row = dw_transaction.GetSelectedRow(0)
If ll_selected_row > 0 Then
	dw_transaction.selectrow(0,False)
	dw_transaction.selectrow(ll_selected_row,True)
	li_id = dw_transaction.object.emp_id[ll_selected_row]
	ll_find_row = dw_master.Find( 'emp_id' + '=' + string(li_id),0,dw_master.RowCount())
	If ll_find_row > 0 Then 
		dw_master.ScrollToRow(ll_find_row)
		dw_master.SelectRow(0,False)
		dw_master.SelectRow(ll_find_row,True)
	End If
End If


dw_master.SetRedraw(true)

//reenable other action buttons
cb_repair.enabled = true
cb_execute.enabled = true
end event

type dw_1 from datawindow within w_pipeline
integer x = 14
integer y = 936
integer width = 2775
integer height = 228
integer taborder = 30
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_pipeline
integer x = 2354
integer y = 1304
integer width = 439
integer height = 180
integer taborder = 80
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Time:"
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pipeline
integer x = 1888
integer y = 1304
integer width = 439
integer height = 180
integer taborder = 70
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Errors:"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pipeline
integer x = 1422
integer y = 1304
integer width = 439
integer height = 180
integer taborder = 60
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Records Written:"
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pipeline
integer x = 960
integer y = 1304
integer width = 439
integer height = 180
integer taborder = 50
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 74481808
string text = "Records Read:"
borderstyle borderstyle = stylelowered!
end type

