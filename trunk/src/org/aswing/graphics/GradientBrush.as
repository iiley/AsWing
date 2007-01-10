/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics{

import org.aswing.graphics.IBrush;
import flash.display.Graphics;
import flash.geom.Matrix;

/**
 * GradientBrush encapsulate the fill paramters for flash.display.Graphics.beginGradientFill()
 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#beginGradientFill()
 * @author iiley
 */
public class GradientBrush implements IBrush{
	public static var LINEAR:String = "linear";
	public static var RADIAL:String = "radial";
	
	
	private var fillType:String;
	private var colors:Array;
	private var alphas:Array;
	private var ratios:Array;
	private var matrix:Matrix;
	
	/**
	 * Create a GradientBrush object<br>
	 * you can refer the explaination for the paramters from Adobe's doc
	 * to create a Matrix, you can use matrix.createGradientBox() from the matrix object itself
	 * 
	 * @see http://livedocs.macromedia.com/flex/2/langref/flash/display/Graphics.html#beginGradientFill()
	 * @see http://livedocs.macromedia.com/flex/2/langref/flash/geom/Matrix.html#createGradientBox()
	 */
	public function GradientBrush(fillType:String , colors:Array, alphas:Array, ratios:Array, matrix:Matrix){
		this.fillType = fillType;
		this.colors = colors;
		setAlphas(alphas);
		setRatios(ratios);
		this.matrix = matrix;
	}
	
	public function getFillType():String{
		return fillType;
	}
	
	/**
	 * 
	 */
	public function setFillType(t:String):void{
		fillType = t;
	}
		
	public function getColors():Array{
		return colors;
	}
	
	/**
	 * 
	 */
	public function setColors(cs:Array):void{
		colors = cs;
	}
	
	public function getAlphas():Array{
		return alphas;
	}
	
	/**
	 * Pay attention that the value in the array should be between 0-1. if the value is greater than 1, 1 will be used, if the value is less than 0, 0 will be used
	 */
	public function setAlphas(alphas:Array):void{
		for(var i:Number = 0 ; i < alphas.length ; i++){
			alphas[i]= Math.min(1, Math.max(0, alphas[i]))
		}
		this.alphas = alphas;
	}
	
	public function getRatios():Array{
		return ratios;
	}
	
	/**
	 * Ratios should be between 0-255, if the value is greater than 255, 255 will be used, if the value is less than 0, 0 will be used
	 */
	public function setRatios(ratios:Array):void{
		for(var i:Number = 0 ; i < ratios.length ; i++){
			ratios[i]= Math.min(255, Math.max(0, ratios[i]))
		}
		ratios = ratios;
	}
	
	public function getMatrix():Object{
		return matrix;
	}
	
	/**
	 * 
	 */
	public function setMatrix(m:Matrix):void{
		matrix = m;
	}
	
	/**
	 * @inheritDoc 
	 */
	public function beginFill(target:Graphics):void{
		target.beginGradientFill(fillType, colors, alphas, ratios, matrix);
	}
	
	/**
	 * @inheritDoc 
	 */
	public function endFill(target:Graphics):void{
		target.endFill();
	}	
}

}
