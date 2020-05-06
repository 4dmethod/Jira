  // Demo.reloadIssues
  // 
  // Created by Brent Raymond on 01/03/20
  // Purpose: 
  // 
  // Note:
  //  
  // History:



Case of 
	: (Form event code:C388=On Clicked:K2:4)
		Form:C1466.issues:=JIRA_Search (New object:C1471("project";JIRA_Init .currentProject))
		
	Else 
		
End case 


