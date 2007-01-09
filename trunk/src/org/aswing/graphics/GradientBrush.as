/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics{

import org.aswing.graphics.Brush;
import flash.display.Graphics;

/**
 * @author iiley
 */
class GradientBrush implements Brush{
	public static var LINEAR:String = "linear";
	public static var RADIAL:String = "radial";
	
	public static function createMatrix(x:Number, y:Number, width:Number, height:Number, direction:Number):Object {
		return {matrixType:"box", x:x, y:y, w:width, h:height, r:direction};	
	}
	
	private var fillType:String;
	private var colors:Array;
	private var alphas:Array;
	private var ratios:Array;
	private var matrix:Object;
	
	public function GradientBrush(fillType:String, colors:Array, alphas:Array, ratios:Array, matrix:Object){
		this.fillType = fillType;
		this.colors = colors;
		this.alphas = alphas;
		this.ratios = ratios;
		this.matrix = matrix;
	}
	
	public function getFillType():String{
		return fillType;
	}
	public function setFillType(t:String):void{
		fillType = t;
	}
		
	public function getColors():Array{
		return colors;
	}
	public function setColors(cs:Array):void{
		colors = cs;
	}
	
	public function getAlphas():Array{
		return alphas;
	}
	public function setAlphas(alphas:Array):void{
		alphas = alphas;
	}
	
	public function getRatios():Array{
		return ratios;
	}
	public function setRatios(rs:Array):void{
		ratios = rs;
	}
	
	public function getMatrix():Object{
		return matrix;
	}
	public function setMatrix(m:Object):void{
		matrix = m;
	}
	
	public function beginFill(target:Graphics):void{
		target.beginGradientFill(fillType, colors, alphas, ratios, matrix);
	}
	
	public function endFill(target:Graphics):void{
		target.endFill();
	}	
}

}
