/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic
{
	
import org.aswing.*;
import org.aswing.plaf.*;
import org.aswing.plaf.basic.background.ButtonBackgound;
import org.aswing.plaf.basic.icon.CheckBoxIcon;

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
		initComponentDefaults(table);
	
		return table;
	}
	
	protected function initClassDefaults(table:UIDefaults):void{
		var uiDefaults:Array = [
			   "ButtonUI", org.aswing.plaf.basic.BasicButtonUI, 
			   "PanelUI", org.aswing.plaf.basic.BasicPanelUI, 
			   "ToggleButtonUI", org.aswing.plaf.basic.BasicToggleButtonUI,
			   "RadioButtonUI", org.aswing.plaf.basic.BasicRadioButtonUI,
			   "CheckBoxUI", org.aswing.plaf.basic.BasicCheckBoxUI
		   ];
		table.putDefaults(uiDefaults);
	}
	
	protected function initSystemColorDefaults(table:UIDefaults):void{
			var defaultSystemColors:Array = [
				"activeCaption", 0xE0E0E0, /* Color for captions (title bars) when they are active. */
				"activeCaptionText", 0x000000, /* Text color for text in captions (title bars). */
				"activeCaptionBorder", 0xC0C0C0, /* Border color for caption (title bar) window borders. */
				"inactiveCaption", 0x808080, /* Color for captions (title bars) when not active. */
				"inactiveCaptionText", 0x666666, /* Text color for text in inactive captions (title bars). */
				"inactiveCaptionBorder", 0xC0C0C0, /* Border color for inactive caption (title bar) window borders. */
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
			table.put("focusInner", new ASColorUIResource(0x40FF40, 30));
			table.put("focusOutter", new ASColorUIResource(0x40FF40, 50));
					
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
			"Button.bg", org.aswing.plaf.basic.background.ButtonBackgound,
			"Button.margin", new InsetsUIResource(2, 2, 2, 2), 
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
			"ToggleButton.margin", new InsetsUIResource(2, 2, 2, 2), 
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
	}
	
}
}