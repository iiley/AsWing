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
import org.aswing.error.ImpMissError;

public class OrientableComponentBackground implements GroundDecorator, UIResource{

	private var verticalImage:DisplayObject;
	private var horizotalImage:DisplayObject;
	private var imageContainer:Sprite;
	private var loaded:Boolean;
	
	public function OrientableComponentBackground(){
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
		imageContainer.mouseChildren = false;
		loaded = false;
	}
	
	protected function checkReloadAssets(c:Component):void{
		if(!loaded){
			var ui:ComponentUI = c.getUI();
			verticalImage = ui.getInstance(getPropertyPrefix()+"verticalBGImage") as DisplayObject;
			horizotalImage = ui.getInstance(getPropertyPrefix()+"horizotalBGImage") as DisplayObject;
			loaded = true;
		}
	}
    	
    protected function getPropertyPrefix():String {
    	throw new ImpMissError();
        return null;
    }
	
	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):void{
		checkReloadAssets(com);
		var bar:Orientable = Orientable(com);
		imageContainer.x = bounds.x;
		imageContainer.y = bounds.y;
		var image:DisplayObject;
		var removeImage:DisplayObject;
		if(bar.getOrientation() == AsWingConstants.HORIZONTAL){
			image = horizotalImage;
			removeImage = verticalImage;
		}else{
			image = verticalImage;
			removeImage = horizotalImage;
		}

		if(image){
			if(!imageContainer.contains(image)){
				imageContainer.addChild(image);
			}
		}
		if(removeImage){
			if(imageContainer.contains(removeImage)){
				imageContainer.removeChild(removeImage);
			}
		}
		if(image){
			image.width = bounds.width;
			image.height = bounds.height;
		}
	}
	
	public function getDisplay(c:Component):DisplayObject{
		checkReloadAssets(c);
		return imageContainer;
	}
	
}
}