/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.geom
{
	

		
	
/**
 * A point with x and y coordinates in int.
 * @author iiley
 */
public class IntPoint{
	
	public var x:int = 0;
	public var y:int = 0;
	
	/**
	 * Constructor
	 */
	public function IntPoint(x:int=0, y:int=0){
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
	
	public function setLocationWithPoint(p:IntPoint):void{
		this.x = p.x;
		this.y = p.y;
	}
	
	/**
	 * Moves this point and return itself.
	 * @param dx delta of x.
	 * @param dy delta of y.
	 * @return the point itself.
	 */
	public function move(dx:int, dy:int):IntPoint{
		x += dx;
		y += dy;
		return this;
	}
	
	/**
	 * Moves this point with an direction in radians and distance, then return itself.
	 * @param angle the angle in radians.
	 * @param distance the distance in pixels.
	 * @return the point itself.
	 */
	public function moveRadians(direction:int, distance:int):IntPoint{
		x += Math.round(Math.cos(direction)*distance);
		y += Math.round(Math.sin(direction)*distance);
		return this;
	}
	
	
	
	/**
	 * Returns the point beside this point with direction and distance.
	 * @return the point beside.
	 */
	public function nextPoint(direction:int, distance:int):IntPoint{
		return new IntPoint(x+Math.cos(direction)*distance, y+Math.sin(direction)*distance);
	}
	
	/**
	 * Returns the distance square between this point and passing point.
	 * @param p the another point.
	 * @return the distance square from this to p.
	 */
	public function distanceSq(p:IntPoint):int{
		var xx:int = p.x;
		var yy:int = p.y;
		
		return ((x-xx)*(x-xx)+(y-yy)*(y-yy));	
	}


	/**
	 * Returns the distance between this point and passing point.
	 * @param p the another point.
	 * @return the distance from this to p.
	 */
	public function distance(p:IntPoint):int{
		return Math.sqrt(distanceSq(p));
	}
    
    /**
     * Returns whether or not this passing object is a same value point.
     * @param toCompare the object to be compared.
     * @return equals or not.
     */
	public function equals(o:Object):Boolean{
		var toCompare:IntPoint = o as IntPoint;
		return x===toCompare.x && y===toCompare.y;
	}

	/**
	 * Duplicates current instance.
	 * @return copy of the current instance.
	 */
	public function clone():IntPoint {
		return new IntPoint(x,y);
	}
    
	public function toString():String{
		return "IntPoint["+x+","+y+"]";
	}	
}

}