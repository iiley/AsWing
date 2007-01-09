package org.aswing.geom
{
	
import flash.geom.Rectangle;
import org.aswing.geom.Point;

/**
 * A Rectangle specifies an area in a coordinate space that is enclosed by the Rectangle 
 * object's top-left point (x, y) in the coordinate space, its width, and its height.
 */
public class Rectangle
{
	public var x:int = 0;
	public var y:int = 0;
	public var width:int = 0;
	public var height:int = 0;
	
	/**
	 * Creates a rectangle.
	 */
	public function Rectangle(x:int=0, y:int=0, width:int=0, height:int=0){
		setRect(x, y, width, height);
	}
	
	/**
	 * Sets the rect with x, y, width and height.
	 */
	public function setRect(x:int, y:int, width:int, height:int):void{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}
	
	public function getRectWithRect(rect:Rectangle):void{
		setRect(rect.x, rect.y, rect.width, rect.height);
	}
	
	/**
	 * Sets the x, y property of the rectangle.
	 */
	public function setLocation(p:Point):void{
		this.x = p.x;
		this.y = p.y;
	}
	
	/**
	 * Sets the width and height properties of the rectangle
	 */
	public function setSize(size:Dimension):void{
		this.width = size.width;
		this.height = size.height;
	}
	
	/**
	 * Returns the size of this rectangle.
	 */
	public function getSize():Dimension{
		return new Dimension(width, height);
	}
	
	/**
	 * Returns the location of this rectangle.
	 */
	public function getLocation():Point{
		return new Point(x, y);
	}
	
    /**
     * Computes the union of this <code>Rectangle</code> with the 
     * specified <code>Rectangle</code>. Returns a new 
     * <code>Rectangle</code> that 
     * represents the union of the two rectangles
     * @param r the specified <code>Rectangle</code>
     * @return    the smallest <code>Rectangle</code> containing both 
     *		  the specified <code>Rectangle</code> and this 
     *		  <code>Rectangle</code>.
     */
    public function union(r:Rectangle):Rectangle{
		var x1:int = Math.min(x, r.x);
		var x2:int = Math.max(x + width, r.x + r.width);
		var y1:int = Math.min(y, r.y);
		var y2:int = Math.max(y + height, r.y + r.height);
		return new Rectangle(x1, y1, x2 - x1, y2 - y1);
    }
    
    /**
     * Resizes the <code>Rectangle</code> both horizontally and vertically.
     * <p>
     * This method modifies the <code>Rectangle</code> so that it is 
     * <code>h</code> units larger on both the left and right side, 
     * and <code>v</code> units larger at both the top and bottom. 
     * <p>
     * The new <code>Rectangle</code> has (<code>x&nbsp;-&nbsp;h</code>, 
     * <code>y&nbsp;-&nbsp;v</code>) as its top-left corner, a 
     * width of 
     * <code>width</code>&nbsp;<code>+</code>&nbsp;<code>2h</code>, 
     * and a height of 
     * <code>height</code>&nbsp;<code>+</code>&nbsp;<code>2v</code>. 
     * <p>
     * If negative values are supplied for <code>h</code> and 
     * <code>v</code>, the size of the <code>Rectangle</code> 
     * decreases accordingly. 
     * The <code>grow</code> method does not check whether the resulting 
     * values of <code>width</code> and <code>height</code> are 
     * non-negative. 
     * @param h the horizontal expansion
     * @param v the vertical expansion
     */
    public function grow(h:int, v:int):void {
		x -= h;
		y -= v;
		width += h * 2;
		height += v * 2;
    }
    
    public function move(dx:int, dy:int):void{
    	x += dx;
    	y += dy;
    }

    public function resize(dwidth:int=0, dheight:int=0):void{
    	width += dwidth;
    	height += dheight;
    }
	
	public function leftTop():Point{
		return new Point(x, y);
	}
	
	public function rightTop():Point{
		return new Point(x + width, y);
	}
	
	public function leftBottom():Point{
		return new Point(x, y + height);
	}
	
	public function rightBottom():Point{
		return new Point(x + width, y + height);
	}
	
	public function containsPoint(p:Point):Boolean{
		if(p.x < x || p.y < y || p.x > x+width || p.y > y+height){
			return false;
		}else{
			return true;
		}
	}
	
	public function equals(o:Object):Boolean{
		var r:Rectangle = o as Rectangle;
		return x===r.x && y===r.y && width===r.width && height===r.height;
	}
		
	/**
	 * Duplicates current instance.
	 * @return copy of the current instance.
	 */
	public function clone():Rectangle {
		return new Rectangle(x, y, width, height);
	}
		
	public function toString():String{
		return "Rectangle[x:"+x+",y:"+y+", width:"+width+",height:"+height+"]";
	}
	
}

}