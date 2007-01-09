/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics{

import org.aswing.ASColor;
import flash.display.Graphics;

/**
 * Pen, to draw line drawing.
 * @author iiley
 */
class Pen{
	private var _thickness:Number;
	private var _color:Number;
	private var _alpha:Number;
	private var _pixelHinting:Boolean;
	private var _scaleMode:String;
	private var _caps:String;
	private var _joints:String;
	private var _miterLimit:Number;
	
	/**
	 * Pen(color:ASColor, thickness:Number)<br>
	 * Pen(color:Number, thickness:Number, alpha:Number)<br>
	 */
	function Pen(asColor:ASColor, 
				 thickness:Number=0, 
				 alpha:Number=1,
				 pixelHinting:Boolean = false, 
				 scaleMode:String = "normal", 
				 caps:String = null, 
				 joints:String = null, 
				 miterLimit:Number = 3){
				 	
		this._color = asColor.getRGB();
		this._alpha = asColor.getAlpha();
		this._thickness = thickness;
		this._pixelHinting = pixelHinting;
		this._scaleMode = scaleMode;
		this._caps = caps;
		this._joints = joints;
		this._miterLimit = miterLimit;
		
		
	}
	
	public function getColor():Number{
		return _color;
	}
	
	public function setColor(color:Number):void{
		this._color=color;
	}
	
	public function getThickness():Number{
		return _thickness;
	}
	
	public function setThickness(thickness:Number):void{
		this._thickness=thickness;
	}
	
	public function getAlpha():Number{
		return _alpha;
	}
	
	public function setAlpha(alpha:Number):void{
		this._alpha=alpha;
	}
	

 	public function getPixelHinting():Boolean{
 		return this._pixelHinting;
 	}
 	
 	public function setPixelHinting(pixelHinting:Boolean):void{
 		this._pixelHinting = pixelHinting;
 	}
	
	public function getScaleMode():String{
		return this._scaleMode;
	}
	
	public function setScaleMode(scaleMode:String="normal"):void{
		this._scaleMode =  scaleMode;
	}
	
	public function getCaps():String{
		return this._caps;
	}
	
	public function setCaps(caps:String):void{
		this._caps=caps
	}
	
	public function getJoints():String{
		return this._joints;
	}
	
	public function setJoints(joints:String):void{
		this._joints=joints
	}
	
	public function getMiterLimit():Number{
		return this._miterLimit;
	}
	
	public function setMiterLimit(miterLimit:Number):void{
		this._miterLimit=miterLimit;
	}
	
	/**
	 * 
	 * 
	 * */

	public function setTo(target:Graphics):void{
		target.lineStyle(_thickness, _color, _alpha,_pixelHinting,_scaleMode,_caps,_joints,_miterLimit);
	}
	
	public function setASColor(color:ASColor):void{
		if(color!=null){			
			this._color=color.getRGB();
			this._alpha=color.getAlpha();
		}
	}
}

}