/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.plaf.basic.BasicAccordionUI;
import org.aswing.plaf.basic.tabbedpane.Tab;

public class SkinAccordionUI extends BasicAccordionUI{
	
	public function SkinAccordionUI(){
		super();
	}
	
    override protected function createNewHeader():Tab{
    	var header:Tab = new SkinAccordionHeader();
    	header.getComponent().setFocusable(false);
    	return header;
    }
}
}