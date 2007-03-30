/*
 Copyright aswing.org, see the LICENCE.txt.
*/


package org.aswing.skinbuilder{
	
public class SkinCheckBoxUI extends SkinRadioButtonUI{
	
	public function SkinCheckBoxUI(){
		super();
	}
	
    override protected function getPropertyPrefix():String {
        return "CheckBox.";
    }
}
}