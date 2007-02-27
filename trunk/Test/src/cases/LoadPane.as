package cases
{
import flash.display.Sprite;
import org.aswing.JPanel;
import org.aswing.BorderLayout;
import org.aswing.JLoadPane;
import org.aswing.FloorPane;
import org.aswing.JButton;

public class LoadPane extends Sprite
{
	private var pane:JPanel;
	private var loadPane:JLoadPane;
	public function LoadPane(){
		pane = new JPanel(new BorderLayout());
		loadPane = new JLoadPane(null, FloorPane.BOTTOM);
		loadPane.setPath("http://192.168.0.202/ihomestatics/images/iBox_1.swf");
		loadPane.setScaleMode(FloorPane.SCALE_FIT_PANE);
		loadPane.setVerticalAlignment(FloorPane.CENTER);
		pane.append(loadPane, BorderLayout.CENTER);
		pane.append(new JButton("sadfasdfa"), BorderLayout.SOUTH);
		pane.setSizeWH(100,100);
		this.addChild(pane);
		pane.validate();
	}
}
}