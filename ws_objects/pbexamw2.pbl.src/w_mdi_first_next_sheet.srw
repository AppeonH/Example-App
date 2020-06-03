$PBExportHeader$w_mdi_first_next_sheet.srw
$PBExportComments$Sheet for m_mdi_first_next menu
forward
global type w_mdi_first_next_sheet from w_center
end type
end forward

global type w_mdi_first_next_sheet from w_center
int X=676
int Y=269
int Width=1810
int Height=743
boolean TitleBar=true
string Title="Untitled"
long BackColor=74481808
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
ToolBarAlignment ToolBarAlignment=AlignAtLeft!
end type
global w_mdi_first_next_sheet w_mdi_first_next_sheet

on open;if len(message.stringparm) > 0 then this.title = message.stringparm
end on

on w_mdi_first_next_sheet.create
end on

on w_mdi_first_next_sheet.destroy
end on

