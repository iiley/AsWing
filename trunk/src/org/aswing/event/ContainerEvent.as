/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.event
{
	import org.aswing.Container;
	import org.aswing.Component;
	

/**
 * The Event class is used to Container events. 
 * @author iiley
 */
public class ContainerEvent extends AWEvent
{	
	private var container:Container;
	private var child:Component;
	
	/**
	 * Create an Container Event.
	 */
	public function ContainerEvent(type:String, container:Container, child:Component, 
					bubbles:Boolean=false, cancelable:Boolean=false){
		super(type, bubbles, cancelable);
		this.container = container;
		this.child = child;
	}
	
	/**
	 * Returns the container whos component child was just removed.
	 */
	public function getContainer():Container{
		return container;
	}
	
	/**
	 * Returns the child component was just removed from its parent container.
	 */
	public function getChild():Component{
		return child;
	}
}

}