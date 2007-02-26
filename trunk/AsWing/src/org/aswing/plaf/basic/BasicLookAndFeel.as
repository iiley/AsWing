/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic
{
	
import org.aswing.*;
import org.aswing.plaf.*;
import org.aswing.plaf.basic.background.*;
import org.aswing.plaf.basic.border.*;
import org.aswing.plaf.basic.icon.*;
import org.aswing.plaf.basic.frame.*;
import org.aswing.resizer.*;

/**
 * Note: All empty object should be undefined or an UIResource instance.
 * Undefined/UIResource instance means not set, if it is null, means that user set it to be null, so LAF value will not be use. 
 * @author iiley
 */
public class BasicLookAndFeel extends LookAndFeel
{
	
	/**
	 * Need to extends it to make a completed LAF and implements features.
	 */
	public function BasicLookAndFeel(){
	}
	
	override public function getDefaults():UIDefaults{
		var table:UIDefaults  = new UIDefaults();

		initClassDefaults(table);
		initSystemColorDefaults(table);
		initSystemFontDefaults(table);
		initCommonUtils(table);
		initComponentDefaults(table);
	
		return table;
	}
	
	protected function initClassDefaults(table:UIDefaults):void{
		var uiDefaults:Array = [
			   "ButtonUI", org.aswing.plaf.basic.BasicButtonUI, 
			   "PanelUI", org.aswing.plaf.basic.BasicPanelUI, 
			   "ToggleButtonUI", org.aswing.plaf.basic.BasicToggleButtonUI,
			   "RadioButtonUI", org.aswing.plaf.basic.BasicRadioButtonUI,
			   "CheckBoxUI", org.aswing.plaf.basic.BasicCheckBoxUI, 
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
			   //"TabbedPaneUI", org.aswing.plaf.basic.BasicTabbedPaneUI,			   
		   ];
		table.putDefaults(uiDefaults);
	}
	
	protected function initSystemColorDefaults(table:UIDefaults):void{
			var defaultSystemColors:Array = [
				"activeCaption", 0xF7F7F7, /* Color for captions (title bars) when they are active. */
				"activeCaptionText", 0x000000, /* Text color for text in captions (title bars). */
				"activeCaptionBorder", 0xC0C0C0, /* Border color for caption (title bar) window borders. */
				"inactiveCaption", 0xE7E7E7, /* Color for captions (title bars) when not active. */
				"inactiveCaptionText", 0x666666, /* Text color for text in inactive captions (title bars). */
				"inactiveCaptionBorder", 0x888888, /* Border color for inactive caption (title bar) window borders. */
				"window", 0xCCCCCC, /* Default color for the interior of windows */
				"windowBorder", 0x000000, /* ??? */
				"windowText", 0x000000, /* ??? */
				"menu", 0xCCCCCC, /* Background color for menus */
				"menuText", 0x000000, /* Text color for menus  */
				"text", 0xC0C0C0, /* Text background color */
				"textText", 0x000000, /* Text foreground color */
				"textHighlight", 0x000080, /* Text background color when selected */
				"textHighlightText", 0xFFFFFF, /* Text color when selected */
				"textInactiveText", 0x808080, /* Text color when disabled */
				"control", 0xF4F4F4,//0xEFEFEF, /* Default color for controls (buttons, sliders, etc) */
				"controlText", 0x000000, /* Default color for text in controls */
				"controlHighlight", 0xEEEEEE, /* Specular highlight (opposite of the shadow) */
				"controlLtHighlight", 0x666666, /* Highlight color for controls */
				"controlShadow", 0xC7C7C5, /* Shadow color for controls */
				"controlDkShadow", 0x666666, /* Dark shadow color for controls */
				"scrollbar", 0xE0E0E0 /* Scrollbar background (usually the "track") */
			];
					
			for(var i:Number=0; i<defaultSystemColors.length; i+=2){
				table.put(defaultSystemColors[i], new ASColorUIResource(defaultSystemColors[i+1]));
			}
			table.put("focusInner", new ASColorUIResource(0x40FF40, 20));
			table.put("focusOutter", new ASColorUIResource(0x40FF40, 40));
					
	}
	
	protected function initSystemFontDefaults(table:UIDefaults):void{
		var defaultSystemFonts:Array = [
				"systemFont", new ASFontUIResource("Tahoma", 11), 
				"menuFont", new ASFontUIResource("Tahoma", 11), 
				"controlFont", new ASFontUIResource("Tahoma", 11), 
				"windowFont", new ASFontUIResource("Tahoma", 11)
		];
		table.putDefaults(defaultSystemFonts);
	}
	
	protected function initCommonUtils(table:UIDefaults):void{
		ResizerController.setDefaultResizerClass(DefaultResizer);
		var arrowColors:Array = [
		    "resizeArrow", table.get("inactiveCaption"),
		    "resizeArrowLight", table.get("window"),
		    "resizeArrowDark", table.get("activeCaptionText"),
		];
		table.putDefaults(arrowColors);
	}
	
	protected function initComponentDefaults(table:UIDefaults):void{
		var buttonBG:ASColorUIResource = new ASColorUIResource(0xE7E7E5);
		// *** Button
	    var comDefaults:Array = [
	    	"Button.background", buttonBG,
	    	"Button.foreground", table.get("controlText"),
	    	"Button.opaque", true,  
	    	"Button.focusable", true,  
	    	"Button.shadow", table.getColor("controlShadow"),        
        	"Button.darkShadow", table.getColor("controlDkShadow"),        
        	"Button.light", table.getColor("controlHighlight"),       
       		"Button.highlight", table.getColor("controlLtHighlight"),
        	"Button.font", table.getFont("controlFont"),
			"Button.bg", org.aswing.plaf.basic.background.ButtonBackground,
			"Button.margin", new InsetsUIResource(2, 3, 3, 2), 
			"Button.textShiftOffset", 1
		];
	    table.putDefaults(comDefaults);
	    
		// *** Panel
	    comDefaults = [
	    	"Panel.background", table.get("window"),
	    	"Panel.foreground", table.get("windowText"),
	    	"Panel.opaque", false,  
	    	"Panel.focusable", false,
        	"Panel.font", table.getFont("windowFont")
		];
	    table.putDefaults(comDefaults);
	    
		// *** ToggleButton
	    comDefaults = [
	    	"ToggleButton.background", buttonBG,
	    	"ToggleButton.foreground", table.get("controlText"),
	    	"ToggleButton.opaque", true, 
	    	"ToggleButton.focusable", true, 
	    	"ToggleButton.shadow", table.getColor("controlShadow"),        
        	"ToggleButton.darkShadow", table.getColor("controlDkShadow"),        
        	"ToggleButton.light", table.getColor("controlHighlight"),       
       		"ToggleButton.highlight", table.getColor("controlLtHighlight"),
        	"ToggleButton.font", table.getFont("controlFont"),
			"ToggleButton.bg", org.aswing.plaf.basic.background.ToggleButtonBackground,
			"ToggleButton.margin", new InsetsUIResource(2, 3, 3, 2), 
			"ToggleButton.textShiftOffset", 1
		];
	    table.putDefaults(comDefaults);
	    
		// *** RadioButton
	    comDefaults = [
	    	"RadioButton.background", table.get("control"),
	    	"RadioButton.foreground", table.get("controlText"),
	    	"RadioButton.opaque", false, 
	    	"RadioButton.focusable", true, 
	    	"RadioButton.shadow", table.getColor("controlShadow"),        
        	"RadioButton.darkShadow", table.getColor("controlDkShadow"),        
        	"RadioButton.light", table.getColor("controlHighlight"),       
       		"RadioButton.highlight", table.getColor("controlLtHighlight"),
        	"RadioButton.font", table.getFont("controlFont"),
		    "RadioButton.icon", org.aswing.plaf.basic.icon.RadioButtonIcon,
			"RadioButton.margin", new InsetsUIResource(0, 0, 0, 0), 
			"RadioButton.textShiftOffset", 1
		];
	    table.putDefaults(comDefaults);
	    
		// *** CheckBox
	    comDefaults = [
	    	"CheckBox.background", table.get("control"),
	    	"CheckBox.foreground", table.get("controlText"),
	    	"CheckBox.opaque", false, 
	    	"CheckBox.focusable", true, 
	    	"CheckBox.shadow", table.getColor("controlShadow"),        
        	"CheckBox.darkShadow", table.getColor("controlDkShadow"),        
        	"CheckBox.light", table.getColor("controlHighlight"),       
       		"CheckBox.highlight", table.getColor("controlLtHighlight"),
        	"CheckBox.font", table.getFont("controlFont"),
		    "CheckBox.icon", org.aswing.plaf.basic.icon.CheckBoxIcon,
			"CheckBox.margin", new InsetsUIResource(0, 0, 0, 0), 
			"CheckBox.textShiftOffset", 1
		];
	    table.putDefaults(comDefaults);
	    
	   // *** JTabbedPane
	    comDefaults = [
	    	"TabbedPane.background", new ASColorUIResource(0xE7E7E5),
	    	"TabbedPane.foreground", table.get("controlText"),
	    	"TabbedPane.opaque", false,  
	    	"TabbedPane.focusable", true,  
	    	"TabbedPane.shadow", new ASColorUIResource(0x888888),        
        	"TabbedPane.darkShadow", new ASColorUIResource(0x444444),        
        	"TabbedPane.light", table.getColor("controlHighlight"),       
       		"TabbedPane.highlight", new ASColorUIResource(0xFFFFFF),
		    "TabbedPane.arrowShadowColor", new ASColorUIResource(0x000000),
		    "TabbedPane.arrowLightColor", new ASColorUIResource(0x444444),
        	"TabbedPane.font", table.getFont("controlFont"),
			"TabbedPane.border", null,
			"TabbedPane.tabMargin", new InsetsUIResource(1, 1, 1, 1),
			"TabbedPane.baseLineThickness", 8,
			"TabbedPane.maxTabWidth", 1000,
		    //"TabbedPane.itemDecorator", org.aswing.plaf.basic.background.TabbedPaneItem			
		];
	    table.putDefaults(comDefaults);
	    
	    // *** Separator
	    comDefaults = [
		    "Separator.background", new ASColorUIResource(0x000000),
		    "Separator.foreground", new ASColorUIResource(0x000000),
	    	"Separator.opaque", false,
	    	"Separator.focusable", false
	    ];
	    table.putDefaults(comDefaults);	    
	    
	    // *** ScrollBar
	    comDefaults = [
	    	"ScrollBar.background", new ASColorUIResource(0xD0D0D0),
	    	"ScrollBar.foreground", table.get("controlText"),
    		"ScrollBar.opaque", true,  
    		"ScrollBar.focusable", true, 
        	"ScrollBar.font", table.getFont("controlFont"),
		    "ScrollBar.thumbBackground", table.get("control"),
		    "ScrollBar.thumbShadow", table.get("controlShadow"),
		    "ScrollBar.thumbDarkShadow", table.get("controlDkShadow"),
		    "ScrollBar.thumbHighlight", table.get("controlHighlight"),
		    "ScrollBar.thumbLightHighlight", table.get("controlLtHighlight"),
		    "ScrollBar.thumbDecorator", org.aswing.plaf.basic.background.ScrollBarThumb,
		    "ScrollBar.arrowShadowColor", new ASColorUIResource(0x000000),
		    "ScrollBar.arrowLightColor", new ASColorUIResource(0x444444)
	    ];
	    table.putDefaults(comDefaults);
	    
	    // *** ScrollPane
	    comDefaults = [
	    	"ScrollPane.opaque", false,  
	    	"ScrollPane.focusable", false  
	    ];
	    table.putDefaults(comDefaults);
	    
	    // *** ProgressBar
	    comDefaults = [
		    "ProgressBar.background", table.get("window"),
		    "ProgressBar.foreground", table.get("windowText"),
	    	"ProgressBar.opaque", false,
	    	"ProgressBar.focusable", false,        	
	    	"ProgressBar.font", new ASFontUIResource("Tahoma", 9),
			"ProgressBar.border", org.aswing.plaf.basic.border.ProgressBarBorder,
		    "ProgressBar.iconDecorator", org.aswing.plaf.basic.background.ProgressBarIcon,
			"ProgressBar.progressColor", new ASColorUIResource(0x3366CC)
	    ];
	    table.putDefaults(comDefaults);	    
	    
		// *** Panel
	    comDefaults = [
	    	"Viewport.background", table.get("window"),
	    	"Viewport.foreground", table.get("windowText"),
	    	"Viewport.opaque", false, 
	    	"Viewport.focusable", true, 
        	"Viewport.font", table.getFont("windowFont")
		];
	    table.putDefaults(comDefaults);
	    
	   // *** Label
	    comDefaults = [
		    "Label.background", table.get("control"),
		    "Label.foreground", table.get("controlText"),
	    	"Label.opaque", false, 
	    	"Label.focusable", false, 
        	"Label.font", table.getFont("controlFont")
		];
	    table.putDefaults(comDefaults);
	    
	   // *** TextField
	    comDefaults = [
		    "TextField.background", new ASColorUIResource(0xF3F3F3),
		    "TextField.foreground", new ASColorUIResource(0x000000),
	    	"TextField.opaque", true,  
	    	"TextField.focusable", true,
	        "TextField.light", new ASColorUIResource(0xDCDEDD),
	        "TextField.shadow", new ASColorUIResource(0x666666),
        	"TextField.font", table.getFont("controlFont"),
			"TextField.bg", org.aswing.plaf.basic.background.TextComponentBackBround,
		    "TextField.border", org.aswing.plaf.basic.border.TextFieldBorder
		];
	    table.putDefaults(comDefaults);
	    
	   // *** TextArea
	    comDefaults = [
		    "TextArea.background", new ASColorUIResource(0xF3F3F3),
		    "TextArea.foreground", new ASColorUIResource(0x000000),
	    	"TextArea.opaque", true,  
	    	"TextArea.focusable", true,
	        "TextArea.light", new ASColorUIResource(0xDCDEDD),
	        "TextArea.shadow", new ASColorUIResource(0x666666),
        	"TextArea.font", table.getFont("controlFont"),
			"TextArea.bg", org.aswing.plaf.basic.background.TextComponentBackBround,
		    "TextArea.border", org.aswing.plaf.basic.border.TextAreaBorder
		];
	    table.putDefaults(comDefaults);
	    
	    // *** Frame
	    comDefaults = [
		    "Frame.background", table.get("window"),
		    "Frame.foreground", table.get("windowText"),
	    	"Frame.opaque", true,  
	    	"Frame.focusable", true,
		    "Frame.activeCaption", table.get("activeCaption"),
		    "Frame.activeCaptionText", table.get("activeCaptionText"),
		    "Frame.activeCaptionBorder", table.get("activeCaptionBorder"),
		    "Frame.inactiveCaption", table.get("inactiveCaption"),
		    "Frame.inactiveCaptionText", table.get("inactiveCaptionText"),
		    "Frame.inactiveCaptionBorder", table.get("inactiveCaptionBorder"),
		    "Frame.titleBarUI", org.aswing.plaf.basic.frame.TitleBarUI,
		    "Frame.resizer", org.aswing.resizer.DefaultResizer,
		    "Frame.font", table.get("windowFont"),
		    "Frame.border", org.aswing.plaf.basic.border.FrameBorder,
		    "Frame.icon", org.aswing.plaf.basic.icon.TitleIcon,
		    "Frame.iconifiedIcon", org.aswing.plaf.basic.icon.FrameIconifiedIcon,
		    "Frame.normalIcon", org.aswing.plaf.basic.icon.FrameNormalIcon,
		    "Frame.maximizeIcon", org.aswing.plaf.basic.icon.FrameMaximizeIcon,
		    "Frame.closeIcon", org.aswing.plaf.basic.icon.FrameCloseIcon
	    ];
	    table.putDefaults(comDefaults);	    
	    
	    // *** ToolTip
	    comDefaults = [
		    "ToolTip.background", new ASColorUIResource(0xFFFFD5),
		    "ToolTip.foreground", table.get("controlText"),
	    	"ToolTip.opaque", true, 
	    	"ToolTip.focusable", false, 
	    	"ToolTip.borderColor", table.get("controlText"),
        	"ToolTip.font", table.getFont("controlFont"),
		    "ToolTip.border", org.aswing.plaf.basic.border.ToolTipBorder
	    ];
	    table.putDefaults(comDefaults);
	    
	    // *** List
	    comDefaults = [
	        "List.font", table.getFont("controlFont"),
		    "List.background", table.get("control"),
		    "List.foreground", table.get("controlText"),
	    	"List.opaque", false, 
	    	"List.focusable", true, 
	        "List.selectionBackground", new ASColorUIResource(0x444444),
		    "List.selectionForeground", table.get("control")
	    ];
	    table.putDefaults(comDefaults);
	    
	    // *** ComboBox
	    comDefaults = [
	        "ComboBox.font", table.getFont("controlFont"),
		    "ComboBox.background", table.get("control"),
		    "ComboBox.foreground", table.get("controlText"),
	    	"ComboBox.opaque", true, 
	    	"ComboBox.focusable", true, 
	    	"ComboBox.shadow", table.getColor("controlShadow"),        
	    	"ComboBox.darkShadow", table.getColor("controlDkShadow"),        
	    	"ComboBox.light", table.getColor("controlHighlight"),       
	   		"ComboBox.highlight", table.getColor("controlLtHighlight"),
		    "ComboBox.border", org.aswing.plaf.basic.border.ComboBoxBorder,
		    "ComboBox.arrowShadowColor", new ASColorUIResource(0x000000),
		    "ComboBox.arrowLightColor", new ASColorUIResource(0x444444)
	    ];
	    table.putDefaults(comDefaults);
	}
	
}
}