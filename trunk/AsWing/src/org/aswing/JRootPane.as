/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import flash.ui.Keyboard;
import flash.events.*;
import flash.text.TextField;
import org.aswing.util.HashMap;

/**
 * The general AsWing window root container, it is the popup, window and frame's ancestor.
 * It manages the key accelerator and mnemonic for a pane.
 * @see #registerMnemonic()
 * @author iiley
 */	
public class JRootPane extends Container{
	
	private var defaultButton:JButton;
	private var mnemonics:HashMap;
	
	//TODO imp
	private var menuBar:*;
	
	public function JRootPane(){
		super();
		layout = new BorderLayout();
		mnemonics = new HashMap();
		addEventListener(TextEvent.TEXT_INPUT, __textInput, true);
		addEventListener(KeyboardEvent.KEY_DOWN, __keyDown, true);
		addEventListener(Event.REMOVED_FROM_STAGE, __removedFromStage);
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
	
	/**
	 * Register a button with its mnemonic.
	 */
	internal function registerMnemonic(button:AbstractButton):void{
		if(button.getMnemonic() >= 0){
			mnemonics.put(button.getMnemonic(), button);
		}
	}
	
	internal function unregisterMnemonic(button:AbstractButton):void{
		if(mnemonics.get(button.getMnemonic()) == button){
			mnemonics.remove(button.getMnemonic());
		}
	}
	
	//-------------------------------------------------------
	//        Event Handlers
	//-------------------------------------------------------
	
	private function __keyDown(e:KeyboardEvent):void{
		var code:uint = e.keyCode;
		if(code == Keyboard.ENTER){
			var dfBtn:AbstractButton = getDefaultButton();
			if(dfBtn != null){
				if(dfBtn.isShowing() && mnBtn.isEnabled()){
					dfBtn.doClick();
				}
				return;
			}
		}
		
		//try to trigger the mnemonic
		if(AsWingManager.getStage().focus is TextField){
			if(!KeyboardManager.getInstance().isMnemonicModifierDown()){
				return;
			}
		}
		var mnBtn:AbstractButton = mnemonics.getValue(int(code));
		if(mnBtn != null){
			if(mnBtn.isShowing() && mnBtn.isEnabled()){
				mnBtn.doClick();
			}
		}
	}
	
	private function __textInput(e:TextEvent):void{
		if(KeyboardManager.getInstance().isKeyDown(Keyboard.CONTROL) 
			|| KeyboardManager.getInstance().isMnemonicModifierDown()){
				e.preventDefault();
			}
	}
	
	private function __removedFromStage(e:Event):void{
		mnemonics.clear();
	}
}

}