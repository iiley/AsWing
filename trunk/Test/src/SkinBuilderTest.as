package
{
	import flash.display.*;
	import org.aswing.*;
	import org.aswing.skinbuilder.*;
	import cases.*;

    [SWF (width="400", height="450")]
	public class SkinBuilderTest extends Sprite
	{
		public function SkinBuilderTest()
		{
			super();
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.stageFocusRect = false;
			UIManager.setLookAndFeel(new SkinBuilderLAF());
			AsWingManager.setRoot(this);
			//create other case instance here to test others
			//for example change below with addChild(new Button());
			//to test buttons.
			addChild(new TabbedPane());
			
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0xff0000);
			sprite.graphics.drawRect(0, 0, 200, 20);
			sprite.graphics.endFill();
			//addChild(sprite);
			sprite.rotation = -90;
			sprite.y = sprite.height;
			sprite.height = 100;
			sprite.y = sprite.height;
			trace("width " + sprite.width);
			trace("height " + sprite.height);
		}
		
	}
}