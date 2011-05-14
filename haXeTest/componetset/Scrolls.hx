package componetset;

	import org.aswing.JProgressBar;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import org.aswing.JSlider;
	import org.aswing.JScrollPane;
	import org.aswing.JPanel;
	import org.aswing.geom.IntDimension;
	import flash.events.Event;
	import org.aswing.AssetPane;
class Scrolls extends JPanel{
	//[Embed(source="princess.jpg")]
	private var imgClass:Loader;
	
	public function new(){
		super();
		name = "Scrolls";
		imgClass = new Loader();
		imgClass.load(new URLRequest("2.jpg"));
		imgClass.contentLoaderInfo.addEventListener(  Event.COMPLETE, __COMPLETE);
	}
	private function __COMPLETE(e:Event):Void
	{
		var scrollPane:JScrollPane = new JScrollPane(new AssetPane(imgClass));// new AssetPane(new imgClass() as DisplayObject));
		scrollPane.setPreferredSize(new IntDimension(300, 300));
		
		append(scrollPane);
		
		var slider:JSlider = new JSlider();
		append(slider);
		slider.setMajorTickSpacing(20);
		slider.setMinorTickSpacing(4);
		slider.setPaintTicks(true);
		slider.setShowValueTip(true);
		
		var progress:JProgressBar = new JProgressBar();
		progress.setIndeterminate(true);
		append(progress);
	}
	
}