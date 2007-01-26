/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{
	
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.events.Event;
import org.aswing.util.*;

/**
 * KeyboardController controlls the key map for the action firing.
 * <p>
 * Thanks Romain for his Fever{@link http://fever.riaforge.org} accelerator framworks implementation, 
 * this is a simpler implementation study from his.
 * 
 * @see org.aswing.KeyMap
 * @see org.aswing.KeyType
 * @author iiley
 */
public class KeyboardManager{
	
	private static var instance:KeyboardManager;
	
	private var keymaps:Vector;
	private var keySequence:Vector;
	private var selfKeyMap:KeyMap;
	private var checkMissedUpTimer:Timer;
	private var inited:Boolean;
	
	/**
	 * Singleton class, 
	 * Don't create instance directly, in stead you should call <code>getInstance()</code>.
	 */
	public function KeyboardManager(){
		inited = false;
		keymaps = new Vector();
		keySequence = new Vector();
		selfKeyMap = new KeyMap();
		registerKeyMap(selfKeyMap);
	}
	
	/**
	 * Returns the global keyboard controller.
	 */
	public static function getInstance():KeyboardManager{
		if(instance == null){
			instance = new KeyboardManager();
		}
		return instance;
	}
	
	/**
	 * Init the keyboad manager, it will only start works when it is inited.
	 * By default, it will be inited when a component is added to stage automatically.
	 */
	public function init(stage:Stage):void{
		if(!inited){
			inited = true;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, __onKeyUp);
			stage.addEventListener(Event.DEACTIVATE, __deactived);
			
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDownCap, true);
			//stage.addEventListener(KeyboardEvent.KEY_UP, __onKeyUpCap, true);
		}
	}
	
	/**
	 * Registers a key action map to the controller
	 */
	public function registerKeyMap(keyMap:KeyMap):void{
		if(!keymaps.contains(keyMap)){
			keymaps.append(keyMap);
		}
	}
	
	/**
	 * Unregisters a key action map to the controller
	 * @param keyMap the key map
	 */
	public function unregisterKeyMap(keyMap:KeyMap):void{
		keymaps.remove(keyMap);
	}
	
	/**
	 * Registers a key action to the default key map of this controller.
	 * @param key the key type
	 * @param action the action
	 * @see KeyMap#registerKeyAction()
	 */
	public function registerKeyAction(key:KeyType, action:Function):void{
		selfKeyMap.registerKeyAction(key, action);
	}
	
	/**
	 * Unregisters a key action to the default key map of this controller.
	 * @param key the key type
	 * @see KeyMap#unregisterKeyAction()
	 */
	public function unregisterKeyAction(key:KeyType):void{
		selfKeyMap.unregisterKeyAction(key);
	}
	
	/**
	 * Returns whether or not the key is down.
	 * @param the key code
	 * @return true if the specified key is down, false if not.
	 */
	public function isKeyDown(keyCode:uint):Boolean{
		return keySequence.contains(keyCode);
	}
		
	private function __onKeyDown(e:KeyboardEvent) : void {
		var code:uint = e.keyCode;
		if(!keySequence.contains(code)){
			keySequence.append(code);
		}
		var n:Number = keymaps.size();
		for(var i:Number=0; i<n; i++){
			var keymap:KeyMap = KeyMap(keymaps.get(i));
			keymap.fireKeyAction(keySequence.toArray());
		}
		if(!checkMissedUpTimer.isRunning()){
			checkMissedUpTimer.start();
		}
	}

	private function __onKeyUp(e:KeyboardEvent) : void {
		var code:uint = e.keyCode;
		keySequence.remove(code);
		if(keySequence.isEmpty()){
			checkMissedUpTimer.stop();
		}
	}
	
	private function __deactived(e:Event):void{
		keySequence.clear();
	}
}

}