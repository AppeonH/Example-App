$PBExportHeader$u_external_function.sru
$PBExportComments$Cross platform user object ancestor
forward
global type u_external_function from nonvisualobject
end type
end forward

global type u_external_function from nonvisualobject
end type
global u_external_function u_external_function

type variables
Protected:
boolean   ib_registry = false
string	is_separator
end variables

forward prototypes
public function boolean uf_isregistryavailable ()
public function integer uf_playsound (string as_filename, integer ai_options)
public function string uf_assemblepath (string as_drive, string as_dirpath, string as_filename, string as_ext)
public function integer uf_parsepath (string as_path, ref string as_drive, ref string as_dirpath, ref string as_filename, ref string as_ext)
public function integer uf_parsepath (string as_path, ref string as_drive, ref string as_dirpath, ref string as_filename)
public function long uf_lastpos (string as_source, string as_target, long al_start)
public function long uf_lastpos (string as_source, string as_target)
public function ulong uf_getsyscolor (int ai_index)
public function integer uf_getscreenwidth ()
public function integer uf_getscreenheight ()
public function string uf_getos_mode ()
public function ulong uf_getfreememory ()
public function integer uf_getmoduleusage (uint aui_inst)
public function uint uf_getdrivetype (integer ai_drive)
public function uint uf_getwindowsdirectory (ref string as_dir, uint aui_size)
public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size)
public function unsignedinteger uf_getfreesystemresources (integer parm)
public function integer uf_get_logon_name (ref string as_name)
public function ulong uf_get_logon_time ()
public function boolean uf_flash_window (long aui_handle, boolean ab_flash)
public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id)
public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time)
public function long uf_getmodulehandle (string as_name)
public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship)
public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max)
public function boolean uf_iswindowvisible (long aui_handle)
public function string uf_get_separator ()
public function unsignedlong uf_findwindow (unsignedlong aul_classname, string as_windowname)
public function string uf_getcurrentdirectory ()
public function string uf_get_pb_ini ()
public function string uf_assemblepath (string as_drive, string as_dirpath, string as_filename)
public subroutine uf_set_directories ()
end prototypes

public function boolean uf_isregistryavailable ();return ib_registry
end function

public function integer uf_playsound (string as_filename, integer ai_options);//Ancestor PlaySound function.

//Return -1 error becuase the function was not found in a descendent 
Return -1
end function

public function string uf_assemblepath (string as_drive, string as_dirpath, string as_filename, string as_ext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  uf_AssemblePath
//
//	Access:  public
//
//	Arguments:
//	as_Drive					The disk drive from the path.
//	as_DirPath					The directory path.
//	as_FileName				The name of the file.
//	as_Ext						The file extension.
//
//	Returns:		String
//					The fully-qualified directory path.
//
//	Description:	Assemble a fully-qualified directory path from its component parts.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.01   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2019, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the MIT License
 * https://opensource.org/licenses/MIT
 *
 * ====================================================================
* This software consists of voluntary contributions made by many
 * individuals.  For more information on the Open Source PowerBuilder 
 * Foundation Class Libraries see 
 * https://github.com/OpenSourcePFCLibraries
*/
//
//////////////////////////////////////////////////////////////////////////////

String	ls_Path

// Set the Drive and Path.
ls_Path = Trim(as_Drive) + Trim(as_DirPath)

// Make sure the separator is included.
If Right(ls_Path, 1) <> is_Separator Then
	ls_Path = ls_Path + is_Separator
End If

// Add the filename.
ls_Path = ls_Path + Trim(as_FileName)

// Add the Extension.
If Trim(as_Ext) <> "" Then
	ls_Path = ls_Path + "." + Trim(as_Ext)
End if

// Return the assembled path.
Return ls_Path

end function

public function integer uf_parsepath (string as_path, ref string as_drive, ref string as_dirpath, ref string as_filename, ref string as_ext);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	uf_ParsePath
//
//	Access:  	public
//
//	Arguments:
//	as_Path					The path to disassemble.
//	as_Drive					The disk drive from the path, passed by reference.
//	as_DirPath				The directory path, passed by reference.
//	as_FileName				The name of the file, passed by reference.
//	as_Ext					The file extension, passed by reference.  If null is 
//								passed in, the extension will not be parsed out of the file.
//
//	Returns:			integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:	Parse a fully-qualified directory path into its component parts.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.01   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2019, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the MIT License
 * https://opensource.org/licenses/MIT
 *
 * ====================================================================
* This software consists of voluntary contributions made by many
 * individuals.  For more information on the Open Source PowerBuilder 
 * Foundation Class Libraries see 
 * https://github.com/OpenSourcePFCLibraries
*/
//
//////////////////////////////////////////////////////////////////////////////

Integer			li_Pos
String			ls_File
//n_cst_string 	lnv_string

If IsNull(as_path) or Len(Trim(as_path))=0 Then
	Return -1
End If

// Get the drive
li_Pos = Pos(as_Path, ":")
If li_Pos = 0 Then
	as_Drive = ""
Else
	If Mid(as_Path, (li_Pos + 1), 1) = is_Separator Then
		li_Pos ++
	End if

	as_Drive = Left(as_Path, li_Pos)
	as_Path = Right(as_Path, (Len(as_Path) - li_Pos))
End if

// Get the file name and extension
li_Pos = uf_LastPos(as_Path, is_Separator, 0)
ls_File = Right(as_Path, (Len(as_Path) - li_Pos))
as_Path = Left(as_Path, li_Pos)

If IsNull(as_Ext) Then
	as_FileName = ls_File
	as_Ext = ""
Else
	// Get the extension
	li_Pos = uf_LastPos(ls_File, ".")


	If li_Pos > 0 Then
		as_FileName = Left(ls_File, (li_Pos - 1))
		as_Ext = Right(ls_File, (Len(ls_File) - li_Pos))
	Else
		as_FileName = ls_File
		as_Ext = ""
	End if
End If

// Everything left is the directory path
as_DirPath = as_Path
Return 1
end function

public function integer uf_parsepath (string as_path, ref string as_drive, ref string as_dirpath, ref string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		uf_ParsePath
//
//	Access:  		public
//
//	Arguments:
//	as_Path			The path to disassemble.
//	as_Drive			The disk drive from the path, passed by reference.
//	as_DirPath		The directory path, passed by reference.
//	as_FileName		The name of the file, passed by reference.
//
//	Returns:			Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:	Parse a fully-qualified directory path into its component parts.
//
//						This function overrides the real uf_ParsePath to allow the file
//						extension to be optional.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.01   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2019, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the MIT License
 * https://opensource.org/licenses/MIT
 *
 * ====================================================================
* This software consists of voluntary contributions made by many
 * individuals.  For more information on the Open Source PowerBuilder 
 * Foundation Class Libraries see 
 * https://github.com/OpenSourcePFCLibraries
*/
//
//////////////////////////////////////////////////////////////////////////////

String	ls_Ext
SetNull (ls_Ext)

Return uf_ParsePath(as_Path, as_Drive, as_DirPath, as_FileName, ls_Ext)
end function

public function long uf_lastpos (string as_source, string as_target, long al_start);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		uf_LastPos	
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The being searched for.
//	al_start			The starting position, 0 means start at the end.
//
//	Returns:  		Long	
//						The position of as_Target.
//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Search backwards through a string to find the last occurrence 
//						of another string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.01   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2019, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the MIT License
 * https://opensource.org/licenses/MIT
 *
 * ====================================================================
* This software consists of voluntary contributions made by many
 * individuals.  For more information on the Open Source PowerBuilder 
 * Foundation Class Libraries see 
 * https://github.com/OpenSourcePFCLibraries
*/
//
//////////////////////////////////////////////////////////////////////////////

Long	ll_Cnt, ll_Pos

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) or IsNull(al_start) Then
	SetNull(ll_Cnt)
	Return ll_Cnt
End If

//Check for an empty string
If Len(as_Source) = 0 Then
	Return 0
End If

// Check for the starting position, 0 means start at the end.
If al_start=0 Then  
	al_start=Len(as_Source)
End If

//Perform find
For ll_Cnt = al_start to 1 Step -1
	ll_Pos = Pos(as_Source, as_Target, ll_Cnt)
	If ll_Pos = ll_Cnt Then 
		//String was found
		Return ll_Cnt
	End If
Next

//String was not found
Return 0
end function

public function long uf_lastpos (string as_source, string as_target);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		uf_LastPos	
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The string being searched for.
//
//	Returns:  		Long	
//						The position of as_Target.

//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  Search backwards through a string to find the last occurrence of another string
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.01   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2019, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the MIT License
 * https://opensource.org/licenses/MIT
 *
 * ====================================================================
* This software consists of voluntary contributions made by many
 * individuals.  For more information on the Open Source PowerBuilder 
 * Foundation Class Libraries see 
 * https://github.com/OpenSourcePFCLibraries
*/
//
//////////////////////////////////////////////////////////////////////////////

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) Then
	Long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Set the starting position and perform the search
Return uf_LastPos (as_source, as_target, Len(as_Source))
end function

public function ulong uf_getsyscolor (int ai_index);//returns 0 becuase it was not found in the descendent nvo

return 0
end function

public function integer uf_getscreenwidth ();//returns -1 not found	r
Return -1
end function

public function integer uf_getscreenheight ();Return -1
end function

public function string uf_getos_mode ();//not valid
return ""
end function

public function ulong uf_getfreememory ();//not valid

return 0
end function

public function integer uf_getmoduleusage (uint aui_inst);//function not found	
return -1
end function

public function uint uf_getdrivetype (integer ai_drive);//drive types
return 0
end function

public function uint uf_getwindowsdirectory (ref string as_dir, uint aui_size);//function not found
return 0
end function

public function uint uf_getsystemdirectory (ref string as_dir, uint aui_size);//directory not found
return 0
end function

public function unsignedinteger uf_getfreesystemresources (integer parm);//not valid
return 0
end function

public function integer uf_get_logon_name (ref string as_name);//func	
return -1
end function

public function ulong uf_get_logon_time ();//no func
return 0
end function

public function boolean uf_flash_window (long aui_handle, boolean ab_flash);//function not found in descendent
return false
end function

public function boolean uf_killtimer (long aui_handle, unsignedinteger aui_id);//not handled
Return False
end function

public function unsignedinteger uf_settimer (long aui_handle, unsignedinteger aui_id, unsignedinteger aui_time);//not handled
return 0
end function

public function long uf_getmodulehandle (string as_name);//function not found
return 0
end function

public function unsignedinteger uf_getwindow (long aui_handle, unsignedinteger aui_relationship);//function not found
return 0
end function

public function integer uf_getwindowtext (long aui_handle, ref string as_text, integer ai_max);//function not found
return 0
end function

public function boolean uf_iswindowvisible (long aui_handle);//function not found
return false
end function

public function string uf_get_separator ();Return is_Separator
end function

public function unsignedlong uf_findwindow (unsignedlong aul_classname, string as_windowname);//function not found
return 0
end function

public function string uf_getcurrentdirectory ();//directory not found
return ""
end function

public function string uf_get_pb_ini ();Return ""
end function

public function string uf_assemblepath (string as_drive, string as_dirpath, string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  uf_AssemblePath
//
//	Access:  public
//
//	Arguments:
//	as_Drive					The disk drive from the path.
//	as_DirPath					The directory path.
//	as_FileName				The name of the file.
//
//	Returns:		String
//					The fu   lly-qualified directory path.
//
//	Description:	Assemble a fully-qualified directory path from its component parts.
//
//						This function overrides the real uf_AssemblePath to allow the file
//						extension to be optional. This is for jane
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.01   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2019, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the MIT License
 * https://opensource.org/licenses/MIT
 *
 * ====================================================================
* This software consists of voluntary contributions made by many
 * individuals.  For more information on the Open Source PowerBuilder 
 * Foundation Class Libraries see 
 * https://github.com/OpenSourcePFCLibraries
*/
//
//////////////////////////////////////////////////////////////////////////////

Return uf_AssemblePath(as_Drive, as_DirPath, as_FileName, "")

end function

public subroutine uf_set_directories ();String	ls_PBDir, ls_File, ls_ExampleDir
Integer	li_Pos
Constant String ls_anchorFile = "\example.bmp"

// Open the splash window hidden to use for setting the directory
OpenWithParm(w_splash, "hide")

// Look for a registry setting for the dir path
If RegistryGet ( sRegKey + "\Code Examples", "ExampleDir", RegString!, ls_ExampleDir ) <> 1 Then
	//  Must be first time
	If ( Right (ls_ExampleDir, 1) = "\") Then
		ls_ExampleDir = Left ( ls_ExampleDir, Len ( ls_ExampleDir ) - 1 )
	End If
	If Not FileExists ( ls_ExampleDir + ls_anchorFile ) Then
		//  Look in the current directory
		ls_ExampleDir = GetCurrentDirectory ()
	End If 
End If

If ( Right (ls_ExampleDir, 1) = "\" ) Then
	ls_ExampleDir = Left ( ls_ExampleDir, Len ( ls_ExampleDir ) - 1 )
End If

// Verify the directory contains the resources needed
// If not valid, the resources (BMPs & ICOs) will be missing.
If Not FileExists ( ls_ExampleDir + ls_anchorFile ) Then
	If MessageBox ("Warning", "The Code Examples were unable to locate the directory containing " + &
								" the bitmap and icon resources required. " + &
								"There is usually a subdirectory called 'examples' under the main PowerBuilder " + &
								"directory.~n~r~n~rYou can set the correct directory by selecting any file in that " + &
								"directory on the following screen.~n~r~n~rDo you want to set the directory now?", Exclamation!, YesNo!, 2) = 2 Then
		Return
	Else
		// Allow the user to find the directory
		If GetFileOpenName("Select any file in the Examples directory", ls_ExampleDir, ls_File) = 1 Then
			li_Pos = Pos ( Lower ( ls_ExampleDir ), Lower ( ls_File ) ) 
			If li_Pos > 0 Then ls_ExampleDir = Left ( ls_ExampleDir, li_Pos - 1 ) 
		End If
	End If
End If

// Make example directory the current directory
w_splash.lb_dir.DirList ( ls_ExampleDir, 0 )
gs_ExampleDir = ls_ExampleDir

//  Store the examples dir in the registry
RegistrySet ( sRegKey + "\Code Examples", "ExampleDir", RegString!, ls_ExampleDir )
Close ( w_splash ) 


end subroutine

on u_external_function.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_external_function.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

