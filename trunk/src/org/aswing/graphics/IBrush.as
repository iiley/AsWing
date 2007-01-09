/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.graphics{
	
import flash.display.Graphics;

/**
 * Brush to draw filled drawing.
 * @author iiley
 */
public interface IBrush{
	
	 function beginFill(target:Graphics):void;
	
	 function endFill(target:Graphics):void;
}

}
