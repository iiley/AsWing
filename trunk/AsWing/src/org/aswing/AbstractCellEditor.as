/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing { 

import org.aswing.CellEditor;
import org.aswing.Component;
import org.aswing.Container;
import org.aswing.event.*;
import org.aswing.geom.*;
import org.aswing.table.TableCellEditor;
import org.aswing.util.ArrayUtils;
import org.aswing.error.ImpMissError;
import flash.events.Event;

/**
 * @author iiley
 */
public class AbstractCellEditor implements CellEditor, TableCellEditor{
	
	private var listeners:Array;
	private var clickCountToStart:int;
	
	public function AbstractCellEditor(){
		listeners = new Array();
		clickCountToStart = 0;
	}
	
    /**
     * Specifies the number of clicks needed to start editing.
     * Default is 0.(mean start after pressed)
     * @param count  an int specifying the number of clicks needed to start editing
     * @see #getClickCountToStart()
     */
    public function setClickCountToStart(count:Number):void {
		clickCountToStart = count;
    }

    /**
     * Returns the number of clicks needed to start editing.
     * @return the number of clicks needed to start editing
     */
    public function getClickCountToStart():Number {
		return clickCountToStart;
    }	
    
    /**
     * Calls the editor's component to update UI.
     */
    public function updateUI():void{
    	getEditorComponent().updateUI();
    }    
    
    public function getEditorComponent():Component{
		throw new ImpMissError();
		return null;
    }
	
	public function getCellEditorValue():* {		
		throw new ImpMissError();
	}
	
   /**
    * Sets the value of this cell. Subclass must override this method to 
    * make editor display this value.
    * @param value the new value of this cell
    */
	private function setCellEditorValue(value:*):void{		
		throw new ImpMissError();
	}

	public function isCellEditable(clickCount : int) : Boolean {
		return clickCount == clickCountToStart;
	}

	public function startCellEditing(owner : Container, value:*, bounds : IntRectangle) : void {
		var com:Component = getEditorComponent();
		com.removeEventListener(AWEvent.ACT, __editorComponentAct);
		com.removeEventListener(AWEvent.FOCUS_LOST, __editorComponentFocusLost);
		com.removeFromContainer();
		com.setBounds(bounds);
		owner.DC_addChild(com);
		setCellEditorValue(value);
		com.requestFocus();
		//if com is a container and can't has focus, then focus its first sub child.
		if(com is Container && !com.isFocusOwner()){
			var con:Container = Container(com);
			var sub:Component;
			sub = con.getFocusTraversalPolicy().getDefaultComponent(con);
			if(sub != null) sub.requestFocus();
			if(sub == null || !sub.isFocusOwner()){
				for(var i:int=0; i<con.getComponentCount(); i++){
					sub = con.getComponent(i);
					sub.requestFocus();
					if(sub.isFocusOwner()){
						break;
					}
				}
			}
		}
		com.addEventListener(AWEvent.ACT, __editorComponentAct);
		com.addEventListener(AWEvent.FOCUS_LOST, __editorComponentFocusLost);
		com.validate();
	}
	
	private function __editorComponentFocusLost(e:Event):void{
		cancelCellEditing();
	}
	
	private function __editorComponentAct(e:Event):void{
		stopCellEditing();
	}

	public function stopCellEditing() : Boolean {
		removeEditorComponent();
		fireEditingStopped();
		return true;
	}

	public function cancelCellEditing() : void {
		removeEditorComponent();
		fireEditingCanceled();
	}
	
	public function isCellEditing() : Boolean {
		var editorCom:Component = getEditorComponent();
		return editorCom != null && editorCom.isShowing();
	}

	public function addCellEditorListener(l : CellEditorListener) : void {
		listeners.push(l);
	}

	public function removeCellEditorListener(l : CellEditorListener) : void {
		ArrayUtils.removeFromArray(listeners, l);
	}
	
	protected function fireEditingStopped():void{
		for(var i:Number = listeners.length-1; i>=0; i--){
			var l:CellEditorListener = CellEditorListener(listeners[i]);
			l.editingStopped(this);
		}
	}
	protected function fireEditingCanceled():void{
		for(var i:Number = listeners.length-1; i>=0; i--){
			var l:CellEditorListener = CellEditorListener(listeners[i]);
			l.editingCanceled(this);
		}
	}
	
	protected function removeEditorComponent():void{
		getEditorComponent().removeFromContainer();
	}
}
}