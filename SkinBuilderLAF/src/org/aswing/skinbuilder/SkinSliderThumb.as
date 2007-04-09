/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.graphics.Graphics2D;
import org.aswing.Icon;
import org.aswing.Component;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;
import org.aswing.AbstractButton;
import org.aswing.JButton;

public class SkinSliderThumb implements Icon, UIResource{
	
	protected var thumb:AbstractButton;
	protected var icon:SkinButtonIcon;
	
	public function SkinSliderThumb(){
		thumb = new JButton();
		thumb.setBackgroundDecorator(null);
	}
	
	protected function checkIcon(c:Component):void{
		if(!icon){
			icon = new SkinButtonIcon(-1, -1, "Slider.thumb.");
			icon.checkSetup(c);
			thumb.setIcon(icon);
		}
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void{
		checkIcon(c);
		thumb.setSize(thumb.getPreferredSize());
		thumb.x = x;
		thumb.y = y;
	}
	
	public function getIconHeight(c:Component):int
	{
		checkIcon(c);
		return thumb.getPreferredHeight();
	}
	
	public function getIconWidth(c:Component):int
	{
		checkIcon(c);
		return thumb.getPreferredWidth();
	}
	
	public function getDisplay(c:Component):DisplayObject
	{
		checkIcon(c);
		return thumb;
	}
	
}
}