package cases
{
	import flash.display.Sprite;
	import org.aswing.*;

	public class TextAreaCase extends Sprite
	{
		private var textArea:JTextArea;
		
		public function TextAreaCase()
		{
			super();
			var panel:JPanel = new JPanel(new BorderLayout());
						
			textArea = new JTextArea();
			for(var i:int=0; i<40; i++){
				textArea.appendText("text " + i + "\n");
			}
			
			var scrollPane:JScrollPane = new JScrollPane(textArea);
			panel.append(scrollPane, BorderLayout.CENTER);
			
			panel.setSizeWH(300, 300);
			addChild(panel);
			panel.validate();
		}
		
	}
}