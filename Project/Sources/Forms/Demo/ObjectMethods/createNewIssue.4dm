  // Demo.createNewIssue
  // 
  // Created by Brent Raymond on 01/03/20
  // Purpose: 
  // 
  // Note:
  //  
  // History:


Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_OBJECT:C1216($oResult)
		
		Form:C1466.newIssue.projectKey:=Form:C1466.currentProject
		Form:C1466.newIssue.labels:=Split string:C1554(Form:C1466.newIssue.labelString;",";sk trim spaces:K86:2+sk ignore empty strings:K86:1)
		
		$oResult:=JIRA_NewIssue (Form:C1466.newIssue)
		
		If (Value type:C1509($oResult.key)=Is text:K8:3)
			JIRA_OpenIssue (New object:C1471("issueKey";$oResult.key))
			
			Form:C1466.newIssue:=New object:C1471
			
		End if 
		
End case 


