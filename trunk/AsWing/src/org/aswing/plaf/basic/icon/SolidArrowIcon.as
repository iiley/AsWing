package org.aswing.plaf.basic.icon
{
import flash.display.DisplayObject;

import org.aswing.*;
import org.aswing.geom.IntPoint;
import org.aswing.graphics.*;
import org.aswing.plaf.UIResource;
import flash.geom.Point;


public class SolidArrowIcon implements Icon, UIResource
{
	private var width:Number;
	private var height:Number;
	private var arrow:Number;
	private var color:ASColor;
	
	public function SolidArrowIcon(arrow:Number, size:Number, color:ASColor){
		this.arrow = arrow;
		this.width = size;
		this.height = size;
		this.color = color;
	}	
	
	public function updateIcon(com:Component, g:Graphics2D, x:int, y:int):void
	{
		var center:Point = new Point(x + width/2, y + height/2);
		var w:Number = width;
		var ps1:Array = new Array();
		ps1.push(nextPoint(center, arrow, w/2/2));
		var back:Point = nextPoint(center, arrow + Math.PI, w/2/2);
		ps1.push(nextPoint(back, arrow - Math.PI/2, w/2));
		ps1.push(nextPoint(back, arrow + Math.PI/2, w/2));
		
		g.fillPolygon(new SolidBrush(color), ps1);
	}
	
	//nextPoint with Point
	private function nextPoint(op:Point, direction:Number, distance:Number):Point{
		return new Point(op.x+Math.cos(direction)*distance, op.y+Math.sin(direction)*distance);
	}
	
	public function getIconHeight():int
	{
		return height;
	}
	
	public function getIconWidth():int
	{
		return width;
	}
	
	public function setArrow(arrow:Number):void{
		this.arrow = arrow;
	}
	
	public function getDisplay():DisplayObject
	{
		return null;
	}
	
}
}