package{

import flash.display.*;
import org.aswing.*;
import org.aswing.skinbuilder.*;
import componetset.*;

[SWF (width="800", height="600", backgroundColor="0xFFFFFF")]
public class ComSet extends Sprite{
	
	private var tabpane:JTabbedPane;
	
	public function ComSet(){
		super();
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.stageFocusRect = false;
		UIManager.setLookAndFeel(new SkinBuilderLAF());
		AsWingManager.setRoot(this);
		
		tabpane = new JTabbedPane();
		tabpane.append(new Buttons());
		tabpane.append(new Scrolls());
		
		tabpane.setSizeWH(800, 600);
		addChild(tabpane);
		tabpane.revalidate();
	}
	
}
}