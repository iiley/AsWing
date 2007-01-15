/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{

import flash.events.EventDispatcher;
import org.aswing.event.*;

/**
 * The default implementation of a <code>Button</code> component's data model.
 */
public class DefaultButtonModel extends EventDispatcher implements ButtonModel
{
	private var group:ButtonGroup;
	private var enabled:Boolean;
	private var rollOver:Boolean;
	private var armed:Boolean;
	private var pressed:Boolean;
	private var selected:Boolean;
	
	public function DefaultButtonModel(){
		super();
		enabled = true;
		rollOver = false;
		armed = false;
		pressed = false;
		selected = false;
	}
	
	
	public function isArmed():Boolean
	{
		return armed;
	}
	
	public function isRollOver():Boolean
	{
		return rollOver;
	}
	
	public function isSelected():Boolean
	{
		return selected;
	}
	
	public function isEnabled():Boolean
	{
		return enabled;
	}
	
	public function isPressed():Boolean
	{
		return pressed;
	}
	
	public function setEnabled(b:Boolean):void
	{
        if(isEnabled() == b) {
            return;
        }
            
        enabled = b;
        if (!b) {
            pressed = false;
            armed = false;
        }
            
        fireStateChanged();
	}
	
	public function setPressed(b:Boolean):void
	{
        if((isPressed() == b) || !isEnabled()) {
            return;
        }
        pressed = b;
        fireStateChanged();
	}
	
	public function setRollOver(b:Boolean):void
	{
        if((isRollover() == b) || !isEnabled()) {
            return;
        }
        rollOver = b;
        fireStateChanged();
	}
	
	public function setArmed(b:Boolean):void{
        if((isArmed() == b) || !isEnabled()) {
            return;
        }
            
        armed = b;
            
        fireStateChanged();
	}
	
	public function setSelected(b:Boolean):void
	{
        if (isSelected() == b) {
            return;
        }

        selected = b;
		
        fireStateChanged();
        fireSelectionChanged();
	}
	
	public function setGroup(group:ButtonGroup):void
	{
		this.group = group;
	}
	
	public function addSelectionListener(listener:Function, priority:int=0, useWeakReference:Boolean=false):void
	{
		addEventListener(AWEvent.SELECTION_CHANGED, listener, false, priority);
	}
	
	public function removeSelectionListener(listener:Function):void
	{
		removeEventListener(AWEvent.SELECTION_CHANGED, listener);
	}
	
	public function addStateListener(listener:Function, priority:int=0, useWeakReference:Boolean=false):void
	{
		addEventListener(AWEvent.STATE_CHANGED, listener, false, priority);
	}
	
	public function removeStateListener(listener:Function):void
	{
		removeEventListener(AWEvent.STATE_CHANGED, listener);
	}
}
}