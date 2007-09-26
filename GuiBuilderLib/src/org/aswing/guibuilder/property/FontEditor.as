package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.*;
import org.aswing.guibuilder.util.MathUtils;
import org.aswing.guibuilder.model.ProModel;
import flash.events.Event;
import org.aswing.guibuilder.FontChooser;

public class FontEditor implements PropertyEditor{
	
	private static var DEFAULT:ASFont = new ASFont();
	
	private var defaultRadio:JRadioButton;
	private var nullRadio:JRadioButton;
	private var button:JButton;
	private var pane:Container;
	private var font:ASFont;
	private var buttonFont:ASFont;
	
	public function FontEditor(){
		pane = new JPanel(new FlowLayout(FlowLayout.LEFT, 2, 0, false));
		button = new JButton("Default");
		buttonFont = button.getFont();
		defaultRadio = new JRadioButton("default");
		nullRadio = new JRadioButton("null");
		pane.appendAll(button, defaultRadio, nullRadio);
		defaultRadio.addActionListener(__default);
		nullRadio.addActionListener(__null);
		defaultRadio.setSelected(true);
		button.addActionListener(__showChooser);
	}
	
	private function __showChooser(e:Event):void{
		FontChooser.getIns().open(__choosed, font);
	}
	private function __choosed(f:ASFont):void{
		if(f){
			nullRadio.setSelected(false);
			defaultRadio.setSelected(false);
			font = f;
			applyProperty();
		}
	}
	
	private function __default(e:Event):void{
		nullRadio.setSelected(false);
		font = DEFAULT;
		applyProperty();
	}
	
	private function __null(e:Event):void{
		defaultRadio.setSelected(false);
		font = null;
		applyProperty();
	}	
	
	public function getDisplay():Component{
		return pane;
	}

	public function parseValue(xml:XML):*{
		if(xml.@value == "null"){
			return null;
		}
		var name:String = xml.@name;
		var size:int = MathUtils.parseInteger(xml.@size);
		var bold:Boolean = (xml.@bold == "true");
		var italic:Boolean = (xml.@italic == "true");
		var underline:Boolean = (xml.@underline == "true");
		var embedFonts:Boolean = (xml.@embedFonts == "true");
		var f:ASFont = new ASFont(name, size, bold, italic, underline, embedFonts);
		font = f;
		button.setText(name);
		button.setToolTipText(
			"Name: "+font.getName() 
			+ "\nSize: "+font.getSize()
			+ "\nBold: "+font.isBold()
			+ "\nItalic: "+font.isItalic()
			+ "\nUnderline: "+font.isUnderline()
			+ "\nEmbeded: "+font.isEmbedFonts());
		nullRadio.setSelected(false);
		defaultRadio.setSelected(false);
		return font;
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		if(value == null){
			xml.@value="null";
			return xml;
		}
		var f:ASFont = value;
		xml.@name = f.getName();
		xml.@size = f.getSize()+"";
		xml.@bold = f.isBold()+"";
		xml.@italic = f.isItalic()+"";
		xml.@underline = f.isUnderline()+"";
		xml.@embedFonts = f.isEmbedFonts()+"";
		return xml;
	}
	
	public function getCodeLines():Array{
		return null;
	}
	
	public function isSimpleOneLine():String{
		if(font == null){
			return "null";
		}
		return "new ASFont(" + font.getName()
				+ ", " + font.getSize() 
				+ ", " + font.isBold() 
				+ ", " + font.isItalic() 
				+ ", " + font.isUnderline()
				+ ", " + font.isEmbedFonts()
				 + ")";
	}		
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(font == DEFAULT){
			button.setText("Default");
			button.setToolTipText("The default font from LAF");
			apply(ProModel.NONE_VALUE_SET);
		}else if(font != null){
			apply(font);
			button.setText(font.getName());
			button.setToolTipText(
				"Name: "+font.getName() 
				+ "\nSize: "+font.getSize()
				+ "\nBold: "+font.isBold()
				+ "\nItalic: "+font.isItalic()
				+ "\nUnderline: "+font.isUnderline()
				+ "\nEmbeded: "+font.isEmbedFonts());
		}else{
			button.setText("Null");
			button.setToolTipText("Null mean inherit from parent");
			apply(null);
		}
	}
}
}