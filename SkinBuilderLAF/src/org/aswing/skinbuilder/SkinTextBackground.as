/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.graphics.Graphics2D;
import org.aswing.*;
import org.aswing.geom.IntRectangle;
import flash.display.DisplayObject;
import org.aswing.plaf.*;
import org.aswing.error.ImpMissError;
import flash.display.Sprite;

public class SkinTextBackground implements GroundDecorator, UIResource{
	
	protected var imageContainer:Sprite;
	protected var defaultImage:DisplayObject;
	protected var uneditableImage:DisplayObject;
	protected var disabledImage:DisplayObject;
	protected var lastViewedImage:DisplayObject;
	
	protected var loaded:Boolean;
	
	public function SkinTextBackground(){
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
		loaded = false;
	}
	
	protected function getPropertyPrefix():String {
        throw new ImpMissError();
        return null;
    }
    
    protected function reloadAssets(ui:ComponentUI):void{
    	var pp:String = getPropertyPrefix();
    	addImage(defaultImage = ui.getInstance(pp+"defaultImage") as DisplayObject);
    	addImage(uneditableImage = ui.getInstance(pp+"uneditableImage") as DisplayObject);
    	addImage(disabledImage = ui.getInstance(pp+"disabledImage") as DisplayObject);
    	defaultImage.visible = true;
    	lastViewedImage = defaultImage;
    }
    
    protected function addImage(image:DisplayObject):void{
    	if(image){
    		image.visible = false;
    		imageContainer.addChild(image);
    	}
    }
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void{
		if(!loaded){
			reloadAssets(c.getUI());
			loaded = true;
		}
		var text:JTextComponent = JTextComponent(c);
		imageContainer.visible = text.isOpaque();
		if(!imageContainer.visible){
			return;
		}
		
		var image:DisplayObject = null;
		if(!text.isEnabled()){
			image = disabledImage;
		}else if(!text.isEditable()){
			image = uneditableImage;
		}
		if(image == null) image = defaultImage;
		if(lastViewedImage != image){
			lastViewedImage.visible = false;
			lastViewedImage = image;
			lastViewedImage.visible = true;
		}
		imageContainer.x = bounds.x;
		imageContainer.y = bounds.y;
		lastViewedImage.width = bounds.width;
		lastViewedImage.height = bounds.height;
	}
	
	public function getDisplay():DisplayObject{
		return imageContainer;
	}
	
}
}