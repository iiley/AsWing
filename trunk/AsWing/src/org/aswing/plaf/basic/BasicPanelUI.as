/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.plaf.basic
{

import org.aswing.*;
import org.aswing.plaf.BaseComponentUI;

public class BasicPanelUI extends BaseComponentUI
{
	public function BasicPanelUI()
	{
		super();
	}
	
    override public function installUI(c:Component):void {
        var p:JPanel = JPanel(c);
        installDefaults(p);
    }

    override public function uninstallUI(c:Component):void {
        var p:JPanel = JPanel(c);
        uninstallDefaults(p);
    }

    private function installDefaults(p:JPanel):void {
    	var pp:String = "Panel.";
        LookAndFeel.installColorsAndFont(p, pp + "background", pp + "foreground", pp + "font");
        LookAndFeel.installBorderAndBFDecorators(p, pp + "border", pp+"bg", pp+"fg");
        LookAndFeel.installBasicProperties(p, pp);
    }

    private function uninstallDefaults(p:JPanel):void {
        LookAndFeel.uninstallBorderAndBFDecorators(p);
    }
}
}