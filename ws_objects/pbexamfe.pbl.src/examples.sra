$PBExportHeader$examples.sra
$PBExportComments$PowerBuilder Code Examples Application
forward
global type examples from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
//cross platform information
//ge_environment maintains the operating environment
environment ge_environment

//gu_ext_func is a user object capable of handling
//generic operating system level calls and mapping
//them to the appropriate external functions.
u_external_function gu_ext_func

//The base registry entry key used
string sREGKEY
string sPBKEY

// the Major Version 
string sVERSION, sVersionSimple

// the Examples Version 
string sVERSIONEX

// the Fix Version
string sVERSIONNAME

// the name of the PB Executable
string sPBEXE

// the directory the Code Examples are installed in
string gs_ExampleDir
end variables

global type examples from application
string appname = "examples"
string themepath = "C:\Program Files (x86)\Appeon\Shared\PowerBuilder\theme190"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = "Pbex.ico"
end type
global examples examples

type prototypes
end prototypes

event open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	open
//
//	Description:
// Determines which platform the application is running
// on and creates the appropriate user object for external
// function declarations.  Initializes global settings for
// the application and connects to the database.
//
//////////////////////////////////////////////////////////////////////////////
string ls_dotversion, ls_version
string	ls_toolbartext
string	ls_usercontrol
int li_rc, li_major, li_minor, li_fixversion
ContextInformation lcx_key

SetPointer(hourglass!)

// Get the current environment for cross-platform issues
GetEnvironment(ge_environment)

/*  Get PB Version.    */
ge_environment.GetContextService ( "ContextInformation", lcx_key)
lcx_key.GetMajorVersion ( li_major )
lcx_key.GetMinorVersion ( li_minor )
lcx_key.GetFixesVersion ( li_fixversion )
lcx_key.GetVersionName ( sVERSIONNAME )

// Minor version should not be part of the application name,
// UNLESS minor version is a major version - figure that out
//li_minor = 0 
ls_dotversion = String ( li_major ) + "." + String ( li_minor )
ls_version = String ( li_major ) + String ( li_minor )

sVersionSimple = String ( li_major )
// Version of Examples ( May Differ from PB Version )
sVERSIONEX = ls_dotversion + "." + String(li_fixversion)

choose case ge_environment.Charset
	case CharSetUnicode! 
		sVERSION = ls_dotversion
		sPBEXE = "pb" + ls_version + ".exe"
	case CharSetDBCSJapanese!
		sVERSION = ls_dotversion + "j"
		sPBEXE = "pb" + ls_version + ".exe"
	case else
		sVERSION = ls_dotversion 
		sPBEXE = "pb" + ls_version + ".exe"
end choose

sREGKEY = "HKEY_CURRENT_USER\Software\Sybase\PowerBuilder\" + sVERSION
sPBKEY  = "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\App Paths\" + sPBEXE + "\"

// Create the global user object gu_ext_func. 
// The user object will handle cross platform operating system external calls
if not f_create_external_func_uo(gu_ext_func) then
	Messagebox ("External Functions User Object","An error occurred while initializing the "+&
					"external function user object.  External calls will not be available "+&
					"for this session.")
end if

// Get the directory for the examples
gu_ext_func.uf_set_directories()
gu_ext_func.uf_get_pb_ini ( ) 

// Display splash screen
OpenWithParm(w_splash, "show")

// Set DBMS connection
li_rc = f_get_profile("sqlca", "dbms", sqlca.dbms)
if li_rc = -1 then
	// Using registry, set default values
	sqlca.dbms = "ODBC"
	sqlca.dbparm = "ConnectString='DSN=PB Demo DB V2019R3;UID=dba;PWD=sql'"
	f_set_profile("sqlca", "dbms", "ODBC" )
	f_set_profile("sqlca", "dbparm", "ConnectString='DSN=PB Demo DB V2019R3;UID=dba;PWD=sql'" )
else
	f_get_profile("sqlca", "database", sqlca.database)
	f_get_profile("sqlca", "userid", sqlca.userid)
	f_get_profile("sqlca", "dbpass", sqlca.dbpass)
	f_get_profile("sqlca", "logid", sqlca.logid)
	f_get_profile("sqlca", "logpass", sqlca.logpass)
	f_get_profile("sqlca", "servername", sqlca.servername)
	f_get_profile("sqlca", "dbparm", sqlca.dbparm)
End if

connect;
if sqlca.sqlcode <> 0 then
	w_splash.SetPosition(NoTopmost!)
	MessageBox ("Sorry! Cannot Connect To Database", sqlca.sqlerrtext)
	
	// Open window to enter connection parameters
	li_rc = 0
	Open(w_set_sqlca)
	if Message.DoubleParm = -1 then
		// Did not connect successfully, so exit
		halt close
		return
	end if
end if

if li_rc = -1 then
	// Save profile entries if using defaults in the registry
	f_set_profile("sqlca", "dbms", sqlca.dbms)
	f_set_profile("sqlca", "database", sqlca.database)
	f_set_profile("sqlca", "userid", sqlca.userid)
	f_set_profile("sqlca", "dbpass", sqlca.dbpass)
	f_set_profile("sqlca", "logid", sqlca.logid)
	f_set_profile("sqlca", "logpass", sqlca.logpass)
	f_set_profile("sqlca", "servername", sqlca.servername)
	f_set_profile("sqlca", "dbparm", sqlca.dbparm)
end if

// Set the application attributes that determines whether the toolbars
// show with large buttons with text or small buttons without text and
// whether they can be moved.
f_get_profile("application", "showtext", ls_toolbartext)
toolbartext = (ls_toolbartext = "yes")

f_get_profile("application", "usercontrol", ls_usercontrol)
if ls_usercontrol = "no" then toolbarusercontrol = false

// Open the front-end window
Open(w_main)
end event

event systemerror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	systemerror
//
//	Description:
// Opens the system error window to display the error text.
//
//////////////////////////////////////////////////////////////////////////////
Open(w_system_error)
end event

event close;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	close
//
//	Description:
// Save the current values of the ShowText and UserControl
// application settings to the registry or example.ini file.
// These determine whether the toolbars show with 
// large buttons with text or small buttons without text and
// whether the user can move them or not. They are set from 
// the registry or the example.ini file in the application open event.
//
//////////////////////////////////////////////////////////////////////////////
string	ls_showtext
string	ls_usercontrol

if toolbartext = true then
	ls_showtext = "yes"
else
	ls_showtext = "no"
end if

if toolbarusercontrol = true then
	ls_usercontrol = "yes"
else
	ls_usercontrol = "no"
end if

f_set_profile("application", "showtext", ls_showtext)
f_set_profile("application", "usercontrol", ls_usercontrol)

//Destroy the Cross Platform NVO if exists.
if not IsNull(gu_ext_func) then destroy(gu_ext_func)
end event

on examples.create
appname="examples"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on examples.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

