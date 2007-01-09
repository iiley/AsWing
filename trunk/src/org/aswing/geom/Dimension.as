package org.aswing.geom
{

/**
 * The Dimension class encapsulates the width and height of a componentin a single object.
 * @author iiley
 */
class Dimension{
	
	public var width:int = 0;
	public var height:int = 0;
	
	/**
	 * Creates a dimension.
	 */
	public function Dimension(width:int=0, height:int=0){
		setSize(width, height);
	}
	
	/**
	 * Sets the size.
	 */
	public function setSize(width:int, height:int):void{
		this.width = width;
		this.height = height;
	}
	
	/**
	 * Increases the size by s and return its self(<code>this</code>).
	 * @return <code>this</code>.
	 */
	public function increaseSize(s:Dimension):Dimension{
		width += s.width;
		height += s.height;
		return this;
	}
	
	/**
	 * Decreases the size by s and return its self(<code>this</code>).
	 * @return <code>this</code>.
	 */
	public function decreaseSize(s:Dimension):Dimension{
		width -= s.width;
		height -= s.height;
		return this;
	}
	
	/**
	 * modify the size and return itself. 
	 */
	public function change(deltaW:int, deltaH:int):Dimension{
		width += deltaW;
		height += deltaH;
		return this;
	}
	
	/**
	 * return a new size with this size with a change.
	 */
	public function changedSize(deltaW:int, deltaH:int):Dimension{
		var s:Dimension = new Dimension(deltaW, deltaH);
		return s.change(d, h);
	}
	
	/**
	 * Combines current and specified dimensions by getting max sizes
	 * and puts result into itself.
	 * @return the combined dimension itself.
	 */
	public function combine(d:Dimension):Dimension {
		this.width = Math.max(this.width, d.width);	
		this.height = Math.max(this.height, d.height);
		return this;
	}

	/**
	 * Combines current and specified dimensions by getting max sizes
	 * and returns new Dimension object
	 * @return a new dimension with combined size.
	 */
	public function combineSize(d:Dimension):Dimension {
		return clone().combine(d);
	}
	
	/**
	 * return a new bounds with this size with a location.
	 * @param x the location x.
	 * @prame y the location y.
	 * @return the bounds.
	 */
	public function getBounds(x:int=0, y:int=0):Rectangle{
		var p:Point = new Point(x, y);
		var r:Rectangle = new Rectangle();
		r.setLocation(p);
		r.setSize(width, height);
		return r;
	}
	
	/**
	 * Returns whether or not the passing o is an same value Dimension.
	 */
	public function equals(o:Object):Boolean{
		var d:Dimension = o as Dimension;
		return width===d.width && height===d.height;
	}

	/**
	 * Duplicates current instance.
	 * @return copy of the current instance.
	 */
	public function clone():Dimension {
		return new Dimension(width,height);
	}
	
	public function toString():String{
		return "Dimension("+width+","+height+")";
	}
}

}