/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import flash.events.TextEvent;
import flash.ui.Keyboard;
import flash.events.KeyboardEvent;

/**
 * 
 */	
public class JRootPane extends Container{
	
	private var defaultButton:JButton;
	//TODO imp
	private var menuBar:*;
	
	public function JRootPane(){
		super();
		addEventListener(TextEvent.TEXT_INPUT, __textInput, true);
		addEventListener(KeyboardEvent.KEY_DOWN, __keyDown, true);
	}
	
	public function setDefaultButton(button:JButton):void{
		defaultButton = button;
	}
	
	public function getDefaultButton():JButton{
		return defaultButton;
	}
	
	/**
	 * Sets the main menuBar of this root pane.(Main menu bar means that 
	 * if user press Alt key, the first menu of the menu bar will be actived)
	 * The menuBar must be located in this root pane(or in its child), 
	 * otherwise, it will not have the main menu bar ability.
	 * @menuBar the menu bar, or null 
	 */
	public function setMenuBar(menuBar:*):void{
		//TODO imp
	}
	
	//-------------------------------------------------------
	//        Event Handlers
	//-------------------------------------------------------
	
	private function __keyDown(e:KeyboardEvent):void{
		if(e.keyCode == Keyboard.ENTER){
			if(getDefaultButton() != null){
				getDefaultButton().doClick();
			}
		}
	}
	
	private function __textInput(e:TextEvent):void{
		if(KeyboardManager.getInstance().isKeyDown(Keyboard.CONTROL) 
			|| KeyboardManager.getInstance().isKeyDown(Keyboard.F12)){
				e.preventDefault();
			}
	}
}

}