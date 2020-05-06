//%attributes = {}
  // Demo
  // 
  // Created by Brent Raymond on 12/30/19
  // Purpose: 
  // 
  // Note:
  //  
  // History:


C_OBJECT:C1216($oForm)
C_LONGINT:C283($lWindow)

$oForm:=New object:C1471

$oForm.username:="4dmethod@gmail.com"
$oForm.password:="iBBEkpJI9Ez53q7YejDX2174"  // API Token
$oForm.server:="https://4dmethod.atlassian.net"
$oForm.currentProject:="QL4D"  // or use JIRA_ProjectList later on when selecting between projects
$oForm.currentIssue:=""  // for use in Macros

If (JIRA_Init ($oForm).success)
	$oForm.issues:=JIRA_Search (New object:C1471("project";JIRA_Init .currentProject))
	
	$oForm.newIssue:=New object:C1471
	
	$lWindow:=Open form window:C675("Demo";Plain form window:K39:10;Horizontally centered:K39:1;Vertically centered:K39:4)
	DIALOG:C40("Demo";$oForm)
	
End if 

