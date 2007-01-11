/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing{
	
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.Insets;


/**
 * A layout manager that allows multiple components to be laid out either vertically or 
 * horizontally. The components will not wrap so, for example, a vertical arrangement 
 * of components will stay vertically arranged when the frame is resized.
 * @author iiley
 */
public class BoxLayout extends EmptyLayout
{
	/**
     * Specifies that components should be laid out left to right.
     */
    public static const X_AXIS:int = 0;
    
    /**
     * Specifies that components should be laid out top to bottom.
     */
    public static const Y_AXIS:int = 1;
    
    
    private var axis:int;
    private var gap:int;
    
    /**
     * @param axis (optional)the layout axis, default is X_AXIS
     * @param gap  (optional)the gap between children, default is 0
     * 
     * @see #X_AXIS
     * @see #X_AXIS
     */
    public function BoxLayout(axis:int=X_AXIS, gap:int=0){
    	setAxis(axis);
    	setGap(gap);
    }
    
    /**
     * Sets new axis.
     * @param axis new axis default is X_AXIS
     */
    public function setAxis(axis:int=X_AXIS):void {
    	this.axis = axis;
    }
    
    /**
     * Gets axis.
     * @return axis
     */
    public function getAxis():int {
    	return axis;	
    }
    
    /**
     * Sets new gap.
     * @param get new gap
     */	
    public function setGap(gap:int=0):void {
    	this.gap = gap
    }
    
    /**
     * Gets gap.
     * @return gap
     */
    public function getGap():int {
    	return gap;	
    }
    
	/**
	 * return target.getSize();
	 */
    override public function preferredLayoutSize(target:Container):IntDimension{
    	var count:int = target.getComponentCount();
    	var insets:Insets = target.getInsets();
    	var width:int = 0;
    	var height:int = 0;
    	var amount:int = 0;
    	for(var i:int=0; i<count; i++){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		var size:IntDimension = c.getPreferredSize();
	    		width = Math.max(width, size.width);
	    		height = Math.max(height, size.height);
    			amount++;
    		}
    	}
    	if(axis == Y_AXIS){
    		height = height*amount;
    		if(amount > 0){
    			height += (amount-1)*gap;
    		}
    	}else{
    		width = width*amount;
    		if(amount > 0){
    			width += (amount-1)*gap;
    		}
    	}
    	
    	var dim:IntDimension = new IntDimension(width, height);
    	return insets.getOutsideSize(dim);
    }

	/**
	 * target.getSize();
	 */
    override public function minimumLayoutSize(target:Container):IntDimension{
    	return target.getInsets().getOutsideSize();
    }
    
	/**
	 * return new IntDimension(int.MAX_VALUE, int.MAX_VALUE);
	 */
    override public function maximumLayoutSize(target:Container):IntDimension{
    	var count:int = target.getComponentCount();
    	var insets:Insets = target.getInsets();
    	var width:int = 0;
    	var height:int = 0;
    	var amount:int = 0;
    	for(var i:int=0; i<count; i++){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		var size:IntDimension = c.getMaximumSize();
	    		width = Math.max(width, size.width);
	    		height = Math.max(height, size.height);
	    		amount++;
    		}
    	}
    	if(axis == Y_AXIS){
    		height = height*amount;
    		if(amount > 0){
    			height += (amount-1)*gap;
    		}
    	}else{
    		width = width*amount;
    		if(amount > 0){
    			width += (amount-1)*gap;
    		}
    	}
    	var dim:IntDimension = new IntDimension(width, height);
    	return insets.getOutsideSize(dim);
    }    
    
    override public function layoutContainer(target:Container):void{
    	var count:int = target.getComponentCount();
    	var amount:int = 0;
    	for(var i:int=0; i<count; i++){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		amount ++;
    		}
    	}
    	var size:IntDimension = target.getSize();
    	var insets:Insets = target.getInsets();
    	var rd:IntRectangle = insets.getInsideBounds(size.getBounds());
    	var ch:int;
    	var cw:int;
    	if(axis == Y_AXIS){
    		ch = Math.floor((rd.height - (amount-1)*gap)/amount);
    		cw = rd.width;
    	}else{
    		ch = rd.height;
    		cw = Math.floor((rd.width - (amount-1)*gap)/amount);
    	}
    	var x:int = rd.x;
    	var y:int = rd.y;
    	var xAdd:int = (axis == Y_AXIS ? 0 : cw+gap);
    	var yAdd:int = (axis == Y_AXIS ? ch+gap : 0);
    	
    	for(var ii:int=0; ii<count; ii++){
    		var comp:Component = target.getComponent(ii);
    		if(comp.isVisible()){
	    		comp.setBounds(new IntRectangle(x, y, cw, ch));
	    		x += xAdd;
	    		y += yAdd;
    		}
    	}
    }
    
	/**
	 * return 0.5
	 */
    override public function getLayoutAlignmentX(target:Container):Number{
    	return 0.5;
    }

	/**
	 * return 0.5
	 */
    override public function getLayoutAlignmentY(target:Container):Number{
    	return 0.5;
    }
}
}