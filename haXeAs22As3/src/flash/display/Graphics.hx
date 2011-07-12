package flash.display;

import flash.geom.Matrix;

class Graphics
{
   var nmeHandle:flash.MovieClip;

   public function new(inHandle:Dynamic)
   {
      nmeHandle = inHandle;
   }

   public function beginFill(color:Int, ?alpha:Float = 1.0)
   { 
	   alpha = Math.min(1, alpha);
	   nmeHandle.beginFill(color, alpha*100);
   }

   public function beginBitmapFill(bitmap:BitmapData, ?matrix:Matrix,
               repeat:Bool = true, smooth:Bool = false)
   {
		nmeHandle.beginBitmapFill(bitmap, matrix, repeat, smooth);
	 
   }

   public function beginGradientFill(type : GradientType,
                 colors : Array<Int>,
                 alphas : Array<Dynamic>,
                 ratios : Array<Dynamic>,
                 ?matrix : Matrix,
                 ?spreadMethod : Null<SpreadMethod>,
                 ?interpolationMethod : Null<InterpolationMethod>,
                 focalPointRatio:Float = 0.0 ) : Void
   {
	   if (matrix==null)
		{
		   matrix = new Matrix();
			matrix.createGradientBox(200,200,0,-100,-100);
		}
		nmeHandle.beginGradientFill(Std.string(type), colors, alphas, ratios, matrix, Std.string(spreadMethod), Std.string(interpolationMethod), focalPointRatio);
   }

   public function endFill(): Void
   { 
	   nmeHandle.endFill();
   }

   public function clear(): Void
   { 
	   nmeHandle.clear();
	   
   }

   public function lineStyle(?thickness:Null<Float>, color:Int = 0, alpha:Float = 1.0,
                      pixelHinting:Bool = false, ?scaleMode:LineScaleMode, ?caps:CapsStyle,
                      ?joints:JointStyle, miterLimit:Float = 3) : Void
   {
		nmeHandle.lineStyle(thickness, color, alpha, pixelHinting, Std.string(scaleMode), Std.string(caps), Std.string(joints),miterLimit);
		
   }




   public function moveTo(inX:Float, inY:Float)
   { 
	   nmeHandle.moveTo(inX, inY);
   }

   public function lineTo(inX:Float, inY:Float)
   { 
	    nmeHandle.lineTo(inX, inY);
   }

   public function curveTo(inCX:Float, inCY:Float, inX:Float, inY:Float)
   { 
	   nmeHandle.curveTo(inCX, inCY, inX, inY);
   }

 
	public function arcTo(x:Float, y:Float, r:Float, hour:Int) {
	   
		  var i:Int;
		  var alpha : Float;
		  var beta : Float;
		  var delta: Float;
		  var maxVal:Int = 12;
		  maxVal = 30;
		  i=0;
		  alpha = Math.PI;
		  delta = Math.PI/6;
		  delta = Math.PI*2/maxVal;
		 nmeHandle.moveTo(x,y);
		 nmeHandle.lineTo(x+Math.sin(alpha)*r,y+Math.cos(alpha)*r);
		  if(hour<0){
			hour=0;
		  }else if(hour>maxVal){
			hour=maxVal;
		  }
		  while(i<hour){
				beta = alpha - delta/2;
				alpha = alpha - delta;
			   nmeHandle.curveTo(
				  x+Math.sin(beta)*r,y+Math.cos(beta)*r,
				  x+Math.sin(alpha)*r,y+Math.cos(alpha)*r);
				i++;
		  }
		 nmeHandle.lineTo(x,y);
		 nmeHandle.endFill();
    }
   public function drawEllipse(x:Float, y:Float, width:Float, height:Float)
   { 
		var pi:Float = Math.PI;
        var xradius:Float = width/2;
        var yradius:Float = height/ 2;
        var cx:Float = x + xradius;
        var cy:Float = y + yradius;
        var tanpi8:Float = Math.tan(pi / 8);
        var cospi4:Float = Math.cos(pi / 4);
        var sinpi4:Float = Math.sin(pi / 4);
        nmeHandle.moveTo(xradius + cx, 0 + cy);
        nmeHandle.curveTo(xradius + cx, (yradius * tanpi8) + cy, (xradius * cospi4) + cx, (yradius * sinpi4) + cy);
        nmeHandle.curveTo((xradius * tanpi8) + cx, yradius + cy, 0 + cx, yradius + cy);
        nmeHandle.curveTo(((-xradius) * tanpi8) + cx, yradius + cy, ((-xradius) * cospi4) + cx, (yradius * sinpi4) + cy);
        nmeHandle.curveTo((-xradius) + cx, (yradius * tanpi8) + cy, (-xradius) + cx, 0 + cy);
        nmeHandle.curveTo((-xradius) + cx, ((-yradius) * tanpi8) + cy, ((-xradius) * cospi4) + cx, ((-yradius) * sinpi4) + cy);
        nmeHandle.curveTo(((-xradius) * tanpi8) + cx, (-yradius) + cy, 0 + cx, (-yradius) + cy);
        nmeHandle.curveTo((xradius * tanpi8) + cx, (-yradius) + cy, (xradius * cospi4) + cx, ((-yradius) * sinpi4) + cy);
        nmeHandle.curveTo(xradius + cx, ((-yradius) * tanpi8) + cy, xradius + cx, 0 + cy);	
   }

   public function drawCircle(cx:Float, cy:Float, r:Float)
   { 
		drawEllipse(cx-r, cy-r, r*2, r*2);
   }

   public function drawRect(x:Float, y:Float, width:Float, height:Float)
   {  
		nmeHandle.moveTo(x, y);
		nmeHandle.lineTo(x+width,y);
		nmeHandle.lineTo(x+width,y+height);
		nmeHandle.lineTo(x,y+height);
		nmeHandle.lineTo(x,y);	
   }

   public function drawRoundRect(x:Float, y:Float, width:Float, height:Float,
                                 inRadX:Float, ?inRadY:Float)
   { 
	   var trR:Float = -1;
	   var tlR:Float = -1;
	   var blR:Float = -1;
	   var brR:Float = -1;
	   if (inRadY == null)
	   {
		   inRadY = inRadX;
	   } 
		   
		if(tlR == -1) tlR = inRadX;
	   	if(trR == -1) trR = inRadX;
		if(blR == -1) blR = inRadY;
		if(brR == -1) brR = inRadY;
	  

		
		//Bottom right
		nmeHandle.moveTo(x+blR, y+height);
		nmeHandle.lineTo(x+width-brR, y+height);
		nmeHandle.curveTo(x+width, y+height, x+width, y+height-blR);
		//Top right
		nmeHandle.lineTo (x+width, y+trR);
		nmeHandle.curveTo(x+width, y, x+width-trR, y);
		//Top left
		nmeHandle.lineTo (x+tlR, y);
		nmeHandle.curveTo(x, y, x, y+tlR);
		//Bottom left
		nmeHandle.lineTo (x, y+height-blR );
		nmeHandle.curveTo(x, y+height, x+blR, y+height); 
   }

   public function drawTriangles(vertices:Array<Float>,
          ?indices:Array<Int>,
          ?uvtData:Array<Float>,
          ?culling:flash.display.TriangleCulling)
   {
      var cull:Int = culling==null ? 0 : Type.enumIndex(culling)-1;
 
   }


   public function drawGraphicsData(graphicsData:Array<IGraphicsData>):Void
   {
     
   }

   public function drawGraphicsDatum(graphicsDatum:IGraphicsData):Void
   {
       
   }

  
   inline static public function RGBA(inRGB:Int,inA:Int=0xff) : Int
	{
	 
		return inRGB | (inA <<24);
 
	}
   public function drawPoints(inXY:Array<Float>, inPointRGBA:Array<Int>=null,
         inDefaultRGBA:Int = #if neko 0x7fffffff #else 0xffffffff #end, inSize:Float = -1.0 )
   {
      
   }
 
}
