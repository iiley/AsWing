/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{

import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import org.aswing.geom.*;
import flash.display.*;
import flash.geom.Point;	
	
public class AsWingUtils
{

    /**
     * A fast access to ASWingConstants Constant
     * @see org.aswing.ASWingConstants
     */
    public static var CENTER:Number  = AsWingConstants.CENTER;
    /**
     * A fast access to AsWingConstants Constant
     * @see org.aswing.AsWingConstants
     */
    public static var TOP:Number     = AsWingConstants.TOP;
    /**
     * A fast access to AsWingConstants Constant
     * @see org.aswing.AsWingConstants
     */
    public static var LEFT:Number    = AsWingConstants.LEFT;
    /**
     * A fast access to AsWingConstants Constant
     * @see org.aswing.AsWingConstants
     */
    public static var BOTTOM:Number  = AsWingConstants.BOTTOM;
    /**
     * A fast access to AsWingConstants Constant
     * @see org.aswing.AsWingConstants
     */
    public static var RIGHT:Number   = AsWingConstants.RIGHT;
    /**
     * A fast access to AsWingConstants Constant
     * @see org.aswing.AsWingConstants
     */        
    public static var HORIZONTAL:Number = AsWingConstants.HORIZONTAL;
    /**
     * A fast access to AsWingConstants Constant
     * @see org.aswing.AsWingConstants
     */
    public static var VERTICAL:Number   = AsWingConstants.VERTICAL;
    
    /**
     * Shared text field to count the text size
     */
    private static const TEXT_FIELD:TextField = new TextField();
    private static var TEXT_FORMAT:TextFormat = null;
    {
    	TEXT_FIELD.autoSize = TextFieldAutoSize.LEFT;
    	TEXT_FIELD.type = TextFieldType.DYNAMIC;
    }
    
    /**
     * Returns whethor or not the display object is showing, which means that 
     * it is visible and it's ancestors(parent, parent's parent ...) is visible and on stage too. 
     * @return trun if showing, not then false.
     */
    public static function isDisplayObjectShowing(dis:DisplayObject):Boolean{
    	if(dis == null || dis.stage == null){
    		return false;
    	}
    	while(dis != null && dis.visible == true){
    		if(dis == dis.stage){
    			return true;
    		}
    		dis = dis.parent;
    	}
    	return false;
    }
    
    /**
     * Returns whether or not the ancestor is the child's ancestor.
     * @return whether or not the ancestor is the child's ancestor.
     */
    public static function isAncestor(ancestor:Component, child:Component):Boolean{
    	var pa:DisplayObjectContainer = child.parent;
    	while(pa != null){
    		if(pa == ancestor){
    			return true;
    		}
    		pa = pa.parent;
    	}
    	return false;
    }
    
    /**
     * Returns the currently visible maximized bounds in a display object(viewable the stage area).
     * @param dis the display object
     */
    public static function getVisibleMaximizedBounds(dis:DisplayObject):IntRectangle{
    	var stage:Stage = dis == null ? null : dis.stage;
    	if(stage == null){
    		stage = AsWingManager.getStage();
    	}
    	if(stage == null){
    		return new IntRectangle(200, 200);
    	}
        var sw:Number = stage.width;
        var sh:Number = stage.height;
        var sa:String = stage.align;
        //TODO imp when stage resized
        var b:IntRectangle = new IntRectangle(0, 0, sw, sh);
        var p:Point = new Point(0, 0);
        dis.globalToLocal(p);
        b.setLocation(IntPoint.creatWithPoint(p));
        return b;
    }
    
    /**
     * Apply the font and color to the textfield.
     * @param text
     * @param font
     * @param color
     */
    public static function applyTextFontAndColor(text:TextField, font:ASFont, color:ASColor):void{
        applyTextFont(text, font);
        applyTextColor(text, color);
    }
    
    /**
     * 
     */
    public static function applyTextFont(text:TextField, font:ASFont):void{
    	font.apply(text);
    }
    
    /**
     * 
     */
    public static function applyTextFormat(text:TextField, textFormat:TextFormat):void{
    	text.setTextFormat(textFormat);
    }    
    
    /**
     * 
     */
    public static function applyTextColor(text:TextField, color:ASColor):void{
        if(text.textColor != color.getRGB()){
        	text.textColor = color.getRGB();
        }
        if(text.alpha != color.getAlpha()){
        	text.alpha = color.getAlpha();
        }
    }    
    
    /**
     * Compute and return the location of the icons origin, the
     * location of origin of the text baseline, and a possibly clipped
     * version of the compound labels string.  Locations are computed
     * relative to the viewR rectangle.
     */
    public static function layoutCompoundLabel(
    	f:ASFont, 
        text:String,
        icon:Icon,
        verticalAlignment:int,
        horizontalAlignment:int,
        verticalTextPosition:int,
        horizontalTextPosition:int,
        viewR:IntRectangle,
        iconR:IntRectangle,
        textR:IntRectangle,
        textIconGap:int):String
    {
    	var textFormat:TextFormat = f.getTextFormat();
        if (icon != null) {
            iconR.width = icon.getIconWidth();
            iconR.height = icon.getIconHeight();
        }else {
            iconR.width = iconR.height = 0;
        }
                
        var textIsEmpty:Boolean = (text==null || text=="");
        if(textIsEmpty){
            textR.width = textR.height = 0;
        }else{
        	var textS:IntDimension = computeStringSize(textFormat, text);
            textR.width = textS.width;
            textR.height = textS.height;
        }
        
         /* Unless both text and icon are non-null, we effectively ignore
         * the value of textIconGap.  The code that follows uses the
         * value of gap instead of textIconGap.
         */

        var gap:Number = (textIsEmpty || (icon == null)) ? 0 : textIconGap;
        
        if(!textIsEmpty){
            
            /* If the label text string is too wide to fit within the available
             * space "..." and as many characters as will fit will be
             * displayed instead.
             */
            var availTextWidth:Number;

            if (horizontalTextPosition == CENTER) {
                availTextWidth = viewR.width;
            }else {
                availTextWidth = viewR.width - (iconR.width + gap);
            }
            
            if (textR.width > availTextWidth) {
                text = layoutTextWidth(text, textR, availTextWidth, textFormat);
            }
        }

        /* Compute textR.x,y given the verticalTextPosition and
         * horizontalTextPosition properties
         */

        if (verticalTextPosition == TOP) {
            if (horizontalTextPosition != CENTER) {
                textR.y = 0;
            }else {
                textR.y = -(textR.height + gap);
            }
        }else if (verticalTextPosition == CENTER) {
            textR.y = (iconR.height / 2) - (textR.height / 2);
        }else { // (verticalTextPosition == BOTTOM)
            if (horizontalTextPosition != CENTER) {
                textR.y = iconR.height - textR.height;
            }else {
                textR.y = (iconR.height + gap);
            }
        }

        if (horizontalTextPosition == LEFT) {
            textR.x = -(textR.width + gap);
        }else if (horizontalTextPosition == CENTER) {
            textR.x = (iconR.width / 2) - (textR.width / 2);
        }else { // (horizontalTextPosition == RIGHT)
            textR.x = (iconR.width + gap);
        }
        

        //trace("textR : " + textR);
        //trace("iconR : " + iconR);    
        //trace("viewR : " + viewR);    

        /* labelR is the rectangle that contains iconR and textR.
         * Move it to its proper position given the labelAlignment
         * properties.
         *
         * To avoid actually allocating a Rectangle, Rectangle.union
         * has been inlined below.
         */
        var labelR_x:Number = Math.min(iconR.x, textR.x);
        var labelR_width:Number = Math.max(iconR.x + iconR.width, textR.x + textR.width) - labelR_x;
        var labelR_y:Number = Math.min(iconR.y, textR.y);
        var labelR_height:Number = Math.max(iconR.y + iconR.height, textR.y + textR.height) - labelR_y;
        
        //trace("labelR_x : " + labelR_x);
        //trace("labelR_width : " + labelR_width);  
        //trace("labelR_y : " + labelR_y);
        //trace("labelR_height : " + labelR_height);        
        
        var dx:Number = 0;
        var dy:Number = 0;

        if (verticalAlignment == TOP) {
            dy = viewR.y - labelR_y;
        }
        else if (verticalAlignment == CENTER) {
            dy = (viewR.y + (viewR.height/2)) - (labelR_y + (labelR_height/2));
        }
        else { // (verticalAlignment == BOTTOM)
            dy = (viewR.y + viewR.height) - (labelR_y + labelR_height);
        }

        if (horizontalAlignment == LEFT) {
            dx = viewR.x - labelR_x;
        }
        else if (horizontalAlignment == RIGHT) {
            dx = (viewR.x + viewR.width) - (labelR_x + labelR_width);
        }
        else { // (horizontalAlignment == CENTER)
            dx = (viewR.x + (viewR.width/2)) - (labelR_x + (labelR_width/2));
        }

        /* Translate textR and glypyR by dx,dy.
         */

        //trace("dx : " + dx);
        //trace("dy : " + dy);  
        
        textR.x += dx;
        textR.y += dy;

        iconR.x += dx;
        iconR.y += dy;
        
        //trace("tf = " + tf);

        //trace("textR : " + textR);
        //trace("iconR : " + iconR);        
        
        return text;
    }
        
    /**
     * Not include the gutters
     */
    public static function stringWidth(tf:TextFormat, ch:String):Number{
    	TEXT_FIELD.text = ch;
    	if(TEXT_FORMAT != tf){
    		TEXT_FIELD.setTextFormat(tf);
    		TEXT_FORMAT = tf;
    	}
        return TEXT_FIELD.textWidth;
    }
    
    /**
     * Not include the gutters
     */
    public static function stringSize(tf:TextFormat, str:String):IntDimension{
    	TEXT_FIELD.text = str;
    	if(TEXT_FORMAT != tf){
    		TEXT_FIELD.setTextFormat(tf);
    		TEXT_FORMAT = tf;
    	}
    	return new IntDimension(Math.ceil(TEXT_FIELD.textWidth), Math.ceil(TEXT_FIELD.textHeight));
    }
        
    public static function computeStringWidth(tf:TextFormat, str:String):Number{
    	TEXT_FIELD.text = str;
    	if(TEXT_FORMAT != tf){
    		TEXT_FIELD.setTextFormat(tf);
    		TEXT_FORMAT = tf;
    	}
        return TEXT_FIELD.width;
    }
    
    public static function computeStringHeight(tf:TextFormat, str:String):Number{
    	TEXT_FIELD.text = str;
    	if(TEXT_FORMAT != tf){
    		TEXT_FIELD.setTextFormat(tf);
    		TEXT_FORMAT = tf;
    	}
        return TEXT_FIELD.height;
    }
    
    public static function computeStringSize(tf:TextFormat, str:String):IntDimension{
    	TEXT_FIELD.text = str;
    	if(TEXT_FORMAT != tf){
    		TEXT_FIELD.setTextFormat(tf);
    		TEXT_FORMAT = tf;
    	}
    	return new IntDimension(Math.ceil(TEXT_FIELD.width), Math.ceil(TEXT_FIELD.height));
    }
    
    /**
     * before call this method textR.width must be filled with correct value of whole text.
     */
    public static function layoutTextWidth(text:String, textR:IntRectangle, availTextWidth:Number, tf:TextFormat):String{
        if (textR.width <= availTextWidth) {
            return text;
        }
        var clipString:String = "...";
        var totalWidth:int = Math.round(computeStringWidth(tf, clipString));
        if(totalWidth > availTextWidth){
            totalWidth = Math.round(computeStringWidth(tf, ".."));
            if(totalWidth > availTextWidth){
                text = ".";
                textR.width = Math.round(computeStringWidth(tf, "."));
                if(textR.width > availTextWidth){
                    textR.width = 0;
                    text = "";
                }
            }else{
                text = "..";
                textR.width = totalWidth;
            }
            return text;
        }else{
            var nChars:Number;
            var lastWidth:Number = totalWidth;
            
            
            //begin binary search
            var num:int = text.length;
            var li:int = 0; //binary search of left index 
            var ri:int = num; //binary search of right index
            
            while(li<ri){
                var i:Number = li + (ri - li)/2;
                var subText:String = text.substring(0, i);
                var length:int = Math.ceil(lastWidth + computeStringWidth(tf, subText));
                
                if((li == i - 1) && li>0){
                    if(length > availTextWidth){
                        subText = text.substring(0, li);
                        textR.width = Math.ceil(lastWidth + computeStringWidth(tf, text.substring(0, li)));
                    }else{
                        textR.width = length;
                    }
                    return subText + clipString;
                }else if(i <= 1){
                    if(length <= availTextWidth){
                        textR.width = length;
                        return subText + clipString;
                    }else{
                        textR.width = lastWidth;
                        return clipString;
                    }
                }
                
                if(length < availTextWidth){
                    li = i;
                }else if(length > availTextWidth){
                    ri = i;
                }else{
                    text = subText + clipString;
                    textR.width = length;
                    return text;
                }
            }
            //end binary search
            textR.width = lastWidth;
            return "";
        }
    }    
}

}