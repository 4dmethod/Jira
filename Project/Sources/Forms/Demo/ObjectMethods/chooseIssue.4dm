  // Demo.chooseIssue
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
		C_COLLECTION:C1488($cChoices)
		C_OBJECT:C1216($oIssue)
		
		$cChoices:=New collection:C1472
		
		Form:C1466.issueList:=JIRA_Search (New object:C1471("project";JIRA_Init .currentProject))
		
		For each ($oIssue;Form:C1466.issueList)
			$cChoices.push(Char:C90(1)+$oIssue.key+\
				" ("+$oIssue.fields.issuetype.name+") ["+$oIssue.fields.status.name+"] "+\
				$oIssue.fields.summary)
			
		End for each 
		
		$lChoice:=Pop up menu:C542($cChoices.join(";"))
		
		If ($lChoice>0)
			Form:C1466.currentIssue:=Form:C1466.issueList.extract("key")[$lChoice-1]
			
		End if 
		
End case 


