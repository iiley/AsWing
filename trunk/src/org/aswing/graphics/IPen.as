/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.graphics{
	
import flash.display.Graphics;	

/**
 * Pen to draw lines.
 * @author n0rthwood
 */	
public interface IPen{
	
	/**
	 * @param target the instance of graphics from a display object
	 */ 
	function setTo(target:Graphics):void;
}

}