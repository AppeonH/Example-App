$PBExportHeader$w_spin_controls.srw
$PBExportComments$Window that allows users to experiment with spin controls
forward
global type w_spin_controls from w_center
end type
type cb_help from commandbutton within w_spin_controls
end type
type cb_cancel from commandbutton within w_spin_controls
end type
type dw_1 from datawindow within w_spin_controls
end type
end forward

global type w_spin_controls from w_center
int X=228
int Y=513
int Width=2497
int Height=925
boolean TitleBar=true
string Title="Datawindow Spin Controls"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
cb_help cb_help
cb_cancel cb_cancel
dw_1 dw_1
end type
global w_spin_controls w_spin_controls

type variables
// current data type of spin control
string    is_cur_spin = "num_spin"
end variables

event open;call super::open;/////////////////////////////////////////////////////////////////////
// initialization
/////////////////////////////////////////////////////////////////////

dw_1.InsertRow (0)

// turn code tables off
dw_1.Modify (	'num_spin.EditMask.CodeTable = no ' + &
					'date_spin.EditMask.CodeTable = no ' + &
					'min_date.visible = 0 ' + &
					'max_date.visible = 0')
					
end event

on close;w_main.Show()
end on

on w_spin_controls.create
this.cb_help=create cb_help
this.cb_cancel=create cb_cancel
this.dw_1=create dw_1
this.Control[]={ this.cb_help,&
this.cb_cancel,&
this.dw_1}
end on

on w_spin_controls.destroy
destroy(this.cb_help)
destroy(this.cb_cancel)
destroy(this.dw_1)
end on

type cb_help from commandbutton within w_spin_controls
int X=2134
int Y=183
int Width=274
int Height=109
int TabOrder=30
string Text="&Help"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;f_open_help ('w_spin_controls')
end on

type cb_cancel from commandbutton within w_spin_controls
int X=2134
int Y=36
int Width=274
int Height=109
int TabOrder=20
string Text="&Close"
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on clicked;Close (parent)
end on

type dw_1 from datawindow within w_spin_controls
event ue_set_column pbm_custom02
int X=25
int Y=36
int Width=1970
int Height=749
int TabOrder=10
string DataObject="d_spin_controls"
boolean Border=false
end type

event ue_set_column;//////////////////////////////////////////////////////////////////////////////////////////////////
// ue_set_column script for dw_1
//////////////////////////////////////////////////////////////////////////////////////////////////

this.SetColumn (is_cur_spin)
end event

event itemchanged;//////////////////////////////////////////////////////////////////////////////////////////////////
// itemchanged script for dw_1
//////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////
// purpose:  Modify the datawindow column attributes
//////////////////////////////////////////////////////////////////////

string	ls_range, &
			ls_mask, &
			ls_inc, &
			ls_min, &
			ls_max
int		li_pos


choose case this.GetColumnName()

	//////////////////////////////////////////////////////////////////////
	// turn code tables on/off
	//////////////////////////////////////////////////////////////////////
	case 'code_table'

		if this.Describe (is_cur_spin + '.EditMask.CodeTable') = 'yes' then
			this.Modify (	'num_spin.EditMask.CodeTable = no ' + &
								'date_spin.EditMask.CodeTable = no')
		else
			this.Modify (	'num_spin.EditMask.CodeTable = yes ' + &
								'date_spin.EditMask.CodeTable = yes')
		end if
	//		this.SetColumn (is_cur_spin)


	//////////////////////////////////////////////////////////////////////
	// Switch between spin control data types (date/number)
	//////////////////////////////////////////////////////////////////////
	case 'data_type'

		if this.GetText() = 'N' then

			// Update 'current spin' instance variable
			is_cur_spin = 'num_spin'

			// Alter tab order and visible attributes so that the 
			// number spin control is visible
			this.Modify (	'num_spin.visible = 1 ' + &
								'date_spin.visible = 0 ' + &
								'num_spin.tabsequence = 10 ' + &
								'date_spin.tabsequence = 0')

			// Make the number min and max spin range columns visible
			this.Modify (	'min.visible = 1 ' + &
								'min_date.visible = 0 ' + &
								'min.tabsequence = 60 ' + &
								'min_date.tabsequence = 0 ' + &
								'max.visible = 1 ' + &
								'max_date.visible = 0 ' + &
								'max.tabsequence = 70 ' + &
								'max_date.tabsequence = 0 ')
		else

			// Update 'current spin' instance variable
			is_cur_spin = 'date_spin'

			// Alter tab order and visible attributes so that the 
			// date spin control is visible
			this.Modify (	'num_spin.visible = 0 ' + &
								'date_spin.visible = 1 ' + &
								'num_spin.tabsequence = 0 ' + &
								'date_spin.tabsequence = 10')

			// Make the date min and max spin range columns visible
			this.Modify (	'min.visible = 0 ' + &
								'min_date.visible = 1 ' + &
								'min.tabsequence = 0 ' + &
								'min_date.tabsequence = 60 ' + &
								'max.visible = 0 ' + &
								'max_date.visible = 1 ' + &
								'max.tabsequence = 0 ' + &
								'max_date.tabsequence = 70 ')
		end if		

		// Display attributes of current spin control type

		this.Object.mask[1] = this.Describe (is_cur_spin + '.EditMask.Mask')
		this.Object.increment[1] = Integer (this.Describe (is_cur_spin + '.EditMask.SpinIncr'))

		// Obtain the spin range for the current spin control.  The spin
		// range is stored as:
		// minimum~~maximum.
		// Notice that there are two tilde characters between the min and
		// max values

		ls_range = this.Describe (is_cur_spin + '.EditMask.SpinRange')
		li_pos = Pos (ls_range, '~~')	
		this.Object.min[1] = Integer (Left (ls_range, li_pos - 1))
		this.Object.max[1] = Integer (Right (ls_range, Len (ls_range) - li_pos - 1))


		// Populate ddlb of edit masks based on current spin control
		// data type (date or number)
		dw_1.ClearValues ('mask')
		if is_cur_spin = 'num_spin' then
			dw_1.SetValue ('mask', 1, '0	0')
			dw_1.SetValue ('mask', 2, '###	###')
			dw_1.SetValue ('mask', 3, '###,###.00	###,###.00')
			dw_1.SetValue ('mask', 4, '$#,###.00	$#,###.00')
		else
			dw_1.SetValue ('mask', 1, 'mm/dd/yy	mm/dd/yy')
			dw_1.SetValue ('mask', 2, 'dd/mm/yy	dd/mm/yy')
			dw_1.SetValue ('mask', 3, 'mm/dd/yyyy	mm/dd/yyyy')
			dw_1.SetValue ('mask', 4, 'dd/mm/yyyy	dd/mm/yyyy')
			dw_1.SetValue ('mask', 5, 'dd/mmm/yy	dd/mmm/yy')
			dw_1.SetValue ('mask', 6, 'jjj/yy	jjj/yy')
			dw_1.SetValue ('mask', 7, 'jjj/yyyy	jjj/yyyy')
		end if		



	//////////////////////////////////////////////////////////////////////
	// Change edit masks
	//////////////////////////////////////////////////////////////////////
	case 'mask'
		ls_mask = this.GetText()
		dw_1.Modify (is_cur_spin + ".EditMask.Mask = '" + ls_mask + "'")



	//////////////////////////////////////////////////////////////////////
	// Change spin increment
	//////////////////////////////////////////////////////////////////////
	case 'increment'
		ls_inc = this.GetText()
		if IsNumber (ls_inc) then
			dw_1.Modify (is_cur_spin + '.EditMask.SpinIncr = ' + ls_inc)
			this.PostEvent ('ue_set_column')
		end if



	//////////////////////////////////////////////////////////////////////
	// Change spin minimum 
	//////////////////////////////////////////////////////////////////////
	case 'min', 'min_date'
		ls_min = this.GetText()

		// Obtain the spin range for the current spin control.  The spin
		// range is stored as:
		// minimum~~maximum.
		// Notice that there are two tilde characters between the min and
		// max values and not a tab character as stated in the PB 3.0 documentation.

		ls_range = this.Describe (is_cur_spin + '.EditMask.SpinRange')
		li_pos = Pos (ls_range, '~~')	
		ls_max = Right (ls_range, Len (ls_range) - li_pos - 1)
		if Len (ls_max) = 0 and is_cur_spin = 'date_spin' then
			ls_max = '01/01/00'
		end if
		ls_range = ls_min + '~~~~' + ls_max

		if is_cur_spin = 'num_spin' then
			if IsNumber (ls_min) then
				this.Modify (is_cur_spin + ".EditMask.SpinRange = '" + ls_range + "'")
			end if
		else
			if IsDate (ls_min) then
				this.Modify (is_cur_spin + ".EditMask.SpinRange = '" + ls_range + "'")
			end if
		end if
		this.PostEvent ('ue_set_column')
	


	//////////////////////////////////////////////////////////////////////
	// Change spin maximum
	//////////////////////////////////////////////////////////////////////
	case 'max', 'max_date'
		ls_max = this.GetText()

		// Obtain the spin range for the current spin control.  The spin
		// range is stored as:
		// minimum~~maximum.
		// Notice that there are two tilde characters between the min and
		// max values and not a tab character as stated in the PB 3.0 documentation.

		ls_range = this.Describe (is_cur_spin + '.EditMask.SpinRange')
		li_pos = Pos (ls_range, '~~')	
		ls_min = Left (ls_range, li_pos - 1)
		if Len (ls_min) = 0 and is_cur_spin = 'date_spin' then
			ls_min = String (Today())
		end if
		ls_range = ls_min + '~~~~' + ls_max

		if is_cur_spin = 'num_spin' then
			if IsNumber (ls_max) then
				this.Modify (is_cur_spin + ".EditMask.SpinRange = '" + ls_range + "'")
			end if
		else
			if IsDate (ls_max) then
				this.Modify (is_cur_spin + ".EditMask.SpinRange = '" + ls_range + "'")
			end if
		end if
		this.PostEvent ('ue_set_column')

end choose

end event

event clicked;//////////////////////////////////////////////////////////////////////////////////////////////////
// clicked script for dw_1
//////////////////////////////////////////////////////////////////////////////////////////////////

if row = 2 or row = 3 then
	this.AcceptText()
end if
end event

event itemerror;//////////////////////////////////////////////////////////////////////////////////////////////////
// itemerror script for dw_1
//////////////////////////////////////////////////////////////////////////////////////////////////

return 3	//Reject the data value but allow the focus to change. 
			//Replace the column value just entered with the value originally in the column.
			//No error message
end event

