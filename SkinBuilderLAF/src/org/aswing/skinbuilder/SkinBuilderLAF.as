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
	[Embed(source="assets/Button_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_defaultImage:Class;
	
	[Embed(source="assets/Button_pressedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_pressedImage:Class;
	
	[Embed(source="assets/Button_rolloverImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_rolloverImage:Class;
	
	[Embed(source="assets/Button_disabledImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_disabledImage:Class;
	
	//===========================================================================
	//=========================== ToggleButton scale-9 ==========================
	//===========================================================================
	[Embed(source="assets/ToggleButton_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_defaultImage:Class;
	
	[Embed(source="assets/ToggleButton_pressedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_pressedImage:Class;
	
	[Embed(source="assets/ToggleButton_disabledImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_disabledImage:Class;
	
	[Embed(source="assets/ToggleButton_selectedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_selectedImage:Class;
	
	[Embed(source="assets/ToggleButton_disabledSelectedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_disabledSelectedImage:Class;
	
	[Embed(source="assets/ToggleButton_rolloverImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_rolloverImage:Class;
	
	[Embed(source="assets/ToggleButton_rolloverSelectedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ToggleButton_rolloverSelectedImage:Class;
	
	//==================================================================
	//=========================== RadioButton ==========================
	//==================================================================
	[Embed(source="assets/RadioButton_defaultImage.png")]
	private var RadioButton_defaultImage:Class;
	
	[Embed(source="assets/RadioButton_pressedImage.png")]
	private var RadioButton_pressedImage:Class;
	
	[Embed(source="assets/RadioButton_disabledImage.png")]
	private var RadioButton_disabledImage:Class;
	
	[Embed(source="assets/RadioButton_selectedImage.png")]
	private var RadioButton_selectedImage:Class;
	
	[Embed(source="assets/RadioButton_disabledSelectedImage.png")]
	private var RadioButton_disabledSelectedImage:Class;
	
	[Embed(source="assets/RadioButton_rolloverImage.png")]
	private var RadioButton_rolloverImage:Class;
	
	[Embed(source="assets/RadioButton_rolloverSelectedImage.png")]
	private var RadioButton_rolloverSelectedImage:Class;
	
	//===============================================================
	//=========================== CheckBox ==========================
	//===============================================================
	[Embed(source="assets/CheckBox_defaultImage.png")]
	private var CheckBox_defaultImage:Class;
	
	[Embed(source="assets/CheckBox_pressedImage.png")]
	private var CheckBox_pressedImage:Class;
	
	[Embed(source="assets/CheckBox_disabledImage.png")]
	private var CheckBox_disabledImage:Class;
	
	[Embed(source="assets/CheckBox_selectedImage.png")]
	private var CheckBox_selectedImage:Class;
	
	[Embed(source="assets/CheckBox_disabledSelectedImage.png")]
	private var CheckBox_disabledSelectedImage:Class;
	
	[Embed(source="assets/CheckBox_rolloverImage.png")]
	private var CheckBox_rolloverImage:Class;
	
	[Embed(source="assets/CheckBox_rolloverSelectedImage.png")]
	private var CheckBox_rolloverSelectedImage:Class;
	
	//===============================================================
	//=========================== ScrollBar =========================
	//===============================================================
	//========= Left Arrow Images =======
	[Embed(source="assets/ScrollBar_arrowLeft_defaultImage.png")]
	private var ScrollBar_arrowLeft_defaultImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowLeft_pressedImage.png")]
	private var ScrollBar_arrowLeft_pressedImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowLeft_disabledImage.png")]
	private var ScrollBar_arrowLeft_disabledImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowLeft_rolloverImage.png")]
	private var ScrollBar_arrowLeft_rolloverImage:Class;
	
	//========= Right Arrow Images =======
	[Embed(source="assets/ScrollBar_arrowRight_defaultImage.png")]
	private var ScrollBar_arrowRight_defaultImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowRight_pressedImage.png")]
	private var ScrollBar_arrowRight_pressedImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowRight_disabledImage.png")]
	private var ScrollBar_arrowRight_disabledImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowRight_rolloverImage.png")]
	private var ScrollBar_arrowRight_rolloverImage:Class;
	
	//========= Up Arrow Images =======
	[Embed(source="assets/ScrollBar_arrowUp_defaultImage.png")]
	private var ScrollBar_arrowUp_defaultImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowUp_pressedImage.png")]
	private var ScrollBar_arrowUp_pressedImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowUp_disabledImage.png")]
	private var ScrollBar_arrowUp_disabledImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowUp_rolloverImage.png")]
	private var ScrollBar_arrowUp_rolloverImage:Class;
	
	//========= Down Arrow Images =======
	[Embed(source="assets/ScrollBar_arrowDown_defaultImage.png")]
	private var ScrollBar_arrowDown_defaultImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowDown_pressedImage.png")]
	private var ScrollBar_arrowDown_pressedImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowDown_disabledImage.png")]
	private var ScrollBar_arrowDown_disabledImage:Class;
	
	[Embed(source="assets/ScrollBar_arrowDown_rolloverImage.png")]
	private var ScrollBar_arrowDown_rolloverImage:Class;
	
	//========= Background Images scale-9 ======= 
	[Embed(source="assets/ScrollBar_verticalBGImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_verticalBGImage:Class;
	
	[Embed(source="assets/ScrollBar_horizotalBGImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_horizotalBGImage:Class;
	
	//========= Thumb Images scale-9 ======= 
	//vertical
	[Embed(source="assets/ScrollBar_thumbVertical_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_thumbVertical_defaultImage:Class;
	
	[Embed(source="assets/ScrollBar_thumbVertical_pressedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_thumbVertical_pressedImage:Class;
	
	[Embed(source="assets/ScrollBar_thumbVertical_rolloverImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_thumbVertical_rolloverImage:Class;
	
	[Embed(source="assets/ScrollBar_thumbVertical_disabledImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_thumbVertical_disabledImage:Class;
	//horizontal
	[Embed(source="assets/ScrollBar_thumbHorizontal_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_thumbHorizontal_defaultImage:Class;
	
	[Embed(source="assets/ScrollBar_thumbHorizontal_pressedImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_thumbHorizontal_pressedImage:Class;
	
	[Embed(source="assets/ScrollBar_thumbHorizontal_rolloverImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_thumbHorizontal_rolloverImage:Class;
	
	[Embed(source="assets/ScrollBar_thumbHorizontal_disabledImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ScrollBar_thumbHorizontal_disabledImage:Class;

	//===========================================================================
	//=========================== Frame =========================================
	//===========================================================================
	//Backgorund scale-9 (Include title bar background all in one picture)
	[Embed(source="assets/Frame_activeBG.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Frame_activeBG:Class;
	
	[Embed(source="assets/Frame_inactiveBG.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Frame_inactiveBG:Class;
	
	//========= Frame_iconifiedIcon Images =======
	[Embed(source="assets/Frame_iconifiedIcon_defaultImage.png")]
	private var Frame_iconifiedIcon_defaultImage:Class;
	
	[Embed(source="assets/Frame_iconifiedIcon_pressedImage.png")]
	private var Frame_iconifiedIcon_pressedImage:Class;
	
	[Embed(source="assets/Frame_iconifiedIcon_disabledImage.png")]
	private var Frame_iconifiedIcon_disabledImage:Class;
	
	[Embed(source="assets/Frame_iconifiedIcon_rolloverImage.png")]
	private var Frame_iconifiedIcon_rolloverImage:Class;
	
	//========= Frame_normalIcon Images =======
	[Embed(source="assets/Frame_normalIcon_defaultImage.png")]
	private var Frame_normalIcon_defaultImage:Class;
	
	[Embed(source="assets/Frame_normalIcon_pressedImage.png")]
	private var Frame_normalIcon_pressedImage:Class;
	
	[Embed(source="assets/Frame_normalIcon_disabledImage.png")]
	private var Frame_normalIcon_disabledImage:Class;
	
	[Embed(source="assets/Frame_normalIcon_rolloverImage.png")]
	private var Frame_normalIcon_rolloverImage:Class;
	
	//========= Frame_maximizeIcon Images =======
	[Embed(source="assets/Frame_maximizeIcon_defaultImage.png")]
	private var Frame_maximizeIcon_defaultImage:Class;
	
	[Embed(source="assets/Frame_maximizeIcon_pressedImage.png")]
	private var Frame_maximizeIcon_pressedImage:Class;
	
	[Embed(source="assets/Frame_maximizeIcon_disabledImage.png")]
	private var Frame_maximizeIcon_disabledImage:Class;
	
	[Embed(source="assets/Frame_maximizeIcon_rolloverImage.png")]
	private var Frame_maximizeIcon_rolloverImage:Class;
	
	//========= Down Arrow Images =======
	[Embed(source="assets/Frame_closeIcon_defaultImage.png")]
	private var Frame_closeIcon_defaultImage:Class;
	
	[Embed(source="assets/Frame_closeIcon_pressedImage.png")]
	private var Frame_closeIcon_pressedImage:Class;
	
	[Embed(source="assets/Frame_closeIcon_disabledImage.png")]
	private var Frame_closeIcon_disabledImage:Class;
	
	[Embed(source="assets/Frame_closeIcon_rolloverImage.png")]
	private var Frame_closeIcon_rolloverImage:Class;
	
	
	

	//===========================================================================
	//=========================== initComponentDefaults =========================
	//===========================================================================
	
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
		
		// *** ScrollBar
		comDefaults = [
			"ScrollBar.opaque", false, 
			"ScrollBar.thumbDecorator", SkinScrollBarThumb, 
			"ScrollBar.arrowSize", 16, //modify this when your arrow images size changed
			
			"ScrollBar.verticalBGImage", ScrollBar_verticalBGImage, 
			"ScrollBar.horizotalBGImage", ScrollBar_horizotalBGImage, 
			
			"ScrollBar.arrowLeft.defaultImage", ScrollBar_arrowLeft_defaultImage, 
			"ScrollBar.arrowLeft.pressedImage", ScrollBar_arrowLeft_pressedImage, 
			"ScrollBar.arrowLeft.disabledImage", ScrollBar_arrowLeft_disabledImage, 
			"ScrollBar.arrowLeft.rolloverImage", ScrollBar_arrowLeft_rolloverImage, 
			
			"ScrollBar.arrowRight.defaultImage", ScrollBar_arrowRight_defaultImage, 
			"ScrollBar.arrowRight.pressedImage", ScrollBar_arrowRight_pressedImage, 
			"ScrollBar.arrowRight.disabledImage", ScrollBar_arrowRight_disabledImage, 
			"ScrollBar.arrowRight.rolloverImage", ScrollBar_arrowRight_rolloverImage, 
			
			"ScrollBar.arrowUp.defaultImage", ScrollBar_arrowUp_defaultImage, 
			"ScrollBar.arrowUp.pressedImage", ScrollBar_arrowUp_pressedImage, 
			"ScrollBar.arrowUp.disabledImage", ScrollBar_arrowUp_disabledImage, 
			"ScrollBar.arrowUp.rolloverImage", ScrollBar_arrowUp_rolloverImage, 
			
			"ScrollBar.arrowDown.defaultImage", ScrollBar_arrowDown_defaultImage, 
			"ScrollBar.arrowDown.pressedImage", ScrollBar_arrowDown_pressedImage, 
			"ScrollBar.arrowDown.disabledImage", ScrollBar_arrowDown_disabledImage, 
			"ScrollBar.arrowDown.rolloverImage", ScrollBar_arrowDown_rolloverImage, 
			
			"ScrollBar.thumbVertical.defaultImage", ScrollBar_thumbVertical_defaultImage, 
			"ScrollBar.thumbVertical.pressedImage", ScrollBar_thumbVertical_pressedImage, 
			"ScrollBar.thumbVertical.disabledImage", ScrollBar_thumbVertical_disabledImage, 
			"ScrollBar.thumbVertical.rolloverImage", ScrollBar_thumbVertical_rolloverImage, 
			
			"ScrollBar.thumbHorizontal.defaultImage", ScrollBar_thumbHorizontal_defaultImage, 
			"ScrollBar.thumbHorizontal.pressedImage", ScrollBar_thumbHorizontal_pressedImage, 
			"ScrollBar.thumbHorizontal.disabledImage", ScrollBar_thumbHorizontal_disabledImage, 
			"ScrollBar.thumbHorizontal.rolloverImage", ScrollBar_thumbHorizontal_rolloverImage
		];
		table.putDefaults(comDefaults);
		
		// *** Frame
		comDefaults = [
			"Frame.background", table.get("window"),
			"Frame.foreground", table.get("windowText"),
			"Frame.opaque", false, 
			"Frame.bg", SkinFrameBackground, //this will use Frame.activeBG and Frame.inactiveBG
			"Frame.margin", new InsetsUIResource(2, 3, 3, 2), //modify this to fit the frame bg image
			"Frame.titleBarHeight", 20, //modify this to fit title bar height of bg image
			"Frame.activeBG", Frame_activeBG, 
			"Frame.inactiveBG", Frame_inactiveBG, 
			"Frame.titleBarLayout", SkinFrameTitleBarLayout, 
			"Frame.border", SkinFrameEmptyBorder, //this border will use Frame.margin property
			"Frame.buttonSize", 14, //modify this to fit title bar button size below
			"Frame.iconifiedIcon", SkinFrameIconifiedIcon,
			"Frame.normalIcon", SkinFrameNormalIcon,
			"Frame.maximizeIcon", SkinFrameMaximizeIcon, 
			"Frame.closeIcon", SkinFrameCloseIcon, 
			
			"Frame.iconifiedIcon.defaultImage", Frame_iconifiedIcon_defaultImage, 
			"Frame.iconifiedIcon.pressedImage", Frame_iconifiedIcon_pressedImage, 
			"Frame.iconifiedIcon.disabledImage", Frame_iconifiedIcon_disabledImage, 
			"Frame.iconifiedIcon.rolloverImage", Frame_iconifiedIcon_rolloverImage, 
			
			"Frame.normalIcon.defaultImage", Frame_normalIcon_defaultImage, 
			"Frame.normalIcon.pressedImage", Frame_normalIcon_pressedImage, 
			"Frame.normalIcon.disabledImage", Frame_normalIcon_disabledImage, 
			"Frame.normalIcon.rolloverImage", Frame_normalIcon_rolloverImage, 
			
			"Frame.maximizeIcon.defaultImage", Frame_maximizeIcon_defaultImage, 
			"Frame.maximizeIcon.pressedImage", Frame_maximizeIcon_pressedImage, 
			"Frame.maximizeIcon.disabledImage", Frame_maximizeIcon_disabledImage, 
			"Frame.maximizeIcon.rolloverImage", Frame_maximizeIcon_rolloverImage,
			
			"Frame.closeIcon.defaultImage", Frame_closeIcon_defaultImage, 
			"Frame.closeIcon.pressedImage", Frame_closeIcon_pressedImage, 
			"Frame.closeIcon.disabledImage", Frame_closeIcon_disabledImage, 
			"Frame.closeIcon.rolloverImage", Frame_closeIcon_rolloverImage
		];
		table.putDefaults(comDefaults);			
	}	
}
}