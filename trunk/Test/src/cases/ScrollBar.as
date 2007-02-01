package cases
{
	import flash.display.Sprite;
	import org.aswing.*;
	import org.aswing.event.*;
	import org.aswing.geom.IntRectangle;
	import org.aswing.geom.IntDimension;
	import org.aswing.geom.IntPoint;
	
	public class ScrollBar extends Sprite
	{
		private var vscroll:JScrollBar;
		private var hscroll:JScrollBar;
		private var container:JPanel;
		private var viewport:JViewport;
		
		public function ScrollBar()
		{
			super();
			var panel:JPanel = new JPanel(new BorderLayout());
			
			vscroll = new JScrollBar(JScrollBar.VERTICAL);
			vscroll.setValue(45);
			hscroll = new JScrollBar(JScrollBar.HORIZONTAL);
			panel.append(vscroll, BorderLayout.EAST);
			panel.append(hscroll, BorderLayout.SOUTH);
			hscroll.addStateListener(__vsListener);
			
			container = new JPanel(new FlowLayout(5, 5));
			for(var i:int=0; i<50; i++){
				container.append(new JButton("Button " + i));
			}
			//container.setPreferredSize(container.getPreferredSize());
			viewport = new JViewport(container);
			panel.append(viewport, BorderLayout.CENTER);
			
			panel.setSizeWH(300, 300);
			addChild(panel);
			panel.validate();
		}
		
		final private function __vsListener(e:InteractiveEvent):void{
			var x:int = hscroll.getValue()/(hscroll.getMaximum()-hscroll.getMinimum()) * viewport.getViewSize().width;
			viewport.setViewPosition(new IntPoint(x, 0));
			//trace("vscroll value : " + hscroll.getValue());
		}
	}
}