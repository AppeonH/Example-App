$PBExportHeader$w_toolbar_func_sheet.srw
$PBExportComments$Sheet window to test new toolbar functionality
forward
global type w_toolbar_func_sheet from w_center
end type
end forward

global type w_toolbar_func_sheet from w_center
int X=836
int Y=385
int Width=1970
int Height=1217
boolean TitleBar=true
string Title="Toolbar Functionality Test Sheet"
string MenuName="m_toolbar_func_sheet"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
end type
global w_toolbar_func_sheet w_toolbar_func_sheet

forward prototypes
public function boolean of_islastsheet ()
end prototypes

public function boolean of_islastsheet ();// Determine if there are any other sheets open

window		lw_Sheet, lw_Frame

lw_Frame = This.ParentWindow()

// Get the first sheet
lw_Sheet = lw_Frame.GetFirstSheet()

Do While IsValid(lw_Sheet)
	If lw_Sheet <> This Then Return False	// Found another sheet open
	lw_Sheet = lw_Frame.GetNextSheet(lw_Sheet)
Loop

Return True

end function

on w_toolbar_func_sheet.create
if this.MenuName = "m_toolbar_func_sheet" then this.MenuID = create m_toolbar_func_sheet
end on

on w_toolbar_func_sheet.destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;Integer				li_SheetNum
w_toolbar_func	lw_Frame
m_toolbar_func	lm_Menu

// Set the title
lw_Frame = Message.PowerObjectParm

This.Title = "Toolbar Fuctionality Test Sheet #" + String(lw_Frame.ii_SheetNum)

// Set toolbar positions from the registry or ini file
f_get_toolbar_profile(This, 2)

// Set the instance varialbe in the menu that points to the application frame
lm_Menu = This.MenuID
lm_Menu.iw_Frame = lw_Frame

end event

event closequery;If of_IsLastSheet() Then
	// Closing the last sheet, ask about saving the toolbar
	If MessageBox("Toolbar Functionality Test", "Do you want to save the sheet toolbar settings before closing?", &
							Question!, YesNo!, 1) = 2 Then Return

	f_save_toolbar_profile(This)
End If

end event

