package cases
{
	import flash.display.Sprite;
	import org.aswing.*;
	import flash.events.Event;

	public class TextFieldCase extends Sprite
	{
		private var panel:JRootPane;
		
		public function TextFieldCase()
		{
			super();
			
			panel = new JRootPane();
			panel.setLayout(new FlowLayout());
			var text:JTextField = new JTextField("input");
			text.setCachePreferSizes(false);
			panel.append(text);
			text.addActionListener(__revalidate);
			panel.append(new JTextField("JTextField1", 8));
			panel.append(new JTextField("JTextField2", 10));
			panel.append(new JTextField("JTextField3", 20));
			panel.append(new JButton("&Button"));
			
			var button:JButton = new JButton("Revalidate");
			panel.append(button);
			panel.setSizeWH(300, 200);
			addChild(panel);
			panel.validate();
			
			button.addActionListener(__revalidate);
		}
		
		private function __revalidate(e:Event):void{
			panel.revalidate();
		}
	}
}