/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.events.Event;
import org.aswing.event.AWEvent;

public class DefaultComboBoxEditor extends EventDispatcher implements ComboBoxEditor{

    private var textField:JTextField;
    private var value:*;
    	
	public function DefaultComboBoxEditor(){
	}
	
	public function selectAll():void{
		getTextField().selectAll();
		//getTextField().makeFocus();
	}
	
	public function setValue(value:*):void{
		this.value = value;
		getTextField().setText(value+"");
	}
	
	public function addActionListener(listener:Function, priority:int=0, useWeakReference:Boolean=false):void{
		addEventListener(AWEvent.ACT, listener, false,  priority, useWeakReference);
	}
	
	public function getValue():*{
		return value;
	}
	
	public function removeActionListener(listener:Function):void{
		removeEventListener(AWEvent.ACT, listener, false);
	}
	
	public function setEditable(b:Boolean):void{
        getTextField().setEditable(b);
        getTextField().setEnabled(b);
	}
	
	public function getEditorComponent():Component{
		return getTextField();
	}
	
	public function isEditable():Boolean{
		return getTextField().isEditable();
	}

    override public function toString():String{
        return "DefaultComboBoxEditor[]";
    }	
    
    //------------------------------------------------------

    
    private function getTextField():JTextField{
        if(textField == null){
            textField = new JTextField(null, 1); //set rows 1 to ensure the JTextField has a perfer height when empty
            textField.setBorder(null);
            textField.setOpaque(false);
            textField.setFocusable(false);
            initHandler();
        }
        return textField;
    }

    private function initHandler():void{
        textField.addActionListener(__textFieldActed);
        textField.addEventListener(AWEvent.FOCUS_LOST, __grapValueFormText);
    }

    private function __grapValueFormText(e:Event):void{
        value = getTextField().getText();
    }

    private function __textFieldActed(e:Event):void{
        __grapValueFormText(null);
        dispatchEvent(new AWEvent(AWEvent.ACT));
    }   
}
}