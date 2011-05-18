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
	 * properties are copied to the font instance, so later change on the pass TextFormat will not affect the font.
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
	
	public function isBold():Boolean{
		return textFormat.bold;
	}
	
	public function changeBold(bold:Boolean):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.bold = bold;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isItalic():Boolean{
		return textFormat.italic;
	}
	
	public function changeItalic(italic:Boolean):ASFont{
		var tf:TextFormat = cloneTextFormat(textFormat);
		tf.italic = italic;
		return new ASFont(tf, 0, false, false, false, advancedProperties);
	}
	
	public function isUnderline():Boolean{
		return textFormat.underline;
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
	
	public function toString():String{
		return "ASFont[" 
		+ "textFormat : " + textFormat 
			+ "]";
	}
}

}