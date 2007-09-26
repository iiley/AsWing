package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.*;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.util.MathUtils;
import org.aswing.colorchooser.JColorSwatches;
import org.aswing.colorchooser.JColorMixer;
import org.aswing.border.BevelBorder;
import org.aswing.event.InteractiveEvent;

public class ColorEditor implements PropertyEditor{
	
	private static var DEFAULT:ASColor = new ASColor();
	
	private var colorButton:JButton;
	private var colorIcon:ColorIcon;
	private var defaultRadio:JRadioButton;
	private var nullRadio:JRadioButton;
	private var pane:Container;
	private var color:ASColor;
	
	private var colorSwatches:JColorSwatches;
	private var colorMixer:JColorChooser;
	private var swatchesWindow:JWindow;
	private var mixerWindow:JFrame;
	private var mixerButton:JButton;
	
	public function ColorEditor(nonull:String=null){
		pane = new JPanel(new FlowLayout(FlowLayout.LEFT, 2, 0, false));
		colorIcon = new ColorIcon();
		colorButton = new JButton(null, colorIcon);
		defaultRadio = new JRadioButton("default");
		nullRadio = new JRadioButton("null");
		pane.appendAll(colorButton, defaultRadio, nullRadio);
		defaultRadio.addActionListener(__default);
		nullRadio.addActionListener(__null);
		colorButton.addActionListener(__chooseColor);
		defaultRadio.setSelected(true);
		if(nonull == "nonull"){
			nullRadio.setVisible(false);
		}
	}
	
	private var settingColor:Boolean = false;
	private function __chooseColor(e:Event):void{
		checkInitColorChoosers();
		settingColor = true;
		colorSwatches.setSelectedColor(color);
		settingColor = false;
		swatchesWindow.show();
		AsWingUtils.centerLocate(swatchesWindow);
	}
	
	private function __openMixer(e:Event):void{
		colorMixer.setSelectedColor(colorSwatches.getSelectedColor());
		swatchesWindow.dispose();
		mixerWindow.show();
		AsWingUtils.centerLocate(mixerWindow);
	}
	
	private function checkInitColorChoosers():void{
		if(colorSwatches == null){
			mixerButton = new JButton("M");
			colorSwatches = new JColorSwatches();
			colorSwatches.addComponentColorSectionBar(mixerButton);
			colorMixer = new JColorChooser();
			colorMixer.setOpaque(true);
			swatchesWindow = new JWindow(null, true);
			colorSwatches.setBorder(new BevelBorder(null, BevelBorder.RAISED));
			colorSwatches.setOpaque(true);
			swatchesWindow.setContentPane(colorSwatches);
			swatchesWindow.pack();
			
			mixerWindow = new JFrame(null, "Color Mixer", true);
			mixerWindow.setResizable(false);
			mixerWindow.setContentPane(colorMixer);
			mixerWindow.pack();
			
			colorSwatches.addEventListener(InteractiveEvent.STATE_CHANGED, __colorChanged);
			colorMixer.getOkButton().addActionListener(__okMixer);
			colorMixer.getCancelButton().addActionListener(__cancelMixer);
			mixerButton.addActionListener(__openMixer);
		}
	}
	
	private function __okMixer(e:Event):void{
		chooseColor(colorMixer.getSelectedColor());
	}
	private function __cancelMixer(e:Event):void{
		swatchesWindow.dispose();
		mixerWindow.dispose();
	}
	
	private function __colorChanged(e:InteractiveEvent):void{
		if(settingColor) return;
		chooseColor(colorSwatches.getSelectedColor());
	}
	
	private function chooseColor(c:ASColor):void{
		swatchesWindow.dispose();
		mixerWindow.dispose();
		nullRadio.setSelected(false);
		defaultRadio.setSelected(false);
		setColor(c);
	}
	
	private function __default(e:Event):void{
		nullRadio.setSelected(false);
		setColor(DEFAULT);
	}
	
	private function __null(e:Event):void{
		defaultRadio.setSelected(false);
		setColor(null);
	}
	
	public function setColor(c:ASColor):void{
		color = c;
		if(c === DEFAULT || c == null){
			colorIcon.setColor(null);
		}else{
			colorIcon.setColor(color);
		}
		colorButton.repaint();
		applyProperty();
	}
	
	public function getDisplay():Component{
		return pane;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		if(color !== DEFAULT){
			apply(color);
		}else{
			apply(ProModel.NONE_VALUE_SET);
		}
	}
	
	public function parseValue(xml:XML):*{
		var str:String = xml.@value;
		defaultRadio.setSelected(false);
		nullRadio.setSelected(false);
		if(str == "null"){
			color = null;
			nullRadio.setSelected(true);
		}else{
			var strs:Array = str.split(",");
			color = new ASColor(MathUtils.parseInteger(strs[0], 16), parseFloat(strs[1]));
		}
		if(color === DEFAULT || color == null){
			colorIcon.setColor(null);
		}else{
			colorIcon.setColor(color);
		}
		colorButton.repaint();
		return color;
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		if(color == null){
			xml.@value = "null";
		}else{
			xml.@value = color.getRGB().toString(16)+","+color.getAlpha();
		}
		return xml;
	}
	
	public function getCodeLines():Array{
		return null;
	}
	
	public function isSimpleOneLine():String{
		if(color == null){
			return "null";
		}
		return "new ASColor(0x" + color.getRGB().toString(16) + ", " + color.getAlpha() + ")";
	}
}
}

import org.aswing.Icon;
import org.aswing.ASColor;
import org.aswing.Component;
import org.aswing.graphics.Graphics2D;
import org.aswing.graphics.SolidBrush;
import flash.display.DisplayObject;	

class ColorIcon implements Icon{
	
	private var color:ASColor;
	
	public function ColorIcon(){
		color = null;
	}
	
	
	public function getDisplay(c:Component):DisplayObject{
		return null;
	}
	
	public function setColor(c:ASColor):void{
		color = c;
	}
	
	public function getIconWidth(c:Component):int{
		return 16;
	}

	public function getIconHeight(c:Component):int{
		return 16;
	}
	
	public function updateIcon(c:Component, g:Graphics2D, x:int, y:int):void{
		if(color != null){
			g.fillRectangle(new SolidBrush(color), x, y, 15, 16);
		}
	}
}