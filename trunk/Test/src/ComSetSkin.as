package{

import componetset.*;

import flash.display.*;

import org.aswing.*;
import org.aswing.border.EmptyBorder;

[SWF (width="800", height="600")]//, backgroundColor="0xFFFFFF")]
public class ComSetSkin extends Sprite{
	
	private var tabpane:JTabbedPane;
	public static var WINDOW:JPopup;
	
	public function ComSetSkin(){
		super();
		AsWingManager.initAsStandard(this);
		//UIManager.setLookAndFeel(new SkinBuilderLAF());
		
		WINDOW = new JPopup();
		
		tabpane = new JTabbedPane();
		/*tabpane.append(new Buttons());
		tabpane.append(new Scrolls());
		tabpane.append(new Containers());
		tabpane.append(new HeavyComs());
		tabpane.append(new Windows());
		tabpane.append(new Menus());
		tabpane.append(new Decorators());
		tabpane.setOpaque(true);*/
		//tabpane.setBackground(ASColor.HALO_BLUE);
		tabpane.appendTab(new JButton(), "bttton 1");
		tabpane.appendTab(new JTextArea(), "text area");
		
		WINDOW.append(tabpane);
		WINDOW.setBorder(new EmptyBorder(null, new Insets(4, 4, 4, 4)));
		//WINDOW.setContentPane(tabpane);
		WINDOW.setSizeWH(800, 600);
		WINDOW.show();
	}
}
}