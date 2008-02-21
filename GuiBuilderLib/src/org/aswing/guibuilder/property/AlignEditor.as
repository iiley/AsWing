package org.aswing.guibuilder.property{

import org.aswing.guibuilder.model.SimpleValue;
import org.aswing.guibuilder.model.ValueModel;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.Component;
import org.aswing.JComboBox;
import flash.events.Event;
import org.aswing.guibuilder.model.ProModel;
import org.aswing.guibuilder.util.MathUtils;
import org.aswing.util.HashMap;

public class AlignEditor extends BasePropertyEditor implements PropertyEditor {
	
	private var combo:JComboBox;
	
	private var values:HashMap;
	private var reverseValues:HashMap;
		
	public function AlignEditor(){
		values = new HashMap();
		values.put( "Center", 0 );
		values.put( "Top", 1 );
		values.put( "Left", 2 );
		values.put( "Bottom", 3 );
		values.put( "Right", 4 );
		
		reverseValues = new HashMap();
		reverseValues.put( 0, "Center" );
		reverseValues.put( 1, "Top" );
		reverseValues.put( 2, "Left" );
		reverseValues.put( 3, "Bottom" );
		reverseValues.put( 4, "Right" );
		
		combo = new JComboBox(["Center", "Top", "Left", "Bottom", "Right"]);
		combo.setEditable(true);
		combo.setPreferredWidth(70);
		combo.addActionListener(__apply);
	}
	
	override protected function fillValue(v:ValueModel, noValueSet:Boolean):void{
		if(noValueSet){
			combo.setSelectedItem("");
		}else {
			var index:int = MathUtils.parseInteger( String( v ) );
			combo.setSelectedItem( reverseValues.get( index ) );
		}
	}	
	
	override protected function getEditorValue():ValueModel{
		var value:* = combo.getSelectedItem();
		if(value == null || value == ""){
			return ProModel.NONE_VALUE_SET;
		}else{
			return new SimpleValue( values.get( value ) );
		}
	}
	
	public function getDisplay():Component{
		return combo;
	}	
	
	override public function setEditorParam(param:String):void{
		var arr:Array;
		if(param == "hor-only"){
			arr = ["Center", "Left", "Right"];
		}else if(param == "ver-only"){
			arr = ["Center", "Top", "Bottom"];
		}else{
			arr = ["Center", "Top", "Left", "Bottom", "Right"];
		}
		combo.setListData( arr );
	}
}
}