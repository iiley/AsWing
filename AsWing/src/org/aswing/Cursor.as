package org.aswing
{
import flash.display.Sprite;
import org.aswing.graphics.*;

public class Cursor extends Sprite
{
	/**
	 * Horizontal resize cursor
	 */
	public static var H_RESIZE_CURSOR:int = 0;

	/**
	 * Vertical resize cursor<br>
	 * Credit to Kristof Neirynck for added V_RESIZE_CURSOR implementation.
	 */
	public static var V_RESIZE_CURSOR:int = 1;
	
	private var type:int;
	
	private var resizeArrowColor:ASColor;
	private var resizeArrowLightColor:ASColor;
	private var resizeArrowDarkColor:ASColor;
	
	public function Cursor(type:int){
		this.type = type;
	    resizeArrowColor = UIManager.getColor("Frame.resizeArrow");
	    resizeArrowLightColor = UIManager.getColor("Frame.resizeArrowLight");
	    resizeArrowDarkColor = UIManager.getColor("Frame.resizeArrowDark");
	    paint();
	}
	
	private function paint():void{
		var w:Number = 1; //arrowAxisHalfWidth
		var r:Number = 4;
		var arrowPoints:Array;
		
		switch (type) {
			case H_RESIZE_CURSOR:
				arrowPoints = [{x:-r*2, y:0}, {x:-r, y:-r}, {x:-r, y:-w},
								 {x:r, y:-w}, {x:r, y:-r}, {x:r*2, y:0},
								 {x:r, y:r}, {x:r, y:w}, {x:-r, y:w},
								 {x:-r, y:r}];
				break;
			case V_RESIZE_CURSOR:
				arrowPoints = [{y:-r*2, x:0}, {y:-r, x:-r}, {y:-r, x:-w},
								 {y:r, x:-w}, {y:r, x:-r}, {y:r*2, x:0},
								 {y:r, x:r}, {y:r, x:w}, {y:-r, x:w},
								 {y:-r, x:r}];
				break;			
		}
		
		var gdi:Graphics2D = new Graphics2D(this.graphics);
		gdi.drawPolygon(new Pen(resizeArrowColor.changeAlpha(0.4), 4), arrowPoints);
		gdi.fillPolygon(new SolidBrush(resizeArrowLightColor), arrowPoints);
		gdi.drawPolygon(new Pen(resizeArrowDarkColor, 1), arrowPoints);	
	}
}
}