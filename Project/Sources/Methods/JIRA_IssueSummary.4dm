//%attributes = {}
  // JIRA_IssueSummary (object): text
  // 
  // Created by Brent Raymond on 01/08/20
  // Purpose: 
  // 
  // Parameters:
  //       issueKey   - 
  // 
  // Note:
  //  
  // History:

C_OBJECT:C1216($1;$oInput)
C_TEXT:C284($0;$tSummary)

C_OBJECT:C1216($oIssue)

$oInput:=$1

Case of 
	: (Not:C34(JIRA_Init .success))
		
	Else 
		$oIssue:=JIRA_Issue ($oInput)
		
		If ($oIssue#Null:C1517)
			$tSummary:="// "+String:C10(Current date:C33)+" "+Current user:C182+\
				": JIRA issue "+$oIssue.key+" - "+$oIssue.fields.summary+" - "
			
		End if 
		
End case 

$0:=$tSummary