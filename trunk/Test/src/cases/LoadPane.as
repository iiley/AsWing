package cases
{
import flash.display.Sprite;
import org.aswing.JPanel;
import org.aswing.BorderLayout;
import org.aswing.JLoadPane;
import org.aswing.FloorPane;
import org.aswing.JButton;
import flash.events.*;
import org.aswing.border.LineBorder;
import org.aswing.ASColor;

public class LoadPane extends Sprite
{
	private var pane:JPanel;
	private var loadPane:JLoadPane;
	public function LoadPane(){
		pane = new JPanel(new BorderLayout());
		loadPane = new JLoadPane("http://192.168.0.202/ihomestatics/images/mail3.gif", FloorPane.CENTER);
		loadPane.setScaleMode(FloorPane.SCALE_FIT_PANE);
		loadPane.setBorder(new LineBorder(null,ASColor.GREEN));
		loadPane.addEventListener(IOErrorEvent.IO_ERROR, __onIOError);
		loadPane.addEventListener(Event.INIT, __onLoadInnit);
		loadPane.setVerticalAlignment(FloorPane.CENTER);
		pane.append(loadPane, BorderLayout.NORTH);
		pane.append(new JButton("sadfasdfa"), BorderLayout.SOUTH);
		pane.setSizeWH(100,100);
		this.addChild(pane);
		pane.validate();
	}
	
	private function __onIOError(e:Event):void{
		loadPane.setPath("http://192.168.0.202/ihomestatics/images/mail.gif");
		//loadPane.setPath("linkmc.swf");
	}
	
	private function __onLoadInnit(e:Event):void{
		//loadPane.setPath(null);
	}
}
}