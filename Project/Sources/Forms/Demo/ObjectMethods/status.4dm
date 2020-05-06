  // Demo.status
  // 
  // Created by Brent Raymond on 01/08/20
  // Purpose: 
  // 
  // Note:
  //  
  // History:

  // 1/8/20 BR: 

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (Form:C1466.selectedIssue#Null:C1517)
			C_COLLECTION:C1488($cStatuses)
			C_LONGINT:C283($lChoice)
			
			$cStatuses:=JIRA_StatusTransitionList (New object:C1471("issueKey";Form:C1466.selectedIssue.key)).extract("name")
			
			$lChoice:=Pop up menu:C542($cStatuses.join(";");$cStatuses.indexOf((OBJECT Get pointer:C1124(Object named:K67:5;"status"))->)+1)
			
			If ($lChoice>0)
				(OBJECT Get pointer:C1124(Object named:K67:5;"status"))->:=$cStatuses[$lChoice-1]
				
			End if 
			
		End if 
		
End case 

