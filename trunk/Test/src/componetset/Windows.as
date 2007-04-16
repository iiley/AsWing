package componetset{

import org.aswing.*;
import org.aswing.border.TitledBorder;
import flash.events.Event;

public class Windows extends JPanel{
	
	private var popup:JPopup;
	private var frame:JFrame;
	
	public function Windows(){
		super();
		name = "Windows, Keys";
		append(new JLabel("Ctrl+Shift+MnemonicKey to act the button"));
		var popButton:JButton = new JButton("Show a simple &Popup");
		var frameButton:JButton = new JButton("Show a &Frame");
		
		append(popButton);
		append(frameButton);
		
		popButton.addActionListener(__showPopup);
		popup = new JPopup(ComSet.WINDOW, true);
		var closeButton:JButton = new JButton("Close");
		var cancelbutton:JButton = new JButton("Do nothing");
		popup.setLayout(new FlowLayout());
		popup.setBorder(new TitledBorder(null, "Popup, just a simple popup"));
		popup.append(closeButton);
		popup.append(cancelbutton);
		closeButton.addActionListener(__closePopup);
		popup.setSizeWH(400, 200);
		popup.setLocationXY(100, 100);
		
		frameButton.addActionListener(__showFrame);
		frame = new JFrame(ComSet.WINDOW, "A Frame");
		var pane:JPanel = new JPanel();
		pane.append(new JLabel("Default button is close button(Press Enter to act)"));
		var closeButton2:JButton = new JButton("Close");
		closeButton2.addActionListener(__closeFrame);
		pane.append(closeButton2);
		var popupChild:JButton = new JButton("Popup a owned modal Frame(Shift+P)");
		popupChild.addActionListener(__popupChild);
		pane.append(popupChild);
		frame.setContentPane(pane);
		frame.setDefaultButton(closeButton2);
		frame.setComBoundsXYWH(100, 100, 400, 240);
		KeyboardManager.getInstance().registerKeyAction(
			new KeySequence(KeyStroke.VK_SHIFT, KeyStroke.VK_P), 
			__popupChild);
	}
	
	private function __showFrame(e:Event):void{
		frame.show();
	}
	
	private function __closeFrame(e:Event):void{
		frame.dispose();
	}
	
	private function __popupChild(e:Event=null):void{
		var fr:JFrame = new JFrame(frame, "Modal Frame", true);
		fr.setComBoundsXYWH(150, 150, 150, 80);
		fr.show();
	}
	
	private function __showPopup(e:Event):void{
		popup.show();
	}
	
	private function __closePopup(e:Event):void{
		popup.dispose();
	}
}
}