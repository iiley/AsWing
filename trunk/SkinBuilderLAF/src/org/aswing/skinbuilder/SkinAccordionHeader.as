/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.plaf.basic.accordion.BasicAccordionHeader;
import org.aswing.*;
import org.aswing.plaf.basic.background.ButtonBackground;

public class SkinAccordionHeader extends BasicAccordionHeader{
	
	public function SkinAccordionHeader(){
		super();
	}

	override protected function createHeaderButton():AbstractButton{
		var tb:JToggleButton = new JToggleButton();
		tb.setBackgroundDecorator(new SkinButtonBackground("Accordion.header."));
		return tb;
	}
	
	override public function setSelected(b:Boolean):void{
		button.setSelected(b);
	}
}
}