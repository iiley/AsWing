/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;
import org.aswing.graphics.SolidBrush;

public class SolidBackground implements GroundDecorator{
	
	private var color:ASColor;
	
	public function SolidBackground(color:ASColor){
		this.color = color;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void
	{
		g.fillRectangle(new SolidBrush(color), bounds.x, bounds.y, bounds.width, bounds.height);	
	}
	
	public function getDisplay(c:Component):DisplayObject
	{
		return null;
	}
	
}
}