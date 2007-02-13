/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event{

import flash.events.Event;

/**
 * The event for list selection change.
 * @see org.aswing.JList
 * @see org.aswing.ListSelectionModel
 * @author iiley
 */
public class ListSelectionEvent extends AWEvent{
		
	/**
     *  The <code>ListSelectionEvent.LIST_SELECTION_CHANGED</code> constant defines the value of the
     *  <code>type</code> property of the event object for a <code>listSelectionChanged</code> event.
     *
     *  <p>The properties of the event object have the following values:</p>
     *  <table class="innertable">
     *     <tr><th>Property</th><th>Value</th></tr>
     *     <tr><td><code>bubbles</code></td><td>false</td></tr>
     *     <tr><td><code>cancelable</code></td><td>false</td></tr>
     *     <tr><td><code>getFirstIndex()</code></td><td>the first changed index.</td></tr>
     *     <tr><td><code>getLastIndex()</code></td><td>the last changed index.</td></tr>
     *     <tr><td><code>currentTarget</code></td><td>The Object that defines the
     *       event listener that handles the event. For example, if you use
     *       <code>comp.addEventListener()</code> to register an event listener,
     *       comp is the value of the <code>currentTarget</code>. </td></tr>
     *     <tr><td><code>target</code></td><td>The Object that dispatched the event;
     *       it is not always the Object listening for the event.
     *       Use the <code>currentTarget</code> property to always access the
     *       Object listening for the event.</td></tr>
     *  </table>
     *
     *  @eventType listSelectionChanged
	 */
	public static const LIST_SELECTION_CHANGED:String = "listSelectionChanged";
	
	private var firstIndex:int;
	private var lastIndex:int;
	
	public function ListSelectionEvent(firstIndex:int, lastIndex:int){
		super(LIST_SELECTION_CHANGED);
		this.firstIndex = firstIndex;
		this.lastIndex = lastIndex;
	}
	
	/**
	 * Returns the first changed index(the begin).
	 * @returns the first changed index.
	 */
	public function getFirstIndex():int{
		return firstIndex;
	}
	
	/**
	 * Returns the last changed index(the end).
	 * @returns the last changed index.
	 */
	public function getLastIndex():int{
		return lastIndex;
	}
	
	override public function clone():Event{
		return new ListSelectionEvent(firstIndex, lastIndex);
	}
}
}