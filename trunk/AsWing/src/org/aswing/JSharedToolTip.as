/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{
	
/**
 * Shared instance Tooltip to saving instances.
 * @author iiley
 */
public class JSharedToolTip extends JToolTip{
	
	private static var sharedInstance:JSharedToolTip;
	
	private var targetedComponent:Component;
	
	public function JSharedToolTip() {
		super();
		setName("JSharedToolTip");
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
     * Registers a component for tooltip management.
     *
     * @param component  a <code>JComponent</code> object to add
     */
	public function registerComponent(c:Component):void{
		//TODO chech whether the week works
		listenOwner(c, true);
		if(getTargetComponent() == c){
			setTipText(c.getToolTipText());
		}
	}
	

    /**
     * Removes a component from tooltip control.
     *
     * @param component  a <code>JComponent</code> object to remove
     */
	public function unregisterComponent(c:Component):void{
		unlistenOwner(c);
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
	 * @param the JComponent being described
	 * @see #registerComponent()
	 */
	override public function setTargetComponent(c:Component):void{
		registerComponent(c);
	}
	
	/** 
	 * Returns the lastest targeted component. 
	 * @return the lastest targeted component. 
	 */
	override public function getTargetComponent():Component{
		return targetedComponent;
	}
	
	//-------------
	override protected function __compRollOver(source:Component):void{
		if(source.getToolTipText() != null && isWaitThenPopupEnabled()){
			targetedComponent = source;
			setTipText(targetedComponent.getToolTipText());
			startWaitToPopup();
		}
	}
	
	override protected function __compRollOut(source:Component):void{
		if(source == targetedComponent && isWaitThenPopupEnabled()){
			disposeToolTip();
			targetedComponent = null;
		}
	}	
}
}