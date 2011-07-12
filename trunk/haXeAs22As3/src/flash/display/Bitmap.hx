package flash.display;

import flash.display.DisplayObject;
import flash.display.PixelSnapping;

class Bitmap extends DisplayObject {
   public var bitmapData(default,setBitmapData) : BitmapData;
   public var pixelSnapping : PixelSnapping;
   public var smoothing : Bool;
 

   public function new(?inBitmapData : BitmapData, ?inPixelSnapping : PixelSnapping, ?inSmoothing : Bool) : Void {
         super();
         pixelSnapping = inPixelSnapping;
         smoothing = inSmoothing;
         setBitmapData(inBitmapData);
   }

   function setBitmapData(inBitmapData:BitmapData) : BitmapData
   {
      var gfx :Graphics= graphics;
      gfx.clear();
	  bitmapData = inBitmapData;
      if (inBitmapData!=null)
      {
         gfx.beginBitmapFill(inBitmapData,false,smoothing);
         gfx.drawRect(0,0,inBitmapData.width,inBitmapData.height);
         gfx.endFill();
      }
      return inBitmapData;
   }

}

