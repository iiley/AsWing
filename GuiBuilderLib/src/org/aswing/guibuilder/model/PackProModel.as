package org.aswing.guibuilder.model{
	
import org.aswing.guibuilder.property.PackEditor;
import org.aswing.guibuilder.PropertyEditor;
import org.aswing.geom.IntDimension;
	

public class PackProModel extends ProModel{
	
	private var peditor:PackEditor;
	
	public function PackProModel(){
		super(null);
		peditor = new PackEditor(this);
	}
		
	public function applyProperty():void{
		var cm:ComModel = owner as ComModel;
		cm.getDisplay().pack();
		var size:IntDimension = cm.getDisplay().getSize();
		var pro:ProModel = cm.getProperty("Size");
		var xml:XML = <Property label="Size" name="Size" type="IntDimension" action="revalidate"></Property>;
		var valueStr:String = "<Value value='" + (size.width+","+size.height) + "'/>";
		xml.appendChild(new XML(valueStr));
		pro.parse(xml);
	}
	
	override public function bindTo(c:Model):void{
		owner = c;
	}
	
	override public function parse(xml:XML):void{
	}
	
	override public function encodeXML():XML{
		return null;
	}
	
	override public function getLabel():String{
		return "Count size";
	}
	
	override public function getName():String{
		return "Pack";
	}
	
	override public function getEditor():PropertyEditor{
		return peditor;
	}
}
}