/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf
{
	
import flash.display.DisplayObject;

import org.aswing.*;
import org.aswing.geom.*;
import org.aswing.graphics.*;
import org.aswing.border.EmptyBorder;

/**
 * The default empty border to be the component border as default. So it can be 
 * replaced by LAF specified.
 */
public class DefaultEmptyDecoraterResource implements Icon, Border, GroundDecorator, UIResource
{
	/**
	 * Shared instance.
	 */
	public static const INSTANCE:DefaultEmptyDecoraterResource = new DefaultEmptyDecoraterResource();
	
	public function DefaultEmptyDecoraterResource()
	{
	}
	
	/**
	 * return null
	 */
	public function getDisplay():DisplayObject{
		return null;
	}	
	
	/**
	 * return 0
	 */
	public function getIconWidth():int{
		return 0;
	}
	
	/**
	 * return 0
	 */
	public function getIconHeight():int{
		return 0;
	}
	
	/**
	 * do nothing
	 */
	public function updateIcon(com:Component, g:Graphics2D, x:int, y:int):void{
	}	
	

	/**
	 * do nothing
	 */
	public function updateBorder(com:Component, g:Graphics2D, bounds:IntRectangle):void{
	}
	
	/**
	 * return new Insets(0,0,0,0)
	 */
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets{
		return new Insets(0,0,0,0);
	}
	
	/**
	 * do nothing
	 */
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):void{
	}
}
}