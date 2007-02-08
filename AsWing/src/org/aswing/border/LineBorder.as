/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.border{

import org.aswing.*;
import org.aswing.graphics.*;
import org.aswing.geom.*;
import flash.display.*;
	
public class LineBorder implements Border{
	
	private var color:ASColor;
	private var thickness:Number;
	private var round:Number;
	
	public function LineBorder(color:ASColor=null, thickness:Number=1, round:Number=0)
	{
		super();
		if(color == null) color = ASColor.BLACK;
		
		this.color = color;
		this.thickness = thickness;
		this.round = round;
	}
	
	public function updateBorder(com:Component, g:Graphics2D, b:IntRectangle):void
	{
 		var t:Number = thickness;
    	if(round <= 0){
    		g.drawRectangle(new Pen(color, thickness), b.x + t/2, b.y + t/2, b.width - t, b.height - t);
    	}else{
    		g.fillRoundRectRingWithThickness(new SolidBrush(color), b.x, b.y, b.width, b.height, round, t);
    	}
	}
	
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets
	{
    	var width:Number = Math.ceil(thickness + round - round*0.707106781186547); //0.707106781186547 = Math.sin(45 degrees);
    	return new Insets(width, width, width, width);
	}
	
	public function getDisplay():DisplayObject
	{
		return null;
	}

	public function getColor():ASColor {
		return color;
	}

	public function setColor(color:ASColor):void {
		this.color = color;
	}

	public function getThickness():Number {
		return thickness;
	}

	public function setThickness(thickness:Number):void {
		this.thickness = thickness;
	}

	public function getRound():Number {
		return round;
	}

	public function setRound(round:Number):void {
		this.round = round;
	}    	
}
}