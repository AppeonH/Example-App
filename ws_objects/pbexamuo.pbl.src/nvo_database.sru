$PBExportHeader$nvo_database.sru
$PBExportComments$Distributed PB example Non visual Database object
forward
global type nvo_database from nonvisualobject
end type
end forward

global type nvo_database from nonvisualobject
end type
global nvo_database nvo_database

type variables
nvo_transaction 	invo_transaction
boolean 		ib_connected
end variables

forward prototypes
public subroutine of_get_trans (ref transaction atr_trans)
public function boolean of_set_datasource (string as_datasource)
private function boolean of_set_transaction (string as_view)
end prototypes

public subroutine of_get_trans (ref transaction atr_trans);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_get_trans
//
//	Access:  public
//
//	Arguments:
//	atr_trans  - transaction passed by reference 
//
//	Returns:  boolean
//	
//
//	Description: 
//		This function will set the passed in transaction to the current instance
//		transaction.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
atr_trans = invo_transaction
end subroutine

public function boolean of_set_datasource (string as_datasource);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_set_datasource
//
//	Access:  public
//
//	Arguments:
//	as_datasource  - the source connection (view) for the data
//
//	Returns:  boolean
//	
//
//	Description: 
//				The datasource is a view into the data to be used in future
//					requests for data. This function will call a private function to set the
//					instance transaction object.
//
//						Supported views:
//							"Sales" - Sales related data
//							"Customer" - Customer related data
//							"Product" - Product related data
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////


CHOOSE CASE as_datasource
	CASE "Sales"
		of_set_transaction("Sales")
	CASE "Customer"
		of_set_transaction("Customer")
	CASE "Product"
		of_set_transaction("Product")
	CASE "Reports"
		of_set_transaction("Reports")
END CHOOSE

return true

end function

private function boolean of_set_transaction (string as_view);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_set_transaction
//
//	Access:  private
//
//	Arguments:
//	as_view  - the source connection (view) for the data
//
//	Returns:  boolean
//	
//
//	Description: This function will set the transaction object
//
//						Supported views:
//							"Sales" - Sales related data
//							"Customer" - Customer related data
//							"Product" - Product related data
//							"Reports" - Reports related data
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
Constant string ls_dbparm = "ConnectString='DSN=PB Demo DB V2019'"

CHOOSE CASE as_view
	CASE "Sales"
		invo_transaction.dbms = "odbc"
		invo_transaction.dbparm = ls_dbparm
		if NOT ib_connected THEN
			connect using invo_transaction;
		end if
		
	CASE "Customer"
		invo_transaction.dbms = "odbc"
		invo_transaction.dbparm = ls_dbparm
		if NOT ib_connected THEN
			connect using invo_transaction;
		end if
	CASE "Product"
		invo_transaction.dbms = "odbc"
		invo_transaction.dbparm = ls_dbparm
		if NOT ib_connected THEN
			connect using invo_transaction;
		end if
	CASE "Reports"
		invo_transaction.dbms = "odbc"
		invo_transaction.dbparm = ls_dbparm
		if NOT ib_connected THEN
			connect using invo_transaction;
		end if

END CHOOSE


return false
end function

on nvo_database.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_database.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;// destroy objects created by this object
destroy(invo_transaction)
end event

event constructor;// create transaction object
invo_transaction = create nvo_transaction
end event

