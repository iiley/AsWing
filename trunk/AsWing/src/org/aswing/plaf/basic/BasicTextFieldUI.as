/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic{
	
public class BasicTextFieldUI extends BasicTextComponentUI{
	
	public function BasicTextFieldUI(){
		super();
	}
	
	//override this to the sub component's prefix
	override protected function getPropertyPrefix():String {
		return "TextField.";
	}
}
}