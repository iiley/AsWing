/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
import flash.events.Event;
import flash.events.EventDispatcher;

import org.aswing.event.*;
import org.aswing.util.*;

/**
 * A generic implementation of SingleSelectionModel.
 * @author iiley
 */
public class DefaultSingleSelectionModel extends EventDispatcher implements SingleSelectionModel
{
	private var index:int;
	
	public function DefaultSingleSelectionModel(){
		index = -1;
	}
	
	public function getSelectedIndex() : int {
		return index;
	}

	public function setSelectedIndex(index : int) : void {
		if(this.index != index){
			this.index = index;
			fireChangeEvent();
		}
	}

	public function clearSelection() : void {
		setSelectedIndex(-1);
	}

	public function isSelected() : Boolean {
		return getSelectedIndex() != -1;
	}
	
	public function addStateListener(listener:Function, priority:int=0, useWeakReference:Boolean=false):void{
		this.addEventListener(InteractiveEvent.STATE_CHANGED, listener, false,  priority, useWeakReference);
	}
	
	public function removeStateListener(listener:Function):void{
		this.removeEventListener(InteractiveEvent.STATE_CHANGED, listener);
	}
	
	private function fireChangeEvent():void{
		dispatchEvent(new Event(InteractiveEvent.STATE_CHANGED));
	}
}
}