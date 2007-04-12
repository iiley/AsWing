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
			   "ScrollBarUI", SkinScrollBarUI, 
			   "ProgressBarUI", SkinProgressBarUI,
			   "ComboBoxUI", SkinComboBoxUI,	   
			   //"SliderUI",org.aswing.plaf.basic.BasicSliderUI,		   
			   //"AdjusterUI",org.aswing.plaf.basic.BasicAdjusterUI,	   
			   "AccordionUI", SkinAccordionUI, 
			   "TabbedPaneUI", SkinTabbedPaneUI,
			   "SplitPaneUI", SkinSplitPaneUI,
			   //"TableUI", org.aswing.plaf.basic.BasicTableUI, 
			   //"TableHeaderUI", org.aswing.plaf.basic.BasicTableHeaderUI, 
			   //"TreeUI", org.aswing.plaf.basic.BasicTreeUI, 
			   //"ToolBarUI", org.aswing.plaf.basic.BasicToolBarUI*/
		   ];
		table.putDefaults(uiDefaults);
	}

	override protected function initSystemColorDefaults(table:UIDefaults):void{
		super.initSystemColorDefaults(table);
			var defaultSystemColors:Array = [
				//"activeCaption", 0xF2F2F2, /* Color for captions (title bars) when they are active. */
				"activeCaptionText", 0xFFFFFF, /* Text color for text in captions (title bars). */
				//"activeCaptionBorder", 0xC0C0C0, /* Border color for caption (title bar) window borders. */
				//"inactiveCaption", 0xE7E7E7, /* Color for captions (title bars) when not active. */
				"inactiveCaptionText", 0x888888, /* Text color for text in inactive captions (title bars). */
				//"inactiveCaptionBorder", 0x888888, /* Border color for inactive caption (title bar) window borders. */
				"window", 0xECE9D8, /* Default color for the interior of windows */
				//"windowBorder", 0x000000, /* ??? */
				"windowText", 0xFFFFFF, /* ??? */
				//"menu", 0xCCCCCC, /* Background color for menus */
				//"menuText", 0x000000, /* Text color for menus  */
				//"text", 0xC0C0C0, /* Text background color */
				//"textText", 0x000000, /* Text foreground color */
				//"textHighlight", 0x000080, /* Text background color when selected */
				//"textHighlightText", 0xFFFFFF, /* Text color when selected */
				//"textInactiveText", 0x808080, /* Text color when disabled */
				//"control", 0xF4F4F4,//0xEFEFEF, /* Default color for controls (buttons, sliders, etc) */
				"controlText", 0x002a37, /* Default color for text in controls */
				//"controlHighlight", 0xEEEEEE, /* Specular highlight (opposite of the shadow) */
				//"controlLtHighlight", 0x666666, /* Highlight color for controls */
				//"controlShadow", 0xC7C7C5, /* Shadow color for controls */
				//"controlDkShadow", 0x666666, /* Dark shadow color for controls */
				//"scrollbar", 0xE0E0E0 /* Scrollbar background (usually the "track") */
			];
					
			for(var i:Number=0; i<defaultSystemColors.length; i+=2){
				table.put(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
			}
			table.put("focusInner", new ASColorUIResource(0x40FF40, 10));
			table.put("focusOutter", new ASColorUIResource(0x40FF40, 20));
	}
	
	override protected function initSystemFontDefaults(table:UIDefaults):void{
		super.initSystemFontDefaults(table);
		var defaultSystemFonts:Array = [
				"systemFont", new ASFontUIResource("Tahoma", 11), 
				"menuFont", new ASFontUIResource("Tahoma", 11), 
				"controlFont", new ASFontUIResource("Tahoma", 11), 
				"windowFont", new ASFontUIResource("Tahoma", 11, true)
		];
		table.putDefaults(defaultSystemFonts);
	}	
	
	//----------------------------------------------------------------------
	//___________________________ Button scale-9 ___________________________
	//======================================================================
	[Embed(source="assets/Button_defaultImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_defaultImage:Class;
	
	[Embed(source="assets/Button_pressedImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_pressedImage:Class;
	
	[Embed(source="assets/Button_rolloverImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_rolloverImage:Class;
	
	[Embed(source="assets/Button_disabledImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_disabledImage:Class;
	
	[Embed(source="assets/Button_DefaultButton_defaultImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var Button_DefaultButton_defaultImage:Class;
	
	//----------------------------------------------------------------------------
	//___________________________ ToggleButton scale-9 ___________________________
	//============================================================================
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
	
	
	//-------------------------------------------------------------------
	//___________________________ RadioButton ___________________________
	//===================================================================
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
	
	
	//----------------------------------------------------------------
	//___________________________ CheckBox ___________________________
	//================================================================
	[Embed(source="assets/CheckBox_defaultImage.png")]
	private var CheckBox_defaultImage:Class;
	
	[Embed(source="assets/CheckBox_pressedImage.png")]
	private var CheckBox_pressedImage:Class;
	
	[Embed(source="assets/CheckBox_pressedSelectedImage.png")]
	private var CheckBox_pressedSelectedImage:Class;
	
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
	
	
	//------------------------------------------------------------------
	//___________________________ ScrollBar ____________________________
	//==================================================================
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

	
	//---------------------------------------------------------------------
	//___________________________ TextField scale-9 _______________________
	//=====================================================================
	[Embed(source="assets/TextField_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var TextField_defaultImage:Class;
	
	[Embed(source="assets/TextField_uneditableImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var TextField_uneditableImage:Class;
	
	[Embed(source="assets/TextField_disabledImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var TextField_disabledImage:Class;
	
	
	//------------------------------------------------------------------------
	//___________________________ TextArea scale-9 ___________________________
	//========================================================================
	[Embed(source="assets/TextArea_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var TextArea_defaultImage:Class;
	
	[Embed(source="assets/TextArea_uneditableImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var TextArea_uneditableImage:Class;
	
	[Embed(source="assets/TextArea_disabledImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var TextArea_disabledImage:Class;
	
	
	//--------------------------------------------------------------
	//___________________________ Frame ____________________________
	//==============================================================
	//Backgorund scale-9 (Include title bar background all in one picture)
	[Embed(source="assets/Frame_activeBG.png", scaleGridTop="31", scaleGridBottom="100", 
		scaleGridLeft="5", scaleGridRight="254")]
	private var Frame_activeBG:Class;
	
	[Embed(source="assets/Frame_inactiveBG.png", scaleGridTop="31", scaleGridBottom="100", 
		scaleGridLeft="5", scaleGridRight="254")]
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
		
	
	//----------------------------------------------------------------------
	//___________________________ ToolTip scale-9 __________________________
	//======================================================================
	[Embed(source="assets/ToolTip_bgImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="68")]
	private var ToolTip_bgImage:Class;
	
	
	//------------------------------------------------------------------------
	//___________________________ ComboBox scale-9 ___________________________
	//========================================================================
	
	//========= Background Images =======
	[Embed(source="assets/ComboBox_defaultImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ComboBox_defaultImage:Class;
	
	[Embed(source="assets/ComboBox_uneditableImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ComboBox_uneditableImage:Class;
	
	[Embed(source="assets/ComboBox_disabledImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var ComboBox_disabledImage:Class;
	
	//========= Arrow Button Images =======
	[Embed(source="assets/ComboBox_arrowButton_defaultImage.png")]
	private var ComboBox_arrowButton_defaultImage:Class;
	
	[Embed(source="assets/ComboBox_arrowButton_pressedImage.png")]
	private var ComboBox_arrowButton_pressedImage:Class;
	
	[Embed(source="assets/ComboBox_arrowButton_disabledImage.png")]
	private var ComboBox_arrowButton_disabledImage:Class;
	
	[Embed(source="assets/ComboBox_arrowButton_rolloverImage.png")]
	private var ComboBox_arrowButton_rolloverImage:Class;
	

	//----------------------------------------------------------------------
	//___________________________ Accordion header scale-9 ___________________________
	//======================================================================
	[Embed(source="assets/Accordion_header_defaultImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="68")]
	private var Accordion_header_defaultImage:Class;
	
	[Embed(source="assets/Accordion_header_pressedImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="68")]
	private var Accordion_header_pressedImage:Class;
	
	[Embed(source="assets/Accordion_header_rolloverImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="68")]
	private var Accordion_header_rolloverImage:Class;
	
	[Embed(source="assets/Accordion_header_disabledImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="68")]
	private var Accordion_header_disabledImage:Class;
	
	[Embed(source="assets/Accordion_header_selectedImage.png", scaleGridTop="11", scaleGridBottom="12", 
		scaleGridLeft="6", scaleGridRight="68")]
	private var Accordion_header_selectedImage:Class;
	

	//----------------------------------------------------------------------
	//___________________________ TabbedPane _______________________________
	//======================================================================
	//========= header top scale-9 =======
	[Embed(source="assets/TabbedPane_top_tab_defaultImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_top_tab_defaultImage:Class;
	
	[Embed(source="assets/TabbedPane_top_tab_pressedImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_top_tab_pressedImage:Class;
	
	[Embed(source="assets/TabbedPane_top_tab_rolloverImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_top_tab_rolloverImage:Class;
	
	[Embed(source="assets/TabbedPane_top_tab_disabledImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_top_tab_disabledImage:Class;
	
	[Embed(source="assets/TabbedPane_top_tab_selectedImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_top_tab_selectedImage:Class;
	
	[Embed(source="assets/TabbedPane_top_tab_rolloverSelectedImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_top_tab_rolloverSelectedImage:Class;
	
	//========= header bottom scale-9 =======
	[Embed(source="assets/TabbedPane_bottom_tab_defaultImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_bottom_tab_defaultImage:Class;
	
	[Embed(source="assets/TabbedPane_bottom_tab_pressedImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_bottom_tab_pressedImage:Class;
	
	[Embed(source="assets/TabbedPane_bottom_tab_rolloverImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_bottom_tab_rolloverImage:Class;
	
	[Embed(source="assets/TabbedPane_bottom_tab_disabledImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_bottom_tab_disabledImage:Class;
	
	[Embed(source="assets/TabbedPane_bottom_tab_selectedImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_bottom_tab_selectedImage:Class;
	
	[Embed(source="assets/TabbedPane_bottom_tab_rolloverSelectedImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var TabbedPane_bottom_tab_rolloverSelectedImage:Class;
	
	//========= header left scale-9 =======
	[Embed(source="assets/TabbedPane_left_tab_defaultImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_left_tab_defaultImage:Class;
	
	[Embed(source="assets/TabbedPane_left_tab_pressedImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_left_tab_pressedImage:Class;
	
	[Embed(source="assets/TabbedPane_left_tab_rolloverImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_left_tab_rolloverImage:Class;
	
	[Embed(source="assets/TabbedPane_left_tab_disabledImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_left_tab_disabledImage:Class;
	
	[Embed(source="assets/TabbedPane_left_tab_selectedImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_left_tab_selectedImage:Class;
	
	[Embed(source="assets/TabbedPane_left_tab_rolloverSelectedImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_left_tab_rolloverSelectedImage:Class;
	
	//========= header right scale-9 =======
	[Embed(source="assets/TabbedPane_right_tab_defaultImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_right_tab_defaultImage:Class;
	
	[Embed(source="assets/TabbedPane_right_tab_pressedImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_right_tab_pressedImage:Class;
	
	[Embed(source="assets/TabbedPane_right_tab_rolloverImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_right_tab_rolloverImage:Class;
	
	[Embed(source="assets/TabbedPane_right_tab_disabledImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_right_tab_disabledImage:Class;
	
	[Embed(source="assets/TabbedPane_right_tab_selectedImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_right_tab_selectedImage:Class;
	
	[Embed(source="assets/TabbedPane_right_tab_rolloverSelectedImage.png", scaleGridTop="12", scaleGridBottom="88", 
		scaleGridLeft="12", scaleGridRight="14")]
	private var TabbedPane_right_tab_rolloverSelectedImage:Class;
	
	//========= Background Image scale-9 =======
	[Embed(source="assets/TabbedPane_top_contentRoundImage.png", scaleGridTop="20", scaleGridBottom="80", 
		scaleGridLeft="20", scaleGridRight="80")]
	private var TabbedPane_top_contentRoundImage:Class;
	[Embed(source="assets/TabbedPane_bottom_contentRoundImage.png", scaleGridTop="20", scaleGridBottom="80", 
		scaleGridLeft="20", scaleGridRight="80")]
	private var TabbedPane_bottom_contentRoundImage:Class;
	[Embed(source="assets/TabbedPane_left_contentRoundImage.png", scaleGridTop="20", scaleGridBottom="80", 
		scaleGridLeft="20", scaleGridRight="80")]
	private var TabbedPane_left_contentRoundImage:Class;
	[Embed(source="assets/TabbedPane_right_contentRoundImage.png", scaleGridTop="20", scaleGridBottom="80", 
		scaleGridLeft="20", scaleGridRight="80")]
	private var TabbedPane_right_contentRoundImage:Class;
	
	//========= Left Arrow Images =======
	[Embed(source="assets/TabbedPane_arrowLeft_defaultImage.png")]
	private var TabbedPane_arrowLeft_defaultImage:Class;
	
	[Embed(source="assets/TabbedPane_arrowLeft_pressedImage.png")]
	private var TabbedPane_arrowLeft_pressedImage:Class;
	
	[Embed(source="assets/TabbedPane_arrowLeft_disabledImage.png")]
	private var TabbedPane_arrowLeft_disabledImage:Class;
	
	[Embed(source="assets/TabbedPane_arrowLeft_rolloverImage.png")]
	private var TabbedPane_arrowLeft_rolloverImage:Class;
	
	//========= Right Arrow Images =======
	[Embed(source="assets/TabbedPane_arrowRight_defaultImage.png")]
	private var TabbedPane_arrowRight_defaultImage:Class;
	
	[Embed(source="assets/TabbedPane_arrowRight_pressedImage.png")]
	private var TabbedPane_arrowRight_pressedImage:Class;
	
	[Embed(source="assets/TabbedPane_arrowRight_disabledImage.png")]
	private var TabbedPane_arrowRight_disabledImage:Class;
	
	[Embed(source="assets/TabbedPane_arrowRight_rolloverImage.png")]
	private var TabbedPane_arrowRight_rolloverImage:Class;
	

	//----------------------------------------------------------------------
	//_______________________________ Slider _______________________________
	//======================================================================
	//========= track scale-9 =======
	/*[Embed(source="assets/Slider_vertical_trackImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var Slider_vertical_trackImage:Class;
	[Embed(source="assets/Slider_vertical_trackDisabledImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var Slider_vertical_trackDisabledImage:Class;
	[Embed(source="assets/Slider_vertical_trackProgressImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var Slider_vertical_trackProgressImage:Class;
	[Embed(source="assets/Slider_vertical_trackProgressDisabledImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var Slider_vertical_trackProgressDisabledImage:Class;
	
	[Embed(source="assets/Slider_horizontal_trackImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var Slider_horizontal_trackImage:Class;
	[Embed(source="assets/Slider_horizontal_trackDisabledImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var Slider_horizontal_trackDisabledImage:Class;
	[Embed(source="assets/Slider_horizontal_trackProgressImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var Slider_horizontal_trackProgressImage:Class;
	[Embed(source="assets/Slider_horizontal_trackProgressDisabledImage.png", scaleGridTop="12", scaleGridBottom="14", 
		scaleGridLeft="12", scaleGridRight="88")]
	private var Slider_horizontal_trackProgressDisabledImage:Class;
	
	//========= Thumb Images =======
	[Embed(source="assets/Slider_thumb_defaultImage.png")]
	private var Slider_thumb_defaultImage:Class;
	
	[Embed(source="assets/Slider_thumb_pressedImage.png")]
	private var Slider_thumb_pressedImage:Class;
	
	[Embed(source="assets/Slider_thumb_disabledImage.png")]
	private var Slider_thumb_disabledImage:Class;
	
	[Embed(source="assets/Slider_thumb_rolloverImage.png")]
	private var Slider_thumb_rolloverImage:Class;*/
	
	
	//----------------------------------------------------------------------
	//___________________________ TabbedPane _______________________________
	//======================================================================
	//========= Icon Images =======
	[Embed(source="assets/Tree_leafImage.png")]
	private var Tree_leafImage:Class;
	
	[Embed(source="assets/Tree_folderExpandedImage.png")]
	private var Tree_folderExpandedImage:Class;
	
	[Embed(source="assets/Tree_folderCollapsedImage.png")]
	private var Tree_folderCollapsedImage:Class;
	
	//========= Control Images =======
	[Embed(source="assets/Tree_leafControlImage.png")]
	private var Tree_leafControlImage:Class;
	
	[Embed(source="assets/Tree_folderExpandedControlImage.png")]
	private var Tree_folderExpandedControlImage:Class;
	
	[Embed(source="assets/Tree_folderCollapsedControlImage.png")]
	private var Tree_folderCollapsedControlImage:Class;
	
	
	//------------------------------------------------------------------
	//___________________________ SplitPane ____________________________
	//==================================================================
	//========= Left Arrow Images =======
	[Embed(source="assets/SplitPane_arrowLeft_defaultImage.png")]
	private var SplitPane_arrowLeft_defaultImage:Class;
	
	[Embed(source="assets/SplitPane_arrowLeft_pressedImage.png")]
	private var SplitPane_arrowLeft_pressedImage:Class;
	
	[Embed(source="assets/SplitPane_arrowLeft_disabledImage.png")]
	private var SplitPane_arrowLeft_disabledImage:Class;
	
	[Embed(source="assets/SplitPane_arrowLeft_rolloverImage.png")]
	private var SplitPane_arrowLeft_rolloverImage:Class;
	
	//========= Right Arrow Images =======
	[Embed(source="assets/SplitPane_arrowRight_defaultImage.png")]
	private var SplitPane_arrowRight_defaultImage:Class;
	
	[Embed(source="assets/SplitPane_arrowRight_pressedImage.png")]
	private var SplitPane_arrowRight_pressedImage:Class;
	
	[Embed(source="assets/SplitPane_arrowRight_disabledImage.png")]
	private var SplitPane_arrowRight_disabledImage:Class;
	
	[Embed(source="assets/SplitPane_arrowRight_rolloverImage.png")]
	private var SplitPane_arrowRight_rolloverImage:Class;
	
	//========= Up Arrow Images =======
	[Embed(source="assets/SplitPane_arrowUp_defaultImage.png")]
	private var SplitPane_arrowUp_defaultImage:Class;
	
	[Embed(source="assets/SplitPane_arrowUp_pressedImage.png")]
	private var SplitPane_arrowUp_pressedImage:Class;
	
	[Embed(source="assets/SplitPane_arrowUp_disabledImage.png")]
	private var SplitPane_arrowUp_disabledImage:Class;
	
	[Embed(source="assets/SplitPane_arrowUp_rolloverImage.png")]
	private var SplitPane_arrowUp_rolloverImage:Class;
	
	//========= Down Arrow Images =======
	[Embed(source="assets/SplitPane_arrowDown_defaultImage.png")]
	private var SplitPane_arrowDown_defaultImage:Class;
	
	[Embed(source="assets/SplitPane_arrowDown_pressedImage.png")]
	private var SplitPane_arrowDown_pressedImage:Class;
	
	[Embed(source="assets/SplitPane_arrowDown_disabledImage.png")]
	private var SplitPane_arrowDown_disabledImage:Class;
	
	[Embed(source="assets/SplitPane_arrowDown_rolloverImage.png")]
	private var SplitPane_arrowDown_rolloverImage:Class;
	
	//========= Background Images scale-9 ======= 
	[Embed(source="assets/SplitPane_divider_verticalBGImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var SplitPane_divider_verticalBGImage:Class;
	
	[Embed(source="assets/SplitPane_divider_horizotalBGImage.png", scaleGridTop="6", scaleGridBottom="18", 
		scaleGridLeft="6", scaleGridRight="67")]
	private var SplitPane_divider_horizotalBGImage:Class;
	
	
	
	//------------------------------------------------------------------
	//___________________________ ProgressBar __________________________
	//==================================================================
	//========= Background Images scale-9 or not ======= 
	[Embed(source="assets/ProgressBar_verticalBGImage.png", scaleGridTop="2", scaleGridBottom="202", 
		scaleGridLeft="2", scaleGridRight="14")]
	private var ProgressBar_verticalBGImage:Class;
	
	[Embed(source="assets/ProgressBar_horizotalBGImage.png", scaleGridTop="2", scaleGridBottom="14", 
		scaleGridLeft="2", scaleGridRight="202")]
	private var ProgressBar_horizotalBGImage:Class;
	
	//========= Foreground Images scale-9 or not ======= 
	[Embed(source="assets/ProgressBar_verticalFGImage.png")]
	private var ProgressBar_verticalFGImage:Class;
	
	[Embed(source="assets/ProgressBar_horizotalFGImage.png")]
	private var ProgressBar_horizotalFGImage:Class;
	
	//-----------------------------------------------------------------------------
	//___________________________ initComponentDefaults ___________________________
	//=============================================================================
	
	override protected function initComponentDefaults(table:UIDefaults):void{
		super.initComponentDefaults(table);
		// *** Button
		var comDefaults:Array = [
			"Button.opaque", false, 
			"Button.defaultImage", Button_defaultImage,
			"Button.pressedImage", Button_pressedImage,
			"Button.disabledImage", Button_disabledImage,
			"Button.rolloverImage", Button_rolloverImage, 
			"Button.DefaultButton.defaultImage", Button_DefaultButton_defaultImage, 
			"Button.bg", SkinButtonBackground,
			"Button.margin", new InsetsUIResource(3, 3, 3, 2), //modify this to fit the image border margin 
			"Button.textShiftOffset", 0
		];
		table.putDefaults(comDefaults);
		
		// *** ToggleButton
		comDefaults = [
			"ToggleButton.opaque", false, 
			"ToggleButton.defaultImage", ToggleButton_defaultImage,
			"ToggleButton.pressedImage", ToggleButton_pressedImage,
			"ToggleButton.disabledImage", ToggleButton_disabledImage,
			"ToggleButton.selectedImage", ToggleButton_selectedImage,
			"ToggleButton.disabledSelectedImage", ToggleButton_disabledSelectedImage,
			"ToggleButton.rolloverImage", ToggleButton_rolloverImage,
			"ToggleButton.rolloverSelectedImage", ToggleButton_rolloverSelectedImage,
			"ToggleButton.bg", SkinToggleButtonBackground,
			"ToggleButton.margin", new InsetsUIResource(2, 3, 3, 2) //modify this to fit the image border margin
		];
		table.putDefaults(comDefaults);

		// *** RadioButton
		comDefaults = [
			"RadioButton.icon", SkinRadioButtonIcon,
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
			"CheckBox.icon", SkinCheckBoxIcon,
			"CheckBox.defaultImage", CheckBox_defaultImage,
			"CheckBox.pressedImage", CheckBox_pressedImage,
			"CheckBox.pressedSelectedImage", CheckBox_pressedSelectedImage,
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
			
			"ScrollBar.bg", SkinScrollBarBackground, 
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
		
		// *** TextField
		comDefaults = [
			"TextField.opaque", false, 
			"TextField.bg", SkinTextFieldBackground,
			"TextField.border", new SkinEmptyBorder(2, 2, 2, 2), //modify this to fit the bg image
			"TextField.defaultImage", TextField_defaultImage, 
			"TextField.uneditableImage", TextField_uneditableImage, 
			"TextField.disabledImage", TextField_disabledImage
		];
		table.putDefaults(comDefaults);
		
		// *** TextArea
		comDefaults = [
			"TextArea.opaque", false, 
			"TextArea.bg", SkinTextFieldBackground,
			"TextArea.border", new SkinEmptyBorder(2, 2, 2, 2), //modify this to fit the bg image
			"TextArea.defaultImage", TextArea_defaultImage, 
			"TextArea.uneditableImage", TextArea_uneditableImage, 
			"TextArea.disabledImage", TextArea_disabledImage
		];
		table.putDefaults(comDefaults);
		
		// *** Frame
		comDefaults = [
			"Frame.background", table.get("window"), 
			"Frame.foreground", table.get("windowText"),
			"Frame.opaque", true, 
			"Frame.bg", SkinFrameBackground, //this will use Frame.activeBG and Frame.inactiveBG
			"Frame.titleBarHeight", 31, //modify this to fit title bar height of bg image
			"Frame.border", new SkinEmptyBorder(0, 5, 5, 5), //modify this to fit the frame bg image
			"Frame.activeBG", Frame_activeBG, 
			"Frame.inactiveBG", Frame_inactiveBG, 
			"Frame.titleBarLayout", SkinFrameTitleBarLayout, 
			"Frame.titleBarOpaque", false, 
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
		
		// *** ToolTip
		comDefaults = [
			"ToolTip.opaque", false, 
			"ToolTip.bg", SkinToolTipBackground, 
			"ToolTip.bgImage", ToolTip_bgImage, 
			"ToolTip.border", new SkinEmptyBorder(2, 2, 2, 2) //modify this to fit the bg image
		];
		table.putDefaults(comDefaults);
		
		// *** ComboBox
		comDefaults = [
			"ComboBox.opaque", false, 
			"ComboBox.bg", SkinComboBoxBackground,
			"ComboBox.border", new SkinEmptyBorder(2, 2, 2, 2), //modify this to fit the bg image
			"ComboBox.defaultImage", ComboBox_defaultImage, 
			"ComboBox.uneditableImage", ComboBox_uneditableImage, 
			"ComboBox.disabledImage", ComboBox_disabledImage, 
			"ComboBox.arrowButton.defaultImage", ComboBox_arrowButton_defaultImage,
			"ComboBox.arrowButton.pressedImage", ComboBox_arrowButton_pressedImage,
			"ComboBox.arrowButton.disabledImage", ComboBox_arrowButton_disabledImage,
			"ComboBox.arrowButton.rolloverImage", ComboBox_arrowButton_rolloverImage
		];
		table.putDefaults(comDefaults);
		
		// *** Accordion
		comDefaults = [
			"Accordion.tabMargin", new InsetsUIResource(2, 3, 3, 2),  //modify this to fit header image
			"Accordion.header.defaultImage", Accordion_header_defaultImage,
			"Accordion.header.pressedImage", Accordion_header_pressedImage,
			"Accordion.header.disabledImage", Accordion_header_disabledImage,
			"Accordion.header.rolloverImage", Accordion_header_rolloverImage, 
			"Accordion.header.selectedImage", Accordion_header_selectedImage
		];
		table.putDefaults(comDefaults);
		
		// *** TabbedPane
		comDefaults = [
			"TabbedPane.tabMargin", new InsetsUIResource(2, 3, 3, 2),  //modify this to fit header image
			"TabbedPane.top.tab.defaultImage", TabbedPane_top_tab_defaultImage,
			"TabbedPane.top.tab.pressedImage", TabbedPane_top_tab_pressedImage,
			"TabbedPane.top.tab.disabledImage", TabbedPane_top_tab_disabledImage,
			"TabbedPane.top.tab.rolloverImage", TabbedPane_top_tab_rolloverImage, 
			"TabbedPane.top.tab.selectedImage", TabbedPane_top_tab_selectedImage, 
			"TabbedPane.top.tab.rolloverSelectedImage", TabbedPane_top_tab_rolloverSelectedImage, 
			
			"TabbedPane.bottom.tab.defaultImage", TabbedPane_bottom_tab_defaultImage,
			"TabbedPane.bottom.tab.pressedImage", TabbedPane_bottom_tab_pressedImage,
			"TabbedPane.bottom.tab.disabledImage", TabbedPane_bottom_tab_disabledImage,
			"TabbedPane.bottom.tab.rolloverImage", TabbedPane_bottom_tab_rolloverImage, 
			"TabbedPane.bottom.tab.selectedImage", TabbedPane_bottom_tab_selectedImage, 
			"TabbedPane.bottom.tab.rolloverSelectedImage", TabbedPane_bottom_tab_rolloverSelectedImage, 
			
			"TabbedPane.left.tab.defaultImage", TabbedPane_left_tab_defaultImage,
			"TabbedPane.left.tab.pressedImage", TabbedPane_left_tab_pressedImage,
			"TabbedPane.left.tab.disabledImage", TabbedPane_left_tab_disabledImage,
			"TabbedPane.left.tab.rolloverImage", TabbedPane_left_tab_rolloverImage, 
			"TabbedPane.left.tab.selectedImage", TabbedPane_left_tab_selectedImage, 
			"TabbedPane.left.tab.rolloverSelectedImage", TabbedPane_left_tab_rolloverSelectedImage, 
			
			"TabbedPane.right.tab.defaultImage", TabbedPane_right_tab_defaultImage,
			"TabbedPane.right.tab.pressedImage", TabbedPane_right_tab_pressedImage,
			"TabbedPane.right.tab.disabledImage", TabbedPane_right_tab_disabledImage,
			"TabbedPane.right.tab.rolloverImage", TabbedPane_right_tab_rolloverImage, 
			"TabbedPane.right.tab.selectedImage", TabbedPane_right_tab_selectedImage, 
			"TabbedPane.right.tab.rolloverSelectedImage", TabbedPane_right_tab_rolloverSelectedImage,  
			
			"TabbedPane.arrowLeft.defaultImage", TabbedPane_arrowLeft_defaultImage, 
			"TabbedPane.arrowLeft.pressedImage", TabbedPane_arrowLeft_pressedImage, 
			"TabbedPane.arrowLeft.disabledImage", TabbedPane_arrowLeft_disabledImage, 
			"TabbedPane.arrowLeft.rolloverImage", TabbedPane_arrowLeft_rolloverImage, 
			
			"TabbedPane.arrowRight.defaultImage", TabbedPane_arrowRight_defaultImage, 
			"TabbedPane.arrowRight.pressedImage", TabbedPane_arrowRight_pressedImage, 
			"TabbedPane.arrowRight.disabledImage", TabbedPane_arrowRight_disabledImage, 
			"TabbedPane.arrowRight.rolloverImage", TabbedPane_arrowRight_rolloverImage, 
			
			"TabbedPane.contentMargin", new InsetsUIResource(14, 4, 4, 4), //modify this to fit TabbedPane_contentRoundImage
			"TabbedPane.top.contentRoundImage", TabbedPane_top_contentRoundImage, 
			"TabbedPane.bottom.contentRoundImage", TabbedPane_bottom_contentRoundImage, 
			"TabbedPane.left.contentRoundImage", TabbedPane_left_contentRoundImage, 
			"TabbedPane.right.contentRoundImage", TabbedPane_right_contentRoundImage, 
			"TabbedPane.contentRoundLineThickness", 4, //modify this to fit contentRoundImage
			"TabbedPane.bg", null //bg is managed by SkinTabbedPaneUI
		];
		table.putDefaults(comDefaults);
		
		// *** Slider
		/*comDefaults = [
			"Slider.vertical.trackImage", Slider_vertical_trackImage,
			"Slider.vertical.trackDisabledImage", Slider_vertical_trackDisabledImage,
			"Slider.vertical.trackProgressImage", Slider_vertical_trackProgressImage,
			"Slider.vertical.trackProgressDisabledImage", Slider_vertical_trackProgressDisabledImage,
			
			"Slider.horizontal.trackImage", Slider_vertical_trackImage,
			"Slider.horizontal.trackDisabledImage", Slider_vertical_trackDisabledImage,
			"Slider.horizontal.trackProgressImage", Slider_vertical_trackProgressImage,
			"Slider.horizontal.trackProgressDisabledImage", Slider_vertical_trackProgressDisabledImage,
			
			"Slider.thumb.defaultImage", Slider_thumb_defaultImage,
			"Slider.thumb.pressedImage", Slider_thumb_pressedImage,
			"Slider.thumb.disabledImage", Slider_thumb_disabledImage,
			"Slider.thumb.rolloverImage", Slider_thumb_rolloverImage,
			
			"Slider.thumbIcon", SkinSliderThumbIcon
		];
		table.putDefaults(comDefaults);*/
		
		 // *** Tree
		comDefaults = [
			"Tree.leafIcon", SkinTreeLeafIcon, 
			"Tree.folderExpandedIcon", SkinTreeFolderExpandedIcon, 
			"Tree.folderCollapsedIcon", SkinTreeFolderCollapsedIcon, 
			"Tree.leafImage", Tree_leafImage, 
			"Tree.folderExpandedImage", Tree_folderExpandedImage, 
			"Tree.folderCollapsedImage", Tree_folderCollapsedImage, 
			
			"Tree.leftChildIndent", 15, //modify this to fit control images width
			"Tree.rightChildIndent", 0, 
			"Tree.expandControl", SkinTreeExpandControl, 
			"Tree.leafControlImage", Tree_leafControlImage, 
			"Tree.folderExpandedControlImage", Tree_folderExpandedControlImage, 
			"Tree.folderCollapsedControlImage", Tree_folderCollapsedControlImage
		];
		table.putDefaults(comDefaults);
		
		// *** SplitPane
		comDefaults = [
			"SplitPane.presentDragColor", new ASColorUIResource(0x000000, 40), 
			
			"SplitPane.defaultDividerSize", 10, //modify this to fit the divier images
			"SplitPane.divider.verticalBGImage", SplitPane_divider_verticalBGImage, 
			"SplitPane.divider.horizotalBGImage", SplitPane_divider_horizotalBGImage, 
			
			"SplitPane.arrowLeft.defaultImage", SplitPane_arrowLeft_defaultImage, 
			"SplitPane.arrowLeft.pressedImage", SplitPane_arrowLeft_pressedImage, 
			"SplitPane.arrowLeft.disabledImage", SplitPane_arrowLeft_disabledImage, 
			"SplitPane.arrowLeft.rolloverImage", SplitPane_arrowLeft_rolloverImage, 
			
			"SplitPane.arrowRight.defaultImage", SplitPane_arrowRight_defaultImage, 
			"SplitPane.arrowRight.pressedImage", SplitPane_arrowRight_pressedImage, 
			"SplitPane.arrowRight.disabledImage", SplitPane_arrowRight_disabledImage, 
			"SplitPane.arrowRight.rolloverImage", SplitPane_arrowRight_rolloverImage, 
			
			"SplitPane.arrowUp.defaultImage", SplitPane_arrowUp_defaultImage, 
			"SplitPane.arrowUp.pressedImage", SplitPane_arrowUp_pressedImage, 
			"SplitPane.arrowUp.disabledImage", SplitPane_arrowUp_disabledImage, 
			"SplitPane.arrowUp.rolloverImage", SplitPane_arrowUp_rolloverImage, 
			
			"SplitPane.arrowDown.defaultImage", SplitPane_arrowDown_defaultImage, 
			"SplitPane.arrowDown.pressedImage", SplitPane_arrowDown_pressedImage, 
			"SplitPane.arrowDown.disabledImage", SplitPane_arrowDown_disabledImage, 
			"SplitPane.arrowDown.rolloverImage", SplitPane_arrowDown_rolloverImage
		];
		table.putDefaults(comDefaults);
		
		// *** ProgressBar
		comDefaults = [
			"ProgressBar.border", null, 
			"ProgressBar.foreground", table.get("controlText"),
			"ProgressBar.bg", SkinProgressBarBackground, 
			"ProgressBar.fg", SkinProgressBarForeground,
			"ProgressBar.fgMargin", new InsetsUIResource(2, 2, 2, 2), //modify this to margin fg
			"ProgressBar.verticalBGImage", ProgressBar_verticalBGImage, 
			"ProgressBar.horizotalBGImage", ProgressBar_horizotalBGImage, 
			"ProgressBar.verticalFGImage", ProgressBar_verticalFGImage, 
			"ProgressBar.horizotalFGImage", ProgressBar_horizotalFGImage
		];
		table.putDefaults(comDefaults);
	}	
}
}