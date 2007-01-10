/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics{

import flash.display.Graphics;
import flash.geom.Matrix;

/**
 * @author iiley
 */
public class GradientBrush implements IBrush{
	
	private var fillType:String;
	private var colors:Array;
	private var alphas:Array;
	private var ratios:Array;
	private var matrix:Matrix;
	private var spreadMethod:String;
	
	/**
	 * Create a gradient brush.
	 * @param fillType A value from the GradientType class that specifies which gradient type to use: GradientType.LINEAR or GradientType.RADIAL. 
	 * @param colors An array of RGB hexadecimal color values to be used in the gradient; for example, red is 0xFF0000, blue is 0x0000FF, and so on. You can specify up to 15 colors. For each color, be sure you specify a corresponding value in the alphas and ratios parameters.
	 * @param alphas An array of alpha values for the corresponding colors in the colors array; valid values are 0 to 1. If the value is less than 0, the default is 0. If the value is greater than 1, the default is 1. 
	 * @param ratios An array of color distribution ratios; valid values are 0 to 255. This value defines the percentage of the width where the color is sampled at 100%. The value 0 represents the left-hand position in the gradient box, and 255 represents the right-hand position in the gradient box. 
	 * @param matrix A transformation matrix as defined by the flash.geom.Matrix class. The flash.geom.Matrix class includes a createGradientBox() method, which lets you conveniently set up the matrix for use with the beginGradientFill() method.
	 * @param spreadMethod A value from the SpreadMethod class that specifies which spread method to use, either: SpreadMethod.PAD, SpreadMethod.REFLECT, or SpreadMethod.REPEAT. 
	 */
	public function GradientBrush(fillType:String , colors:Array, alphas:Array, ratios:Array, matrix:Matrix=null, spreadMethod="pad"){
		this.fillType = fillType;
		this.colors = colors;
		this.alphas = alphas;
		this.ratios = ratios;
		this.matrix = matrix;
		this.spreadMethod = spreadMethod;
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
		this.alphas = alphas;
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
	
	public function setMatrix(m:Matrix):void{
		matrix = m;
	}
	
	public function setSpreadMethod(spreadMethod:String):void{
		this.spreadMethod = spreadMethod;
	}
	
	public function getSpreadMethod():String{
		return spreadMethod;
	}
	
	public function beginFill(target:Graphics):void{
		target.beginGradientFill(fillType, colors, alphas, ratios, matrix);
	}
	
	public function endFill(target:Graphics):void{
		target.endFill();
	}	
}

}
