/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics{

import org.aswing.ASColor;
import flash.display.Graphics;
import org.aswing.graphics.IPen;

/**
 * Pen encapsulate normal lineStyle properties. <br>
 * You can use pen to draw an ordinary shape. To draw gradient lines, refer to <code>org.aswing.graphics.GradientPen</code>
 * 
 * @see org.aswing.graphics.IPen
 * @see org.aswing.graphics.GradientPen
 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#lineStyle()
 * @author iiley
 */
public class Pen implements IPen{
	
	private var _thickness:uint;
	private var _color:uint;
	private var _alpha:Number;
	private var _pixelHinting:Boolean;
	private var _scaleMode:String;
	private var _caps:String;
	private var _joints:String;
	private var _miterLimit:Number;
	
	/**
	 * Create a Pen.
	 */
	public function Pen(color:uint=0,
				 alpha:Number=1,
				 thickness:uint=1, 
				 pixelHinting:Boolean = false, 
				 scaleMode:String = "normal", 
				 caps:String = null, 
				 joints:String = null, 
				 miterLimit:Number = 3){
				 	
		this._color = color;
		setAlpha(alpha);
		this._thickness = thickness;
		this._pixelHinting = pixelHinting;
		this._scaleMode = scaleMode;
		this._caps = caps;
		this._joints = joints;
		this._miterLimit = miterLimit;
	}
	
	public function getColor():uint{
		return _color;
	}
	
	/**
	 * 
	 */
	public function setColor(color:uint):void{
		this._color=color;
	}
	
	
	public function getThickness():uint{
		return _thickness;
	}
	
	/**
	 * 
	 */
	public function setThickness(thickness:uint):void{
		this._thickness=thickness;
	}
	
	public function getAlpha():Number{
		return _alpha;
	}
	
	/**
	 * 
	 */
	public function setAlpha(alpha:Number):void{
		this._alpha=Math.min(1, Math.max(0, alpha));
	}

 	public function getPixelHinting():Boolean{
 		return this._pixelHinting;
 	}
 	
 	/**
	 * 
	 */
 	public function setPixelHinting(pixelHinting:Boolean):void{
 		this._pixelHinting = pixelHinting;
 	}
	
	public function getScaleMode():String{
		return this._scaleMode;
	}
	
	/**
	 * 
	 */
	public function setScaleMode(scaleMode:String="normal"):void{
		this._scaleMode =  scaleMode;
	}
	
	public function getCaps():String{
		return this._caps;
	}
	
	/**
	 * 
	 */
	public function setCaps(caps:String):void{
		this._caps=caps
	}
	
	public function getJoints():String{
		return this._joints;
	}
	
	/**
	 * 
	 */
	public function setJoints(joints:String):void{
		this._joints=joints
	}
	
	public function getMiterLimit():Number{
		return this._miterLimit;
	}
	
	/**
	 * 
	 */
	public function setMiterLimit(miterLimit:Number):void{
		this._miterLimit=miterLimit;
	}
	
	/**
	 * @inheritDoc 
	 */
	public function setTo(target:Graphics):void{
		target.lineStyle(_thickness, _color, _alpha,_pixelHinting,_scaleMode,_caps,_joints,_miterLimit);
	}
	
	/**
	 * Set color and alpha through ASColor
	 * 
	 * @param color instance of an ASColor object.
	 * @see org.aswing.ASColor
	 */
	public function setASColor(color:ASColor):void{
		if(color!=null){			
			this._color = color.getRGB();
			this._alpha = color.getAlpha();
		}
	}
}

}