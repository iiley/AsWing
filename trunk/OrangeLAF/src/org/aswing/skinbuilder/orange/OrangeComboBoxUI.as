package org.aswing.skinbuilder.orange{

import org.aswing.skinbuilder.SkinComboBoxUI;
import org.aswing.JScrollPane;
import org.aswing.border.LineBorder;
import org.aswing.ASColor;

public class OrangeComboBoxUI extends SkinComboBoxUI{
	
	public function OrangeComboBoxUI(){
		super();
	}
	    
    override protected function getScollPane():JScrollPane{
    	if(scollPane == null){
    		scollPane = new JScrollPane(getPopupList());
    		scollPane.setBorder(new LineBorder(null, new ASColor(0xFDAC05)));
    		scollPane.setOpaque(true);
    	}
    	return scollPane;
    }
}
}