/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{

import org.aswing.event.AWEvent;
import org.aswing.plaf.*;
import org.aswing.error.ImpMissError;	
	
/**
 *  Dispatched when the button's state changed. the state is all about:
 * <ul>
 * <li>enabled</li>
 * <li>rollOver</li>
 * <li>pressed</li>
 * <li>released</li>
 * <li>selected</li>
 * </ul>
 * </p>
 *  @eventType org.aswing.event.AWEvent.STATE_CHANGED
 */
[Event(name="stateChanged", type="org.aswing.event.AWEvent")]
	
/**
 *  Dispatched when the button's selection changed.
 *  @eventType org.aswing.event.AWEvent.SELECTION_CHANGED
 */
[Event(name="selectionChanged", type="org.aswing.event.AWEvent")]

/**
 * Defines common behaviors for buttons and menu items.
 * @author iiley
 */
public class AbstractButton extends Component
{
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	public static const CENTER:Number  = AsWingConstants.CENTER;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	public static const TOP:Number     = AsWingConstants.TOP;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    public static const LEFT:Number    = AsWingConstants.LEFT;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    public static const BOTTOM:Number  = AsWingConstants.BOTTOM;
 	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
    public static const RIGHT:Number   = AsWingConstants.RIGHT;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */        
	public static const HORIZONTAL:Number = AsWingConstants.HORIZONTAL;
	/**
	 * A fast access to AsWingConstants Constant
	 * @see org.aswing.AsWingConstants
	 */
	public static const VERTICAL:Number   = AsWingConstants.VERTICAL;	
	

    /** The data model that determines the button's state. */
    private var model:ButtonModel;
    
    private var text:String;
    private var margin:Insets;
    private var defaultMargin:Insets;

    // Button icons
    private var       defaultIcon:Icon;
    private var       pressedIcon:Icon;
    private var       disabledIcon:Icon;

    private var       selectedIcon:Icon;
    private var       disabledSelectedIcon:Icon;

    private var       rolloverIcon:Icon;
    private var       rolloverSelectedIcon:Icon;
    
    // Display properties
    private var    paintBorder:Boolean;
    private var    rolloverEnabled:Boolean;

    // Icon/Label Alignment
    private var        verticalAlignment:Number;
    private var        horizontalAlignment:Number;
    
    private var        verticalTextPosition:Number;
    private var        horizontalTextPosition:Number;

    private var        iconTextGap:Number;	
	
	public function AbstractButton(text:String="", icon:Icon=null)
	{
		super();
		setName("AbstractButton");
		
    	paintBorder = true;
    	rolloverEnabled = false;
    	
    	verticalAlignment = CENTER;
    	horizontalAlignment = CENTER;
    	verticalTextPosition = CENTER;
    	horizontalTextPosition = RIGHT;
    	
    	iconTextGap = 2;
    	
    	setText(text);
    	setIcon(icon);
	}

    /**
     * Returns the model that this button represents.
     * @return the <code>model</code> property
     * @see #setModel()
     */
    public function getModel():ButtonModel{
        return model;
    }
    
    /**
     * Sets the model that this button represents.
     * @param m the new <code>ButtonModel</code>
     * @see #getModel()
     */
    public function setModel(newModel:ButtonModel):void {
        
        var oldModel:ButtonModel = getModel();
        
        if (oldModel != null) {
            oldModel.removeStateListener(__modelStateListener);
            oldModel.removeSelectionListener(__modelSelectionListener);
        }
        
        model = newModel;
        
        if (newModel != null) {
            newModel.addStateListener(__modelStateListener);
            newModel.addSelectionListener(__modelSelectionListener);
        }

        if (newModel != oldModel) {
            revalidate();
            repaint();
        }
    }
        
    /**
     * Returns the L&F object that renders this component.
     * @return the ButtonUI object
     * @see #setUI()
     */
	override public function getUI():ComponentUI {
        return ButtonUI(ui);
    }

    
    /**
     * Sets the L&F object that renders this component.
     * @param ui the <code>ButtonUI</code> L&F object
     * @see #getUI()
     */
    override public function setUI(ui:ComponentUI):void {
        super.setUI(ui);
    }

    
    /**
     * Resets the UI property to a value from the current look
     * and feel.  Subtypes of <code>AbstractButton</code>
     * should override this to update the UI. For
     * example, <code>JButton</code> might do the following:
     * <pre>
     *      setUI(ButtonUI(UIManager.getUI(this)));
     * </pre>
     */
    override public function updateUI():void{
    	throw new ImpMissError();
    }
    
    /**
     * Adds a action listener to this button. Buttons fire a action event when 
     * user clicked on it.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.AWEvent#ACT
     */
    public function addActionListener(listener:Function, priority:int=0, useWeakReference:Boolean=false):void{
    	addEventListener(AWEvent.ACT, listener, false, priority, useWeakReference);
    }
	/**
	 * Removes a action listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.AWEvent#ACT
	 */
	public function removeActionListener(listener:Function):void{
		removeEventListener(AWEvent.ACT, listener);
	}    
    	
	/**
	 * Add a listener to listen the button's selection change event.
	 * When the button's selection changed, fired when diselected or selected.
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.AWEvent#SELECTION_CHANGED
	 */	
	public function addSelectionListener(listener:Function, priority:int=0, useWeakReference:Boolean=false):void{
		addEventListener(AWEvent.SELECTION_CHANGED, listener, false, priority);
	}

	/**
	 * Removes a selection listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.AWEvent#SELECTION_CHANGED
	 */
	public function removeSelectionListener(listener:Function):void{
		removeEventListener(AWEvent.SELECTION_CHANGED, listener);
	}
	
	/**
	 * Adds a listener to listen the button's state change event.
	 * <p>
	 * When the button's state changed, the state is all about:
	 * <ul>
	 * <li>enabled</li>
	 * <li>rollOver</li>
	 * <li>pressed</li>
	 * <li>released</li>
	 * <li>selected</li>
	 * </ul>
	 * </p>
	 * @param listener the listener
	 * @param priority the priority
	 * @param useWeakReference Determines whether the reference to the listener is strong or weak.
	 * @see org.aswing.event.AWEvent#STATE_CHANGED
	 */	
	public function addStateListener(listener:Function, priority:int=0, useWeakReference:Boolean=false):void{
		addEventListener(AWEvent.STATE_CHANGED, listener, false, priority);
	}	
	
	/**
	 * Removes a state listener.
	 * @param listener the listener to be removed.
	 * @see org.aswing.event.AWEvent#STATE_CHANGED
	 */	
	public function removeStateListener(listener:Function):void{
		removeEventListener(AWEvent.STATE_CHANGED, listener);
	}
	
    /**
     * Enabled (or disabled) the button.
     * @param b  true to enable the button, otherwise false
     */
	override public function setEnabled(b:Boolean):void{
		if (!b && model.isRollOver()) {
	    	model.setRollOver(false);
		}
        super.setEnabled(b);
        model.setEnabled(b);
    }    

    /**
     * Returns the state of the button. True if the
     * toggle button is selected, false if it's not.
     * @return true if the toggle button is selected, otherwise false
     */
    public function isSelected():Boolean{
        return model.isSelected();
    }
    
    /**
     * Sets the state of the button. Note that this method does not
     * trigger an Event for users.
     * Call <code>click</code> to perform a programatic action change.
     *
     * @param b  true if the button is selected, otherwise false
     */
    public function setSelected(b:Boolean):void{
        model.setSelected(b);
    }
    
    /**
     * Sets the <code>rolloverEnabled</code> property, which
     * must be <code>true</code> for rollover effects to occur.
     * The default value for the <code>rolloverEnabled</code>
     * property is <code>false</code>.
     * Some look and feels might not implement rollover effects;
     * they will ignore this property.
     * 
     * @param b if <code>true</code>, rollover effects should be painted
     * @see #isRollOverEnabled()
     */
    public function setRollOverEnabled(b:Boolean):void{
    	if(rolloverEnabled != b){
    		rolloverEnabled = b;
    		repaint();
    	}
    }
    
    /**
     * Gets the <code>rolloverEnabled</code> property.
     *
     * @return the value of the <code>rolloverEnabled</code> property
     * @see #setRollOverEnabled()
     */    
    public function isRollOverEnabled():Boolean{
    	return rolloverEnabled;
    }

	/**
	 * Sets space for margin between the button's border and
     * the label. Setting to <code>null</code> will cause the button to
     * use the default margin.  The button's default <code>Border</code>
     * object will use this value to create the proper margin.
     * However, if a non-default border is set on the button, 
     * it is that <code>Border</code> object's responsibility to create the
     * appropriate margin space (else this property will
     * effectively be ignored).
     *
     * @param m the space between the border and the label
	 */
	public function setMargin(m:Insets):void{
        // Cache the old margin if it comes from the UI
        if(m is UIResource) {
            defaultMargin = m;
        }
        
        // If the client passes in a null insets, restore the margin
        // from the UI if possible
        if(m == null && defaultMargin != null) {
            m = defaultMargin;
        }

        var old:Insets = margin;
        margin = m;
        if (old == null || !m.equals(old)) {
            revalidate();
        	repaint();
        }
	}
	
	public function getMargin():Insets{
		var m:Insets = margin;
		if(margin == null){
			m = defaultMargin;
		}
		if(m == null || m is UIResource){//make it can be replaced by LAF
			return new InsetsUIResource(m.top, m.left, m.bottom, m.right);
		}else{
			return new Insets(m.top, m.left, m.bottom, m.right);
		}
	}
		
	public function setText(text:String):void{
		if(this.text != text){
			this.text = text;
			repaint();
			invalidate();
		}
	}
	
	public function getText():String{
		return text;
	}
	
	public function setIcon(defaultIcon:Icon):void{
		if(this.defaultIcon != defaultIcon){
			removeChild(this.defaultIcon.getDisplay());
			this.defaultIcon = defaultIcon;
			addChild(this.defaultIcon.getDisplay());
			repaint();
			invalidate();
		}
	}

	public function getIcon():Icon{
		return defaultIcon;
	}
    
    /**
     * Returns the pressed icon for the button.
     * @return the <code>pressedIcon</code> property
     * @see #setPressedIcon()
     */
    public function getPressedIcon():Icon {
        return pressedIcon;
    }
    
    /**
     * Sets the pressed icon for the button.
     * @param pressedIcon the icon used as the "pressed" image
     * @see #getPressedIcon()
     */
    public function setPressedIcon(pressedIcon:Icon):void {
        var oldValue:Icon = this.pressedIcon;
        this.pressedIcon = pressedIcon;
        if (pressedIcon != oldValue) {
        	removeChild(oldValue.getDisplay());
        	addChild(pressedIcon.getDisplay());
			//if (getModel().isPressed()) {
                repaint();
            //}
        }
    }

    /**
     * Returns the selected icon for the button.
     * @return the <code>selectedIcon</code> property
     * @see #setSelectedIcon()
     */
    public function getSelectedIcon():Icon {
        return selectedIcon;
    }
    
    /**
     * Sets the selected icon for the button.
     * @param selectedIcon the icon used as the "selected" image
     * @see #getSelectedIcon()
     */
    public function setSelectedIcon(selectedIcon:Icon):void {
        var oldValue:Icon = this.selectedIcon;
        this.selectedIcon = selectedIcon;
        if (selectedIcon != oldValue) {
        	removeChild(oldValue.getDisplay());
        	addChild(selectedIcon.getDisplay());
            //if (isSelected()) {
                repaint();
            //}
        }
    }

    /**
     * Returns the rollover icon for the button.
     * @return the <code>rolloverIcon</code> property
     * @see #setRollOverIcon()
     */
    public function getRollOverIcon():Icon {
        return rolloverIcon;
    }
    
    /**
     * Sets the rollover icon for the button.
     * @param rolloverIcon the icon used as the "rollover" image
     * @see #getRollOverIcon()
     */
    public function setRollOverIcon(rolloverIcon:Icon):void {
        var oldValue:Icon = this.rolloverIcon;
        this.rolloverIcon = rolloverIcon;
        setRollOverEnabled(true);
        if (rolloverIcon != oldValue) {
        	removeChild(oldValue.getDisplay());
        	addChild(rolloverIcon.getDisplay());
			//if(getModel().isRollOver()){
            	repaint();
            //}
        }
      
    }
    
    /**
     * Returns the rollover selection icon for the button.
     * @return the <code>rolloverSelectedIcon</code> property
     * @see #setRollOverSelectedIcon()
     */
    public function getRollOverSelectedIcon():Icon {
        return rolloverSelectedIcon;
    }
    
    /**
     * Sets the rollover selected icon for the button.
     * @param rolloverSelectedIcon the icon used as the
     *		"selected rollover" image
     * @see #getRollOverSelectedIcon()
     */
    public function setRollOverSelectedIcon(rolloverSelectedIcon:Icon):void {
        var oldValue:Icon = this.rolloverSelectedIcon;
        this.rolloverSelectedIcon = rolloverSelectedIcon;
        setRollOverEnabled(true);
        if (rolloverSelectedIcon != oldValue) {
        	removeChild(oldValue.getDisplay());
        	addChild(rolloverSelectedIcon.getDisplay());
            //if (isSelected()) {
                repaint();
            //}
        }
    }
    
    /**
     * Returns the icon used by the button when it's disabled.
     * If no disabled icon has been set, the button constructs
     * one from the default icon. 
     * <p>
     * The disabled icon really should be created 
     * (if necessary) by the L&F.-->
     *
     * @return the <code>disabledIcon</code> property
     * @see #getPressedIcon()
     * @see #setDisabledIcon()
     */
    public function getDisabledIcon():Icon {
        if(disabledIcon == null) {
            if(defaultIcon != null) {
            	//TODO imp with UIResource??
                //return new GrayFilteredIcon(defaultIcon);
                return defaultIcon;
            }
        }
        return disabledIcon;
    }
    
    /**
     * Sets the disabled icon for the button.
     * @param disabledIcon the icon used as the disabled image
     * @see #getDisabledIcon()
     */
    public function setDisabledIcon(disabledIcon:Icon):void {
        var oldValue:Icon = this.disabledIcon;
        this.disabledIcon = disabledIcon;
        if (disabledIcon != oldValue) {
        	removeChild(oldValue.getDisplay());
        	addChild(disabledIcon.getDisplay());
            //if (!isEnabled()) {
                repaint();
            //}
        }
    }
    
    /**
     * Returns the icon used by the button when it's disabled and selected.
     * If not no disabled selection icon has been set, the button constructs
     * one from the selection icon. 
     * <p>
     * The disabled selection icon really should be 
     * created (if necessary) by the L&F. -->
     *
     * @return the <code>disabledSelectedIcon</code> property
     * @see #getPressedIcon()
     * @see #setDisabledIcon()
     */
    public function getDisabledSelectedIcon():Icon {
        if(disabledSelectedIcon == null) {
            if(selectedIcon != null) {
            	//TODO imp with UIResource??
                //disabledSelectedIcon = new GrayFilteredIcon(selectedIcon);
            } else {
                return getDisabledIcon();
            }
        }
        return disabledSelectedIcon;
    }

    /**
     * Sets the disabled selection icon for the button.
     * @param disabledSelectedIcon the icon used as the disabled
     * 		selection image
     * @see #getDisabledSelectedIcon()
     */
    public function setDisabledSelectedIcon(disabledSelectedIcon:Icon):void {
        var oldValue:Icon = this.disabledSelectedIcon;
        this.disabledSelectedIcon = disabledSelectedIcon;
        if (disabledSelectedIcon != oldValue) {
        	removeChild(oldValue.getDisplay());
        	addChild(disabledSelectedIcon.getDisplay());
            //if (!isEnabled() && isSelected()) {
                repaint();
                revalidate();
            //}
        }
    }

    /**
     * Returns the vertical alignment of the text and icon.
     *
     * @return the <code>verticalAlignment</code> property, one of the
     *		following values: 
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function getVerticalAlignment():Number {
        return verticalAlignment;
    }
    
    /**
     * Sets the vertical alignment of the icon and text.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function setVerticalAlignment(alignment:Number):void {
        if (alignment == verticalAlignment){
        	return;
        }else{
        	verticalAlignment = alignment;
        	repaint();
        }
    }
    
    /**
     * Returns the horizontal alignment of the icon and text.
     * @return the <code>horizontalAlignment</code> property,
     *		one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     */
    public function getHorizontalAlignment():Number{
        return horizontalAlignment;
    }
    
    /**
     * Sets the horizontal alignment of the icon and text.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     */
    public function setHorizontalAlignment(alignment:Number):void {
        if (alignment == horizontalAlignment){
        	return;
        }else{
        	horizontalAlignment = alignment;     
        	repaint();
        }
    }

    
    /**
     * Returns the vertical position of the text relative to the icon.
     * @return the <code>verticalTextPosition</code> property, 
     *		one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER  (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function getVerticalTextPosition():Number{
        return verticalTextPosition;
    }
    
    /**
     * Sets the vertical position of the text relative to the icon.
     * @param alignment  one of the following values:
     * <ul>
     * <li>AsWingConstants.CENTER (the default)
     * <li>AsWingConstants.TOP
     * <li>AsWingConstants.BOTTOM
     * </ul>
     */
    public function setVerticalTextPosition(textPosition:Number):void {
        if (textPosition == verticalTextPosition){
	        return;
        }else{
        	verticalTextPosition = textPosition;
        	repaint();
        }
    }
    
    /**
     * Returns the horizontal position of the text relative to the icon.
     * @return the <code>horizontalTextPosition</code> property, 
     * 		one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     */
    public function getHorizontalTextPosition():Number {
        return horizontalTextPosition;
    }
    
    /**
     * Sets the horizontal position of the text relative to the icon.
     * @param textPosition one of the following values:
     * <ul>
     * <li>AsWingConstants.RIGHT (the default)
     * <li>AsWingConstants.LEFT
     * <li>AsWingConstants.CENTER
     * </ul>
     */
    public function setHorizontalTextPosition(textPosition:Number):void {
        if (textPosition == horizontalTextPosition){
        	return;
        }else{
        	horizontalTextPosition = textPosition;
        	repaint();
        }
    }
    
    /**
     * Returns the amount of space between the text and the icon
     * displayed in this button.
     *
     * @return an int equal to the number of pixels between the text
     *         and the icon.
     * @see #setIconTextGap()
     */
    public function getIconTextGap():Number {
        return iconTextGap;
    }

    /**
     * If both the icon and text properties are set, this property
     * defines the space between them.  
     * <p>
     * The default value of this property is 4 pixels.
     * 
     * @see #getIconTextGap()
     */
    public function setIconTextGap(iconTextGap:Number):void {
        var oldValue:Number = this.iconTextGap;
        this.iconTextGap = iconTextGap;
        if (iconTextGap != oldValue) {
            revalidate();
            repaint();
        }
    }
    
    //--------------------------------------------------------------
    //			internal handlers
    //--------------------------------------------------------------
	
	private function __modelStateListener():void{
		dispatchEvent(new AWEvent(AWEvent.STATE_CHANGED));
	}
	
	private function __modelSelectionListener():void{
		dispatchEvent(new AWEvent(AWEvent.SELECTION_CHANGED));
	}
	
}

}