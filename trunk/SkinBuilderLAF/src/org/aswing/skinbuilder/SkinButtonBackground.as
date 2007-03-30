/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.plaf.*;
import org.aswing.plaf.basic.*;
import org.aswing.*;
import org.aswing.geom.*;
import org.aswing.graphics.Graphics2D;
import flash.display.*;

public class SkinButtonBackground implements GroundDecorator, UIResource{
	
    protected var defaultImage:Sprite;
    protected var pressedImage:Sprite;
    protected var disabledImage:Sprite;
    protected var selectedImage:Sprite;
    protected var disabledSelectedImage:Sprite;
    protected var rolloverImage:Sprite;
    protected var rolloverSelectedImage:Sprite;
    
    protected var lastViewedImage:Sprite;
    protected var imageContainer:Sprite;
    protected var setuped:Boolean;
    
	public function SkinButtonBackground(){
		setuped = false;
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
	}
	
    protected function getPropertyPrefix():String {
        return "Button.";
    }
	
	protected function setupAssets(ui:ComponentUI):void{
        var pp:String = getPropertyPrefix();
        defaultImage  = ui.getInstance(pp+"defaultImage") as Sprite;
        pressedImage  = ui.getInstance(pp+"pressedImage") as Sprite;
        disabledImage = ui.getInstance(pp+"disabledImage") as Sprite;
        selectedImage         = ui.getInstance(pp+"selectedImage") as Sprite;
        disabledSelectedImage = ui.getInstance(pp+"disabledSelectedImage") as Sprite;
        rolloverImage         = ui.getInstance(pp+"rolloverImage") as Sprite;
        rolloverSelectedImage = ui.getInstance(pp+"rolloverSelectedImage") as Sprite;
        
        addStateImage(defaultImage);
        addStateImage(pressedImage);
        addStateImage(disabledImage);
        addStateImage(selectedImage);
        addStateImage(disabledSelectedImage);
        addStateImage(rolloverImage);
        addStateImage(rolloverSelectedImage);
        defaultImage.visible = true;
        lastViewedImage = defaultImage;
	}
 	
 	private function addStateImage(img:Sprite):void{
        if(img != null){
        	imageContainer.addChild(img);
        	img.visible = false;
        }
 	}
 	
 	public function getDisplay():DisplayObject{
 		return imageContainer;
 	}
 	
 	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):void{
 		if(!setuped){
 			setupAssets(com.getUI());
 			setuped = true;
 		}
 		
 		var button:AbstractButton = AbstractButton(com)
 		
 		imageContainer.visible = button.isOpaque();
 		if(!button.isOpaque()){
 			return;
 		}
 		var model:ButtonModel = button.getModel();
 		var image:Sprite = defaultImage;
 		var tmpImage:Sprite = null;
 		
		if(!model.isEnabled()){
			if(model.isSelected()){
				tmpImage = disabledSelectedImage;
			}else{
				tmpImage = disabledImage;
			}
		}else if(model.isPressed() && model.isArmed()){
			tmpImage = pressedImage;
		}else if(button.isRollOverEnabled() && model.isRollOver()){
			if(model.isSelected()) {
				tmpImage = rolloverSelectedImage;
			}else{
				tmpImage = rolloverImage;
			}
		}else if(model.isSelected()){
			tmpImage = selectedImage;
		}
		if(tmpImage != null){
			image = tmpImage;
		}
		if(image != lastViewedImage){
			lastViewedImage.visible = false;
			image.visible = true;
			lastViewedImage = image;
		}
		imageContainer.x = bounds.x;
		imageContainer.y = bounds.y;
		image.width = bounds.width;
		image.height = bounds.height;
 	}
}
}