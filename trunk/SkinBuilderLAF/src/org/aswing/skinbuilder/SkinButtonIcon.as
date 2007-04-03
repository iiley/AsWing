/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.graphics.Graphics2D;
import org.aswing.*;
import flash.display.*;
import org.aswing.plaf.*;
import org.aswing.error.ImpMissError;

/**
 * Skin button icon.
 * You can use only four states, defaultImage, pressedImage, disabledImage and rolloverImage.
 * additional states will works too(selectedImage, disabledSelectedImage, rolloverSelectedImage) 
 * if they are defined in the assets properties.
 * @author iiley
 */
public class SkinButtonIcon implements Icon, UIResource{
	
	private var width:int = -1;
	private var height:int = -1;
	
    protected var stateAsset:ButtonStateObject;
    protected var setuped:Boolean;
    
	public function SkinButtonIcon(width:int=-1, height:int=-1){
		this.width = width;
		this.height = height;
		setuped = false;
		stateAsset = new ButtonStateObject();
	}
	
	protected function getPropertyPrefix():String {
        throw new ImpMissError();
        return null;
    }
	
	protected function setupAssets(ui:ComponentUI):void{
        var pp:String = getPropertyPrefix();
		var defaultImage:DisplayObject  = ui.getInstance(pp+"defaultImage") as DisplayObject;
		var pressedImage:DisplayObject  = ui.getInstance(pp+"pressedImage") as DisplayObject;
		var disabledImage:DisplayObject = ui.getInstance(pp+"disabledImage") as DisplayObject;
        var selectedImage:DisplayObject         = ui.getInstance(pp+"selectedImage") as DisplayObject;
        var disabledSelectedImage:DisplayObject = ui.getInstance(pp+"disabledSelectedImage") as DisplayObject;
        var rolloverImage:DisplayObject         = ui.getInstance(pp+"rolloverImage") as DisplayObject;
        var rolloverSelectedImage:DisplayObject = ui.getInstance(pp+"rolloverSelectedImage") as DisplayObject;
        
        stateAsset.setDefaultImage(defaultImage);
        stateAsset.setPressedImage(pressedImage);
        stateAsset.setDisabledImage(disabledImage);
        stateAsset.setSelectedImage(selectedImage);
        stateAsset.setDisabledSelectedImage(disabledSelectedImage);
        stateAsset.setRolloverImage(rolloverImage);
        stateAsset.setRolloverSelectedImage(rolloverSelectedImage);
	}
 	
 	public function getDisplay():DisplayObject{
 		return stateAsset;
 	}
 	
	public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void{
		if(!setuped){
			setupAssets(c.getUI());
			setuped = true;
			if(width < 0){
				c.revalidate();
			}
		}
		var button:AbstractButton = AbstractButton(c);
 		var model:ButtonModel = button.getModel();
 		stateAsset.setEnabled(model.isEnabled());
 		stateAsset.setPressed(model.isPressed() && model.isArmed());
 		stateAsset.setSelected(model.isSelected());
 		stateAsset.setRollovered(button.isRollOverEnabled() && model.isRollOver());
		stateAsset.x = x;
		stateAsset.y = y;
		stateAsset.updateRepresent();
 	}
	
	public function getIconHeight():int{
		if(height >= 0){
			return height;
		}else{
			return stateAsset.height;
		}
	}
	
	public function getIconWidth():int{
		if(width >= 0){
			return width;
		}else{
			return stateAsset.width;
		}
	}
	
}
}