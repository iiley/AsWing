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
import org.aswing.plaf.BaseComponentUI;
import org.aswing.plaf.ButtonUI;
import org.aswing.AbstractButton;
import org.aswing.event.AWEvent;
import flash.text.TextField;
import flash.filters.BlurFilter;

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
		installDefaults(b);
		installComponents(b);
		installListeners(b);
	}
    
	override public function uninstallUI(c:Component):void{
		button = AbstractButton(c);
		uninstallDefaults(b);
		uninstallComponents(b);
		uninstallListeners(b);
 	}
 	
 	protected function installDefaults(b:AbstractButton):void{
        // load shared instance defaults
        var pp:String = getPropertyPrefix();
        if(!defaults_initialized) {
            defaultTextShiftOffset = getInt(pp + "textShiftOffset");
        	defaults_initialized = true;
        }
        
        if(b.getMargin() instanceof UIResource) {
            b.setMargin(getInsets(pp + "margin"));
        }
        
        LookAndFeel.installColorsAndFont(b, pp + "background", pp + "foreground", pp + "font");
        LookAndFeel.installBorder(b, pp + "border");
        LookAndFeel.installBasicProperties(b, pp);
        setTextShiftOffset();
 	}
	
 	protected function uninstallDefaults(b:AbstractButton):void{
 		LookAndFeel.uninstallBorder(b);
 	}
 	
 	protected function installComponents(b:AbstractButton):void{
 		textField = new TextField();
 		b.addChild(textField);
 	}
	
 	protected function uninstallComponents(b:AbstractButton):void{
 		b.removeChild(textField);
 	}
 	
 	protected function installListeners(b:AbstractButton):void{
 		b.addStateListener(stateListener);
 	}
	
 	protected function uninstallListeners(b:AbstractButton):void{
 		b.removeStateListener(stateListener);
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
    
    private function stateListener(e:AWEvent):void{
    	button.paintImmediately();
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
            c.getFont(), b.getText(), b.getIcon(), 
            b.getVerticalAlignment(), b.getHorizontalAlignment(),
            b.getVerticalTextPosition(), b.getHorizontalTextPosition(),
            viewRect, iconRect, textRect, 
	    	b.getText() == null ? 0 : b.getIconTextGap());
	   	
    	
    	paintIcon(b, g, iconRect);
    	
        if (text != null && text != ""){
        	if(b.getModel().isPressed()){
        		textRect.x += getTextShiftOffset();
        		textRect.y += getTextShiftOffset();
        	}
			paintText(b, textRect, text);
        }else{
        	textField.text = "";
        	textField.visible = false;
        }
    }
    
    /**
     * paint the text to specified button with specified bounds
     */
    private function paintText(b:AbstractButton, textRect:IntRectangle, text:String):void{
    	var model:ButtonModel = b.getModel();
    	var font:ASFont = b.getFont();
    	
		if(textField.text != text){
			textField.text = text;
		}
		if(!b.isFontValidated()){
			AsWingUtils.applyTextFont(textField, font);
			b.setFontValidated(true);
		}
    	ASWingUtils.applyTextColor(textField, color);
		textField.x = tRect.x;
		textField.y = tRect.y;
			    	
    	if(!model.isEnabled()){
    		textField.filters = [new BlurFilter()];
    	}
    }
    
    /**
     * paint the icon to specified button's mc with specified bounds
     */
    private function paintIcon(b:AbstractButton, g:Graphics2D, iconRect:IntRectangle):void{
        var model:ButtonModel = b.getModel();
        var icon:Icon = b.getIcon();
        var tmpIcon:Icon = null;
        
        var icons:Array = getIcons();
        for(var i:int=0; i<icons.length; i++){
        	var ico:Icon = icons[i];
        	ico.getDisplay().visible = false;
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
		} else if(b.isRolloverEnabled() && model.isRollover()) {
			if(model.isSelected()) {
				tmpIcon = b.getRolloverSelectedIcon();
			} else {
				tmpIcon = b.getRolloverIcon();
			}
		} else if(model.isSelected()) {
			tmpIcon = b.getSelectedIcon();
		}
              
		if(tmpIcon != null) {
			icon = tmpIcon;
		}
        icon.getDisplay().visible = true;
		if(model.isPressed() && model.isArmed()) {
			icon.updateIcon(c, g, iconRect.x + getTextShiftOffset(),
                        iconRect.y + getTextShiftOffset());
		}else{
			icon.updateIcon(c, g, iconRect.x, iconRect.y);
		}
    }
    
    protected function getIcons():Array{
    	var arr:Array = new Array();
    	if(button.getIcon() != null){
    		arr.push(button.getIcon());
    	}
    	if(button.getDisabledIcon()() != null){
    		arr.push(button.getDisabledIcon());
    	}
    	if(button.getSelectedIcon()() != null){
    		arr(button.getSelectedIcon());
    	}
    	if(button.getDisabledSelectedIcon()() != null){
    		arr.push(button.getDisabledSelectedIcon());
    	}
    	if(button.getRollOverIcon()() != null){
    		arr.push(button.getRollOverIcon());
    	}
    	if(button.getRollOverSelectedIcon()() != null){
    		arr.push(button.getRollOverSelectedIcon());
    	}
    	if(button.getPressedIcon()() != null){
    		arr.push(button.getPressedIcon());
    	}
    	return arr;
    }
    
	protected function paintBackGround(com:Component, g:Graphics2D, b:IntRectangle):void{
	}
        
    /**
     * Returns the a button's preferred size with specified icon and text.
     */
    /*private function getButtonPreferredSize(b:AbstractButton, icon:Icon, text:String):IntDimension{
    	viewRect.setRect(0, 0, 100000, 100000);
    	textRect.x = textRect.y = textRect.width = textRect.height = 0;
        iconRect.x = iconRect.y = iconRect.width = iconRect.height = 0;
        
        ASWingUtils.layoutCompoundLabel(
            b.getFont(), text, icon, 
            b.getVerticalAlignment(), b.getHorizontalAlignment(),
            b.getVerticalTextPosition(), b.getHorizontalTextPosition(),
            viewRect, iconRect, textRect, 
	    	b.getText() == null ? 0 : b.getIconTextGap()
        );
        /* The preferred size of the button is the size of 
         * the text and icon rectangles plus the buttons insets.
         */
        /*var size:Dimension;
        if(icon == null){
        	size = textRect.getSize();
        }else if(b.getText()==null || b.getText()==""){
        	size = iconRect.getSize();
        }else{
        	var r:Rectangle = iconRect.union(textRect);
        	size = r.getSize();
        }
        size = b.getInsets().getOutsideSize(size);
		if(b.getMargin() != null)
        	size = b.getMargin().getOutsideSize(size);
        return size;
    }*/
    /**
     * Returns the a button's minimum size with specified icon and text.
     */    
    /*private function getButtonMinimumSize(b:AbstractButton, icon:Icon, text:String):IntDimension{
        var size:Dimension = b.getInsets().getOutsideSize();
		if(b.getMargin() != null)
        	size = b.getMargin().getOutsideSize(size);
		return size;
    }    
    
    override public function getPreferredSize(c:Component):Dimension{
    	var b:AbstractButton = AbstractButton(c);
    	var icon:Icon = b.getIcon();
    	var text:String = b.getText();
    	return getButtonPreferredSize(b, icon, text);
    }

    override public function getMinimumSize(c:Component):Dimension{
    	var b:AbstractButton = AbstractButton(c);
    	var icon:Icon = b.getIcon();
    	var text:String = b.getText();
    	return getButtonMinimumSize(b, icon, text);
    }

    override public function getMaximumSize(c:Component):Dimension{
		return new Dimension(Number.MAX_VALUE, Number.MAX_VALUE);
    }   */     
}
}