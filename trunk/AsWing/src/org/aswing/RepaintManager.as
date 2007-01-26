/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{

import org.aswing.util.HashSet;
import flash.display.Stage;
import flash.events.Event;
import org.aswing.util.Timer;

/**
 * RepaintManager use to manager the component's painting.
 * 
 * <p>If you want to repaint a component, call its repaint method, the component will register itself
 * to RepaintManager, when this frame end, it will call its paintImmediately method to paint its.
 * So component's repaint method is fast. But it will not paint immediately, if you want to paint
 * it immediately, you should call paintImmediately method, but it is not fast.</p>
 * @author iiley
 */	
public class RepaintManager
{
	
	private static var instance:RepaintManager;
	private static var stage:Stage;
	/**
	 * Although it's a set in fact, but it work more like a queue
	 * The component will not be added twice into the repaintQueue (one time a component do not need more than one painting)
	 */
	private var repaintQueue:HashSet;
	/**
	 * similar to repaintQueue
	 */
	private var validateQueue:HashSet;
	
	private var timer:Timer;
	
	/**
	 * Singleton class, 
	 * Don't create instance directly, in stead you should call <code>getInstance()</code>.
	 */
	public function RepaintManager(){
		if(instance != null){
			throw new Error("Singleton can't be create more than once!");
		}
		repaintQueue = new HashSet();
		validateQueue = new HashSet();
		timer = new Timer(40, false);
		timer.addActionListener(__render);
	}
	
	/**
	 * Init the repaint manager, it will works better when it is inited.
	 * By default, it will be inited when a component is added to stage automatically.
	 */	
	internal function init(theStage:Stage):void{
		if(stage == null){
			stage = theStage;
			stage.addEventListener(Event.RENDER, __render);
		}
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
		renderLater();
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
			renderLater();
		}
	}
	
	/**
	 * Regists it need to be validated.
	 * @see org.aswing.Component#validate()
	 */	
	public function addInvalidRootComponent(com:Component):void{
		validateQueue.add(com);
		renderLater();
	}
	
	private function renderLater():void{
		if(stage != null){
			stage.invalidate();
		}else{
			if(!timer.isRunning()){
				timer.start();
			}
		}
	}
	
	/**
	 * If the ancestor of the component has no parent or it is isValidateRoot 
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
		//TODO: check if the root here is needed, if not delte the var declar
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
	private function __render(e:Event):void{
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