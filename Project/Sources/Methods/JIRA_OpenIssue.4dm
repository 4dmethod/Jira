//%attributes = {}
  // JIRA_OpenIssue (object) : 
  // 
  // Created by Brent Raymond on 12/30/19
  // Purpose: 
  // 
  // Parameters:
  //       issueKey   - 
  // 
  // Note:
  //  
  // History:


C_OBJECT:C1216($1;$oInput)

$oInput:=$1

Case of 
	: (Not:C34(JIRA_Init .success))
		
	: ($oInput.issueKey=Null:C1517)
		
	Else 
		OPEN URL:C673(JIRA_Init .server+"/projects/"+JIRA_Init .currentProject+"/issues/"+$oInput.issueKey)
		
End case 

