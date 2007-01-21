/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic{
	
import org.aswing.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
	
/**
 * Basic RadioButton implementation.
 * @author iiley
 */	
public class BasicRadioButtonUI extends BasicToggleButtonUI{
	
	private var defaultIcon:Icon;
	
	public function BasicRadioButtonUI(){
		super();
	}
	
	override protected function installDefaults(b:AbstractButton):void{
		super.installDefaults(b);
		defaultIcon = getIcon(getPropertyPrefix() + "icon");
		trace("RadioButton defaultIcon : " + defaultIcon);
	}
	
    override protected function getPropertyPrefix():String {
        return "RadioButton.";
    }
    	
    public function getDefaultIcon():Icon {
        return defaultIcon;
    }
    
    override protected function getIconToLayout():Icon{
    	if(button.getIcon() == null){
    		return defaultIcon;
    	}else{
    		return button.getIcon();
    	}
    }
    
	override protected function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):void{
		if(c.isOpaque()){
			g.fillRectangle(new SolidBrush(c.getBackground()), b.x, b.y, b.width, b.height);
		}
	}
}
}