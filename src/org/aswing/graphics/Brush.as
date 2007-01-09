package org.aswing.graphics{
/*
 Copyright aswing.org, see the LICENCE.txt.
*/
import flash.display.Graphics;
/**
 * Brush to draw filled drawing.
 * @author iiley
 */
interface Brush{
	
	 function beginFill(target:Graphics):void;
	
	 function endFill(target:Graphics):void;
}
}
