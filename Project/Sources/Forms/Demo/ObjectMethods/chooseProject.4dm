  // Demo.chooseProject
  // 
  // Created by Brent Raymond on 01/17/20
  // Purpose: 
  // 
  // Note:
  //  
  // History:


Case of 
	: (Form event code:C388=On Clicked:K2:4)
		C_LONGINT:C283($lChoice)
		
		Form:C1466.projectList:=JIRA_ProjectList .values
		
		$lChoice:=Pop up menu:C542(Form:C1466.projectList.extract("key").join(";"))
		
		If ($lChoice>0)
			Form:C1466.currentProject:=Form:C1466.projectList.extract("key")[$lChoice-1]
			
		End if 
		
End case 


