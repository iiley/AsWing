package componetset{

import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.BorderLayout;
import org.aswing.JComboBox;
import org.aswing.JTextField;
import org.aswing.JAdjuster;
import org.aswing.JTextArea;
import org.aswing.SoftBox;
import org.aswing.JScrollPane;
import org.aswing.ASColor;
import org.aswing.FloorPane;
import flash.display.DisplayObject;
import org.aswing.geom.IntDimension;
import org.aswing.JSlider;

public class Scrolls extends JPanel{
	[Embed(source="princess.jpg")]
	private var imgClass:Class;
	
	public function Scrolls(){
		super();
		name = "Scrolls";
		setOpaque(true);
		//setBackground(new ASColor(0xEEEEEE));
		
		var scrollPane:JScrollPane = new JScrollPane(new FloorPane(new imgClass() as DisplayObject));
		scrollPane.setPreferredSize(new IntDimension(300, 300));
		
		append(scrollPane);
		
		var slider:JSlider = new JSlider();
		append(slider);
		slider.setMajorTickSpacing(20);
		slider.setMinorTickSpacing(4);
		slider.setPaintTicks(true);
	}
	
}
}