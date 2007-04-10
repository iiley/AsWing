/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.graphics.Graphics2D;
import org.aswing.geom.*;
import org.aswing.*;
import flash.display.*;
import org.aswing.plaf.*;
import flash.events.*;
import org.aswing.event.*;

public class SkinScrollBarThumb implements GroundDecorator, UIResource{
	
    protected var thumb:AWSprite;
    protected var verticalContainer:ButtonStateObject;
    protected var horizontalContainer:ButtonStateObject;
    
    protected var verticalDefaultImage:DisplayObject;
    protected var verticalPressedImage:DisplayObject;
    protected var verticalDisabledImage:DisplayObject;
    protected var verticalRolloverImage:DisplayObject;
    
    protected var horizontalDefaultImage:DisplayObject;
    protected var horizontalPressedImage:DisplayObject;
    protected var horizontalDisabledImage:DisplayObject;
    protected var horizontalRolloverImage:DisplayObject;
    
    protected var size:IntDimension;
    protected var verticle:Boolean;
    
    protected var enabled:Boolean;
	protected var rollover:Boolean;
	protected var pressed:Boolean;
	
	public function SkinScrollBarThumb(){
		thumb = new AWSprite();
		rollover = false;
		pressed = false;
		enabled = true;
		initSelfHandlers();
	}
	
	private function checkReloadAssets(c:Component):void{
		if(verticalContainer){
			return;
		}
		verticalContainer = new ButtonStateObject();
		horizontalContainer = new ButtonStateObject();
		var ui:ComponentUI = c.getUI();
		verticalContainer.setDefaultImage(getAsset(ui, "thumbVertical.defaultImage"));
		verticalContainer.setPressedImage(getAsset(ui, "thumbVertical.pressedImage"));
		verticalContainer.setDisabledImage(getAsset(ui, "thumbVertical.disabledImage"));
		verticalContainer.setRolloverImage(getAsset(ui, "thumbVertical.rolloverImage"));
		
		horizontalContainer.setDefaultImage(getAsset(ui, "thumbHorizontal.defaultImage"));
		horizontalContainer.setPressedImage(getAsset(ui, "thumbHorizontal.pressedImage"));
		horizontalContainer.setDisabledImage(getAsset(ui, "thumbHorizontal.disabledImage"));
		horizontalContainer.setRolloverImage(getAsset(ui, "thumbHorizontal.rolloverImage"));
	}
	
	
    protected function getAsset(ui:ComponentUI, exName:String):DisplayObject {
        return ui.getInstance("ScrollBar."+exName) as DisplayObject;
    }
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void{
		checkReloadAssets(c);
		thumb.x = bounds.x;
		thumb.y = bounds.y;
		size = bounds.getSize();
		var sb:JScrollBar = JScrollBar(c);
		enabled = sb.isEnabled();
		verticle = (sb.getOrientation() == JScrollBar.VERTICAL);
		paint();
	}
	
	public function getDisplay(c:Component):DisplayObject{
		checkReloadAssets(c);
		return thumb;
	}
	
	protected function paint():void{
		if(verticle){
			if(!thumb.contains(verticalContainer)){
				thumb.addChild(verticalContainer);
			}
			if(thumb.contains(horizontalContainer)){
				thumb.removeChild(horizontalContainer);
			}
			verticalContainer.setEnabled(enabled);
			verticalContainer.setPressed(pressed);
			verticalContainer.setRollovered(rollover);
			verticalContainer.updateRepresent(size.getBounds());
		}else{
			if(!thumb.contains(horizontalContainer)){
				thumb.addChild(horizontalContainer);
			}
			if(thumb.contains(verticalContainer)){
				thumb.removeChild(verticalContainer);
			}
			horizontalContainer.setEnabled(enabled);
			horizontalContainer.setPressed(pressed);
			horizontalContainer.setRollovered(rollover);
			horizontalContainer.updateRepresent(size.getBounds());
		}
	}

	private function initSelfHandlers():void{
		thumb.addEventListener(MouseEvent.ROLL_OUT, __rollOutListener);
		thumb.addEventListener(MouseEvent.ROLL_OVER, __rollOverListener);
		thumb.addEventListener(MouseEvent.MOUSE_DOWN, __mouseDownListener);
		thumb.addEventListener(ReleaseEvent.RELEASE, __mouseUpListener);
	}
	
	private function __rollOverListener(e:Event):void{
		rollover = true;
		paint();
	}
	private function __rollOutListener(e:Event):void{
		rollover = false;
		if(!pressed){
			paint();
		}
	}
	private function __mouseDownListener(e:Event):void{
		pressed = true;
		paint();
	}
	private function __mouseUpListener(e:Event):void{
		if(pressed){
			pressed = false;
			paint();
		}
	}
	
}
}