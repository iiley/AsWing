package cases
{
	import flash.display.Sprite;
	import org.aswing.*;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;

	public class Panel extends Sprite
	{
		public function Panel(){
			super();
			var panel:JPanel = new JPanel();
			var button:JButton = new JButton("Button");
			panel.append(button);
			panel.append(new JButton("Button 1"));
			panel.append(new JButton("Button 2"));
			panel.append(new JButton("Button 3"));
			panel.setSizeWH(100, 60);
			addChild(panel);
			panel.validate();
		}
	}
}