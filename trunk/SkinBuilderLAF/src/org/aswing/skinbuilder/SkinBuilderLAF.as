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
	
	//=====================================================================
	//=========================== Button scale-9 ==========================
	//=====================================================================
	[Embed(source="Button_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_defaultImage:Class;
	
	[Embed(source="Button_pressedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_pressedImage:Class;
	
	[Embed(source="Button_rolloverImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_rolloverImage:Class;
	
	[Embed(source="Button_disabledImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_disabledImage:Class;
	
	//===========================================================================
	//=========================== ToggleButton scale-9 ==========================
	//===========================================================================
	[Embed(source="ToggleButton_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_defaultImage:Class;
	
	[Embed(source="ToggleButton_pressedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_pressedImage:Class;
	
	[Embed(source="ToggleButton_disabledImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_disabledImage:Class;
	
	[Embed(source="ToggleButton_selectedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_selectedImage:Class;
	
	[Embed(source="ToggleButton_disabledSelectedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_disabledSelectedImage:Class;
	
	[Embed(source="ToggleButton_rolloverImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_rolloverImage:Class;
	
	[Embed(source="ToggleButton_rolloverSelectedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_rolloverSelectedImage:Class;
	
	//==================================================================
	//=========================== RadioButton ==========================
	//==================================================================
	[Embed(source="RadioButton_defaultImage.png")]
	private var RadioButton_defaultImage:Class;
	
	[Embed(source="RadioButton_pressedImage.png")]
	private var RadioButton_pressedImage:Class;
	
	[Embed(source="RadioButton_disabledImage.png")]
	private var RadioButton_disabledImage:Class;
	
	[Embed(source="RadioButton_selectedImage.png")]
	private var RadioButton_selectedImage:Class;
	
	[Embed(source="RadioButton_disabledSelectedImage.png")]
	private var RadioButton_disabledSelectedImage:Class;
	
	[Embed(source="RadioButton_rolloverImage.png")]
	private var RadioButton_rolloverImage:Class;
	
	[Embed(source="RadioButton_rolloverSelectedImage.png")]
	private var RadioButton_rolloverSelectedImage:Class;
	
	//===============================================================
	//=========================== CheckBox ==========================
	//===============================================================
	[Embed(source="CheckBox_defaultImage.png")]
	private var CheckBox_defaultImage:Class;
	
	[Embed(source="CheckBox_pressedImage.png")]
	private var CheckBox_pressedImage:Class;
	
	[Embed(source="CheckBox_disabledImage.png")]
	private var CheckBox_disabledImage:Class;
	
	[Embed(source="CheckBox_selectedImage.png")]
	private var CheckBox_selectedImage:Class;
	
	[Embed(source="CheckBox_disabledSelectedImage.png")]
	private var CheckBox_disabledSelectedImage:Class;
	
	[Embed(source="CheckBox_rolloverImage.png")]
	private var CheckBox_rolloverImage:Class;
	
	[Embed(source="CheckBox_rolloverSelectedImage.png")]
	private var CheckBox_rolloverSelectedImage:Class;

	override protected function initComponentDefaults(table:UIDefaults):void{
		super.initComponentDefaults(table);
		// *** Button
		var comDefaults:Array = [
			"Button.defaultImage", Button_defaultImage,
			"Button.pressedImage", Button_pressedImage,
			"Button.disabledImage", Button_disabledImage,
			"Button.rolloverImage", Button_rolloverImage,
			"Button.bg", SkinButtonBackground,
			"Button.margin", new InsetsUIResource(2, 3, 3, 2)
		];
		table.putDefaults(comDefaults);
		
		// *** ToggleButton
		comDefaults = [
			"ToggleButton.defaultImage", ToggleButton_defaultImage,
			"ToggleButton.pressedImage", ToggleButton_pressedImage,
			"ToggleButton.disabledImage", ToggleButton_disabledImage,
			"ToggleButton.selectedImage", ToggleButton_selectedImage,
			"ToggleButton.disabledSelectedImage", ToggleButton_disabledSelectedImage,
			"ToggleButton.rolloverImage", ToggleButton_rolloverImage,
			"ToggleButton.rolloverSelectedImage", ToggleButton_rolloverSelectedImage,
			"ToggleButton.bg", SkinToggleButtonBackground,
			"ToggleButton.margin", new InsetsUIResource(2, 3, 3, 2)
		];
		table.putDefaults(comDefaults);

		// *** RadioButton
		comDefaults = [
			"RadioButton.defaultImage", RadioButton_defaultImage,
			"RadioButton.pressedImage", RadioButton_pressedImage,
			"RadioButton.disabledImage", RadioButton_disabledImage,
			"RadioButton.selectedImage", RadioButton_selectedImage,
			"RadioButton.disabledSelectedImage", RadioButton_disabledSelectedImage,
			"RadioButton.rolloverImage", RadioButton_rolloverImage,
			"RadioButton.rolloverSelectedImage", RadioButton_rolloverSelectedImage
		];
		table.putDefaults(comDefaults);

		// *** CheckBox
		comDefaults = [
			"CheckBox.defaultImage", CheckBox_defaultImage,
			"CheckBox.pressedImage", CheckBox_pressedImage,
			"CheckBox.disabledImage", CheckBox_disabledImage,
			"CheckBox.selectedImage", CheckBox_selectedImage,
			"CheckBox.disabledSelectedImage", CheckBox_disabledSelectedImage,
			"CheckBox.rolloverImage", CheckBox_rolloverImage,
			"CheckBox.rolloverSelectedImage", CheckBox_rolloverSelectedImage
		];
		table.putDefaults(comDefaults);				
	}	
}
}