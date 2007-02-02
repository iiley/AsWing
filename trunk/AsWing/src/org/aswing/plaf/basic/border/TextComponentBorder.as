/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.border{
	
import org.aswing.graphics.*;
import org.aswing.geom.IntRectangle;
import org.aswing.*;
import flash.display.DisplayObject;
import org.aswing.plaf.*;

public class TextComponentBorder implements Border, UIResource{

    private var light:ASColor;
    private var shadow:ASColor;
    	
	public function TextComponentBorder(){
		
	}
	
    protected function getPropertyPrefix():String {
    	throw new Error("Subclass should override this method!!");
        return "";
    }
	
	private function reloadColors(ui:ComponentUI):void{
		light = ui.getColor(getPropertyPrefix()+"light");
		shadow = ui.getColor(getPropertyPrefix()+"shadow");
	}
    	
	public function updateBorder(c:Component, g:Graphics2D, r:IntRectangle):void
	{
		if(light == null){
			reloadColors(c.getUI());
		}
	    var x1:Number = r.x;
		var y1:Number = r.y;
		var w:Number = r.width;
		var h:Number = r.height;
		var textCom:JTextComponent = JTextComponent(c);
		if(textCom.isEditable() && textCom.isEnabled()){
			g.drawRectangle(new Pen(shadow, 1), x1+0.5, y1+0.5, w-1, h-1);
		}
		g.drawRectangle(new Pen(light, 1), x1+1.5, y1+1.5, w-3, h-3);		
	}
	
	public function getBorderInsets(com:Component, bounds:IntRectangle):Insets
	{
		return new Insets(2, 2, 2, 2);
	}
	
	public function getDisplay():DisplayObject
	{
		return null;
	}
	
}
}