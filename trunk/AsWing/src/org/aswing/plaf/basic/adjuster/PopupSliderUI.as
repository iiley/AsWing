/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic.adjuster{

import org.aswing.plaf.basic.BasicSliderUI;
import org.aswing.*;
import org.aswing.geom.IntRectangle;

/**
 * SliderUI for JAdjuster popup slider.
 * @author iiley
 */
public class PopupSliderUI extends BasicSliderUI{
	
	public function PopupSliderUI()
	{
		super();
	}
	
	override protected function getPropertyPrefix():String {
		return "Adjuster.";
	}
	
	override protected function installDefaults():void{	
		super.installDefaults();
		slider.setOpaque(true);
	}
	
	override protected function getPrefferedLength():int{
		return 100;
	}

    public function getTrackMargin():Insets{
    	var b:IntRectangle = slider.getPaintBounds();
    	countTrackRect(b);
    	
    	var insets:Insets = new Insets();
    	insets.top = trackRect.y - b.y;
    	insets.bottom = b.y + b.height - trackRect.y - trackRect.height;
    	insets.left = trackRect.x - b.x;
    	insets.right = b.x + b.width - trackRect.x - trackRect.width;
    	return insets;
    }
    	
}
}