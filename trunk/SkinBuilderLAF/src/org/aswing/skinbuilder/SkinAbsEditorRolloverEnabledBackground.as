/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{
	
import flash.display.*;
import flash.events.MouseEvent;
import org.aswing.*;
import org.aswing.plaf.ComponentUI;
import org.aswing.geom.IntRectangle;
import org.aswing.graphics.Graphics2D;
	
	
public class SkinAbsEditorRolloverEnabledBackground extends SkinAbsEditorBackground{
	
	protected var defaultRolloverImage:DisplayObject;
	protected var uneditableRolloverImage:DisplayObject;
	protected var rollover:Boolean;
	protected var c:Component;
	protected var bounds:IntRectangle;
	
	public function SkinAbsEditorRolloverEnabledBackground(){
		super();
		rollover = false;
	}
	
	private function __rollover(e:MouseEvent):void{
		if(checkRemoveListeners()){
			return;
		}
		if(!rollover){
			rollover = true;
			updateDecorator(c, null, bounds);
		}
	}
	
	private function __rollout(e:MouseEvent):void{
		if(checkRemoveListeners()){
			return;
		}
		if(rollover){
			rollover = false;
			updateDecorator(c, null, bounds);
		}	
	}
	
	private function checkRemoveListeners():Boolean{
		if(!c.contains(imageContainer)){
			c.addEventListener(MouseEvent.ROLL_OVER, __rollover);
			c.addEventListener(MouseEvent.ROLL_OUT, __rollout);
			c = null;
			bounds = null;
			return true;
		}
		return false;
	}
    
    override protected function reloadAssets(ui:ComponentUI):void{
    	super.reloadAssets(ui);
    	var pp:String = getPropertyPrefix();
    	addImage(defaultRolloverImage = ui.getInstance(pp+"defaultRolloverImage") as DisplayObject);
    	addImage(uneditableRolloverImage = ui.getInstance(pp+"uneditableRolloverImage") as DisplayObject);
    }
	
	override public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void{
		if(this.c == null){
			c.addEventListener(MouseEvent.ROLL_OVER, __rollover);
			c.addEventListener(MouseEvent.ROLL_OUT, __rollout);
		}
		this.c = c;
		this.bounds = bounds.clone();
		if(!loaded){
			reloadAssets(c.getUI());
			loaded = true;
		}
		
		var image:DisplayObject = null;
		if(!c.isEnabled()){
			image = disabledImage;
		}else if(!isEditable(c)){
			if(rollover && uneditableRolloverImage){
				image = uneditableRolloverImage;
			}else{
				image = uneditableImage;
			}
		}else{
			if(rollover && defaultRolloverImage){
				image = defaultRolloverImage;
			}else{
				image = defaultImage;
			}
		}
		if(image == null) image = defaultImage;
		if(lastViewedImage != image){
			lastViewedImage.visible = false;
			lastViewedImage = image;
			lastViewedImage.visible = true;
		}
		//not use bounds, avoid the border
		lastViewedImage.width = c.width;
		lastViewedImage.height = c.height;
	}	
}
}