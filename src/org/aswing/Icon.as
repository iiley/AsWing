/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
	
/**
 * A small fixed size picture, typically used to decorate components. 
 * <p>
 * You can either return a display object to be the icon or just return null and paint the picture 
 * in <code>updateIcon</code> method use the component g(Graphics).
 */
public interface Icon extends Decorator
{	
	/**
	 * Returuns the icon width.
	 * @return the width of the icon.
	 */
	function getIconWidth():int;
	
	/**
	 * Returns the icon height.
	 * @return the height of the icon.
	 */
	function getIconHeight():int;
	
	/**
	 * Updates the icon.
	 * @param com the component which owns the icon.
	 * @param g the graphics of the component, you can paint picture onto it.
	 * @param x the x coordinates of the icon should be.
	 * @param y the y coordinates of the icon should be.
	 */
	function updateIcon(com:Component, g:Graphics2D, x:int, y:int):void;	
}

}