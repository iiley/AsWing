/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing
{
	
import flash.text.TextFormat;

/**
 * Font that specified the font name, size, style and whether or not embed.
 * @author iiley
 */
public class ASFont
{
	
 	private var name:String;
 	private var size:uint;
 	private var bold:Boolean;
 	private var italic:Boolean;
 	private var underline:Boolean;
 	private var embedFonts:Boolean;
 	
 	/**
 	 * Create a font.
 	 */
	public function ASFont(name:String="Tahoma", size:Number=11, bold:Boolean=false, italic:Boolean=false, underline:Boolean=false, embedFonts:Boolean=false){
		this.name = name;
		this.size = size;
		this.bold = bold;
		this.italic = italic;
		this.underline = underline;
		this.embedFonts = embedFonts;
	}
	
	public function getName():String{
		return name;
	}
	
	public function getSize():uint{
		return size;
	}
	
	public function isBold():Boolean{
		return bold;
	}
	
	public function isItalic():Boolean{
		return italic;
	}
	
	public function isUnderline():Boolean{
		return underline;
	}
	
	public function isEmbedFonts():Boolean{
		return embedFonts;
	}
	
	/**
	 * Return a new text format that contains the font properties.
	 * @return a new text format.
	 */
	public function getTextFormat():TextFormat{
		return new TextFormat(name, size, null, bold, italic, underline);
	}
}

}