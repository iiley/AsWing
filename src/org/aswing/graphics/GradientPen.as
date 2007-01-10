/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics{
		
import flash.geom.Matrix;
import flash.display.Graphics;

/**
 * GradientPen to draw Gradient lines.
 * @author n0rthwood
 */		
public class GradientPen extends Pen implements IPen{
	
	private var fillType:String;
	private var colors:Array;
	private var alphas:Array;
	private var ratios:Array;
	private var matrix:Matrix;
	private var spreadMethod:String;
	private var interpolationMethod:String;
	private var focalPointRatio:Number;

	public function GradientPen(thickness:uint,fillType:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0){
		super(thickness);
		this.fillType=fillType;
		this.colors=colors;
		setAlphas(alphas);
		setRatios(ratios);
		this.matrix=matrix;
		this.spreadMethod=spreadMethod;
		this.interpolationMethod=interpolationMethod;
		this.focalPointRatio=focalPointRatio;
	}
	
	public function getSpreadMethod():String{
		return this.spreadMethod;
	}
	
	public function setSpreadMethod(spreadMethod:String):void{
		this.spreadMethod=spreadMethod;
	}
	
	public function getInterpolationMethod():String{
		return this.interpolationMethod;
	}
	
	public function setInterpolationMethod(interpolationMethod:String):void{
		this.interpolationMethod=interpolationMethod;
	}
	
	public function getFocalPointRatio():Number{
		return this.focalPointRatio;
	}
	
	public function setFocalPointRatio(focalPointRatio:Number):void{
		this.focalPointRatio=focalPointRatio;
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
	
	override public function setTo(target:Graphics):void{
		super.setTo(target);
		target.lineGradientStyle(fillType,colors,alphas,ratios,matrix,spreadMethod,interpolationMethod,focalPointRatio);
	}
}

}