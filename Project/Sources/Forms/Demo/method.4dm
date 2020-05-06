  // Demo
  // 
  // Created by Brent Raymond on 01/08/20
  // Purpose: 
  // 
  // Note:
  //  
  // History:

Case of 
	: (Form event code:C388=On Page Change:K2:54)
		Case of 
			: (FORM Get current page:C276=1)
				Form:C1466.username:=JIRA_Init .username
				Form:C1466.password:=JIRA_Init .password
				Form:C1466.server:=JIRA_Init .server
				Form:C1466.currentProject:=JIRA_Init .currentProject
				Form:C1466.currentIssue:=JIRA_Init .currentIssue
				
		End case 
		
	Else 
		
End case 



