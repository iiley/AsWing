/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

/**
 * A FocusTraversalPolicy that determines traversal order based on the order
 * of child Components in a Container.
 * 
 * @author iiley 
 */
public class ContainerOrderFocusTraversalPolicy implements FocusTraversalPolicy{
		
	public function ContainerOrderFocusTraversalPolicy(){
	}
	
	public function getComponentAfter(c:Component):Component
	{
		var container:Container = c.getParent();
		if(container == null){
			return getFirstComponent(c as Container);
		}
		var index:int = container.getIndex(c);
		var n:int = container.getComponentCount();
		if(index >= 0){
			while((++index) < n){
				var nc:Component = getFocusableComponent(container.getComponent(index));
				if(nc != null){
					return nc;
				}
			}
		}
		//up circle
		return getComponentAfter(container);
	}
	
	public function getComponentBefore(c:Component):Component
	{
		var container:Container = c.getParent();
		if(container == null){
			return getLastComponent(c as Container);
		}
		var index:int = container.getIndex(c);
		while((--index) >= 0){
			var nc:Component = getFocusableComponent(container.getComponent(index));
			if(nc != null){
				return nc;
			}
		}
		//up circle
		return getComponentBefore(container);
	}
	
	/**
	 * This will return the first focusable component in the container.
	 * @return the default component to be focused.
	 */
	public function getDefaultComponent(container:Container):Component
	{
		return getFirstComponent(container);
	}
	
	/**
	 * Returns the first focusable component in the container.
	 */
	protected function getFirstComponent(container:Container):Component{
		if(container == null){
			return null;
		}
		var index:int = -1;
		var n:int = container.getComponentCount();
		while((++index) < n){
			var nc:Component = getFocusableComponent(container.getComponent(index));
			if(nc != null){
				return nc;
			}
		}
		//do not up cirle here
		return null;
	}
	
	/**
	 * Returns the last focusable component in the container.
	 */
	protected function getLastComponent(container:Container):Component{
		if(container == null){
			return null;
		}
		var index:int = container.getComponentCount();
		while((--index) >= 0){
			var nc:Component = getFocusableComponent(container.getComponent(index));
			if(nc != null){
				return nc;
			}
		}
		//do not up cirle here
		return null;
	}
	
	private function getFocusableComponent(c:Component):Component{
		if(c.isShowing() && c.isEnabled()){
			if(c.isFocusable()){
				return c;
			}else if(c is Container){//down circle
				var con:Container = c as Container;
				var conDefault:Component = con.getFocusTraversalPolicy().getDefaultComponent(con);
				if(conDefault != null){
					return conDefault;
				}
			}
		}
		return null;
	}
	
}
}