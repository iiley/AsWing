package cases
{
import flash.display.Sprite;
import flash.events.*;

import org.aswing.*;
import org.aswing.geom.IntDimension;
import org.aswing.border.LineBorder;

public class AttachPane extends Sprite
{
	private var pane:JPanel;
	private var attachPane:JAttachPane;
	private var loadPane:JLoadPane;
	public function AttachPane(){
		pane = new JPanel(new BorderLayout());
		loadPane = new JLoadPane("linkmc.swf", FloorPane.PREFER_SIZE_LAYOUT);
		loadPane.addEventListener(Event.INIT, __onLoadInnit);
		loadPane.setScaleMode(FloorPane.SCALE_FIT_PANE);
		loadPane.setPreferredSize(new IntDimension(100,100));
		loadPane.setBorder(new LineBorder(null, ASColor.BLUE));
	//	loadPane.setPath("http://192.168.0.202/linkmc.swf");				
		attachPane = new JAttachPane(null, FloorPane.PREFER_SIZE_BOTH);
		attachPane.setScaleMode(FloorPane.SCALE_FIT_PANE);
		attachPane.setVerticalAlignment(FloorPane.CENTER);
		attachPane.setBorder(new LineBorder(null, ASColor.RED));
		attachPane.setPreferredHeight(100);
		pane.append(loadPane, BorderLayout.CENTER);
		var preButton:JButton = new JButton();	
		preButton.setIcon(new LoadIcon("http://ihome.1001m.com/ihomestatics/images/daily/confirm2.png"));
		pane.append(preButton, BorderLayout.EAST);
		pane.append(attachPane, BorderLayout.NORTH);
		var southButton:JButton = new JButton();	
		southButton.setIcon(new AttachIcon("link_mc2"));
		pane.append(southButton, BorderLayout.SOUTH);
		pane.setSizeWH(200,300);

		this.addChild(pane);
		pane.validate();
	}

	private function __onLoadInnit(e:Event):void{
		attachPane.setPathAndLoader("link_mc2", loadPane.getLoader());	
	}
}
}