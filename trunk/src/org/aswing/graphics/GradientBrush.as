/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics{

import org.aswing.graphics.IBrush;
import flash.display.Graphics;
import flash.geom.Matrix;

/**
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
		for(var i:Number = 0 ; i < alphas.length ; i++){
			alphas[i]= Math.min(1, Math.max(0, alphas[i]))
		}
		this.alphas = alphas;
	}
	
	public function getRatios():Array{
		return ratios;
	}
	public function setRatios(rs:Array):void{
		for(var i:Number = 0 ; i < rs.length ; i++){
			rs[i]= Math.min(255, Math.max(0, rs[i]))
		}
		ratios = rs;
	}
	
	public function getMatrix():Object{
		return matrix;
	}
	public function setMatrix(m:Matrix):void{
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
