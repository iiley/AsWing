/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{
	
import org.aswing.plaf.basic.*;
import org.aswing.*;
import org.aswing.geom.*;
import org.aswing.graphics.Graphics2D;
import flash.display.*;

public class SkinButtonUI extends BasicButtonUI implements GroundDecorator{
	
    protected var defaultImage:Sprite;
    protected var pressedImage:Sprite;
    protected var disabledImage:Sprite;
    protected var selectedImage:Sprite;
    protected var disabledSelectedImage:Sprite;
    protected var rolloverImage:Sprite;
    protected var rolloverSelectedImage:Sprite;
    
    protected var lastViewedImage:Sprite;
    protected var imageContainer:Sprite;
	
	public function SkinButtonUI(){
		super();
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
	}
	
 	override protected function installDefaults(b:AbstractButton):void{
        super.installDefaults(b);
        var pp:String = getPropertyPrefix();
        defaultImage  = getInstance(pp+"defaultImage") as Sprite;
        pressedImage  = getInstance(pp+"pressedImage") as Sprite;
        disabledImage = getInstance(pp+"disabledImage") as Sprite;
        selectedImage         = getInstance(pp+"selectedImage") as Sprite;
        disabledSelectedImage = getInstance(pp+"disabledSelectedImage") as Sprite;
        rolloverImage         = getInstance(pp+"rolloverImage") as Sprite;
        rolloverSelectedImage = getInstance(pp+"rolloverSelectedImage") as Sprite;
        
        addStateImage(defaultImage);
        addStateImage(pressedImage);
        addStateImage(disabledImage);
        addStateImage(selectedImage);
        addStateImage(disabledSelectedImage);
        addStateImage(rolloverImage);
        addStateImage(rolloverSelectedImage);
        defaultImage.visible = true;
        lastViewedImage = defaultImage;
        button.setBackgroundDecorator(this);
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