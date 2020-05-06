  // Demo.chooseType
  // 
  // Created by Brent Raymond on 01/03/20
  // Purpose: 
  // 
  // Note:
  //  
  // History:


Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($lChoice)
		
		Form:C1466.issueTypeNames:=JIRA_Project (New object:C1471("projectKey";Form:C1466.currentProject)).issueTypes.extract("name")
		
		$lChoice:=Pop up menu:C542(Form:C1466.issueTypeNames.join(";"))
		
		If ($lChoice>0)
			Form:C1466.newIssue.issuetype:=Form:C1466.issueTypeNames[$lChoice-1]
			
		End if 
		
End case 


