$PBExportHeader$w_benchmark_ex.srw
$PBExportComments$Performance Benchmarks Example
forward
global type w_benchmark_ex from w_center
end type
type cb_saveas from commandbutton within w_benchmark_ex
end type
type cb_help from commandbutton within w_benchmark_ex
end type
type cb_setup from commandbutton within w_benchmark_ex
end type
type cb_print from commandbutton within w_benchmark_ex
end type
type dw_1 from datawindow within w_benchmark_ex
end type
type cb_report from commandbutton within w_benchmark_ex
end type
type cb_close from commandbutton within w_benchmark_ex
end type
type cb_machine from commandbutton within w_benchmark_ex
end type
type cb_pcode from commandbutton within w_benchmark_ex
end type
end forward

global type w_benchmark_ex from w_center
integer y = 4
integer width = 1751
integer height = 344
string title = "PowerBuilder 5.0 Benchmark Comparison"
long backcolor = 74481808
toolbaralignment toolbaralignment = alignatleft!
cb_saveas cb_saveas
cb_help cb_help
cb_setup cb_setup
cb_print cb_print
dw_1 dw_1
cb_report cb_report
cb_close cb_close
cb_machine cb_machine
cb_pcode cb_pcode
end type
global w_benchmark_ex w_benchmark_ex

forward prototypes
public function boolean of_check_vals (string as_section, string as_key, ref string as_num, ref string as_time)
end prototypes

public function boolean of_check_vals (string as_section, string as_key, ref string as_num, ref string as_time);// Function to determine if a test was run.
// If there is no saved entry for the test or if it's time is 0,
// then it was not run

// Get number of iterations
f_get_profile(as_Section, as_Key + "#", as_Num)

// Get time
f_get_profile(as_Section, as_Key + "T", as_Time)

If as_Time = "" Then Return False

If Double(as_Time) > 0 Then
	Return True
Else
	Return False
End if
end function

on w_benchmark_ex.create
int iCurrent
call super::create
this.cb_saveas=create cb_saveas
this.cb_help=create cb_help
this.cb_setup=create cb_setup
this.cb_print=create cb_print
this.dw_1=create dw_1
this.cb_report=create cb_report
this.cb_close=create cb_close
this.cb_machine=create cb_machine
this.cb_pcode=create cb_pcode
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_saveas
this.Control[iCurrent+2]=this.cb_help
this.Control[iCurrent+3]=this.cb_setup
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_report
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_machine
this.Control[iCurrent+9]=this.cb_pcode
end on

on w_benchmark_ex.destroy
call super::destroy
destroy(this.cb_saveas)
destroy(this.cb_help)
destroy(this.cb_setup)
destroy(this.cb_print)
destroy(this.dw_1)
destroy(this.cb_report)
destroy(this.cb_close)
destroy(this.cb_machine)
destroy(this.cb_pcode)
end on

event resize;dw_1.Height = newheight - 260
dw_1.Width = newwidth - 30
end event

event close;w_main.Show()
end event

event open;call super::open;this.Title = "PowerBuilder " + sVersion + " Benchmark Comparison"

dw_1.Object.t_14.Text = "PowerBuilder " + SVersion + " Benchmarks"
end event

type cb_saveas from commandbutton within w_benchmark_ex
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save As..."
integer x = 2528
integer y = 116
integer width = 352
integer height = 84
integer taborder = 80
end type

event clicked;String	ls_File, ls_Path, ls_Ext

GetFileSaveName("Save Report", ls_Path, ls_File, "psr", "PSReport Files (*.psr),*.psr, " + &
							"Text Files (*.txt),*.txt, HTML Files (*.htm),*.htm")

If Trim(ls_Path) <> "" Then
	ls_Ext = Lower(Right(ls_Path, 3))
	
	Choose Case ls_Ext
		Case "psr"
			dw_1.SaveAs(ls_Path, PSReport!, True)
		Case "txt"
			dw_1.SaveAs(ls_Path, Text!, True)
		Case "htm"
			dw_1.SaveAs(ls_Path, HTMLTable!, True)
		Case Else
			MessageBox("Save Report", "The type of file saved is identified by the extension.  " + &
								"Use '.psr' for PSReport, '.txt' for Text, or '.htm' for HTML Table", Exclamation!, OK!)
			Return
	End Choose
End if
end event

type cb_help from commandbutton within w_benchmark_ex
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Help"
integer x = 928
integer y = 16
integer width = 352
integer height = 84
integer taborder = 30
end type

event clicked;f_open_help(Parent.ClassName())
end event

type cb_setup from commandbutton within w_benchmark_ex
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Printer Setup..."
integer x = 2130
integer y = 116
integer width = 352
integer height = 84
integer taborder = 70
end type

event clicked;PrintSetup()
end event

type cb_print from commandbutton within w_benchmark_ex
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Print"
integer x = 1733
integer y = 116
integer width = 352
integer height = 84
integer taborder = 60
end type

event clicked;dw_1.Print()
end event

type dw_1 from datawindow within w_benchmark_ex
string dataobject = "d_benchmark_comparison_report"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
integer x = 9
integer y = 244
integer width = 2263
integer height = 1224
integer taborder = 90
end type

type cb_report from commandbutton within w_benchmark_ex
event ue_get_data ( )
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Report >>"
integer x = 1335
integer y = 116
integer width = 352
integer height = 84
integer taborder = 50
end type

event ue_get_data;String	ls_Report, ls_PNum, ls_PTime, ls_MNum, ls_MTime

// Get the saved timings for each test.  Only include the tests that were 
//actually run in both versions.

If of_check_vals("Benchmark P-Code Tests", "loop", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "loop", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "Script Looping~tExecute an empty For/Next loop.~t" + &
					ls_PNum + "~t" + ls_PTime +"~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "tak", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "tak", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "TAK Benchmark~tThe TAK Benchmark is a widely used " + &
									"algorithm to compare programming tools that make " + &
									"extensive use of funciton calls.~t" + &
					ls_PNum + "~t" + ls_PTime +"~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "sort", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "sort", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "Array Sorting~tSort the values in an array that is " + &
									"initially sorted in reverse order.~t" + &
					ls_PNum + "~t" + ls_PTime +"~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "function", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "function", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "Global Function Overhead~tCall an empty global function.~t" + &
					ls_PNum + "~t" + ls_PTime + "~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "ofunction", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "ofunction", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "Object Function Overhead~tCall an empty object (window) function.~t" + &
					ls_PNum + "~t" + ls_PTime +"~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "event", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "event", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "Event Overhead~tTrigger an empty event.~t" + &
					ls_PNum + "~t" + ls_PTime +"~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "window", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "window", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "Window Instantiation~tOpen a window with no controls.~t" + &
					ls_PNum + "~t" + ls_PTime + "~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "string", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "string", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "String Parsing~tChange all occurrences of one string " + &
									"within another.~t" + &
					ls_PNum + "~t" + ls_PTime +"~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "var", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "var", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "Global Variable~tUse a global variable in an assignment statement.~t" + &
					ls_PNum + "~t" + ls_PTime +"~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "const", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "const", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "Global Constant~tUse a global constant in an assignment statement.~t" + &
					ls_PNum + "~t" + ls_PTime +"~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

If of_check_vals("Benchmark P-Code Tests", "get", ls_PNum, ls_PTime) And &
	of_check_vals("Benchmark Machine Code Tests", "get", ls_MNum, ls_MTime) Then
	ls_Report = ls_Report + "Using DataStores~tCopy all rows from a DataStore into variables " + &
									"using GetItem..., then write them to another DataStore using SetItem.~t" + &
					ls_PNum + "~t" + ls_PTime + "~t" + ls_MNum + "~t" + ls_MTime +"~r~n"
End If

dw_1.ImportString(ls_Report)

end event

event clicked;String	ls_Parm, ls_CPU, ls_Speed, ls_Memory, ls_OSType, ls_OSVer, ls_PBVer, ls_Report
Integer	li_Pos1, li_Pos2

// Get information about the machine running the tests.
Choose Case ge_Environment.CPUType
	Case alpha!
		ls_CPU = "Alpha"
	Case hppa!
		ls_CPU = "hppa"
	Case i286!
		ls_CPU = "i286"
	Case i386!
		ls_CPU = "i386"
	Case i486!
		ls_CPU = "i486"
	Case m68000!
		ls_CPU = "68000"
	Case m68020!
		ls_CPU = "68020"
	Case m68030!
		ls_CPU = "68030"
	Case m68040!
		ls_CPU = "68040"
	Case mips!
		ls_CPU = "Mips"
	Case pentium!
		ls_CPU = "Pentium"
	Case powerpc!
		ls_CPU = "PowerPC"
	Case sparc!
		ls_CPU = "Sparc"
End Choose

f_get_profile("Benchmark Machine", "Speed", ls_Speed)
f_get_profile("Benchmark Machine", "Memory", ls_Memory)

// If the information is not saved, open the window to enter it.
If Trim(ls_Speed) = "" Or Trim(ls_Memory) = "" Then
	Open(w_benchmark_machine)
	ls_Speed = "Unknown"
	ls_Memory = "Unknown"
	f_get_profile("Benchmark Machine", "Speed", ls_Speed)
	f_get_profile("Benchmark Machine", "Memory", ls_Memory)
End if

If ls_Speed <> "Unknown" Then
	ls_Speed = ls_Speed + " Mhz"
End if

If ls_Memory <> "Unknown" Then
	ls_Memory = ls_Memory + " Meg."
End if

// Get information about the operating system and version of PowerBuilder running the tests.
ls_PBVer = String(ge_Environment.PBMajorRevision) + "." + String(ge_Environment.PBMinorRevision) + &
				"." + String(ge_Environment.PBFixesRevision)

Choose Case ge_Environment.OSType
	Case windows!
		If ge_Environment.OSMajorRevision = 4 Then
			ls_PBVer = ls_PBVer + " - Win32"
			ls_OSType = "Windows 95"
			ls_OSVer = ""
		ElseIf ge_Environment.OSMinorRevision = 95 Then
			ls_PBVer = ls_PBVer + " - Win16"
			ls_OSType = "Windows 95"
			ls_OSVer = ""
		Else
			ls_OSType = "Windows"
			ls_OSVer = String(ge_Environment.OSMajorRevision) + "." + String(ge_Environment.OSMinorRevision)
		End if
	Case windowsnt!
		ls_PBVer = ls_PBVer + " - Win32"
		ls_OSType = "WindowsNT"
		ls_OSVer = String(ge_Environment.OSMajorRevision) + "." + String(ge_Environment.OSMinorRevision)
End Choose

// Set the values in the DataWindow
dw_1.object.cpu.text = ls_CPU
dw_1.object.cpu_speed.text = ls_Speed
dw_1.object.memory.text = ls_Memory
dw_1.object.ostype.text = ls_OSType
dw_1.object.osver.text = ls_OSVer
dw_1.object.pbver.text = ls_PBVer

dw_1.Reset()

Post Event ue_get_data()
Parent.WindowState = Maximized!

end event

type cb_close from commandbutton within w_benchmark_ex
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
boolean cancel = true
integer x = 928
integer y = 116
integer width = 352
integer height = 84
integer taborder = 40
end type

event clicked;Close(Parent)

end event

type cb_machine from commandbutton within w_benchmark_ex
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Execute Machine-Code Benchmarks"
integer x = 9
integer y = 116
integer width = 864
integer height = 84
integer taborder = 20
end type

event clicked;string ls_Path, ls_file, ls_exe
int li_pos

RegistryGet ( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\exbm_m.exe", "path", RegString!, ls_Path )

If ls_Path = "" Then
	If MessageBox ( "PB Runtime", "Unable to locate the PB Runtime." + &
								"~n~r~n~rYou can set the runtime directory by selecting any file in that " + &
								"directory on the following screen.~n~r~n~rDo you want to set the directory now?", Exclamation!, YesNo!, 2) = 2 then
		Return
	Else
		// Allow the user to find the directory
		if GetFileOpenName("Select any file in the PB Runtime directory", ls_Path, ls_file ) = 1 then
			li_Pos = Pos ( Lower ( ls_Path ), Lower ( ls_File ) ) 
			if li_Pos > 0 then ls_Path = Left ( ls_Path, li_Pos - 1 ) 
			RegistrySet ( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\exbm_m.exe", "path", RegString!, ls_Path )

		end if
		
		
	end if
	
End If

If Right ( gs_exampledir, 1 ) = gu_ext_func.uf_Get_Separator ( ) Then
	ls_exe = gs_exampledir + "exbm_m.exe"
Else
	ls_exe = gs_exampledir + gu_ext_func.uf_Get_Separator ( ) + "exbm_m.exe"
End If

If Run(ls_exe) = -1 Then
	MessageBox("Error", "Error running Benchmark Program Machine Code executable (exbm_m.exe)", &
						StopSign!)
End If
end event

type cb_pcode from commandbutton within w_benchmark_ex
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Execute P-Code Benchmarks"
integer x = 9
integer y = 16
integer width = 864
integer height = 84
integer taborder = 10
end type

event clicked;string ls_Path, ls_file, ls_exe
int li_pos

RegistryGet ( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\exbm_p.exe", "path", RegString!, ls_Path )

If ls_Path = "" Then
	If MessageBox ( "PB Runtime", "Unable to locate the PB Runtime." + &
								"~n~r~n~rYou can set the runtime directory by selecting any file in that " + &
								"directory on the following screen.~n~r~n~rDo you want to set the directory now?", Exclamation!, YesNo!, 2) = 2 then
		Return
	Else
		// Allow the user to find the directory
		if GetFileOpenName("Select any file in the PB Runtime directory", ls_Path, ls_file ) = 1 then
			li_Pos = Pos ( Lower ( ls_Path ), Lower ( ls_File ) ) 
			if li_Pos > 0 then ls_Path = Left ( ls_Path, li_Pos - 1 ) 
			RegistrySet ( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\exbm_p.exe", "path", RegString!, ls_Path )

		end if
		
		
	end if
	
End If

If Right ( gs_exampledir, 1 ) = gu_ext_func.uf_Get_Separator ( ) Then
	ls_exe = gs_exampledir + "exbm_p.exe"
Else
	ls_exe = gs_exampledir + gu_ext_func.uf_Get_Separator ( ) + "exbm_p.exe"
End If

If Run(ls_exe) = -1 Then
	MessageBox("Error", "Error running Benchmark Program P-Code executable (exbm_p.exe)", &
						StopSign!)
End If
end event

