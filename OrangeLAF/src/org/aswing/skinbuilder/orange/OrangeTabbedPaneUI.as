package org.aswing.skinbuilder.orange{

import org.aswing.skinbuilder.SkinTabbedPaneUI;

public class OrangeTabbedPaneUI extends SkinTabbedPaneUI{
	
	public function OrangeTabbedPaneUI(){
		super();
	}
	
	override protected function installDefaults():void{
		super.installDefaults();
		var pp:String = getPropertyPrefix();
		tabBorderInsets = getInsets(pp+"tabBorderInsets");
		selectedTabExpandInsets = getInsets(pp+"selectedTabExpandInsets");
	}
}
}