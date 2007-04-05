/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.plaf.basic.BasicComboBoxUI;
import org.aswing.*;

public class SkinComboBoxUI extends BasicComboBoxUI{
	
	public function SkinComboBoxUI(){
		super();
	}
	
	override protected function createDropDownButton():Component{
		var btn:JButton = new JButton();
		btn.setBorder(null);
		btn.setBackground(null);
		btn.setOpaque(false);
		btn.setIcon(new SkinButtonIcon(-1, -1, getPropertyPrefix()));
		return btn;
	}
}
}