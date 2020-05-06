  // Demo.updateConfig
  // 
  // Created by Brent Raymond on 12/31/19
  // Purpose: 
  // 
  // Note:
  //  
  // History:


Case of 
	: (Form event code:C388=On Clicked:K2:4)
		If (JIRA_Init (Form:C1466).success)
			ALERT:C41("Configuration updated.")
			
		End if 
		
	Else 
		
End case 



