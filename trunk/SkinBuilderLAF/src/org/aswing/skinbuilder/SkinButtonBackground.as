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
	
    protected var stateAsset:ButtonStateObject;
    protected var setuped:Boolean;
    
	public function SkinButtonBackground(){
		setuped = false;
		stateAsset = new ButtonStateObject();
	}
	
    protected function getPropertyPrefix():String {
        return "Button.";
    }
	
	protected function setupAssets(ui:ComponentUI):void{
		stateAsset.setDefaultImage(getAsset(ui, "defaultImage"));
		stateAsset.setPressedImage(getAsset(ui, "pressedImage"));
		stateAsset.setDisabledImage(getAsset(ui, "disabledImage"));
		stateAsset.setSelectedImage(getAsset(ui, "selectedImage"));
		stateAsset.setDisabledSelectedImage(getAsset(ui, "disabledSelectedImage"));
		stateAsset.setRolloverImage(getAsset(ui, "rolloverImage"));
		stateAsset.setRolloverSelectedImage(getAsset(ui, "rolloverSelectedImage"));
	}
	
	private function getAsset(ui:ComponentUI, extName:String):DisplayObject{
        var pp:String = getPropertyPrefix();
        return ui.getInstance(pp+extName) as DisplayObject;
	}
 	
 	public function getDisplay():DisplayObject{
 		return stateAsset;
 	}
 	
 	public function updateDecorator(com:Component, g:Graphics2D, bounds:IntRectangle):void{
 		if(!setuped){
 			setupAssets(com.getUI());
 			setuped = true;
 		}
 		
 		var button:AbstractButton = AbstractButton(com)
 		
 		stateAsset.visible = button.isOpaque();
 		if(!button.isOpaque()){
 			return;
 		}
 		var model:ButtonModel = button.getModel();
 		stateAsset.setEnabled(model.isEnabled());
 		stateAsset.setPressed(model.isPressed() && model.isArmed());
 		stateAsset.setSelected(model.isSelected());
 		stateAsset.setRollovered(button.isRollOverEnabled() && model.isRollOver());
 		stateAsset.updateRepresent(bounds);
 	}
}
}