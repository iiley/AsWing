/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{

import org.aswing.util.HashSet;
import flash.display.Stage;
import flash.events.Event;

/**
 * RepaintManager use to manager the component's painting.
 * 
 * <p>If you want to repaint a component, call its repaint method, it will regist itself
 * to RepaintManager, when frame ended, it will call its paintImmediately to paint its.
 * So component's repaint method is fast. But it will not paint immediately, if you want to paint
 * it immediately, you should call paintImmediately method, but it is not fast.
 * @author iiley
 */	
public class RepaintManager
{
	
	private static var instance:RepaintManager;
	private static var stage:Stage;
	/**
	 * although it's a set in fact, but it work more like a queue
	 * just one component would only located one position.(one time a component do not need more than one painting)
	 */
	private var repaintQueue:HashSet;
	/**
	 * similar to repaintQueue
	 */
	private var validateQueue:HashSet;
	
	/**
	 * @private
	 */
	public function RepaintManager(){
		if(instance != null){
			throw new Error("Singleton can't be create more than once!");
		}
		repaintQueue = new HashSet();
		validateQueue = new HashSet();
	}
	
	internal function initStage(theStage:Stage):void{
		if(stage == null){
			stage = theStage;
			stage.addEventListener(Event.RENDER, __render);
		}
	}
	
	internal function isStageInited():Boolean{
		return stage != null;
	}
	
	public static function getInstance():RepaintManager{
		if(instance == null){
			instance = new RepaintManager();
		}
		return instance;
	}
		
	/**
	 * Regist A Component need to repaint.
	 * @see org.aswing.Component#repaint()
	 */
	public function addRepaintComponent(com:Component):void{
		repaintQueue.add(com);
		stage.invalidate();
	}
	
	/**
	 * Find the Component's validate root parent and regist it need to validate.
	 * @see org.aswing.Component#revalidate()
	 * @see org.aswing.Component#validate()
	 * @see org.aswing.Component#invalidate()
	 */	
	public function addInvalidComponent(com:Component):void{
		var validateRoot:Component = getValidateRootComponent(com);
		if(validateRoot != null){
			validateQueue.add(validateRoot);
		}
		stage.invalidate();
	}
	
	/**
	 * Regists it need to validate.
	 * @see org.aswing.Component#validate()
	 */	
	public function addInvalidRootComponent(com:Component):void{
		validateQueue.add(com);
		stage.invalidate();
	}
	
	/**
	 * If a ancestors of component has no parent or it is isValidateRoot 
	 * and it's parent are visible, then it will be the validate root component,
	 * else it has no validate root component.
	 */
	private function getValidateRootComponent(com:Component):Component{
		var validateRoot:Component = null;
		var i:Component;
		for(i = com; i!=null; i=i.getParent()){
			if(i.isValidateRoot()){
				validateRoot = i;
				break;
			}
		}
		
		var root:Component = null;
		for(i = validateRoot; i!=null; i=i.getParent()){
			if(!i.isVisible()){
				//return null;
			}
		}
		return validateRoot;
	}
	
	/**
	 * Every frame this method will be executed to invoke the painting of components needed.
	 */
	private function __render():void{
		var i:int;
		var n:int;
		var com:Component;
						
//		var time:Number = getTimer();
		var processValidates:Array = validateQueue.toArray();
		//must clear here, because there maybe addRepaintComponent at below operation
		validateQueue.clear();
		n = processValidates.length;
		i = -1;
		if(n > 0){
			//trace("------------------------one tick---------------------------");
		}
		while((++i) < n){
			com = processValidates[i];
			com.validate();
			//trace("validating com : " + com);
		}
//		if(n > 0){
//			trace(n + " validate time : " + (getTimer() - time));
//		}
//		time = getTimer();
		
		
		var processRepaints:Array = repaintQueue.toArray();
		//must clear here, because there maybe addInvalidComponent at below operation
		repaintQueue.clear();
		
		n = processRepaints.length;
		i = -1;
		while((++i) < n){
			com = processRepaints[i];
			com.paintImmediately();
		}
//		if(n > 0){
//			trace(n + " paint time : " + (getTimer() - time));
//		}
	}	
}
}