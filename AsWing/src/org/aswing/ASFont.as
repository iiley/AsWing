/*
Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing{

import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

import org.aswing.geom.IntDimension;

/**
 * Font that specified the font name, size, style and whether or not embed.
 * @author iiley
 */
public class ASFont{
	
	private var textFormat:TextFormat;
	
	private var advancedProperties:ASFontAdvProperties;
	
	/**
	 * Create a font with properties or TextFormat.<br/>
	 * If you specified a TextFormat param, then the font can use be seen a full featured TextFormat font, notic, the 
	 * properties are copied to the font instance, so later change on the pass TextFormat will not affect the font. And, 
	 * notice that serveral calls at same frame, just the last font will take effet.
	 * @param nameOrTextFormat if it is a TextFormat, the font will use the TextFormat properties directly, so the follow size, bold, italic, 
	 * underline params will be ignored except embedFontsOrAdvancedPros
	 * @param size size
	 * @param bold bold
	 * @param italic italic
	 * @param underline underline
	 * @param embedFontsOrAdvancedPros a boolean to indicate whether or not embedFonts or 
	 * 			a <code>ASFontAdvProperties</code> instance.
	 * @see org.aswing.ASFontAdvProperties
	 */
	public function ASFont(nameOrTextFormat:*="Tahoma", size:Number=11, bold:Boolean=false, italic:Boolean=false, underline:Boolean=false, 
						   embedFontsOrAdvancedPros:*=null){
		if(embedFontsOrAdvancedPros is ASFontAdvProperties){
			advancedProperties = embedFontsOrAdvancedPros as ASFontAdvProperties;
		}else{
			advancedProperties = new ASFontAdvProperties(embedFontsOrAdvancedPros==true);
		}
		if(nameOrTextFormat is TextFormat){
			textFormat = cloneTextFormat(nameOrTextFormat);
		}else{
			textFormat = new TextFormat(
				nameOrTextFormat, size, null, bold, italic, underline,  
				"", "", TextFormatAlign.LEFT, 0, 0, 0, 0 
			);
		}
	}
	
	public function getName():String{
		return textFormat.font;
	}
	
	public function changeName(name:String):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.font = name;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function getSize():uint{
		return uint(textFormat.size);
	}
	
	public function changeSize(size:int):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.size = size;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isBold() : Boolean {
		return (textFormat.bold as Boolean);
	}
	
	public function changeBold(bold:Boolean):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.bold = bold;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isItalic() : Boolean {
		return (textFormat.italic as Boolean);
	}
	
	public function changeItalic(italic:Boolean):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.italic = italic;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isUnderline() : Boolean {
		return (textFormat.underline as Boolean);
	}
	
	public function changeUnderline(underline:Boolean):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.underline = underline;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isEmbedFonts():Boolean{
		return advancedProperties.isEmbedFonts();
	}
	
	public function getAdvancedProperties():ASFontAdvProperties{
		return advancedProperties;
	}
	
	/**
	 * Applys the font to the specified text field.
	 * @param textField the text filed to be applied font.
	 * @param beginIndex The zero-based index position specifying the first character of the desired range of text. 
	 * @param endIndex The zero-based index position specifying the last character of the desired range of text. 
	 */
	public function apply(textField:TextField, beginIndex:int=-1, endIndex:int=-1):void{
		advancedProperties.apply(textField);
		textField.setTextFormat(textFormat, beginIndex, endIndex);
		textField.defaultTextFormat = textFormat;
	}
	
	/**
	 * Return a new text format that contains the font properties.
	 * @return a new text format.
	 */
	public function createTextFormat():TextFormat{
		return cloneTextFormat(textFormat);
	}
	
	private function cloneTextFormat(tf:TextFormat):TextFormat{
		var newTF:TextFormat = new TextFormat();
		newTF.align = tf.align;
		newTF.blockIndent = tf.blockIndent;
		newTF.bold = tf.bold;
		newTF.bullet = tf.bullet;
		newTF.color = tf.color;
		newTF.font = tf.font;
		newTF.indent = tf.indent;
		newTF.italic = tf.italic;
		newTF.kerning = tf.kerning;
		newTF.leading = tf.leading;
		newTF.leftMargin = tf.leftMargin;
		newTF.letterSpacing = tf.letterSpacing;
		newTF.rightMargin = tf.rightMargin;
		newTF.size = tf.size;
		newTF.tabStops = tf.tabStops;
		newTF.target = tf.target;
		newTF.underline = tf.underline;
		newTF.url = tf.url;
		return newTF;
	}
	
	/**
	 * Computes text size with this font.
	 * @param text the text to be compute
	 * @includeGutters whether or not include the 2-pixels gutters in the result
	 * @return the computed size of the text
	 * @see org.aswing.AsWingUtils#computeStringSizeWithFont
	 */
	public function computeTextSize(text:String, includeGutters:Boolean=true):IntDimension{
		return AsWingUtils.computeStringSizeWithFont(this, text, includeGutters);
	}
	
	/**
	 * Clone a ASFont, most time you dont need to call this because ASFont 
	 * is un-mutable class, but to avoid UIResource, you can call this.
	 */
	public function clone():ASFont{
		return new ASFont(textFormat, 0, false, false, false, advancedProperties);
	}
	
	/**
	 * When this font will take over an old font to apply to TextField, need call this to combine/replace textFormat properties.
	 * <br/>
	 * Developer do not need to call this method, unless you are going to call apply() method manually.
	 * @return itself
	 */
	public function takeover(oldF:ASFont):ASFont{
		if(null == oldF || this == oldF){
			return this;
		}
		var tf:TextFormat = oldF.textFormat;
		if(null == textFormat.align){
			textFormat.align = tf.align;
		}
		if(null == textFormat.blockIndent){
			textFormat.blockIndent = tf.blockIndent;
		}
		if(null == textFormat.bold){
			textFormat.bold = tf.bold;
		}
		if(null == textFormat.bullet){
			textFormat.bullet = tf.bullet;
		}
		if(null == textFormat.color){
			textFormat.color = tf.color;
		}
		if(null == textFormat.font){
			textFormat.font = tf.font;
		}
		if(null == textFormat.indent){
			textFormat.indent = tf.indent;
		}
		if(null == textFormat.italic){
			textFormat.italic = tf.italic;
		}
		if(null == textFormat.kerning){
			textFormat.kerning = tf.kerning;
		}
		if(null == textFormat.leading){
			textFormat.leading = tf.leading;
		}
		if(null == textFormat.leftMargin){
			textFormat.leftMargin = tf.leftMargin;
		}
		if(null == textFormat.letterSpacing){
			textFormat.letterSpacing = tf.letterSpacing;
		}
		if(null == textFormat.rightMargin){
			textFormat.rightMargin = tf.rightMargin;
		}
		if(null == textFormat.size){
			textFormat.size = tf.size;
		}
		if(null == textFormat.tabStops){
			textFormat.tabStops = tf.tabStops;
		}
		if(null == textFormat.target){
			textFormat.target = tf.target;
		}
		if(null == textFormat.underline){
			textFormat.underline = tf.underline;
		}
		if(null == textFormat.url){
			textFormat.url = tf.url;
		}
		advancedProperties.takeover(oldF.advancedProperties);
		return this;
	}
	
	public function toString():String{
		return "ASFont[" 
		+ "textFormat : " + textFormat 
			+ "]";
	}
}

}