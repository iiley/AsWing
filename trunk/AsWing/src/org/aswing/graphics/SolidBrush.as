/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics{

import flash.display.Graphics;
import org.aswing.ASColor;
import org.aswing.graphics.IBrush;

/**
 * SolidBrush encapsulate fill parameters for flash.display.Graphics.beginFill()
 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#beginFill()
 * @author iiley
 */
public class SolidBrush implements IBrush{
	
	private var color:ASColor;
	private var alpha:Number;
	
	public function SolidBrush(color:ASColor){
		this.color = color;
	}
		
	public function getColor():ASColor{
		return color;
	}
	
	/**
	 * 
	 */
	public function setColor(color:ASColor):void{		
		this.color = color;	
	}
	
	/**
	 * 
	 */
	public function beginFill(target:Graphics):void{
		target.beginFill(color.getRGB(), color.getAlpha());
	}
	
	/**
	 * 
	 */
	public function endFill(target:Graphics):void{
		target.endFill();
	}
}
}
