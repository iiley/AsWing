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
		loadPane.addEventListener(Event.COMPLETE, __onLoadInnit);
		loadPane.setVerticalAlignment(AssetPane.CENTER);
		pane.append(loadPane, BorderLayout.CENTER);
		var btn:JButton = new JButton("load 2");
		pane.append(btn, BorderLayout.SOUTH);
		pane.setSizeWH(100,400);
		this.addChild(pane);
		pane.validate();
		btn.addActionListener(__load2);
	}
	
	private function __load2(e:Event):void{
		loadPane.load(new URLRequest("../res/3.jpg"));
	}
	
	private function __onIOError(e:Event):void{
		loadPane.load(new URLRequest("../res/2.jpg"));
	}
	
	private function __onLoadInnit(e:Event):void{
		var info:LoaderInfo = loadPane.getAssetLoaderInfo();
		trace(info.url);
		trace(loadPane.getAsset().loaderInfo.url);
	}
}
}