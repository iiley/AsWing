/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

public class SkinScrollBarArrowIcon extends SkinButtonIcon{
	
	private var prefix:String;
	
	public function SkinScrollBarArrowIcon(prefix:String, size:int){
		super(size, size);
		this.prefix = prefix;
	}
	
	override protected function getPropertyPrefix():String {
        return prefix;
    }
}
}