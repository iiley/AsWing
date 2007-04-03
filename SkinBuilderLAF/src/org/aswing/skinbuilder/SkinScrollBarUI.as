/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import flash.display.DisplayObject;

import org.aswing.*;
import org.aswing.plaf.basic.BasicScrollBarUI;

public class SkinScrollBarUI extends BasicScrollBarUI{
	
	public function SkinScrollBarUI(){
		super();
	}
	
	override protected function installDefaults():void{
		var pp:String = getPropertyPrefix();
		scrollBarWidth = getInt(pp+"arrowSize");
	}
	
    override protected function createArrowButton():JButton{
		var b:JButton = new JButton();
		b.setFocusable(false);
		b.setOpaque(false);
		b.setBackgroundDecorator(null);
		return b;
    }	

	override protected function createIcons():void{
		var pp:String = getPropertyPrefix();
		var size:int = scrollBarWidth;
    	leftIcon = new SkinScrollBarArrowIcon(pp+"arrowLeft.", size);
    	rightIcon = new SkinScrollBarArrowIcon(pp+"arrowRight.", size);
    	upIcon = new SkinScrollBarArrowIcon(pp+"arrowUp.", size);
    	downIcon = new SkinScrollBarArrowIcon(pp+"arrowDown.", size);
    }
}
}