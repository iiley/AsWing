/*
 Copyright aswing.org, see the LICENCE.txt.
*/

package org.aswing.skinbuilder{
	
import org.aswing.*;

public class SkinComboBoxBackground extends SkinAbsEditorBackground{
	
	public function SkinComboBoxBackground(){
		super();
	}
	
	override protected function getPropertyPrefix():String {
        return "ComboBox.";
    }
}
}