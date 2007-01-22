/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.icon
{
	
import org.aswing.graphics.*;
import org.aswing.*;
import org.aswing.geom.*;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;

public class ArrowIcon implements Icon, UIResource
{
	
	private var arrow:Number;
	private var width:int;
	private var height:int;
	private var shadow:ASColor;
	private var darkShadow:ASColor;
	
	public function ArrowIcon(arrow:Number, size:int, shadow:ASColor,
			 darkShadow:ASColor){
		this.arrow = arrow;
		this.width = size;
		this.height = size;
		this.shadow = shadow;
		this.darkShadow = darkShadow;
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void
	{
		var center:IntPoint = new IntPoint(c.getWidth()/2, c.getHeight()/2);
		var w:Number = width;
		var ps1:Array = new Array();
		ps1.push(center.nextPoint(arrow, w/2/2));
		var back:IntPoint = center.nextPoint(arrow + Math.PI, w/2/2);
		ps1.push(back.nextPoint(arrow - Math.PI/2, w/2));
		ps1.push(back.nextPoint(arrow + Math.PI/2, w/2));
		
		//w -= (w/4);
		var ps2:Array = new Array();
		ps2.push(center.nextPoint(arrow, w/2/2-1));
		back = center.nextPoint(arrow + Math.PI, w/2/2-1);
		ps2.push(back.nextPoint(arrow - Math.PI/2, w/2-2));
		ps2.push(back.nextPoint(arrow + Math.PI/2, w/2-2));
		
		g.fillPolygon(new SolidBrush(darkShadow), ps1);
		g.fillPolygon(new SolidBrush(shadow), ps2);		
	}
	
	public function getIconHeight():int
	{
		return width;
	}
	
	public function getIconWidth():int
	{
		return height;
	}
	
	public function getDisplay():DisplayObject
	{
		return null;
	}
	
}
}