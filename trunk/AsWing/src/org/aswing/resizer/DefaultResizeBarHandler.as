/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.resizer{
	
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import org.aswing.event.AWEvent;
import flash.events.Event;
import org.aswing.AWSprite;
	
	
/**
 * The Handler for Resizer's mc bars.
 * @author iiley
 */
public class DefaultResizeBarHandler{
	
	private var resizer:DefaultResizer;
	private var mc:AWSprite;
	private var arrowRotation:Number;
	private var strategy:ResizeStrategy;
	
	public function DefaultResizeBarHandler(resizer:DefaultResizer, barMC:AWSprite, arrowRotation:Number, strategy:ResizeStrategy){
		this.resizer = resizer;
		mc = barMC;
		this.arrowRotation = arrowRotation;
		this.strategy = strategy;
		
		handle();
	}
	
	public static function createHandler(resizer:DefaultResizer, barMC:AWSprite, arrowRotation:Number, strategy:ResizeStrategy):DefaultResizeBarHandler{
		return new DefaultResizeBarHandler(resizer, barMC, arrowRotation, strategy);
	}
	
	private function handle():void{
		mc.addEventListener(MouseEvent.ROLL_OVER, __onRollOver);
		mc.addEventListener(MouseEvent.ROLL_OUT, __onRollOut);
		mc.addEventListener(MouseEvent.MOUSE_DOWN, __onPress);
		mc.addEventListener(MouseEvent.CLICK, __onRelease);
		mc.addEventListener(AWEvent.RELEASE_OUT_SIDE, __onReleaseOutside);
	}
	
	private function __onRollOver(e:Event):void{
		showArrowToMousePos();
		mc.stage.addEventListener(MouseEvent.MOUSE_MOVE, showArrowToMousePos);
	}
	
	private function __onRollOut(e:Event):void{
		mc.stage.removeEventListener(MouseEvent.MOUSE_MOVE, showArrowToMousePos);
		resizer.hideArrow();
	}
	
	private function __onPress(e:Event):void{
		resizer.startDragArrow();
		startResize();
		mc.stage.addEventListener(MouseEvent.MOUSE_MOVE, resizing);
	}
	
	private function __onRelease(e:Event):void{
		resizer.stopDragArrow();
		mc.stage.removeEventListener(MouseEvent.MOUSE_MOVE, resizing);
		finishResize();
	}
	
	private function __onReleaseOutside(e:Event):void{
		__onRelease(e);
		resizer.hideArrow();
	}
	
	private function showArrowToMousePos(e:Event=null):void{
		resizer.setArrowRotation(arrowRotation);
		resizer.showArrowToMousePos();
	}
	
	private function startResize():void{
		resizer.startResize(strategy);
	}
	
	private function resizing(e:MouseEvent):void{
		resizer.resizing(strategy, e);
	}
	
	private function finishResize():void{
		resizer.finishResize(strategy);
	}
}
}