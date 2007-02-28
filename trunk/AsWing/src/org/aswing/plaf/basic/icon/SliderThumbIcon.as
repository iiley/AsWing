/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon{

import org.aswing.graphics.*;
import org.aswing.Icon;
import org.aswing.Component;
import flash.display.*;
import org.aswing.plaf.*;
import org.aswing.plaf.basic.BasicGraphicsUtils;
import org.aswing.ASColor;
import org.aswing.JSlider;
import org.aswing.geom.IntRectangle;

public class SliderThumbIcon implements Icon, UIResource{
	
	protected var thumb:Sprite;
	protected var enabledButton:SimpleButton;
	protected var disabledButton:SimpleButton;
	
	protected var thumbLightHighlightColor:ASColor;
	protected var thumbHighlightColor:ASColor;
	protected var thumbLightShadowColor:ASColor;
	protected var thumbDarkShadowColor:ASColor;
	protected var thumbColor:ASColor;
	
	public function SliderThumbIcon(){
		thumb = new Sprite();
	}
	
	protected function getPropertyPrefix():String {
		return "Slider.";
	}	
	
	protected function initThumb(ui:ComponentUI):void{
		var pp:String = getPropertyPrefix();
		thumbHighlightColor = ui.getColor(pp+"thumbHighlight");
		thumbLightHighlightColor = ui.getColor(pp+"thumbLightHighlight");
		thumbLightShadowColor = ui.getColor(pp+"thumbShadow");
		thumbDarkShadowColor = ui.getColor(pp+"thumbDarkShadow");
		thumbColor = ui.getColor(pp+"thumb");
		
		//enabled
		enabledButton = new SimpleButton();
		var upState:Shape = new Shape();
		var g:Graphics2D = new Graphics2D(upState.graphics);
    	
    	var borderC:ASColor = thumbDarkShadowColor;
    	var fillC:ASColor = thumbColor;
    	paintThumb(g, borderC, fillC, true);
    	enabledButton.upState = upState; 
		enabledButton.overState = upState;
		enabledButton.downState = upState;
		enabledButton.hitTestState = upState;
		enabledButton.useHandCursor = false;
		thumb.addChild(enabledButton);
		
		//disabled
		disabledButton = new SimpleButton();
		upState = new Shape();
		g = new Graphics2D(upState.graphics);
    	
    	borderC = thumbColor;
    	fillC = thumbColor;
    	paintThumb(g, borderC, fillC, false);
    	disabledButton.upState = upState; 
		disabledButton.overState = upState;
		disabledButton.downState = upState;
		disabledButton.hitTestState = upState;
		disabledButton.useHandCursor = false;
		thumb.addChild(disabledButton);
		disabledButton.visible = false;
	}
	
	private function paintThumb(g:Graphics2D, borderC:ASColor, fillC:ASColor, enabled:Boolean):void{
		if(!enabled){
	    	g.beginDraw(new Pen(borderC));
	    	g.beginFill(new SolidBrush(fillC));
	    	g.rectangle(1, 1, getIconWidth()-2, getIconHeight()-2);
	    	g.endFill();
	    	g.endDraw();
		}else{
    		BasicGraphicsUtils.drawControlBackground(
    			g, 
    			new IntRectangle(0, 0, getIconWidth(), getIconHeight()), 
    			fillC,
    			0);
			g.drawRectangle(new Pen(borderC), 0.5, 0.5, getIconWidth()-1, getIconHeight()-1);
		}
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void
	{
		if(thumbColor == null){
			initThumb(c.getUI());
		}
		thumb.x = x;
		thumb.y = y;
		var slider:JSlider = c as JSlider;
		if(slider != null){
			disabledButton.visible = !slider.isEnabled();
			enabledButton.visible = slider.isEnabled();
		}
	}
	
	public function getIconHeight():int
	{
		return 18;
	}
	
	public function getIconWidth():int
	{
		return 8;
	}
	
	public function getDisplay():DisplayObject
	{
		return thumb;
	}
	
}
}