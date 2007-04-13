package componetset{
	
import org.aswing.*;
import cases.ColorDotIcon;

public class Buttons extends JPanel{
	
	public function Buttons(){
		super(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
		name = "Buttons";
		
		var jbuttons:JPanel = new JPanel();
		var jbtn1:JButton = new JButton("JButton");
		var jbtn2:JButton = new JButton("JButton Disabled");
		jbtn2.setEnabled(false);
		var jbtn3:JButton = new JButton("With Icon", new ColorDotIcon(20, ASColor.RED));
		jbuttons.append(jbtn1);
		jbuttons.append(jbtn2);
		jbuttons.append(jbtn3);
		append(jbuttons);
		
		var toggles:JPanel = new JPanel();
		var tog1:JToggleButton = new JToggleButton("JToggleButton");
		var tog2:JButton = new JButton("Disabled");
		tog2.setEnabled(false);
		var tog3:JButton = new JButton("Icon", new ColorDotIcon(10, ASColor.BLUE));
		toggles.append(tog1);
		toggles.append(tog2);
		toggles.append(tog3);
		append(toggles);
		
		var checks:JPanel = new JPanel();
		var che1:JCheckBox = new JCheckBox("JCheckBox");
		var che2:JCheckBox = new JCheckBox("Disabled");
		che2.setEnabled(false);
		var che3:JCheckBox = new JCheckBox("Selected Disabled");
		che3.setSelected(true);
		che3.setEnabled(false);
		checks.append(che1);
		checks.append(che2);
		checks.append(che3);
		append(checks);
		
		var radios:JPanel = new JPanel();
		var rad1:JCheckBox = new JRadioButton("JRadioButton");
		var rad2:JCheckBox = new JRadioButton("Disabled");
		rad2.setEnabled(false);
		var rad3:JCheckBox = new JRadioButton("Selected Disabled");
		rad3.setSelected(true);
		rad3.setEnabled(false);
		var rad4:JCheckBox = new JRadioButton("In fact they are in a Group");
		var group:ButtonGroup = new ButtonGroup();
		group.append(rad1);
		group.append(rad2);
		group.append(rad3);
		group.append(rad4);
		radios.append(rad1);
		radios.append(rad2);
		radios.append(rad3);
		radios.append(rad4);
		append(radios);
	}
	
}
}