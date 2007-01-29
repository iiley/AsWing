/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import flash.display.*;
import flash.events.*;
import flash.ui.Keyboard;

/**
 * FocusManager manages all the when a component should receive focus, i.e if it
 * can.
 * 
 * @author iiley
 */
public class FocusManager{
	
   /**
     * The identifier for the Forward focus traversal keys.
     *
     * @see #setDefaultFocusTraversalKeys()
     * @see #getDefaultFocusTraversalKeys()
     * @see Component#setFocusTraversalKeys()
     * @see Component#getFocusTraversalKeys()
     */
	public static var FORWARD_TRAVERSAL_KEYS:Number = 0;
    /**
     * The identifier for the Backward focus traversal keys.
     *
     * @see #setDefaultFocusTraversalKeys()
     * @see #getDefaultFocusTraversalKeys()
     * @see Component#setFocusTraversalKeys()
     * @see Component#getFocusTraversalKeys()
     */
	public static var BACKWARD_TRAVERSAL_KEYS:Number = 1;
    /**
     * The identifier for the Up Cycle focus traversal keys.
     *
     * @see #setDefaultFocusTraversalKeys()
     * @see #getDefaultFocusTraversalKeys()
     * @see Component#setFocusTraversalKeys()
     * @see Component#getFocusTraversalKeys()
     */
	public static var UP_CYCLE_TRAVERSAL_KEYS:Number = 2;
    /**
     * The identifier for the Down Cycle focus traversal keys.
     *
     * @see #setDefaultFocusTraversalKeys()
     * @see #getDefaultFocusTraversalKeys()
     * @see Component#setFocusTraversalKeys()
     * @see Component#getFocusTraversalKeys()
     */
	public static var DOWN_CYCLE_TRAVERSAL_KEYS:Number = 3;
    /**
     * The identifiers length.
     */
	public static var TRAVERSAL_KEY_LENGTH:Number = (DOWN_CYCLE_TRAVERSAL_KEYS + 1);
	
	/**
	 * Then tab index range(start index, inclusive) of AsWing component using
	 */
	public static var ASWING_TAB_INDEX_START:Number = 10000;
	/**
	 * Then tab index range(end inde, inclusive) of AsWing component using
	 */	
	public static var ASWING_TAB_INDEX_END:Number   = 20000;
	
	private static var instance:FocusManager;
	private static var traversalEnabled:Boolean = true;
		
	private static var oldFocusOwner:Component;
	private static var focusOwner:Component;
	private static var activeWindow:JWindow;
	private static var currentFocusCycleRoot:Container;
	
	private static var lastFocusRecivedComponentObject:Object;
	private static var justSystemTabDirection:Number = 0;
	
	private var stage:Stage;
	private var inited:Boolean;
	private var defaultPolicy:FocusTraversalPolicy;
	private var traversing:Boolean;
	
	private var focusFrontHolderMC:Sprite;
	private var focusBackHolderMC:Sprite;
	
	
	public function FocusManager(){
		traversing = false;
		inited = false;
		defaultPolicy = new ContainerOrderFocusTraversalPolicy();
	}
	
	/**
	 * Init the focus manager, it will only start works when it is inited.
	 * By default, it will be inited when a component is added to stage automatically.
	 */
	public function init(theStage:Stage):void{
		if(!inited){
			stage = theStage;
			inited = true;
			stage.addEventListener(FocusEvent.KEY_FOCUS_CHANGE, __onKeyFocusChange);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);

			focusFrontHolderMC = new Sprite();
			focusFrontHolderMC.name = "aswing_focusFrontHolder";
			focusFrontHolderMC.tabEnabled = true;
			focusFrontHolderMC.tabIndex = ASWING_TAB_INDEX_START;
			focusBackHolderMC = new Sprite();
			focusBackHolderMC.name = "aswing_focusBackHolder";
			focusBackHolderMC.tabEnabled = true;
			focusBackHolderMC.tabIndex = ASWING_TAB_INDEX_END;
			stage.addChild(focusFrontHolderMC);
			stage.addChild(focusBackHolderMC);
		}
	}
	
	/**
	 * Un-init this focus manager.
	 */
	public function uninit():void{
		if(stage != null){
			stage.removeEventListener(FocusEvent.KEY_FOCUS_CHANGE, __onKeyFocusChange);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, __onMouseDown);
		}
	}
	
	/**
	 * Makes specified component obj(a movie clip or a text field) to receive this flash internal focus.
	 * @return the flash system tab navigating direction, 0 if it is not navigated by system tab.
	 */
	public function receiveFocus(obj:InteractiveObject):Number{
		lastFocusRecivedComponentObject.tabIndex = undefined;
		lastFocusRecivedComponentObject.tabEnabled = false;
		obj.tabEnabled = true;
		obj.tabIndex = ASWING_TAB_INDEX_START + Math.floor((ASWING_TAB_INDEX_END - ASWING_TAB_INDEX_START)/2);
		if(justSystemTabDirection == 0){
			if(stage.focus != obj){
				stage.focus = obj;
			}
		}else if(justSystemTabDirection < 0){
			stage.focus = focusBackHolderMC;
		}else{
			stage.focus = focusFrontHolderMC;
		}
		lastFocusRecivedComponentObject = obj;
		var dir:Number = justSystemTabDirection;
		justSystemTabDirection = 0;
		return dir;
	}
	
	private static function __onMouseDown(e:MouseEvent):void{
		instance.__noticeWhenMouseDown();
	}
	
	private static function __onKeyFocusChange(e:FocusEvent):void{
		if(!traversalEnabled){
			return;
		}
		if(focusOwner != null){
			e.preventDefault();
		}
		if(e.shiftKey){
			instance.setTraversing(true);
			instance.focusPrevious();
		}else{
			instance.setTraversing(true);
			instance.focusNext();
		}
	}
	
	private function __noticeWhenMouseDown():void{
		traversing = false;
		//TODO imp
		//getFocusOwner().clearFocusGraphicsByUI();
	}
	
	/**
	 * Returns if the focus is traversing by keys.
	 * <p>
	 * Once when focus traversed by FocusTraversalKeys this is turned on, 
	 * true will be returned. Once when Mouse is down, this will be turned off, 
	 * false will be returned.
	 * @return true if the focus is traversing by FocusTraversalKeys, otherwise returns false.
	 * @see #getDefaultFocusTraversalKeys()
	 * @see Component#getFocusTraversalKeys()
	 */
	public function isTraversing():Boolean{
		return traversing;
	}
	
	/**
	 * Sets if the focus is traversing by keys.
	 * <p>
	 * By default, the traversing property will only be set true when TRAVERSAL_KEYS down.
	 * If your component need view focus rect, you should set it to true when your component's 
	 * managed key down. 
	 * @param b true tag traversing to be true, false tag traversing to be false
	 * @see #isTraversing()
	 */
	public function setTraversing(b:Boolean):void{
		traversing = b;
	}
		
	/**
	 * Disables the traversal by keys pressing.
	 * If this method called, TAB... keys will not effect the focus traverse. And component will not fire 
	 * any Key events when there are focused and key pressed.
	 */
	public static function disableTraversal():void{
		traversalEnabled = false;
	}
	
	/**
	 * Enables the traversal by keys pressing.
	 * If this method called, TAB... keys will effect the focus traverse. And component will fire 
	 * Key events when there are focused and key pressed.
	 */
	public static function enableTraversal():void{
		traversalEnabled = true;
	}
	
	/**
	 * Returns whether the traversal enabled.
	 * @return whether the traversal enabled.
	 * @see #disableTraversal()
	 * @see #enableTraversal()
	 */
	public static function isTraversalEnabled():Boolean{
		return traversalEnabled;
	}
	
    /**
     * Returns the current FocusManager instance
     *
     * @return this the current FocusManager instance
     * @see #setCurrentManager
     */
	public static function getCurrentManager():FocusManager{		
		if(instance == null){
			instance = new FocusManager();	
		}		
		return instance;
	}
	
	/**
     * Sets the current FocusManager instance. If null is specified, 
     * then the current FocusManager is replaced with a new instance of FocusManager.
     * 
     * @param newManager the new FocusManager
     * @see #getCurrentManager
     * @see org.aswing.FocusManager
	 */
	public static function setCurrentManager(newManager:FocusManager):void{
		if(newManager == null){
			newManager = new FocusManager();
		}
		var oldManager:FocusManager = instance;
		if(oldManager != newManager){
			if(oldManager != null){
				oldManager.uninit();
			}
			instance = newManager;
			if(oldManager != null && oldManager.stage != null){
				instance.init(oldManager.stage);
			}
		}
	}

	/**
     * Returns the previous focused component.
     *
     * @return the previous focused component.
     */
	public static function getPreviousFocusedComponent():Component{
		return oldFocusOwner;
	}

	/**
     * Returns the focus owner.
     *
     * @return the focus owner.
     * @see #setFocusOwner()
     */
	public function getFocusOwner():Component{
		return focusOwner;
	}
	
	/**
     * Sets the focus owner. The operation will be cancelled if the Component
     * is not focusable.
     * <p>
     * This method does not actually set the focus to the specified Component.
     * It merely stores the value to be subsequently returned by
     * <code>getFocusOwner()</code>. Use <code>Component.requestFocus()</code>
     * or <code>Component.requestFocusInWindow()</code> to change the focus
     * owner.
     *
     * @param focusOwner the focus owner
     * @see #getFocusOwner()
     * @see Component#requestFocus()
     * @see Component#isFocusable()
	 */
	public function setFocusOwner(newFocusOwner:Component):void{
		if(focusOwner != newFocusOwner){
			oldFocusOwner = focusOwner;
			focusOwner = newFocusOwner;
		}
	}
	
	/**
     * Returns the active Window.
     * The active Window is always either the focused Window, or the first
     * Window that is an owner of the focused Window.
     *
     * @return the active Window
     * @see #setActiveWindow()
	 */
	public function getActiveWindow():JWindow{
		return activeWindow;
	}
	
	/**
     * Sets the active Window. The active Window is always either the 
     * focused Window, or the first Window that is an owner of the focused Window.
     * <p>
     * This method does not actually change the active Window . 
     * It merely stores the value to be
     * subsequently returned by <code>getActiveWindow()</code>. Use
     * <code>Component.requestFocus()</code> or
     * <code>Component.requestFocusInWindow()</code> or
     * <code>JWindow.setActive()</code>to change the active
     * Window.
     *
     * @param activeWindow the active Window
     * @see #getActiveWindow()
     * @see Component#requestFocus()
     * @see Component#requestFocusInWindow()
     * @see JWindow#setActive()
	 */
	public function setActiveWindow(newActiveWindow:JWindow):void{
		activeWindow = newActiveWindow;
	}	
	
    /**
     * Focuses the Component after aComponent, typically based on a
     * FocusTraversalPolicy.
     *
     * @param aComponent the Component that is the basis for the focus
     *        traversal operation
     * @see FocusTraversalPolicy
     */
	public function focusNextOfComponent(aComponent:Component):void{
        if (aComponent != null) {
            aComponent.transferFocus();
        }
	}
	
    /**
     * Focuses the Component before aComponent, typically based on a
     * FocusTraversalPolicy.
     *
     * @param aComponent the Component that is the basis for the focus
     *        traversal operation
     * @see FocusTraversalPolicy
     */	
	public function focusPreviousOfComponent(aComponent:Component):void{ 
        if (aComponent != null) {
            aComponent.transferFocusBackward();
        }
	}

    /**
     * Focuses the Component after the current focus owner.
     * @see #focusNextOfComponent()
     */	
	public function focusNext():void{
		focusNextOfComponent(getFocusOwner());
	}
    /**
     * Focuses the Component before the current focus owner.
     * @see #focusPreviousOfComponent()
     */	
	public function focusPrevious():void{
		focusPreviousOfComponent(getFocusOwner());
	}
	
	/**
     * Returns the default FocusTraversalPolicy. Top-level components 
     * use this value on their creation to initialize their own focus traversal
     * policy by explicit call to Container.setFocusTraversalPolicy.
     *
     * @return the default FocusTraversalPolicy. null will never be returned.
     * @see #setDefaultFocusTraversalPolicy()
     * @see Container#setFocusTraversalPolicy()
     * @see Container#getFocusTraversalPolicy()
     */
	public function getDefaultFocusTraversalPolicy():FocusTraversalPolicy{
		return defaultPolicy;
	}

    /**
     * Sets the default FocusTraversalPolicy. Top-level components 
     * use this value on their creation to initialize their own focus traversal
     * policy by explicit call to Container.setFocusTraversalPolicy.
     * Note: this call doesn't affect already created components as they have 
     * their policy initialized. Only new components will use this policy as
     * their default policy.
     *
     * @param defaultPolicy the new, default FocusTraversalPolicy, if it is null, nothing will be done
     * @see #getDefaultFocusTraversalPolicy()
     * @see Container#setFocusTraversalPolicy()
     * @see Container#getFocusTraversalPolicy()
     */	
	public function setDefaultFocusTraversalPolicy(newDefaultPolicy:FocusTraversalPolicy):void{
		if (newDefaultPolicy != null){
			defaultPolicy = newDefaultPolicy;
		}
	}
}
}