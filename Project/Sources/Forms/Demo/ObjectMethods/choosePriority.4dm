  // Demo.choosePriority
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
		
		Form:C1466.priorityNames:=JIRA_PrioritiesList .extract("name")
		
		$lChoice:=Pop up menu:C542(Form:C1466.priorityNames.join(";"))
		
		If ($lChoice>0)
			Form:C1466.newIssue.priority:=Form:C1466.priorityNames[$lChoice-1]
			
		End if 
		
End case 


