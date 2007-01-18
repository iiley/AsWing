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
	
	private var color:uint;
	private var alpha:Number;
	
	public function SolidBrush(color:uint=0x000000, alpha:Number=1){
		this.color=color;
		this.alpha=alpha;
	}
	
	public static function createBrush(c:ASColor):SolidBrush{
		return new SolidBrush(c.getRGB(), c.getAlpha());
	}
	
	public function getColor():uint{
		return color;
	}
	
	/**
	 * 
	 */
	public function setColor(color:uint):void{		
		this.color=color;	
	}
	
	/**
	 * 
	 */
	public function setAlpha(alpha:Number):void{
		this.alpha=alpha;
	}
	
	public function getAlpha():Number{
		return alpha;
	}
	
	/**
	 * 
	 */
	public function beginFill(target:Graphics):void{
		target.beginFill(color,alpha);
	}
	
	/**
	 * 
	 */
	public function endFill(target:Graphics):void{
		target.endFill();
	}
	
	/**
	 * Set color through ASColor
	 * @param color ASColor instance
	 * @see org.aswing.ASColor
	 */
	public function setASColor(color:ASColor):void{
		if(color != null){
			this.color = color.getRGB();
			this.alpha = color.getAlpha();
		}
	}
}
}
