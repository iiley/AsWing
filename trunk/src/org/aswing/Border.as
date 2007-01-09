/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	
import org.aswing.Component;
import org.aswing.geom.Rectangle;
import org.aswing.graphics.Graphics2D;
	
/**
 * Interface describing an object capable of rendering a border around the edges of a component.
 * <p>
 * You can either return a display object to be the border or just return null and paint the border 
 * in <code>updateBorder</code> method use the component g(Graphics).
 */
public interface Border extends Decorator
{
	/**
	 * Updates the border.
	 * @param com the component which owns the border.
	 * @param g the graphics of the component, you can paint picture onto it.
	 * @param bounds the bounds of the border should be.
	 */
	function updateBorder(com:Component, g:Graphics2D, bounds:Rectangle):void;
	
	/**
	 * Returns the insets of the border.
	 * @param com the component which owns the border.
	 * @param the bounds of the border should be.
	 */
	function getBorderInsets(com:Component, bounds:Rectangle):Insets;	
}

}