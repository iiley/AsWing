/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic
{
	
import org.aswing.*;
import org.aswing.graphics.Graphics2D;
import org.aswing.geom.IntRectangle;
import org.aswing.geom.IntDimension;
import org.aswing.Component;
import org.aswing.plaf.*;
import org.aswing.event.AWEvent;
import flash.text.TextField;
import flash.filters.BlurFilter;
import flash.utils.getTimer;

/**
 * Basic Button implementation.
 * To implement a Diff button UI, generally you should:
 * <ul>
 * 	<li>override <code>paintBackGround</code> to paint different bg for you button
 * 	<li>implement a diff Border for it, and put it into UI defaults with "Button.border" as key.
 * 	<li>initialize differnt UI defaults for buttons in your LAF class, for example:  
 * 	Button.font, ToggleButton.backgound XxxButton.foreground...
 * </ul>
 * @author iiley
 */
public class BasicButtonUI extends BaseComponentUI implements ButtonUI
{
    
    // Offset controlled by set method 
    private var shiftOffset:Number;
    private var defaultTextShiftOffset:Number;

    // Has the shared instance defaults been initialized?
    private var defaults_initialized:Boolean;	
	protected var button:AbstractButton;
	
	protected var textField:TextField;
	
	public function BasicButtonUI(){
		super();
	}

    protected function getPropertyPrefix():String {
        return "Button.";
    }
    
	override public function installUI(c:Component):void{
		button = AbstractButton(c);
		installDefaults(button);
		installComponents(button);
		installListeners(button);
	}
    
	override public function uninstallUI(c:Component):void{
		button = AbstractButton(c);
		uninstallDefaults(button);
		uninstallComponents(button);
		uninstallListeners(button);
 	}
 	
 	protected function installDefaults(b:AbstractButton):void{
        // load shared instance defaults
        var pp:String = getPropertyPrefix();
        if(!defaults_initialized) {
            defaultTextShiftOffset = getInt(pp + "textShiftOffset");
        	defaults_initialized = true;
        }
        
        if(b.getMargin() is UIResource) {
            b.setMargin(getInsets(pp + "margin"));
        }
        
        LookAndFeel.installColorsAndFont(b, pp + "background", pp + "foreground", pp + "font");
        LookAndFeel.installBorderAndBFDecorators(b, pp + "border", pp+"bg", pp+"fg");
        LookAndFeel.installBasicProperties(b, pp);
        setTextShiftOffset();
        button.mouseChildren = false;
 	}
	
 	protected function uninstallDefaults(b:AbstractButton):void{
 		LookAndFeel.uninstallBorderAndBFDecorators(b);
 	}
 	
 	protected function installComponents(b:AbstractButton):void{
 		textField = new TextField();
 		textField.selectable = false;
 		textField.mouseEnabled = false;
 		textField.mouseWheelEnabled = false;
 		b.addChild(textField);
 	}
	
 	protected function uninstallComponents(b:AbstractButton):void{
 		b.removeChild(textField);
 	}
 	
 	protected function installListeners(b:AbstractButton):void{
 		b.addStateListener(__stateListener);
 	}
	
 	protected function uninstallListeners(b:AbstractButton):void{
 		b.removeStateListener(__stateListener);
 	}
 	
 	//-----------------------------------------------------
 	
    protected function clearTextShiftOffset():void{
        shiftOffset = 0;
    }
    
    protected function setTextShiftOffset():void{
        shiftOffset = defaultTextShiftOffset;
    }
    
    protected function getTextShiftOffset():int{
    	return shiftOffset;
    } 	
    
    //--------------------------------------------------------
    
    private function __stateListener(e:AWEvent):void{
    	button.repaint();
    }
    
    //--------------------------------------------------
    
    /* These rectangles/insets are allocated once for all 
     * ButtonUI.paint() calls.  Re-using rectangles rather than 
     * allocating them in each paint call substantially reduced the time
     * it took paint to run.  Obviously, this method can't be re-entered.
     */
	private static var viewRect:IntRectangle = new IntRectangle();
    private static var textRect:IntRectangle = new IntRectangle();
    private static var iconRect:IntRectangle = new IntRectangle();    

    override public function paint(c:Component, g:Graphics2D, r:IntRectangle):void{
    	super.paint(c, g, r);
    	var b:AbstractButton = AbstractButton(c);
    	
    	var insets:Insets = b.getMargin();
    	if(insets != null){
    		r = insets.getInsideBounds(r);
    	}
    	viewRect.setRect(r);
    	
    	textRect.x = textRect.y = textRect.width = textRect.height = 0;
        iconRect.x = iconRect.y = iconRect.width = iconRect.height = 0;

        // layout the text and icon
        var text:String = AsWingUtils.layoutCompoundLabel(
            c.getFont(), b.getText(), getIconToLayout(), 
            b.getVerticalAlignment(), b.getHorizontalAlignment(),
            b.getVerticalTextPosition(), b.getHorizontalTextPosition(),
            viewRect, iconRect, textRect, 
	    	b.getText() == null ? 0 : b.getIconTextGap());
	   	
    	
    	paintIcon(b, g, iconRect);
    	
        if (text != null && text != ""){
        	if(b.getModel().isArmed()){
        		textRect.x += getTextShiftOffset();
        		textRect.y += getTextShiftOffset();
        	}
			paintText(b, textRect, text);
        }else{
        	textField.text = "";
        	textField.visible = false;
        }
    }
    
    protected function getIconToLayout():Icon{
    	return button.getIcon();
    }
    
    /**
     * do nothing here, let background decorator to paint the background
     */
	override protected function paintBackGround(c:Component, g:Graphics2D, b:IntRectangle):void{
		//do nothing here, let background decorator to paint the background
	}    
    
    /**
     * paint the text to specified button with specified bounds
     */
    protected function paintText(b:AbstractButton, textRect:IntRectangle, text:String):void{
    	var model:ButtonModel = b.getModel();
    	var font:ASFont = b.getFont();
    	
		if(textField.text != text){
			textField.text = text;
		}
		if(!b.isFontValidated()){
			AsWingUtils.applyTextFont(textField, font);
			b.setFontValidated(true);
		}
    	AsWingUtils.applyTextColor(textField, button.getForeground());
		textField.x = textRect.x;
		textField.y = textRect.y;
			    	
    	if(!model.isEnabled()){
    		textField.filters = [new BlurFilter()];
    	}
    }
    
    /**
     * paint the icon to specified button's mc with specified bounds
     */
    protected function paintIcon(b:AbstractButton, g:Graphics2D, iconRect:IntRectangle):void{
        var model:ButtonModel = b.getModel();
        var icon:Icon = b.getIcon();
        var tmpIcon:Icon = null;
        
        var icons:Array = getIcons();
        for(var i:int=0; i<icons.length; i++){
        	var ico:Icon = icons[i];
			setIconVisible(ico, false);
        }
        
	    if(icon == null) {
	    	return;
	    }

		if(!model.isEnabled()) {
			if(model.isSelected()) {
				tmpIcon = b.getDisabledSelectedIcon();
			} else {
				tmpIcon = b.getDisabledIcon();
			}
		} else if(model.isPressed() && model.isArmed()) {
			tmpIcon = b.getPressedIcon();
			if(tmpIcon != null) {
				// revert back to 0 offset
				//clearTextShiftOffset();
			}
		} else if(b.isRollOverEnabled() && model.isRollOver()) {
			if(model.isSelected()) {
				tmpIcon = b.getRollOverSelectedIcon();
			} else {
				tmpIcon = b.getRollOverIcon();
			}
		} else if(model.isSelected()) {
			tmpIcon = b.getSelectedIcon();
		}
              
		if(tmpIcon != null) {
			icon = tmpIcon;
		}
		setIconVisible(icon, true);
		if(model.isPressed() && model.isArmed()) {
			icon.updateIcon(b, g, iconRect.x + getTextShiftOffset(),
                        iconRect.y + getTextShiftOffset());
		}else{
			icon.updateIcon(b, g, iconRect.x, iconRect.y);
		}
    }
    
    private function setIconVisible(icon:Icon, visible:Boolean):void{
    	if(icon.getDisplay() != null){
    		icon.getDisplay().visible = visible;
    	}
    }
    
    protected function getIcons():Array{
    	var arr:Array = new Array();
    	if(button.getIcon() != null){
    		arr.push(button.getIcon());
    	}
    	if(button.getDisabledIcon() != null){
    		arr.push(button.getDisabledIcon());
    	}
    	if(button.getSelectedIcon() != null){
    		arr.push(button.getSelectedIcon());
    	}
    	if(button.getDisabledSelectedIcon() != null){
    		arr.push(button.getDisabledSelectedIcon());
    	}
    	if(button.getRollOverIcon() != null){
    		arr.push(button.getRollOverIcon());
    	}
    	if(button.getRollOverSelectedIcon() != null){
    		arr.push(button.getRollOverSelectedIcon());
    	}
    	if(button.getPressedIcon() != null){
    		arr.push(button.getPressedIcon());
    	}
    	return arr;
    }
    
      
    /**
     * Returns the a button's preferred size with specified icon and text.
     */
    protected function getButtonPreferredSize(b:AbstractButton, icon:Icon, text:String):IntDimension{
    	viewRect.setRectXYWH(0, 0, 100000, 100000);
    	textRect.x = textRect.y = textRect.width = textRect.height = 0;
        iconRect.x = iconRect.y = iconRect.width = iconRect.height = 0;
        
        AsWingUtils.layoutCompoundLabel(
            b.getFont(), text, icon, 
            b.getVerticalAlignment(), b.getHorizontalAlignment(),
            b.getVerticalTextPosition(), b.getHorizontalTextPosition(),
            viewRect, iconRect, textRect, 
	    	b.getText() == null ? 0 : b.getIconTextGap()
        );
        /* The preferred size of the button is the size of 
         * the text and icon rectangles plus the buttons insets.
         */
        var size:IntDimension;
        if(icon == null){
        	size = textRect.getSize();
        }else if(b.getText()==null || b.getText()==""){
        	size = iconRect.getSize();
        }else{
        	var r:IntRectangle = iconRect.union(textRect);
        	size = r.getSize();
        }
        size = b.getInsets().getOutsideSize(size);
		if(b.getMargin() != null)
        	size = b.getMargin().getOutsideSize(size);
        return size;
    }
    
    /**
     * Returns the a button's minimum size with specified icon and text.
     */    
    protected function getButtonMinimumSize(b:AbstractButton, icon:Icon, text:String):IntDimension{
        var size:IntDimension = b.getInsets().getOutsideSize();
		if(b.getMargin() != null)
        	size = b.getMargin().getOutsideSize(size);
		return size;
    }    
    
    override public function getPreferredSize(c:Component):IntDimension{
    	var b:AbstractButton = AbstractButton(c);
    	return getButtonPreferredSize(b, getIconToLayout(), b.getText());
    }

    override public function getMinimumSize(c:Component):IntDimension{
    	var b:AbstractButton = AbstractButton(c);
    	return getButtonMinimumSize(b, getIconToLayout(), b.getText());
    }

    override public function getMaximumSize(c:Component):IntDimension{
		return IntDimension.createBigDimension();
    }
}
}