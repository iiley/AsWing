/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.background
{
	
import flash.display.DisplayObject;

import org.aswing.*;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.*;
import org.aswing.plaf.basic.BasicGraphicsUtils;
import org.aswing.plaf.ComponentUI;

public class ButtonBackgound implements GroundDecorator{
    private var shadow:ASColor;
    private var darkShadow:ASColor;
    private var highlight:ASColor;
    private var lightHighlight:ASColor;
    
	public function ButtonBackgound(){
	} 
	

	private function reloadColors(ui:ComponentUI):void{
		shadow = ui.getColor("Button.shadow");
		darkShadow = ui.getColor("Button.darkShadow");
		highlight = ui.getColor("Button.light");
		lightHighlight = ui.getColor("Button.highlight");
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void{
		if(shadow == null){
			reloadColors(c.getUI());
		}
		var b:AbstractButton = c as AbstractButton;
		bounds = bounds.clone();
		if(b == null) return;
		if(c.isOpaque()){
			var model:ButtonModel = b.getModel();
	    	var isPressing:Boolean = model.isArmed() || model.isSelected();
			BasicGraphicsUtils.drawBezel(g, bounds, isPressing, shadow, darkShadow, highlight, lightHighlight);
			bounds.grow(-2, -2);
			BasicGraphicsUtils.paintButtonBackGround(b, g, bounds);
		}
	}
	
	public function getDisplay():DisplayObject
	{
		return null;
	}
	
}
}