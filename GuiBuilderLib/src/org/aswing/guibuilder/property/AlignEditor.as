package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JComboBox;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.util.MathUtils;

public class AlignEditor extends AbsComboIntEditor{
	
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
		
	public function AlignEditor(){
		super(["Center", "Top", "Left", "Bottom", "Right"]);
	}
}
}