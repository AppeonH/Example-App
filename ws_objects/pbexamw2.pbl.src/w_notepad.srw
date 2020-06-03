$PBExportHeader$w_notepad.srw
$PBExportComments$Main notepad window
forward
global type w_notepad from w_center
end type
type mle_notepad from multilineedit within w_notepad
end type
type st_position from statictext within w_notepad
end type
type dw_clock from datawindow within w_notepad
end type
end forward

shared variables
// Used to store the current actvated instance of the
// notepad multilineedit

MultiLIneEdit   smle_notepad  
end variables

global type w_notepad from w_center
int X=164
int Y=71
int Width=2593
int Height=1780
boolean TitleBar=true
string Title="PowerBuilt Notepad"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
event ue_openfile pbm_custom17
event ue_savefile pbm_custom18
event ue_newfile pbm_custom19
event ue_deletefile pbm_custom20
event ue_status_indicator pbm_custom21
event ue_clock pbm_custom22
event ue_printfile pbm_custom23
event ue_modified_text pbm_custom24
event ue_find_text pbm_custom25
event ue_find_next_text pbm_custom26
event ue_replace_text pbm_custom27
event ue_go_to_line pbm_custom28
event ue_set_text_color pbm_custom29
event ue_edit_actions pbm_custom30
event ue_change_fonts pbm_custom31
event ue_closefile pbm_custom32
mle_notepad mle_notepad
st_position st_position
dw_clock dw_clock
end type
global w_notepad w_notepad

type variables
boolean   ib_text_modified, &
              ib_save_failed
string   is_filename, is_fullname
s_notepad_parms   istr_parms


end variables

forward prototypes
protected subroutine wf_set_line_index ()
end prototypes

on ue_openfile;//////////////////////////////////////////////////////////////////////
//
// Open a new sheet.  This event is triggered from the File-Open menu item.
//
//////////////////////////////////////////////////////////////////////

int	li_fileid


//////////////////////////////////////////////////////////////////////
// If anything was previously modified, give the option to save
//////////////////////////////////////////////////////////////////////
if ib_text_modified then
	if MessageBox ("PowerBuilt NotePad", "Do you want to save?", &
			question!, yesno!) = 1 then
		Triggerevent (this, "ue_savefile")
	end if
end if


//////////////////////////////////////////////////////////////////////
// Prompt for a filename to open
//////////////////////////////////////////////////////////////////////
SetPointer (HourGlass!)
if GetFileOpenName ("Open", is_fullname, is_filename, "txt", &
							"Text Files (*.txt),*.txt,INI Files (*.ini)," + &
							"*.ini,Batch Files (*.bat),*.bat") < 1 then return


//////////////////////////////////////////////////////////////////////
// Open the new file and put results into the MLE
//////////////////////////////////////////////////////////////////////
li_fileid = FileOpen (is_fullname, StreamMode!)
FileRead (li_fileid, mle_notepad.text)
FileClose (li_fileid)	


//////////////////////////////////////////////////////////////////////
// New file opened, nothing modified yet; disable save.
//////////////////////////////////////////////////////////////////////
Disable (m_notepad.m_file.m_save)
ib_text_modified = false


//////////////////////////////////////////////////////////////////////
// Set file name in title bar
//////////////////////////////////////////////////////////////////////
this.title = Upper (is_filename)

end on

on ue_savefile;//////////////////////////////////////////////////////////////////////
//
// Save the contents of the current sheet to a file
//
//////////////////////////////////////////////////////////////////////

int		li_fileid, &
			li_ret
string 	ls_old_fullname, &
			ls_save_filename, &
			ls_save_pathname


SetPointer (HourGlass!)

//////////////////////////////////////////////////////////////////////
// remember original file name. If user tries to change it, see if it
// already exists; if so prompt 'OK to replace?'
//////////////////////////////////////////////////////////////////////
ls_old_fullname = is_fullname


//////////////////////////////////////////////////////////////////////
// Don't pass an invalid filename to the GetFileSaveName function
// New (never-before-saved) notepads have names "Document1", "Document2", ...
//////////////////////////////////////////////////////////////////////
if Left (is_filename, 8) = "Document" and Match (Mid (is_filename, 9), "[0-9]")  then
	ls_save_filename = ""
	ls_save_pathname = ""
else
	ls_save_filename = is_filename
	ls_save_pathname = is_filename
end if

if GetFileSaveName ("Save", ls_save_pathname, &
							ls_save_filename,"txt", &
							"Text Files (*.txt),*.txt,INI Files (*.ini),*.ini," + &
							"Batch Files (*.bat),*.bat") < 1 then
	ib_save_failed = true
	return
end if


//////////////////////////////////////////////////////////////////////
// If user changed the name, check if file already exists
//////////////////////////////////////////////////////////////////////
if ls_save_pathname <> ls_old_fullname then
	if FileExists (ls_save_pathname) then
		li_ret = Messagebox ("PowerBuilt Notepad", &
							"Do you want to replace " + ls_save_pathname + "?", &
							question!, YesNoCancel!, 2)
// If "Cancel", return to Notepad. If "No", ask for another File Name
		if li_ret = 3 then return		// User clicked "Cancel"

		do while li_ret = 2				// User clicked "No"
			li_ret = GetFileSaveName ("Save", ls_save_pathname, &
									ls_save_filename,"txt", &
				"Text Files (*.txt),*.txt,INI Files (*.ini),*.ini,Batch Files (*.bat),*.bat")
			if li_ret < 1 then return
			if FileExists (ls_save_pathname) then
				li_ret = Messagebox ("PowerBuilt Notepad", &
							"Do you want to replace " + ls_save_pathname + "?", &
							question!, YesNoCancel!, 2)
				if li_ret = 3 then return	// User clicked "Cancel"
			end if	
		loop			// Repeat as long as user hits No

	end if		// End:  User tried to replace existing file
end if		// End:  User changed file name


//////////////////////////////////////////////////////////////////////
// Write out the contents of the MultiLine Edit to the file from
// which it was read.
//////////////////////////////////////////////////////////////////////
is_fullname = ls_save_pathname
is_filename = ls_save_filename
SetPointer (HourGlass!)

li_fileid = FileOpen (is_fullname, StreamMode!, write!, lockwrite!, Replace!)
FileWrite (li_fileid, mle_notepad.text)
FileClose (li_fileid)


//////////////////////////////////////////////////////////////////////
// Reset sheet variables and menu
//////////////////////////////////////////////////////////////////////
// Just Saved, nothing modified yet; disable save.
Disable (m_notepad.m_file.m_save)
ib_text_modified = false

// Set file name in title bar
this.title =  Upper (is_filename)

end on

on ue_newfile;//////////////////////////////////////////////////////////////////////
//
// Clear contents of current notepad and re-initialize it
//
//////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////
// If anything was previously modified, give the option to save
//////////////////////////////////////////////////////////////////////
if ib_text_modified then
	if MessageBox ("PowerBuilt NotePad", "Do you want to save?", &
			question!, yesno!) = 1 then
		Triggerevent (this, "ue_savefile")
	end if
end if


//////////////////////////////////////////////////////////////////////
// Trigger the Open event to set filename as next document#, and
// set Window Title
//////////////////////////////////////////////////////////////////////
this.TriggerEvent (open!)
end on

on ue_deletefile;//////////////////////////////////////////////////////////////////////
//
// Delete a specified file from disk
//
//////////////////////////////////////////////////////////////////////

string	ls_filename, &
			ls_fullname

if GetFileSaveName ("Delete", ls_fullname, ls_filename, &
						"txt", "Text Files (*.txt),*.txt,INI Files (*.ini)," + &
						"*.ini,Batch Files (*.bat),*.bat") < 1 then return

if MessageBox ("PowerBuilt Notepad", &
						"OK to Delete file " + ls_fullname + "?", question!, yesno!) = 1 then
	FileDelete (ls_fullname)
end if
end on

on ue_status_indicator;//////////////////////////////////////////////////////////////////////
//
// Toggle the status indicator on/off
//
//////////////////////////////////////////////////////////////////////

if st_position.visible then
	Hide (st_position)
else
	wf_set_line_index()
	Show (st_position)
end if
	
end on

on ue_clock;//////////////////////////////////////////////////////////////////////
//
// Toggle clock on/off
//
//////////////////////////////////////////////////////////////////////

if dw_clock.visible then
	Hide (dw_clock)
else
	Show (dw_clock)
end if
	
end on

on ue_printfile;//////////////////////////////////////////////////////////////////////
//
// Print the current multiline edit.
//
//////////////////////////////////////////////////////////////////////

int	li_job, &
		li_oldpos, &
		li_newpos, &
		li_lines, &
		li_count, &
		li_pagenum, &
		li_lineindex = 1035


SetPointer (HourGlass!)

//////////////////////////////////////////////////////////////////////
// Open print job
//////////////////////////////////////////////////////////////////////
li_job = PrintOpen ( )
if li_job = -1 then
	Messagebox ("Error!", "Print Job failed to open!")
	return
end if


//////////////////////////////////////////////////////////////////////
// Define fonts for print job
//////////////////////////////////////////////////////////////////////
PrintDefineFont (li_job, 1, "Arial", 250, 400, Default!, Decorative!, &
						false, false)
PrintDefineFont (li_job, 2, "Arial", 250, 700, Default!, Decorative!, &
						false, false)
PrintSetFont (li_job, 2)


//////////////////////////////////////////////////////////////////////
// Print 
//////////////////////////////////////////////////////////////////////
li_pagenum = 1
Print (li_job, "File: " + is_fullname, 6700)
Print (li_job, "Page " + String (li_pagenum))
Print (li_job, "")
Print (li_job, "")
PrintSetFont (li_job, 1)

mle_notepad.SetRedraw (false)
li_oldpos = Position (mle_notepad)
li_count = 1

for li_lines = 1 TO LineCount (mle_notepad) 
	if li_count > 48 then
		li_count = 0
		li_pagenum = li_pagenum + 1
		PrintPage (li_job)
		PrintSetFont (li_job, 2)
		Print (li_job, "File: " + is_fullname, 6700)
		Print (li_job, "Page " + String (li_pagenum))
		Print (li_job, "")
		Print (li_job, "")
		PrintSetFont (li_job, 1)
	end if
	li_newpos = Send (Handle (mle_notepad), li_lineindex, li_lines, 0)
	SelectText (mle_notepad, li_newpos, 1)
	Print (li_job, TextLine (mle_notepad))
	li_count = li_count + 1
NEXT

mle_notepad.SelectText (li_oldpos, 1)
mle_notepad.SetRedraw (true)

PrintClose (li_job)














end on

on ue_modified_text;//////////////////////////////////////////////////////////////////////
// Set instance flag to true since text has been modified.
// Enable the file save menu item.
//////////////////////////////////////////////////////////////////////

ib_text_modified = true
Enable (m_notepad.m_file.m_save)
end on

on ue_find_text;//////////////////////////////////////////////////////////////////////
//
// Find the specified text on this sheet
//
//////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////
// Open the response window to prompt for what to search for.
//////////////////////////////////////////////////////////////////////
OpenWithParm (w_notepad_find, mle_notepad)

// On return, set the instance variables for this sheet.
if isValid (Message.PowerObjectParm) then
	istr_parms = message.powerobjectparm
else
	return   //  Nothing selected
end if

//////////////////////////////////////////////////////////////////////
// Be sure the next text menu item gets set properly after returning
// from w_notepad_find. Remember, the activate event gets invoked
// before we return from w_notepad_find. It may disable the menuitem
// before we get a chance to set i_find_loc
//////////////////////////////////////////////////////////////////////
if istr_parms.find_loc = 0 then
	Disable (m_notepad.m_search.m_findnexttext)
else
	Enable (m_notepad.m_search.m_findnexttext)
end if

end on

on ue_find_next_text;//////////////////////////////////////////////////////////////////////
//
// Find the next instance of the specified text in this sheet
//
//////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////
// Begin search from where we left off. Start at end of last token found.
//////////////////////////////////////////////////////////////////////
istr_parms.find_loc = istr_parms.find_loc + Len (istr_parms.find_string)


//////////////////////////////////////////////////////////////////////
// if we're matching case, search regular; otherwise force both to lower.
//////////////////////////////////////////////////////////////////////
if istr_parms.uplow then
	istr_parms.find_loc = Pos (smle_notepad.text, istr_parms.find_string, istr_parms.find_loc)
else
	istr_parms.find_loc = Pos (Lower (smle_notepad.text), Lower (istr_parms.find_string), istr_parms.find_loc)
end if


//////////////////////////////////////////////////////////////////////
// If not found, show message; otherwise, select found text
//////////////////////////////////////////////////////////////////////
if istr_parms.find_loc = 0 then
	MessageBox ("Find Text", "String " + istr_parms.find_string + " not found", StopSign!)
	Disable (m_notepad.m_search.m_findnexttext)
else
	smle_notepad.SelectText (istr_parms.find_loc, Len (istr_parms.find_string))
end if
end on

on ue_replace_text;//////////////////////////////////////////////////////////////////////
//
// Find and replace routine for text
//
//////////////////////////////////////////////////////////////////////

string	ls_source
int		li_loc, &
			li_rep_count, &
			li_ret


//////////////////////////////////////////////////////////////////////
// Open the window where text to find and replace is specified
//////////////////////////////////////////////////////////////////////
Open (w_notepad_replace)
istr_parms = message.powerobjectparm

li_loc = 1

if istr_parms.replace_event = "change_all" then
	//////////////////////////////////////////////////////////////////////
	// Logic for change all
	//////////////////////////////////////////////////////////////////////
	mle_notepad.SetRedraw (false)

	// Loop thru MLE text searching for string. If upper lower case is 
	// checked, do exact match; otherwise check as if all lower case.
	// Replace any found strings with replace text. Give count of items
	// replaced at the end.

	do while li_loc <> 0
		if istr_parms.uplow then
			li_loc = Pos (mle_notepad.text, istr_parms.find_string, li_loc)
		else
			ls_source = Lower (mle_notepad.text)
			li_loc = Pos (ls_source, Lower (istr_parms.find_string), li_loc)
		end if

		if li_loc <> 0 then
			li_rep_count = li_rep_count + 1
			mle_notepad.text = Replace (mle_notepad.text, li_loc, &
										Len (istr_parms.find_string), istr_parms.replace_string)
			li_loc = li_loc + 1	// position past the last one we found
		end if
	loop 

	mle_notepad.SetRedraw (true)

	//////////////////////////////////////////////////////////////////////
	// If anything was replaced, set modified indicator and enable save
	//////////////////////////////////////////////////////////////////////
	if li_rep_count > 0 then
		Enable (m_notepad.m_file.m_save)
		ib_text_modified = true
	end if

	MessageBox ("Replace Text", &
					"Number of items replaced: " + string (li_rep_count), &
					Information!, ok!)
elseif istr_parms.replace_event = "search_and_verify" then

	// Loop thru MLE text searching for string. If upper lower case is 
	// checked, do exact match; otherwise check as if all lower case.
	// Replace any found strings with replace text. Give count of items
	// replaced at the end.

	do while li_loc <> 0
		if istr_parms.uplow then
			li_loc = Pos (mle_notepad.text, istr_parms.find_string, li_loc)
		else
			ls_source = Lower (mle_notepad.text)
			li_loc = Pos (ls_source, Lower (istr_parms.find_string), li_loc)
		end if

		if li_loc <> 0 then
			mle_notepad.SetFocus()
			mle_notepad.SelectText (li_loc, Len (istr_parms.find_string))
			li_ret = Messagebox ("Replace Text", &
								"Replace " + istr_parms.find_string + " with " + &
								istr_parms.replace_string + "?", &
								Question!, YesNoCancel!)
			if li_ret = 1 then
				li_rep_count = li_rep_count + 1
				mle_notepad.text = Replace (mle_notepad.text, li_loc, &
										Len (istr_parms.find_string), istr_parms.replace_string)
			elseif li_ret = 3 then
				exit
			end if
			li_loc = li_loc + 1	// position past the last one we found
		end if
	loop 

	// If anything was replaced, set modified indicator and enable save
	if li_rep_count > 0 then
		Enable (m_notepad.m_file.m_save)
		ib_text_modified = true
	end if

	MessageBox ("Replace Text", &
					"Number of items replaced: " + string (li_rep_count), &
					Question!, ok!)
end if

end on

on ue_go_to_line;//////////////////////////////////////////////////////////////////////
// Scroll to the line number that was specified.
//////////////////////////////////////////////////////////////////////

OpenWithParm (w_notepad_goto, mle_notepad)
end on

on ue_set_text_color;//////////////////////////////////////////////////////////////////////
// Set the text color
//////////////////////////////////////////////////////////////////////

OpenWithParm (w_notepad_colors, mle_notepad)
end on

on ue_edit_actions;//////////////////////////////////////////////////////////////////////
//
// edit text functions (cut, copy, paste, ...)
//
//////////////////////////////////////////////////////////////////////


// Depending on which edit menuitem was selected, take the appropriate
// action on the currently active multilineedit. The current mle is
// stored in a shared variable and set on open or activate of a sheet.

choose case String (message.longparm, "address")

	case "undo"
		if CanUndo (smle_notepad) then
			Undo (smle_notepad)
			this.TriggerEvent ("ue_modified_text")
		else
			Messagebox ("Sorry!", "Nothing to Undo!")
		end if

	case "cut"
		Cut (smle_notepad)
		this.TriggerEvent ("ue_modified_text")

	case "copy"
		Copy (smle_notepad)

	case "paste"
		Paste (smle_notepad)
		this.TriggerEvent ("ue_modified_text")

	case "clear"
		Clear (smle_notepad)
		this.TriggerEvent ("ue_modified_text")

	case "selectall"
		smle_notepad.SelectText (1, Len (smle_notepad.text))

	case else
		MessageBox ("Sorry!", "There is no such edit action")
end choose

end on

on ue_change_fonts;//////////////////////////////////////////////////////////////////////
// Change the current text font for the sheet
//////////////////////////////////////////////////////////////////////

smle_notepad.facename = String (Message.LongParm, "address")

end on

on ue_closefile;close (this)
end on

protected subroutine wf_set_line_index ();//////////////////////////////////////////////////////////////////////
//
// Function: wf_set_line_index
//
// Purpose: set the status indicator to line:column
//		
//	Scope: protected
//
//	Arguments: none
//
//	Returns: none
//
//////////////////////////////////////////////////////////////////////


int		li_linenum, &
			li_charnum, &
			li_lineindex = 1035
string	ls_stat


li_linenum = SelectedLine (mle_notepad)

li_charnum = Send (Handle (smle_notepad), li_lineindex, li_linenum - 1, 0)
li_charnum = Position (mle_notepad) - li_charnum

if ib_text_modified then
	ls_stat = "* "
else
	ls_stat = "  "
end if

st_position.text = ls_stat + String (li_linenum, '###0') + ":" + String (li_charnum, '###0')
end subroutine

on closequery;//////////////////////////////////////////////////////////////////////
//
// Ask user if changes need to be saved before closing
//
//////////////////////////////////////////////////////////////////////

int	li_ret

if ib_text_modified then
	li_ret = MessageBox ("PowerBuilt NotePad", &
			"Do you want to save " + is_filename + "?", &
			question!, yesnocancel!)
	if li_ret = 1 then
		this.Triggerevent ("ue_savefile")
		if ib_save_failed then
			ib_save_failed = false
			Message.ReturnValue = 1
		end if
	else
		if li_ret = 3 then
			message.ReturnValue = 1
		end if
	end if
end if
end on

on open;//////////////////////////////////////////////////////////////////////
//
// On open event of each new sheet, set the sheet title to the next
// document number and set the current multiline edit in the shared
// variable sh_notepad.
//
//////////////////////////////////////////////////////////////////////

w_notepad_frame parent_win


parent_win = parentwindow()

parent_win.i_document_number ++
is_filename = "Document" + String (parent_win.i_document_number)
is_fullname = ""
this.title = is_filename

smle_notepad = mle_notepad





end on

on resize;//////////////////////////////////////////////////////////////////////
//
// Size the MLE to fill the sheet, leaving space for the clock and
// line index status indicator.
//
//////////////////////////////////////////////////////////////////////


mle_notepad.Resize (WorkSpaceWidth (this), &
			WorkSpaceHeight (this) - (st_position.height*1.1))

// Position the clock and status indicator appropriately
st_position.Move (mle_notepad.x + mle_notepad.width - (st_position.width*1.1), &
                           mle_notepad.y + mle_notepad.height)
dw_clock.Move (mle_notepad.x, mle_notepad.y + mle_notepad.height)




end on

on activate;/////////////////////////////////////////////////////////////////////
//
// Set globals and menu items appropriately, in the event that there
// are multiple sheets.
//
/////////////////////////////////////////////////////////////////////

// Remember which mle we're working with
smle_notepad = mle_notepad

// Check the clock & status menu items appropriately, based on whether
// they're currently visible in this sheet
if dw_clock.visible then
	check (m_notepad.m_options.m_clock)
else
	uncheck (m_notepad.m_options.m_clock)
end if
if st_position.visible then
	check (m_notepad.m_options.m_statusindicator)
else
	uncheck (m_notepad.m_options.m_statusindicator)
end if

// Enable the 'save' menuitem appropriately depending on whether text
// has been modified for this sheet.
if ib_text_modified then
	Enable (m_notepad.m_file.m_save)
else
	Disable (m_notepad.m_file.m_save)
end if

// Enable the 'find next' menuitem appropriately, depending on whether
// we're in the middle of a find text search (current location of search
// will be non-zero).
if istr_parms.find_loc = 0 then
	Disable (m_notepad.m_search.m_findnexttext)
else
	Enable (m_notepad.m_search.m_findnexttext)
end if

end on

on w_notepad.create
this.mle_notepad=create mle_notepad
this.st_position=create st_position
this.dw_clock=create dw_clock
this.Control[]={ this.mle_notepad,&
this.st_position,&
this.dw_clock}
end on

on w_notepad.destroy
destroy(this.mle_notepad)
destroy(this.st_position)
destroy(this.dw_clock)
end on

type mle_notepad from multilineedit within w_notepad
event ue_char_entered pbm_char
event ue_key_up pbm_keyup
event ue_lmouse_up pbm_lbuttonup
int Width=2539
int Height=1377
int TabOrder=10
boolean Border=false
boolean VScrollBar=true
boolean AutoVScroll=true
boolean HideSelection=false
string Pointer="arrow!"
long TextColor=41943040
int TextSize=-10
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

on ue_char_entered;//////////////////////////////////////////////////////////////////////
// Set the modified flag to true and enable the file-save menu item
// when a character is entered into the document.
//////////////////////////////////////////////////////////////////////

if ib_text_modified = false then
	Enable (m_notepad.m_file.m_save)
	ib_text_modified = true
end if

end on

on ue_key_up;//////////////////////////////////////////////////////////////////////
// if the status indicator is on, update it
//////////////////////////////////////////////////////////////////////

if st_position.visible then
	wf_set_line_index ()
end if
end on

on ue_lmouse_up;//////////////////////////////////////////////////////////////////////
// if the status indicator is on, update it
//////////////////////////////////////////////////////////////////////

if st_position.visible then
	wf_set_line_index ()
end if
end on

on rbuttondown;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Have the edit menu popup when the right mouse button is clicked.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

m_notepad.m_edit.PopMenu (parent.PointerX(), parent.PointerY())
end on

type st_position from statictext within w_notepad
int X=2216
int Y=1412
int Width=310
int Height=77
boolean Visible=false
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleLowered!
string Text="0001:0001"
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=41943040
int TextSize=-9
int Weight=400
string FaceName="MS Sans Serif"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_clock from datawindow within w_notepad
int X=11
int Y=1409
int Width=644
int Height=77
int TabOrder=20
boolean Visible=false
boolean Enabled=false
string DataObject="d_clock"
BorderStyle BorderStyle=StyleLowered!
end type

type mdi_1 from mdiclient within w_notepad
end type

