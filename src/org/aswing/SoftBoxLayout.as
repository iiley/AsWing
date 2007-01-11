/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing{

import org.aswing.ASWingConstants;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.EmptyLayout;
import org.aswing.geom.IntDimension;
import org.aswing.geom.IntRectangle;
import org.aswing.Insets;

/**
 * The SoftBoxLayout will layout the child components using their preferredWidth or preferredHeight instead of width or height.
 * It ignores the preferredWidth when set to Y_AXIS, ignores the preferredHeight when set to X_AXIS.
 * <p>
 * When set to X_AXIS, all of the child components share the same height from the container and use their own preferredWidth
 * When set to Y_AXIS, all of the child components share the same width  from the container and use their own preferredHeight
 * </p>
 * <pre>
 * 		A X_AXIS SoftBoxLayout
 *   -----------------------------------------------------------
 *   | -------------------- ---------------------------------  |
 *   | |                  | |                               |  |
 *   | |                  | |                               |  |
 *   | |preferredWidth=9  | |preferredWidth=20              |  |
 *   | |                  | |preferredHeight won't work here|  |
 *   | |                  | |                               |  |
 *   | -------------------- --------------------------------   |
 *   -----------------------------------------------------------
 * </pre>
 * 
 * <pre>
 * 		A Y_AXIS SoftBoxLayout
 *   -------------------------------------
 *   | ---------------------------------  |
 *   | |                                | | 
 *   | |                                | |  
 *   | |preferredWidth doesn't work     | |
 *   | |preferredHeigh=15               | |
 *   | |                                | |  
 *   | ---------------------------------- |
 *   | ---------------------------------- |
 * 	 | |                                | |
 *   | |    preferredWidth doesn't work | |
 * 	 | |    preferredHeigh=10           | |
 * 	 | |                                | |   
 *   | ---------------------------------- |
 *  --------------------------------------|
 * </pre>
 * 
 * @see BoxLayout
 * @author iiley
 */
public class SoftBoxLayout extends EmptyLayout{
	/**
     * Specifies that components should be laid out left to right.
     */
    public static const X_AXIS:int = 0;
    
    /**
     * Specifies that components should be laid out top to bottom.
     */
    public static const Y_AXIS:int = 1;
    
    
    /**
     * This value indicates that each row of components
     * should be left-justified(X_AXIS)/top-justified(Y_AXIS).
     */
    public static const LEFT:int 	= ASWingConstants.LEFT;

    /**
     * This value indicates that each row of components
     * should be centered.
     */
    public static const CENTER:int = ASWingConstants.CENTER;

    /**
     * This value indicates that each row of components
     * should be right-justified(X_AXIS)/bottom-justified(Y_AXIS).
     */
    public static const RIGHT:int 	= ASWingConstants.RIGHT;
    
    /**
     * This value indicates that each row of components
     * should be left-justified(X_AXIS)/top-justified(Y_AXIS).
     */
    public static const TOP:int 	= ASWingConstants.TOP;

    /**
     * This value indicates that each row of components
     * should be right-justified(X_AXIS)/bottom-justified(Y_AXIS).
     */
    public static const BOTTOM:int = ASWingConstants.BOTTOM;
    
    
    private var axis:int;
    private var gap:int;
    private var align:int;
    
    /**
     * @param axis the layout axis, default X_AXIS
     * @param gap (optional)the gap between each component, default 0
     * @param align (optional)the alignment value, default is LEFT
     * @see #X_AXIS
     * @see #Y_AXIS
     */
    public function SoftBoxLayout(axis:int, gap:int=0, align:int=LEFT){
    	setAxis(axis);
    	setGap(gap);
    	setAlign(align);
    }
    	
    /**
     * Sets new axis. Must be one of:
     * <ul>
     *  <li>X_AXIS
     *  <li>Y_AXIS
     * </ul> Default is X_AXIS.
     * @param axis new axis
     */
    public function setAxis(axis:int = X_AXIS):void {
    	this.axis = axis ;
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
    public function setGap(gap:int = 0):void {
    	this.gap = gap ;
    }
    
    /**
     * Gets gap.
     * @return gap
     */
    public function getGap():Number {
    	return gap;	
    }
    
    /**
     * Sets new align. Must be one of:
     * <ul>
     *  <li>LEFT
     *  <li>RIGHT
     *  <li>CENTER
     *  <li>TOP
     *  <li>BOTTOM
     * </ul> Default is LEFT.
     * @param align new align
     */
    public function setAlign(align:int=LEFT):void{
    	this.align =  align;
    }
    
    /**
     * Returns the align.
     * @return the align
     */
    public function getAlign():int{
    	return align;
    }
    	
	/**
	 * Returns preferredLayoutSize;
	 */
    override public function preferredLayoutSize(target:Container):IntDimension{
    	var count:int = target.getComponentCount();
    	var insets:Insets = target.getInsets();
    	var width:int = 0;
    	var height:int = 0;
    	var wTotal:int = 0;
    	var hTotal:int = 0;
    	for(var i:int=0; i<count; i++){
    		var c:Component = target.getComponent(i);
    		if(c.isVisible()){
	    		var size:IntDimension = c.getPreferredSize();
	    		width = Math.max(width, size.width);
	    		height = Math.max(height, size.height);
	    		var g:int = i > 0 ? gap : 0;
	    		wTotal += (size.width + g);
	    		hTotal += (size.height + g);
    		}
    	}
    	if(axis == Y_AXIS){
    		height = hTotal;
    	}else{
    		width = wTotal;
    	}
    	
    	var dim:IntDimension = new IntDimension(width, height);
    	return insets.getOutsideSize(dim);;
    }

	/**
	 * Returns minimumLayoutSize;
	 */
    override public function minimumLayoutSize(target:Container):IntDimension{
    	return target.getInsets().getOutsideSize();
    }
    
    /**
     * do nothing
     */
    override public function layoutContainer(target:Container):void{
    	var count:int = target.getComponentCount();
    	var size:IntDimension = target.getSize();
    	var insets:Insets = target.getInsets();
    	var rd:IntRectangle = insets.getInsideBounds(size.getBounds());
    	var ch:int = rd.height;
    	var cw:int = rd.width;
    	var x:int = rd.x;
    	var y:int = rd.y;
    	if(align == RIGHT || align == BOTTOM){
    		if(axis == Y_AXIS){
    			y = y + ch;
    		}else{
    			x = x + cw;
    		}
	    	for(var i:int=count-1; i>=0; i--){
	    		var c:Component = target.getComponent(i);
	    		if(c.isVisible()){
		    		var ps:IntDimension = c.getPreferredSize();
		    		if(axis == Y_AXIS){
		    			y -= ps.height;
		    			c.setBounds(new IntRectangle(x, y, cw, ps.height));
		    			y -= gap;
		    		}else{
		    			x -= ps.width;
		    			c.setBounds(new IntRectangle(x, y, ps.width, ch));
		    			x -= gap;
		    		}
	    		}
	    	}
    		
    	}else{//left or top or center
	    	if(align == CENTER){
	    		var prefferedSize:IntDimension = insets.getInsideSize(target.getPreferredSize());
	    		if(axis == Y_AXIS){
	    			y = Math.round(y + (ch - prefferedSize.height)/2);
	    		}else{
	    			x = Math.round(x + (cw - prefferedSize.width)/2);
	    		}
	    	}
	    	for(var ii:int=0; ii<count; ii++){
	    		var comp:Component = target.getComponent(ii);
	    		if(comp.isVisible()){
		    		var cps:IntDimension = comp.getPreferredSize();
		    		if(axis == Y_AXIS){
		    			comp.setBounds(new IntRectangle(x, y, cw, cps.height));
		    			y += (cps.height + gap);
		    		}else{
		    			comp.setBounds(new IntRectangle(x, y, cps.width, ch));
		    			x += (cps.width + gap);
		    		}
	    		}
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