package cases.table{

import org.aswing.table.DefaultTextCell;
import cases.*;
import org.aswing.*;

public class SexIconCell extends DefaultTextCell{
	
	private static var MALE_ICON:Icon;
	private static var FEMALE_ICON:Icon;
	
	public function SexIconCell(){
		super();
		if(MALE_ICON == null){
			FEMALE_ICON = new CircleIcon(ASColor.RED, 18, 18);
			MALE_ICON = new ColorIcon(ASColor.BLUE, 18, 18);
		}
	}
	
	override public function setCellValue(value:*) : void {
		this.value = value;
		setText(value.toString());
		if(value){
			setIcon(MALE_ICON);
		}else{
			setIcon(FEMALE_ICON);
		}
	}
}
}