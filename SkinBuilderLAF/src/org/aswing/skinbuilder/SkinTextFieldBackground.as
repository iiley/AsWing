/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

public class SkinTextFieldBackground extends SkinTextBackground{
	
	public function SkinTextFieldBackground(){
		super();
	}
	
	override protected function getPropertyPrefix():String {
        return "TextField.";
    }
}
}