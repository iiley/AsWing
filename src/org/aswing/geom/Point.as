/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.geom
{
	
import flash.geom.Point;
		
/**
 * A point with x and y coordinates in integer.
 * @author iiley
 */
public class Point{
	
	public var x:int = 0;
	public var y:int = 0;
	
	/**
	 * Constructor
	 */
	public function Point(x:int=0, y:int=0){
		setLocation(x, y);
	}
	
	/**
	 * Sets the location of this point with x and y.
	 * @param x the x coordinates.
	 * @param y the y coordinates.
	 */
	public function setLocation(x:int=0, y:int=0):void{
		this.x = x;
		this.y = y;
	}
	
	public function setLocationWithPoint(p:Point):void{
		this.x = p.x;
		this.y = p.y;
	}
	
	/**
	 * Moves this point and return itself.
	 * @param dx delta of x.
	 * @param dy delta of y.
	 * @return the point itself.
	 */
	public function move(dx:int, dy:int):Point{
		x += dx;
		y += dy;
		return this;
	}
	
	/**
	 * Moves this point with an direction and distance, then return itself.
	 * @param angle the angle in radians.
	 * @param distance the distance in pixels.
	 * @return the point itself.
	 */
	public function moveRadians(direction:Number, distance:Number):Point{
		x += Math.round(Math.cos(direction)*distance);
		y += Math.round(Math.sin(direction)*distance);
		return this;
	}
	
	/**
	 * Returns the point beside this point with direction and distance.
	 * @return the point beside.
	 */
	public function nextPoint(direction:Number, distance:Number):Point{
		return new Point(x+Math.cos(direction)*distance, y+Math.sin(direction)*distance);
	}
	
	/**
	 * Returns the distance square between this point and passing point.
	 * @param p the another point.
	 * @return the distance square from this to p.
	 */
	public function distanceSq(p:Point):int{
		var xx:int;
		var yy:int;
		if(tx instanceof Point){
			xx = tx.x;
			yy = tx.y;
		}else{
			xx = tx;
			yy = ty;
		}
		return ((x-xx)*(x-xx)+(y-yy)*(y-yy));	
	}


	/**
	 * Returns the distance between this point and passing point.
	 * @param p the another point.
	 * @return the distance from this to p.
	 */
	public function distance(p:Point):int{
		return Math.sqrt(distanceSq(p));
	}
    
    /**
     * Returns whether or not this passing object is a same value point.
     * @param o the object to be compared.
     * @return equals or not.
     */
	public function equals(o:Object):Boolean{
		var p:Point = o as Point;
		return x===p.x && y===p.y;
	}

	/**
	 * Duplicates current instance.
	 * @return copy of the current instance.
	 */
	public function clone():Point {
		return new Point(x,y);
	}
    
	public function toString():String{
		return "Point["+x+","+y+"]";
	}	
}

}