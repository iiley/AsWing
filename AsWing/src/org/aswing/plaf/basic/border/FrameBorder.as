/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border{
	
import org.aswing.graphics.*;
import org.aswing.*;
import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;

/**
 * Basic frame border
 * @author iiley
 */
public class FrameBorder implements Border, UIResource{
	
	private static const GLASS:int = 4;
	
	private var activeColor:ASColor;
	private var inactiveColor:ASColor;
	
	public function FrameBorder(){
	}
		
	public function updateBorder(c:Component, g:Graphics2D, b:IntRectangle):void
	{
		if(activeColor == null){
			activeColor   = c.getUI().getColor("Frame.activeCaptionBorder");
			inactiveColor = c.getUI().getColor("Frame.inactiveCaptionBorder");   
		}
		var frame:JFrame = JFrame(c);
		var color:ASColor = frame.getFrameUI().isPaintActivedFrame() ? activeColor : inactiveColor;
		
		//fill alpha rect
		g.drawRoundRect(
			new Pen(color, 1), 
			b.x+0.5, b.y+0.5, b.width-1, b.height-1, 
			GLASS + 4);
		g.drawRoundRect(
			new Pen(ASColor.WHITE, 1), 
			b.x+1.5, b.y+1.5, b.width-3, b.height-3, 
			GLASS + 3);
		g.fillRoundRectRingWithThickness(
			new SolidBrush(color.changeAlpha(0.2)),
			b.x + 2, b.y + 2, b.width - 4, b.height - 4,
			GLASS+2, GLASS, GLASS+1);
		g.drawRoundRect(
			new Pen(color, 1), 
			b.x+2.5+GLASS, b.y+2.5+GLASS, b.width-5-GLASS*2, b.height-5-GLASS*2, 
			GLASS, GLASS, 0, 0);
	}
	
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets
	{
		var w:int = GLASS + 3;
		return new Insets(w, w, w, w);
	}
	
	public function getDisplay(c:Component):DisplayObject
	{
		return null;
	}
	
}
}