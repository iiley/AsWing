/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	import flash.display.DisplayObject;
	
	
//--------------------------------------
//  Events
//--------------------------------------

/**
 * Dispatched when a component is added to a container. 
 * The following methods trigger this event: DisplayObjectContainer.addChild(), DisplayObjectContainer.addChildAt(). 
 *
 *  @eventType org.aswing.event.AWEvent.COM_ADDED
 */
[Event(name="comAdded", type="org.aswing.event.AWEvent")]

/**
 *  Dispatched when the component is moved.
 *
 *  @eventType org.aswing.event.AWEvent.COM_REMOVED
 */
[Event(name="comRemoved", type="org.aswing.event.AWEvent")]
	
/**
 * Container can contain many component to be his child, all children are in its bounds,
 * and it moved, all children moved. It be removed from stage all children will be removed from stage.
 * <p>
 * It for component like <code>DisplayObjectContainer</code> for <code>DisplayObject</code>.
 * </p>
 * @author iiley
 */	
public class Container extends Component
{

	private var children:Array;
	private var layout:LayoutManager;
		
	public function Container()
	{
		super();
		setName("Container");
		children = new Array();
		//TODO layout
		//layout = new EmptyLayout();
	}
	
	public function setLayout(layout:LayoutManager):void{
		this.layout = layout;
		revalidate();
	}
	
	public function getLayout():LayoutManager{
		return layout;
	}
	
    /** 
     * Invalidates the container.  The container and all parents
     * above it are marked as needing to be laid out.  This method can
     * be called often, so it needs to execute quickly.
     * @see #validate()
     * @see #doLayout()
     * @see org.aswing.LayoutManager
     */
    override public function invalidate():void {
    	layout.invalidateLayout(this);
    	super.invalidate();
    }
	
    /** 
     * Validates this container and all of its subcomponents.
     * <p>
     * The <code>validate</code> method is used to cause a container
     * to lay out its subcomponents again. It should be invoked when
     * this container's subcomponents are modified (added to or
     * removed from the container, or layout-related information
     * changed) after the container has been displayed.
     *
     * @see #append()
     * @see Component#invalidate()
     * @see org.aswing.Component#revalidate()
     */
    override public function validate():void {
    	if(!valid){
    		doLayout();
    		for(var i:int=0; i<children.length; i++){
    			children[i].validate();
    		}
    		valid = true;
    	}
    }
    
	/**
	 * layout this container
	 */
	public function doLayout():void{
		if(isDisplayable() && isVisible()){
			layout.layoutContainer(this);
		}
	}
	
	/**
	 * On Component just can add to one Container.
	 * So if the com has a parent, it will remove from its parent first, then add to 
	 * this container. 
	 * This method is as same as <code>insert(-1, com, constraints)</code>.
	 * @param com the component to be added
	 * @param constraints an object expressing layout contraints for this component
	 * @see #insert()
	 */
	public function append(com:Component, constraints:Object=null):void{
	    insertImp(-1, com, constraints);
	}
	
	/**
	 * Adds one or more component to the container with null constraints
	 * @see #append()
	 */
	public function appendAll(...coms):void{
		for each(var i:* in coms){
			var com:Component = i as Component;
			if(com != null){
				append(com);
			}
		}
	}
	
	/**
	 * Add component to spesified index.
	 * So if the com has a parent, it will remove from its parent first, then add to 
	 * this container. 
	 * @param i index the position at which to insert the component, or less than 0 value to append the component to the end 
	 * @param com the component to be added
	 * @param constraints an object expressing layout contraints for this component
	 * @throws Error when index > children count
	 * @throws Error when add container's parent(or itself) to itself
	 * @see Component#removeFromContainer()
	 * @see #append()
	 */
	public function insert(i:int, com:Component, constraints:Object=null):void{
		insertImp(i, com, constraints);
	}
	
	protected function insertImp(i:int, com:Component, constraints:Object):void{
		if(i > getComponentCount()){
			throw new Error("illegal component position when insert comp to container");
		}
		if(com is Container){
			for(var cn:Container = this; cn != null; cn = cn.getParent()) {
                if (cn == com) {
                	trace("adding container's parent to itself");
                	throw new Error("adding container's parent to itself");
                }
            }
		}
		if(com.getParent() != null){
			com.removeFromContainer();
		}
		if(i < 0){
			children.push(com);
			DC_addChild(com);
		}else{
			//TODO imp
			//DC_addChildAt(com, i);
			children.splice(i, 0, com);
		}
		layout.addLayoutComponent(com, (constraints == null) ? com.getConstraints() : constraints);
		//TODO event
		//dispatchEvent(createEventObj(ON_COM_ADDED, com));	
		
		if (valid) {
			invalidate();
	    }			
	}
	
	protected function DC_addChild(dis:DisplayObject):DisplayObject{
		return super.addChild(dis);
	}
	
	protected function DC_addChildAt(dis:DisplayObject, index:int):DisplayObject{
		return super.addChildAt(dis, index);
	}
	
	protected function getChildIndexWithComponentIndex(index:int):int{
		//TODO imp
		return 0;
	}
	
	/**
	 * Remove the specified child component.
	 * @return the component just removed, null if the component is not in this container.
	 */
	public function remove(com:Component):Component{
		var i:int = getIndex(com);
		if(i >= 0){
			return removeAt(i);
		}
		return null;
	}
	
	/**
	 * Remove the specified index child component.
	 * @param i the index of component.
	 * @return the component just removed. or null there is not component at this position.
	 */	
	public function removeAt(i:int):Component{
		if(i < 0){
			return null;
		}
		var com:Component = children[i];
		if(com != null){
			layout.removeLayoutComponent(com);
			children.splice(i, 1);
			//TODO ???
			//dispatchEvent(createEventObj(ON_COM_REMOVED, com));
			//com.destroy();
			//com.parent = null;
			
			if (valid) {
				invalidate();
		    }			
		}
		return com;
	}
	
	/**
	 * Remove all child components.
	 */
	public function removeAll():void{
		while(children.length > 0){
			removeAt(children.length - 1);
		}
	}
		
    /** 
     * Gets the nth(index) component in this container.
     * @param  n   the index of the component to get.
     * @return the n<sup>th</sup> component in this container. returned null if 
     * the index if out of bounds.  
     * @see #getComponentCount()
     */
	public function getComponent(index:int):Component{
		return children[index];
	}
	
	/**
	 * Returns the index of the child component in this container.
	 * @return the index of the specified child component.
	 * @see #getComponent()
	 */
	public function getIndex(com:Component):int{
		for(var i:int=0; i<children.length; i++){
			if(com == children[i]){
				return i;
			}
		}
		return -1;
	}
	
    /** 
     * Gets the number of components in this container.
     * @return    the number of components in this container.
     * @see       #getComponent()
     */	
	public function getComponentCount():int{
		return children.length;
	}
	
    /**
     * Checks if the component is contained in the component hierarchy of
     * this container.
     * @param c the component
     * @return     <code>true</code> if it is an ancestor; 
     *             <code>false</code> otherwise.
     */
    public function isAncestorOf(c:Component):Boolean{
		var p:Container = c.getParent();
		if (c == null || p == null) {
		    return false;
		}
		while (p != null) {
		    if (p == this) {
				return true;
		    }
		    p = p.getParent();
		}
		return false;
    }		
	
}

}