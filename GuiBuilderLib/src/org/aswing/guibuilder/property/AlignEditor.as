package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JComboBox;

public class AlignEditor implements PropertyEditor{
	
    public static const CENTER:int  = 0;

    // 
    // Box-orientation constant used to specify locations in a box.
    //
    /** 
     * Box-orientation constant used to specify the top of a box.
     */
    public static const TOP:int     = 1;
    /** 
     * Box-orientation constant used to specify the left side of a box.
     */
    public static const LEFT:int    = 2;
    /** 
     * Box-orientation constant used to specify the bottom of a box.
     */
    public static const BOTTOM:int  = 3;
    /** 
     * Box-orientation constant used to specify the right side of a box.
     */
    public static const RIGHT:int   = 4;	
	
	private var alignCombo:JComboBox;
	private var aligns:Array = ["Center", "Top", "Left", "Bottom", "Right"];
	
	public function AlignEditor(){
		alignCombo = new JComboBox(aligns);	
		alignCombo.setPreferredWidth(70);
	}
	
	public function getDisplay():Component{
		return alignCombo;
	}
	
	public function applyProperty(apply:Function):void{
		var index:int = alignCombo.getSelectedIndex();
		if(index >= 0){
			apply(index);
		}
	}
	
}
}