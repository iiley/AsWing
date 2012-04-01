/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing;

 
import org.aswing.error.Error; 
	
/**
 * Shared instance Tooltip to saving instances.
 * @author paling
 */
class JSharedToolTip extends JToolTip{
	
	private static var sharedInstance:JSharedToolTip;
	
	private var targetedComponent:Component;
	private var targetedQueue:IntHash<Component>;
	
	public function new() {
		super();
		setName("JSharedToolTip");
		targetedQueue = new IntHash<Component>();
	}
	
	/**
	 * Returns the shared JSharedToolTip instance.
	 * <p>
	 * You can create a your shared tool tip instance too, if you want to 
	 * shared by the default.
	 * </p>
	 * @return a singlton shared instance.
	 */
	public static function getSharedInstance():JSharedToolTip{
		if(sharedInstance == null){
			sharedInstance = new JSharedToolTip();
		}
		return sharedInstance;
	}
	
	/**
	 * Sets the shared JSharedToolTip instance.
	 * <p>
	 * You can only call this before any <code>getSharedInstance()</code> invoke, and 
	 * you can only set it once. This is means, you'd better to call this at the beginning 
	 * of your program.
	 * </p>
	 * @param ins the shared JSharedToolTip instance you want to use.
	 */
	public static function setSharedInstance(ins:JSharedToolTip):Void{
		if(sharedInstance!=null)	{
			throw new Error("sharedInstance is already set!");
		 
		}else{
			sharedInstance = ins;
		}
	}
	
    /**
     * Registers a component for tooltip management.
     *
     * @param c  a <code>Component</code> object to add.
     * @param (optional)tipText the text to show when tool tip display. If the c 
     * 		is a <code>Component</code> this param is useless, if the c is only a 
     * 		<code>Component</code> this param is required.
     */
	public function registerComponent(c:Component, tipText:String=null):Void{
		//TODO chech whether the week works
		if (!targetedQueue.exists(c.getAwmlIndex()))
		{
			targetedQueue.set( c.getAwmlIndex(), c);
			listenOwner(c, true); 
		}
		if(getTargetComponent() == c){
			setTipText(getTargetToolTipText(c));
		}
	}
	

    /**
     * Removes a component from tooltip control.
     *
     * @param component  a <code>Component</code> object to remove
     */
	public function unregisterComponent(c:Component):Void {
		if (targetedQueue.exists(c.getAwmlIndex()))
		{ 
			targetedQueue.remove(c.getAwmlIndex());
			//why
			//unlistenOwner(c); 
		} 
		
		if(getTargetComponent() == c){
			disposeToolTip();
			targetedComponent = null;
		}
	}
	
	/**
	 * Registers a component that the tooltip describes. 
	 * The component c may be null and will have no effect. 
	 * <p>
	 * This method is overrided just to call registerComponent of this class.
	 * @param the Component being described
	 * @see #registerComponent()
	 */
	override public function setTargetComponent(c:Component):Void{
		registerComponent(c);
	}
	
	/** 
	 * Returns the lastest targeted component. 
	 * @return the lastest targeted component. 
	 */
	override public function getTargetComponent():Component{
		return targetedComponent;
	}
	
	private function getTargetToolTipText(c:Component):String{
	 
			var co:Component = AsWingUtils.as(c,Component)	;
			return co.getToolTipText();
	 
	}
	
	//-------------
	override private function __compRollOver(source:Component):Void{
		var tipText:String= getTargetToolTipText(source);
		if(tipText != null && isWaitThenPopupEnabled()){
			targetedComponent = source;
			setTipText(tipText);
			startWaitToPopup();
		}
	}
	
	override private function __compRollOut(source:Component):Void{
		if(source == targetedComponent && isWaitThenPopupEnabled()){
			disposeToolTip();
			targetedComponent = null;
		}
	}	
}