/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.graphics.Graphics2D;
import org.aswing.GroundDecorator;
import org.aswing.geom.IntRectangle;
import org.aswing.*;
import flash.display.DisplayObject;
import org.aswing.plaf.UIResource;
import org.aswing.plaf.ComponentUI;
import flash.display.Sprite;

public class SkinScrollBarBackground implements GroundDecorator, UIResource{
	
	private var verticalImage:DisplayObject;
	private var horizotalImage:DisplayObject;
	private var imageContainer:Sprite;
	
	public function SkinScrollBarBackground(){
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
	}
	
	private function reloadAssets(ui:ComponentUI):void{
		verticalImage = ui.getInstance(getPropertyPrefix()+"verticalBGImage") as DisplayObject;
		horizotalImage = ui.getInstance(getPropertyPrefix()+"horizotalBGImage") as DisplayObject;
		if(verticalImage){
			verticalImage.visible = false;
			imageContainer.addChild(verticalImage);
		}
		if(horizotalImage){
			horizotalImage.visible = false;
			imageContainer.addChild(horizotalImage);
		}
	}
    	
    protected function getPropertyPrefix():String {
        return "ScrollBar.";
    }
	
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):void{
		var bar:JScrollBar = JScrollBar(com);
		imageContainer.visible = bar.isOpaque();
		if(!imageContainer.visible){
			return;
		}
		imageContainer.x = bounds.x;
		imageContainer.y = bounds.y;
		var image:DisplayObject;
		if(bar.getOrientation() == JScrollBar.VERTICAL){
			image = verticalImage;
			if(horizotalImage) horizotalImage.visible = false;
		}else{
			image = horizotalImage;
			if(verticalImage) verticalImage.visible = false;
		}
		if(image){
			image.visible = true;
			image.width = bounds.width;
			image.height = bounds.height;
		}
	}
	
	public function getDisplay():DisplayObject{
		return imageContainer;
	}
	
}
}