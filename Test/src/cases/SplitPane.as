package cases
{
import flash.display.Sprite;
import org.aswing.JSplitPane;
import org.aswing.JButton;
import org.aswing.border.LineBorder;
import org.aswing.ASColor;
import org.aswing.JPanel;
import org.aswing.BorderLayout;

public class SplitPane extends Sprite
{
	public function SplitPane(){
		super();
		var pane:JPanel = new JPanel(new BorderLayout());
		
		var sp:JSplitPane = new JSplitPane();
		sp.setBorder(new LineBorder(null, ASColor.BLUE, 1));
		//pane.setTopComponent(new JButton("Top"));
		sp.setLeftComponent(new JButton("Left"));
		sp.setRightComponent(new JButton("Right"));
		//sp.setBottomComponent(new JButton("Bottom"));
		sp.setOrientation(JSplitPane.VERTICAL_SPLIT);
		sp.setOneTouchExpandable(false);
		pane.append(sp, BorderLayout.CENTER);
		pane.setSizeWH(300,300);
		this.addChild(pane);
		pane.validate();
	}
}
}