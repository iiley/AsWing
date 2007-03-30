/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{

import org.aswing.plaf.basic.BasicLookAndFeel;
import org.aswing.plaf.*;
import org.aswing.*;

/**
 * SkinBuilder LookAndFeel let you change the skin easily 
 * with only Replace the image files(and modify the scale 9 properties 
 * if the new image size is not same).
 * @author iiley
 */
public class SkinBuilderLAF extends BasicLookAndFeel{
	
	public function SkinBuilderLAF(){
		super();
	}
	
	override protected function initClassDefaults(table:UIDefaults):void{
		super.initClassDefaults(table);
		var uiDefaults:Array = [
			   "RadioButtonUI", SkinRadioButtonUI,  
			   "CheckBoxUI", SkinCheckBoxUI, 
			   /*"ColorSwatchesUI", org.aswing.plaf.basic.BasicColorSwatchesUI,
			   "ColorMixerUI", org.aswing.plaf.basic.BasicColorMixerUI,
			   "ColorChooserUI", org.aswing.plaf.basic.BasicColorChooserUI,			   
			   "ScrollBarUI", org.aswing.plaf.basic.BasicScrollBarUI, 
			   "SeparatorUI", org.aswing.plaf.basic.BasicSeparatorUI,
			   "ViewportUI", org.aswing.plaf.basic.BasicViewportUI,
			   "ScrollPaneUI", org.aswing.plaf.basic.BasicScrollPaneUI, 
			   "LabelUI",org.aswing.plaf.basic.BasicLabelUI, 
			   "TextFieldUI",org.aswing.plaf.basic.BasicTextFieldUI, 
			   "TextAreaUI",org.aswing.plaf.basic.BasicTextAreaUI, 
			   "FrameUI",org.aswing.plaf.basic.BasicFrameUI, 
			   "ToolTipUI",org.aswing.plaf.basic.BasicToolTipUI, 
			   "ProgressBarUI", org.aswing.plaf.basic.BasicProgressBarUI,			   			   
			   "ListUI",org.aswing.plaf.basic.BasicListUI,		   			   
			   "ComboBoxUI",org.aswing.plaf.basic.BasicComboBoxUI,			   
			   "SliderUI",org.aswing.plaf.basic.BasicSliderUI,		   
			   "AdjusterUI",org.aswing.plaf.basic.BasicAdjusterUI,	   
			   "AccordionUI",org.aswing.plaf.basic.BasicAccordionUI,	   
			   "TabbedPaneUI",org.aswing.plaf.basic.BasicTabbedPaneUI,
			   "SplitPaneUI", org.aswing.plaf.basic.BasicSplitPaneUI,
			   "SpacerUI", org.aswing.plaf.basic.BasicSpacerUI,
			   "TableUI", org.aswing.plaf.basic.BasicTableUI, 
			   "TableHeaderUI", org.aswing.plaf.basic.BasicTableHeaderUI, 
			   "TreeUI", org.aswing.plaf.basic.BasicTreeUI, 
			   "ToolBarUI", org.aswing.plaf.basic.BasicToolBarUI*/
		   ];
		table.putDefaults(uiDefaults);
	}
	
	//=========================== Button ==========================
	[Embed(source="Button_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_defaultImage:Class;
	
	[Embed(source="Button_pressedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_pressedImage:Class;
	
	[Embed(source="Button_rolloverImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_rolloverImage:Class;
	
	//=========================== ToggleButton ==========================
	[Embed(source="ToggleButton_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_defaultImage:Class;
	
	[Embed(source="ToggleButton_pressedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_pressedImage:Class;
	
	[Embed(source="ToggleButton_selectedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_selectedImage:Class;
	
	[Embed(source="ToggleButton_rolloverImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_rolloverImage:Class;

	override protected function initComponentDefaults(table:UIDefaults):void{
		super.initComponentDefaults(table);
		// *** Button
		var comDefaults:Array = [
			"Button.defaultImage", Button_defaultImage,
			"Button.pressedImage", Button_pressedImage,
			//"Button.disabledImage", Button_disabledImage,
			//"Button.selectedImage", Button_selectedImage,
			//"Button.disabledSelectedImage", Button_disabledSelectedImage,
			"Button.rolloverImage", Button_rolloverImage,
			//"Button.rolloverSelectedImage", Button_rolloverSelectedImage,
			
			"Button.bg", SkinButtonBackground,
			"Button.margin", new InsetsUIResource(2, 3, 3, 2)
		];
		table.putDefaults(comDefaults);
		
		// *** ToggleButton
		comDefaults = [
			"ToggleButton.defaultImage", ToggleButton_defaultImage,
			"ToggleButton.pressedImage", ToggleButton_pressedImage,
			//"ToggleButton.disabledImage", ToggleButton_disabledImage,
			"ToggleButton.selectedImage", ToggleButton_selectedImage,
			//"ToggleButton.disabledSelectedImage", ToggleButton_disabledSelectedImage,
			"ToggleButton.rolloverImage", ToggleButton_rolloverImage,
			//"ToggleButton.rolloverSelectedImage", ToggleButton_rolloverSelectedImage,
			"ToggleButton.bg", SkinToggleButtonBackground,
			"ToggleButton.margin", new InsetsUIResource(2, 3, 3, 2)
		];
		table.putDefaults(comDefaults);
	}	
}
}