/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.dnd{

import org.aswing.Component;
import flash.display.Sprite;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.geom.Point;
import org.aswing.geom.IntPoint;

/**
 * The motion of the drop target does not accept the dropped initiator. 
 * @author iiley
 */
public class RejectedMotion implements DropMotion{
	
	
	private var timer:Timer;
	private var initiatorPos:IntPoint;
	private var dragObject:Sprite;
	
	public function RejectedMotion(){
		timer = new Timer(40);
		timer.addEventListener(TimerEvent.TIMER, __enterFrame);
	}
	
	private function startNewMotion(dragInitiator:Component, dragObject : Sprite):void{
		this.dragObject = dragObject;
		initiatorPos = dragInitiator.getGlobalLocation();
		if(initiatorPos == null){
			initiatorPos = new IntPoint();
		}
		timer.start();
	}
	
	public function startMotionAndLaterRemove(dragInitiator:Component, dragObject : Sprite) : void {
		//create a new instance to do motion, avoid muiltiple motion shared instance
		var motion:RejectedMotion = new RejectedMotion();
		motion.startNewMotion(dragInitiator, dragObject);
	}
	
	private function __enterFrame(e:TimerEvent):void{
		//check first
		var speed:Number = 0.25;
		
		var p:Point = new Point(dragObject.x, dragObject.y);
		p = dragObject.parent.localToGlobal(p);
		p.x += (initiatorPos.x - p.x) * speed;
		p.y += (initiatorPos.y - p.y) * speed;
		if(Point.distance(p, initiatorPos.toPoint()) < 1){
			dragObject.parent.removeChild(dragObject);
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER, __enterFrame);
			return;
		}
		p = dragObject.parent.globalToLocal(p);
		dragObject.alpha += (4 - dragObject.alpha) * speed;
		dragObject.x = p.x;
		dragObject.y = p.y;
	}
	
}
}