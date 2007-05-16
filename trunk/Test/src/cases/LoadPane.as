package cases{

import flash.display.*;
import flash.events.*;
import org.aswing.*;
import org.aswing.border.*;
import flash.net.URLRequest;

public class LoadPane extends Sprite
{
	private var pane:JPanel;
	private var loadPane:JLoadPane;
	public function LoadPane(){
		pane = new JPanel(new BorderLayout());
		loadPane = new JLoadPane("../res/princess.jpg");
		loadPane.setScaleMode(AssetPane.SCALE_FIT_PANE);
		loadPane.setBorder(new LineBorder(null,ASColor.GREEN));
		loadPane.addEventListener(IOErrorEvent.IO_ERROR, __onIOError);
		loadPane.addEventListener(Event.INIT, __onLoadInnit);
		loadPane.setVerticalAlignment(AssetPane.CENTER);
		pane.append(loadPane, BorderLayout.CENTER);
		pane.append(new JButton("sadfasdfa"), BorderLayout.SOUTH);
		pane.setSizeWH(100,400);
		this.addChild(pane);
		pane.validate();
	}
	
	private function __onIOError(e:Event):void{
		loadPane.load(new URLRequest("../res/princess.jpg"));
	}
	
	private function __onLoadInnit(e:Event):void{
	}
}
}