package org.aswing.guibuilder.property{

import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JComboBox;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.util.MathUtils;

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
		alignCombo.addActionListener(__apply);
	}
	
	private function __apply(e:Event):void{
		applyProperty();
	}
	
	public function parseValue(xml:XML):*{
		var index:int = MathUtils.parseInteger(xml.@value);
		alignCombo.setSelectedIndex(index);
		return index;
	}
	
	public function encodeValue(value:*):XML{
		var xml:XML = <Value></Value>;
		xml.@value = value+"";
		return xml;
	}
	
	public function getDisplay():Component{
		return alignCombo;
	}
	
	protected var apply:Function;
	public function setApplyFunction(apply:Function):void{
		this.apply = apply;
	}
	
	public function applyProperty():void{
		var index:int = alignCombo.getSelectedIndex();
		if(index >= 0){
			apply(index);
		}else{
			apply(ProModel.NONE_VALUE_SET);
		}
	}
	
}
}