//%attributes = {}
  // JIRA_Init ({object}) : object
  // 
  // Created by Brent Raymond on 12/24/19
  // Purpose: Initialize the JIRA module, return reference to init in Storage
  // 
  // Parameters:
  //         username - 
  //         password - 
  //         server - 
  //         currentProject - 
  //         currentIssue - 
  //
  // Note:
  //  
  // History:



C_OBJECT:C1216($1;$oInit)
C_OBJECT:C1216($0)

If (Storage:C1525.JIRA=Null:C1517)
	Use (Storage:C1525)
		Storage:C1525.JIRA:=New shared object:C1526("success";False:C215)
		
	End use 
	
End if 

Case of 
	: (Storage:C1525.JIRA=Null:C1517)
		
	: (Count parameters:C259=0)
		
	Else 
		$oInit:=$1
		
		Use (Storage:C1525.JIRA)
			OB_CopyToSharedObject ($oInit;Storage:C1525.JIRA)
			
			  // standard headers for all calls
			Storage:C1525.JIRA.headerNames:=New shared collection:C1527("Accept")
			Storage:C1525.JIRA.headerValues:=New shared collection:C1527("application/json")
			
			Storage:C1525.JIRA.success:=True:C214
			
		End use 
		
End case 

$0:=Storage:C1525.JIRA



