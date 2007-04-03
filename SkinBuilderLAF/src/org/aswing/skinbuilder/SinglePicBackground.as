/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import org.aswing.*;
import flash.display.DisplayObject;
import org.aswing.plaf.*;
import flash.display.Sprite;
import org.aswing.error.ImpMissError;

public class SinglePicBackground implements GroundDecorator, UIResource{
	
	protected var imageContainer:Sprite;
	protected var image:DisplayObject;
	protected var loaded:Boolean;
	
	public function SinglePicBackground(){
		imageContainer = AsWingUtils.createSprite(null, "imageContainer");
		loaded = false;
	}
	
	protected function getDefaltsKey():String{
		throw new ImpMissError();
		return null;
	}
	
	public function updateDecorator(c:Component, g:Graphics2D, bounds:IntRectangle):void{
		if(!loaded){
			image = c.getUI().getInstance(getDefaltsKey()) as DisplayObject;
			if(image){
				imageContainer.addChild(image);
			}
			loaded = true;
		}
		if(image){
			//not use bounds, avoid border margin
			image.width = c.width;
			image.height = c.height;
		}
	}
	
	public function getDisplay():DisplayObject{
		return imageContainer;
	}
	
}
}