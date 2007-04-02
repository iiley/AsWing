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

public class SkinRadioButtonUI extends BasicRadioButtonUI implements Icon, UIResource{
	
    protected var stateAsset:ButtonStateObject;
    protected var setuped:Boolean;
    
    protected var defaultIconWidth:int;
    protected var defaultIconHeight:int;
	
	public function SkinRadioButtonUI(){
		super();
		setuped = false;
		stateAsset = new ButtonStateObject();
	}
	
 	override protected function installDefaults(b:AbstractButton):void{
        super.installDefaults(b);
        var pp:String = getPropertyPrefix();
		var defaultImage:DisplayObject  = getInstance(pp+"defaultImage") as DisplayObject;
		var pressedImage:DisplayObject  = getInstance(pp+"pressedImage") as DisplayObject;
		var disabledImage:DisplayObject = getInstance(pp+"disabledImage") as DisplayObject;
        var selectedImage:DisplayObject         = getInstance(pp+"selectedImage") as DisplayObject;
        var disabledSelectedImage:DisplayObject = getInstance(pp+"disabledSelectedImage") as DisplayObject;
        var rolloverImage:DisplayObject         = getInstance(pp+"rolloverImage") as DisplayObject;
        var rolloverSelectedImage:DisplayObject = getInstance(pp+"rolloverSelectedImage") as DisplayObject;
        
        stateAsset.setDefaultImage(defaultImage);
        stateAsset.setPressedImage(pressedImage);
        stateAsset.setDisabledImage(disabledImage);
        stateAsset.setSelectedImage(selectedImage);
        stateAsset.setDisabledSelectedImage(disabledSelectedImage);
        stateAsset.setRolloverImage(rolloverImage);
        stateAsset.setRolloverSelectedImage(rolloverSelectedImage);
        
        defaultIconWidth = defaultImage.width;
        defaultIconHeight = defaultImage.height;
        //this is the importance
        defaultIcon = this;
 	}
 	
 	public function getDisplay():DisplayObject{
 		return stateAsset;
 	}
 	
	public function getIconWidth():int{
		return defaultIconWidth;
	}
	
	public function getIconHeight():int{
		return defaultIconHeight;
	}
	
	public function updateIcon(com:Component, g:Graphics2D, x:int, y:int):void{
 		var model:ButtonModel = button.getModel();
 		stateAsset.setEnabled(model.isEnabled());
 		stateAsset.setPressed(model.isPressed() && model.isArmed());
 		stateAsset.setSelected(model.isSelected());
 		stateAsset.setRollovered(button.isRollOverEnabled() && model.isRollOver());
		stateAsset.x = x;
		stateAsset.y = y;
		stateAsset.updateRepresent();
	}
}
}