/*
 Copyright aswing.org, see the LICENCE.txt.
*/
/**
 * @author n0rthwood
 */
package org.aswing.graphics
{
	import flash.display.Graphics;
	import flash.display.BitmapData;
	import flash.geom.Matrix;



public class BitmapBrush implements IBrush{
	
	private var _bitmapData:BitmapData;
	private var _matrix:Matrix;
	private var _repeat:Boolean;
	private var _smooth:Boolean;
	
	public function BitmapBrush(bitmap:BitmapData, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false){
		this._bitmapData=bitmap;
		this._matrix=matrix;
		this._repeat=repeat;
		this._smooth=smooth;
	}
	
	
	public function beginFill(target:Graphics):void{
		target.beginBitmapFill(_bitmapData,_matrix,_repeat,_smooth);
	}
	
	public function endFill(target:Graphics):void{
		target.endFill();
	}
	
	public function getBitmapData():BitmapData{
		return _bitmapData;
	}
	
	public function setBitmapData(bitmapData:BitmapData):void{
		this._bitmapData = bitmapData;
	}
	
	public function getMatrix():Matrix{
		return _matrix;
	}
	
	public function setMatrix(matrix:Matrix):void{
		this._matrix = matrix;
	}
	
	public function isRepeat():Boolean{
		return _repeat;
	}
	
	public function setRepeat(repeat:Boolean):void{
		this._repeat = repeat;
	}
	
	public function isSmooth():Boolean{
		return _smooth;
	}
	
	public function setSmooth(smooth:Boolean):void{
		this._smooth = smooth;
	}
	
}

}