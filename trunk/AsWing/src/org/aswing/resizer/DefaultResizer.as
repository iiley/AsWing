/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.resizer{
	
import org.aswing.*;
import org.aswing.geom.*;
import org.aswing.plaf.UIResource;
import org.aswing.event.AWEvent;
import flash.display.*;
import org.aswing.graphics.*;
import flash.events.MouseEvent;

/**
 * Resizer is a resizer for Components to make it resizable when user mouse on 
 * component's edge.
 * @author iiley
 */
public class DefaultResizer implements Resizer, UIResource{
	
	private static var RESIZE_MC_WIDTH:Number = 4;
		
	private var owner:Component;

	//-----------resize equiments--------------
	private var resizeMC:Sprite;
	
	private var resizeArrowMC:Sprite;
	private var boundsMC:Shape;
	
	private var topResizeMC:AWSprite;
	private var leftResizeMC:AWSprite;
	private var bottomResizeMC:AWSprite;
	private var rightResizeMC:AWSprite;
	
	private var topLeftResizeMC:AWSprite;
	private var topRightResizeMC:AWSprite;
	private var bottomLeftResizeMC:AWSprite;
	private var bottomRightResizeMC:AWSprite;
	
	private var startX:Number;
	private var startY:Number;
	
	private var enabled:Boolean;
	private var resizeDirectly:Boolean;
	
	private var resizeArrowColor:ASColor;
	private var resizeArrowLightColor:ASColor;
	private var resizeArrowDarkColor:ASColor;
	
	private var listener:Object;
	
	/**
	 * Create a Resizer for specified component.
	 */
	public function DefaultResizer(){
		enabled = true;
		resizeDirectly = false;
		startX = 0;
		startY = 0;
		//Default colors
	    resizeArrowColor = new ASColor(0x808080);
	    resizeArrowLightColor = new ASColor(0xCCCCCC);
	    resizeArrowDarkColor = new ASColor(0x000000);
	}
	
	public function setResizeArrowColor(c:ASColor):void{
		resizeArrowColor = c;
	}
	
	public function setResizeArrowLightColor(c:ASColor):void{
		resizeArrowLightColor = c;
	}
	
	public function setResizeArrowDarkColor(c:ASColor):void{
		resizeArrowDarkColor = c;
	}
	
	public function setOwner(c:Component):void{
		if(owner != null){
			owner.removeEventListener(AWEvent.PAINT, locate);
			if(resizeMC != null){
				owner.removeChild(resizeMC);
			}
		}
		owner = c;
		if(owner != null){
			owner.addEventListener(AWEvent.PAINT, locate);
			if(resizeMC == null){
				createResizeMCs();
			}
			owner.addChildAt(resizeMC, owner.numChildren);
		}
		locate();
	}
		
	/**
	 * <p>Indicate whether need resize component directly when drag the resizer arrow.
	 * <p>if set to false, there will be a rectange to represent then size what will be resized to.
	 * <p>if set to true, the component will be resize directly when drag, but this is need more cpu counting.
	 * <p>Default is false.
	 * @see org.aswing.JFrame
	 */	
	public function setResizeDirectly(r:Boolean):void{
		resizeDirectly = r;
	}
	
	/**
	 * Returns whether need resize component directly when drag the resizer arrow.
	 * @see #setResizeDirectly
	 */
	public function isResizeDirectly():Boolean{
		return resizeDirectly;
	}
	
	//-----------------------For Handlers-------------------------
	
	public function setArrowRotation(r:Number):void{
		resizeArrowMC.rotation = r;
	}
	
	public function hideArrow():void{
		resizeArrowMC.visible = false;
	}
	
	public function showArrowToMousePos():void{
		resizeArrowMC.visible = true;
		resizeArrowMC.x = resizeArrowMC.parent.mouseX;
		resizeArrowMC.y = resizeArrowMC.parent.mouseY;		
	}
	
	public function startDragArrow():void{
		resizeArrowMC.startDrag(true);
	}
	
	public function stopDragArrow():void{
		resizeArrowMC.stopDrag();
	}
	
	public function startResize(strategy:ResizeStrategy):void{
		if(!resizeDirectly){
			boundsMC.visible = true;
			representRect(owner.getComBounds());
		}
		startX = resizeMC.mouseX;
		startY = resizeMC.mouseY;
	}
	
	public function resizing(strategy:ResizeStrategy, e:MouseEvent):void{
		var bounds:IntRectangle = strategy.getBounds(owner, resizeMC.mouseX - startX, resizeMC.mouseY - startY);
		if(resizeDirectly){
			owner.setBounds(bounds);
			owner.revalidate();
			e.updateAfterEvent();
			startX = resizeMC.mouseX;//restart every time
			startY = resizeMC.mouseY;//restart every time
		}else{
			representRect(bounds);
		}
	}
	
	public function finishResize(strategy:ResizeStrategy):void{
		if(!resizeDirectly){
			owner.setComBounds(lastRepresentedBounds);
			boundsMC.visible = false;
			owner.revalidate();
		}
	}
	
	private var lastRepresentedBounds:IntRectangle;
	
	private function representRect(bounds:IntRectangle):void{
		if(!resizeDirectly){
			var currentPos:IntPoint = owner.getLocation();
			var x:Number = bounds.x - currentPos.x;
			var y:Number = bounds.y - currentPos.y;
			var w:Number = bounds.width;
			var h:Number = bounds.height;
			var g:Graphics2D = new Graphics2D(boundsMC.graphics);
			boundsMC.graphics.clear();
			g.drawRectangle(new Pen(resizeArrowLightColor), x-1,y-1,w+2,h+2);
			g.drawRectangle(new Pen(resizeArrowColor), x,y,w,h);
			g.drawRectangle(new Pen(resizeArrowDarkColor), x+1,y+1,w-2,h-2);
			lastRepresentedBounds = bounds;
		}
	}
	
	private function createResizeMCs():void{
		var r:Number = RESIZE_MC_WIDTH;
		resizeMC = new Sprite();
		resizeMC.name = "resizer";
		resizeArrowMC = new Sprite();
		resizeArrowMC.name = "arrow";
		resizeMC.addChild(resizeArrowMC);
		
		var w:Number = 1; //arrowAxisHalfWidth
		var arrowPoints:Array = [{x:-r*2, y:0}, {x:-r, y:-r}, {x:-r, y:-w},
								 {x:r, y:-w}, {x:r, y:-r}, {x:r*2, y:0},
								 {x:r, y:r}, {x:r, y:w}, {x:-r, y:w},
								 {x:-r, y:r}];
								 
		var gdi:Graphics2D;
		gdi = new Graphics2D(resizeArrowMC.graphics);
		gdi.drawPolygon(new Pen(resizeArrowColor.changeAlpha(40), 4), arrowPoints);
		gdi.fillPolygon(new SolidBrush(resizeArrowLightColor), arrowPoints);
		gdi.drawPolygon(new Pen(resizeArrowDarkColor, 1), arrowPoints);
		resizeArrowMC.visible = false;
		
		boundsMC = new Shape();
		boundsMC.name = "bounds";
		boundsMC.visible = false;
		resizeMC.addChild(boundsMC);
		
		topResizeMC = new AWSprite();
		leftResizeMC = new AWSprite();
		rightResizeMC = new AWSprite();
		bottomResizeMC = new AWSprite();
		
		topLeftResizeMC = new AWSprite();
		topRightResizeMC = new AWSprite();
		bottomLeftResizeMC = new AWSprite();
		bottomRightResizeMC = new AWSprite();
		
		resizeMC.addChild(topResizeMC);
		resizeMC.addChild(leftResizeMC);
		resizeMC.addChild(rightResizeMC);
		resizeMC.addChild(bottomResizeMC);
		
		resizeMC.addChild(topLeftResizeMC);
		resizeMC.addChild(topRightResizeMC);
		resizeMC.addChild(bottomLeftResizeMC);
		resizeMC.addChild(bottomRightResizeMC);
		
		DefaultResizeBarHandler.createHandler(this, topResizeMC, 90, createResizeStrategy(0, -1));
		DefaultResizeBarHandler.createHandler(this, leftResizeMC, 0, createResizeStrategy(-1, 0));
		DefaultResizeBarHandler.createHandler(this, rightResizeMC, 0, createResizeStrategy(1, 0));
		DefaultResizeBarHandler.createHandler(this, bottomResizeMC, 90, createResizeStrategy(0, 1));
		
		DefaultResizeBarHandler.createHandler(this, topLeftResizeMC, 45, createResizeStrategy(-1, -1));
		DefaultResizeBarHandler.createHandler(this, topRightResizeMC, -45, createResizeStrategy(1, -1));
		DefaultResizeBarHandler.createHandler(this, bottomLeftResizeMC, -45, createResizeStrategy(-1, 1));
		DefaultResizeBarHandler.createHandler(this, bottomRightResizeMC, 45, createResizeStrategy(1, 1));
		
		var brush:SolidBrush = new SolidBrush(new ASColor(0, 0));
		gdi = new Graphics2D(topResizeMC.graphics);
		gdi.fillRectangle(brush, 0, 0, r, r);
		gdi = new Graphics2D(leftResizeMC.graphics);
		gdi.fillRectangle(brush, 0, 0, r, r);
		gdi = new Graphics2D(rightResizeMC.graphics);
		gdi.fillRectangle(brush, -r, 0, r, r);	
		gdi = new Graphics2D(bottomResizeMC.graphics);
		gdi.fillRectangle(brush, 0, -r, r, r);	
		
		gdi = new Graphics2D(topLeftResizeMC.graphics);
		gdi.fillRectangle(brush, 0, 0, r*2, r);
		gdi.fillRectangle(brush, 0, 0, r, r*2);
		gdi = new Graphics2D(topRightResizeMC.graphics);
		gdi.fillRectangle(brush, -r*2, 0, r*2, r);
		gdi.fillRectangle(brush, -r, 0, r, r*2);
		gdi = new Graphics2D(bottomLeftResizeMC.graphics);
		gdi.fillRectangle(brush, 0, -r, r*2, r);
		gdi.fillRectangle(brush, 0, -r*2, r, r*2);
		gdi = new Graphics2D(bottomRightResizeMC.graphics);
		gdi.fillRectangle(brush, -r*2, -r, r*2, r);
		gdi.fillRectangle(brush, -r, -r*2, r, r*2);
		
		resizeMC.visible = enabled;
	}
	
	/**
	 * Override this method if you want to use another resize strategy.
	 */
	private function createResizeStrategy(wSign:Number, hSign:Number):ResizeStrategy{
		return new ResizeStrategyImp(wSign, hSign); 
	}
	
	public function setEnabled(e:Boolean):void{
		enabled = e;
		resizeMC.visible = enabled;
	}
	
	public function isEnabled():Boolean{
		return enabled;
	}
		
	/**
	 * Locate the resizer mcs to fit the component.
	 */
	private function locate():void{
		//var x:Number = 0;
		//var y:Number = 0;
		var w:Number = owner.getWidth();
		var h:Number = owner.getHeight();
		var r:Number = RESIZE_MC_WIDTH;
		
		topResizeMC.width = Math.max(0, w-r*2);
		topResizeMC.x = r;
		topResizeMC.y = 0;
		leftResizeMC.height = Math.max(0, h-r*2);
		leftResizeMC.x = 0;
		leftResizeMC.y = r;
		rightResizeMC.height = Math.max(0, h-r*2);
		rightResizeMC.x = w;
		rightResizeMC.y = r;
		bottomResizeMC.width = Math.max(0, w-r*2);
		bottomResizeMC.x = r;
		bottomResizeMC.y = h;
		
		topLeftResizeMC.x = 0;
		topLeftResizeMC.y = 0;
		topRightResizeMC.x = w;
		topRightResizeMC.y = 0;
		bottomLeftResizeMC.x = 0;
		bottomLeftResizeMC.y = h;
		bottomRightResizeMC.x = w;
		bottomRightResizeMC.y = h;
	}
}
}