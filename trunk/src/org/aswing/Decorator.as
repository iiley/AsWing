/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{

import flash.display.DisplayObject;

/**
 * Decorator for components, it return a display object to be the UI decorator.
 */
public interface Decorator
{
	/**
	 * Returns the display object which is used to be the component decorator.
	 */
	function getDisplay():DisplayObject;
	
}

}