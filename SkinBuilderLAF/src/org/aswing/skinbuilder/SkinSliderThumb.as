/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.graphics.Graphics2D;
import org.aswing.Icon;
import org.aswing.Component;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;
import org.aswing.AbstractButton;
import org.aswing.JButton;

public class SkinSliderThumb extends OrientableThumb{

    override protected function getPropertyPrefix():String{
    	return "Slider.";
    }
}
}