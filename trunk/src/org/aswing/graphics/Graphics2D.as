package org.aswing.graphics
{

import flash.display.Graphics;

/**
 * Graphics, use to paint graphics contexts on a MovieClip.
 * @author iiley
 */
class Graphics2D {
	
	private var target:Graphics;
	private var brush:Brush;
	
	/**
	 * Create a graphics with target Graphics.
	 * @param target where the graphics contexts will be paint on.
	 */
	public function Graphics2D(target:Graphics){
		this.target = target;
	}
	
	private function setTarget(target:Graphics):void{
		this.target = target;
	}
	
	private function dispose():void{
		target = null;
	}
	
	private function startPen(p:Pen):void{
		p.setTo(target);
	}
	
	private function endPen():void{
		target.lineStyle();
		target.moveTo(0, 0); //avoid a drawing error
	}
	
	private function startBrush(b:Brush):void{
		brush = b;
		b.beginFill(target);
	}
	
	private function endBrush():void{
		brush.endFill(target);
		target.moveTo(0, 0); //avoid a drawing error
	}
	
	//-------------------------------Public Functions-------------------
	/**
	 * Clears the graphics contexts drawn on the target Graphics.
	 */
	private function clear():void {
		if(target!=undefined) target.clear();
	}
	
	/**
	 * Draws a line. 
	 * Between the points (x1, y1) and (x2, y2) in the target Graphics. 
	 * @param p the pen to draw
	 * @param x1 the x corrdinate of the first point.
	 * @param y1 the y corrdinate of the first point.
	 * @param x2 the x corrdinate of the sencod point.
	 * @param y2 the y corrdinate of the sencod point.
	 */
	public function drawLine(p:Pen, x1:Number, y1:Number, x2:Number, y2:Number):void {
		startPen(p);
		line(x1, y1, x2, y2);
		endPen();
	}
	
	/**
	 * Draws a polyline. (not close figure automaticlly)<br>
	 * Start with the points[0] and end of the points[points.length-1] as a closed path. 
	 * 
	 * @param p the pen to draw
	 * @param points the Array contains all vertex points in the polygon.
	 * @see #polyline()
	 */
	public function drawPolyline(p:Pen, points:Array):void{
		startPen(p);
		polyline(points);
		endPen();
	}
	
	/**
	 * Fills a polygon.(not close figure automaticlly)<br>
	 * Start with the points[0] and end of the points[points.length-1] as a closed path. 
	 * 
	 * @param b the brush to fill.
	 * @param points the Array contains all vertex points in the polygon.
	 * @see #polyline()
	 */	
	public function fillPolyline(b:Brush, points:Array):void{
		startBrush(b);
		polyline(points);
		endBrush();
	}
	
	/**
	 * Draws a polygon.(close figure automaticlly)<br>
	 * Start with the points[0] and end of the points[0] as a closed path. 
	 * 
	 * @param p the pen to draw
	 * @param points the Array contains all vertex points in the polygon.
	 * @see #polygon()
	 */
	public function drawPolygon(p:Pen, points:Array):void{
		startPen(p);
		polygon(points);
		endPen();
	}
	
	/**
	 * Fills a polygon.(close figure automaticlly)<br>
	 * Start with the points[0] and end of the points[0] as a closed path. 
	 * 
	 * @param b the brush to fill.
	 * @param points the Array contains all vertex points in the polygon.
	 * @see #polygon()
	 */	
	public function fillPolygon(b:Brush, points:Array):void{
		startBrush(b);
		polygon(points);
		endBrush();
	}
	
	/**
	 * Fills a polygon ring.
	 * @param b the brush to fill.
	 * @param points1 the first polygon's points.
	 * @param points2 the second polygon's points.
	 * @see #fillPolygon()
	 */
	public function fillPolygonRing(b:Brush, points1:Array, points2:Array):void{
		startBrush(b);
		polygon(points1);
		polygon(points2);
		endBrush();
	}
	
	/**
	 * Draws a rectange.
	 * @param pen the pen to draw.
	 * @param x the left top the rectange bounds' x corrdinate.
	 * @param y the left top the rectange bounds' y corrdinate.
	 * @param w the width of rectange bounds.
	 * @param h the height of rectange bounds.
	 */
	public function drawRectangle(pen:Pen, x:Number, y:Number, w:Number, h:Number):void {
		this.startPen(pen);
		this.rectangle(x, y, w, h);
		this.endPen();
	}
	
	/**
	 * Fills a rectange.
	 * @param brush the brush to fill.
	 * @param x the left top the rectange bounds' x corrdinate.
	 * @param y the left top the rectange bounds' y corrdinate.
	 * @param w the width of rectange bounds.
	 * @param h the height of rectange bounds.
	 */	
	public function fillRectangle(brush:Brush, x:Number, y:Number, width:Number, height:Number):void{
		startBrush(brush);
		rectangle(x,y,width,height);
		endBrush();
	}
	
	/**
	 * Fills a rectange ring.
	 * @param brush the brush to fill.
	 * @param cx the center of the ring's x corrdinate.
	 * @param cy the center of the ring's y corrdinate.
	 * @param w1 the first rectange's width.
	 * @param h1 the first rectange's height.
	 * @param w2 the second rectange's width.
	 * @param h2 the second rectange's height.
	 */	
	public function fillRectangleRing(brush:Brush, cx:Number, cy:Number, w1:Number, h1:Number, w2:Number, h2:Number):void{
		startBrush(brush);
		rectangle(cx-w1/2, cy-h1/2, w1, h1);
		rectangle(cx-w2/2, cy-h2/2, w2, h2);
		endBrush();
	}
	
	/**
	 * Fills a rectange ring with specified thickness.
	 * @param brush the brush to fill.
	 * @param x the left top the ring bounds' x corrdinate.
	 * @param y the left top the ring bounds' y corrdinate.
	 * @param w the width of ring periphery bounds.
	 * @param h the height of ring periphery bounds.
	 * @param t the thickness of the ring.
	 */
	public function fillRectangleRingWithThickness(brush:Brush, x:Number, y:Number, w:Number, h:Number, t:Number):void{
		startBrush(brush);
		rectangle(x, y, w, h);
		rectangle(x+t, y+t, w - t*2, h - t*2);
		endBrush();
	}	
	
	/**
	 * Draws a circle.
	 * @param p the pen to draw.
	 * @param cx the center of the circle's x corrdinate.
	 * @param cy the center of the circle's y corrdinate.
	 * @param radius the radius of the circle.
	 */
	public function drawCircle(p:Pen, cx:Number, cy:Number, radius:Number):void{
		startPen(p);
		circle(cx, cy, radius);
		endPen();		
	}
	
	/**
	 * Fills a circle.
	 * @param b the brush to draw.
	 * @param cx the center of the circle's x corrdinate.
	 * @param cy the center of the circle's y corrdinate.
	 * @param radius the radius of the circle.
	 */
	public function fillCircle(b:Brush, cx:Number, cy:Number, radius:Number):void{
		startBrush(b);
		circle(cx, cy, radius);
		endBrush();
	}
	
	/**
	 * Fills a circle ring.
	 * @param b the brush to draw.
	 * @param cx the center of the ring's x corrdinate.
	 * @param cy the center of the ring's y corrdinate.
	 * @param r1 the first circle radius.
	 * @param r2 the second circle radius.
	 */
	public function fillCircleRing(b:Brush, cx:Number, cy:Number, r1:Number, r2:Number):void{
		startBrush(b);
		circle(cx, cy, r1);
		circle(cx, cy, r2);
		endBrush();
	}
	
	/**
	 * Fills a circle ring with specified thickness.
	 * @param b the brush to draw.
	 * @param cx the center of the ring's x corrdinate.
	 * @param cy the center of the ring's y corrdinate.
	 * @param r the radius of circle periphery.
	 * @param t the thickness of the ring.
	 */
	public function fillCircleRingWithThickness(b:Brush, cx:Number, cy:Number, r:Number, t:Number):void{
		startBrush(b);
		circle(cx, cy, r);
		r -= t;
		circle(cx, cy, r);
		endBrush();
	}
	
	/**
	 * Draws a ellipse.
	 * @param brush the brush to fill.
	 * @param x the left top the ellipse bounds' x corrdinate.
	 * @param y the left top the ellipse bounds' y corrdinate.
	 * @param w the width of ellipse bounds.
	 * @param h the height of ellipse bounds.
	 */	
	public function drawEllipse(p:Pen, x:Number, y:Number, width:Number, height:Number):void{
		startPen(p);
		ellipse(x, y, width, height);
		endPen();
	}
	
	/**
	 * Fills a rectange.
	 * @param brush the brush to fill.
	 * @param x the left top the ellipse bounds' x corrdinate.
	 * @param y the left top the ellipse bounds' y corrdinate.
	 * @param w the width of ellipse bounds.
	 * @param h the height of ellipse bounds.
	 */		
	public function fillEllipse(b:Brush, x:Number, y:Number, width:Number, height:Number):void{
		startBrush(b);
		ellipse(x, y, width, height);
		endBrush();
	}
	
	/**
	 * Fill a ellipse ring.
	 * @param brush the brush to fill.
	 * @param cx the center of the ring's x corrdinate.
	 * @param cy the center of the ring's y corrdinate.
	 * @param w1 the first eclipse's width.
	 * @param h1 the first eclipse's height.
	 * @param w2 the second eclipse's width.
	 * @param h2 the second eclipse's height.
	 */
	public function fillEllipseRing(brush:Brush, cx:Number, cy:Number, w1:Number, h1:Number, w2:Number, h2:Number):void{
		startBrush(brush);
		ellipse(cx-w1/2, cy-h1/2, w1, h1);
		ellipse(cx-w2/2, cy-h2/2, w2, h2);
		endBrush();
	}
	
	/**
	 * Fill a ellipse ring with specified thickness.
	 * @param brush the brush to fill.
	 * @param x the left top the ring bounds' x corrdinate.
	 * @param y the left top the ring bounds' y corrdinate.
	 * @param w the width of ellipse periphery bounds.
	 * @param h the height of ellipse periphery bounds.
	 * @param t the thickness of the ring.
	 */
	public function fillEllipseRingWithThickness(brush:Brush, x:Number, y:Number, w:Number, h:Number, t:Number):void{
		startBrush(brush);
		ellipse(x, y, w, h);
		ellipse(x+t, y+t, w-t*2, h-t*2);
		endBrush();
	}	
	
	/**
	 * Draws a round rectangle.
	 * @param pen the pen to draw.
	 * @param x the left top the rectangle bounds' x corrdinate.
	 * @param y the left top the rectangle bounds' y corrdinate.
	 * @param width the width of rectangle bounds.
	 * @param height the height of rectangle bounds.
	 * @param radius the top left corner's round radius.
	 * @param trR the top right corner's round radius. (miss this param default to same as radius)
	 * @param blR the bottom left corner's round radius. (miss this param default to same as radius)
	 * @param brR the bottom right corner's round radius. (miss this param default to same as radius)
	 */
	public function drawRoundRect(pen:Pen, x:Number, y:Number, width:Number, height:Number, radius:Number, trR:Number, blR:Number, brR:Number):void{
		startPen(pen);
		roundRect(x, y, width, height, radius, trR, blR, brR);
		endPen();
	}
	
	/**
	 * Fills a round rectangle.
	 * @param brush the brush to fill.
	 * @param x the left top the rectangle bounds' x corrdinate.
	 * @param y the left top the rectangle bounds' y corrdinate.
	 * @param width the width of rectangle bounds.
	 * @param height the height of rectangle bounds.
	 * @param radius the top left corner's round radius.
	 * @param trR the top right corner's round radius. (miss this param default to same as radius)
	 * @param blR the bottom left corner's round radius. (miss this param default to same as radius)
	 * @param brR the bottom right corner's round radius. (miss this param default to same as radius)
	 */	
	public function fillRoundRect(brush:Brush, x:Number, y:Number, width:Number, height:Number, radius:Number, trR:Number, blR:Number, brR:Number):void{
		startBrush(brush);
		roundRect(x,y,width,height,radius,trR,blR,brR);
		endBrush();
	}
	
	/**
	 * Fill a round rect ring.
	 * @param brush the brush to fill
	 * @param cx the center of the ring's x corrdinate
	 * @param cy the center of the ring's y corrdinate
	 * @param w1 the first round rect's width
	 * @param h1 the first round rect's height
	 * @param r1 the first round rect's round radius
	 * @param w2 the second round rect's width
	 * @param h2 the second round rect's height
	 * @param r2 the second round rect's round radius
	 */	
	public function fillRoundRectRing(brush:Brush,cx:Number,cy:Number,w1:Number,h1:Number,r1:Number, w2:Number, h2:Number, r2:Number):void{
		startBrush(brush);
		roundRect(cx-w1/2, cy-h1/2, w1, h1, r1);
		roundRect(cx-w2/2, cy-h2/2, w2, h2, r2);
		endBrush();
	}
	
	/**
	 * Fill a round rect ring with specified thickness.
	 * @param brush the brush to fill
	 * @param x the left top the ring bounds' x corrdinate
	 * @param y the left top the ring bounds' y corrdinate
	 * @param w the width of ring periphery bounds
	 * @param h the height of ring periphery bounds
	 * @param r the round radius of the round rect
	 * @param t the thickness of the ring
	 * @param ir the inboard round radius, default is <code>r-t</code>
	 */	
	public function fillRoundRectRingWithThickness(brush:Brush, x:Number, y:Number, w:Number, h:Number, r:Number, t:Number, ir:Number):void{
		startBrush(brush);
		roundRect(x, y, w, h, r);
		if(ir == undefined) ir = r - t;
		roundRect(x+t, y+t, w-t*2, h-t*2, ir);
		endBrush();
	}	
	
	public function beginFill(brush:Brush):void{
		startBrush(brush);
	}
	public function endFill():void{
		endBrush();
		target.moveTo(0, 0); //avoid a drawing error
	}
	public function beginDraw(pen:Pen):void{
		startPen(pen);
	}
	public function endDraw():void{
		endPen();
		target.moveTo(0, 0); //avoid a drawing error
	}
	public function moveTo(x:Number, y:Number):void{
		target.moveTo(x, y);
	}
	public function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void{
		target.curveTo(controlX, controlY, anchorX, anchorY);
	}
	public function lineTo(x:Number, y:Number):void{
		target.lineTo(x, y);
	}
	
	//---------------------------------------------------------------------------
	/**
	 * Paths a line. 
	 * Between the points (x1, y1) and (x2, y2) in the target Graphics. 
	 * @param x1 the x corrdinate of the first point.
	 * @param y1 the y corrdinate of the first point.
	 * @param x2 the x corrdinate of the sencod point.
	 * @param y2 the y corrdinate of the sencod point.
	 */
	public function line(x1:Number, y1:Number, x2:Number, y2:Number):void{
		target.moveTo(x1, y1);
		target.lineTo(x2, y2);
	}
	
	/**
	 * Paths a polygon.(close figure automaticlly)
	 * @param points the points of the polygon, length should be max than 1
	 * @see #drawPolygon()
	 * @see #fillPolygon()
	 * @see #polyline()
	 */
	public function polygon(points:Array):void{
		if(points.length > 1){
			polyline(points);
			target.lineTo(points[0].x, points[0].y);
		}
	}
	
	/**
	 * Paths a polyline(not close figure automaticlly).
	 * @param points the points of the polygon, length should be max than 1
	 * @see #drawPolyline()
	 * @see #fillPolyline()
	 * @see #polygon()
	 */
	public function polyline(points:Array):void{
		if(points.length > 1){
			target.moveTo(points[0].x, points[0].y);
			for(var i:Number=1; i<points.length; i++){
				target.lineTo(points[i].x, points[i].y);
			}
		}
	}
	
	/**
	 * Paths a rectangle.
	 * @see #drawRectangle()
	 * @see #fillRectangle()
	 */
	public function rectangle(x:Number,y:Number,width:Number,height:Number):void{
		target.moveTo(x, y);
		target.lineTo(x+width,y);
		target.lineTo(x+width,y+height);
		target.lineTo(x,y+height);
		target.lineTo(x,y);
	}
	
	/**
	 * Paths a ellipse.
	 * @see #drawEllipse()
	 * @see #fillEllipse()
	 */
	public function ellipse(x:Number, y:Number, width:Number, height:Number):void{
		var pi:Number = Math.PI;
        var xradius:Number = width/2;
        var yradius:Number = height/ 2;
        var cx:Number = x + xradius;
        var cy:Number = y + yradius;
        var tanpi8:Number = Math.tan(pi / 8);
        var cospi4:Number = Math.cos(pi / 4);
        var sinpi4:Number = Math.sin(pi / 4);
        target.moveTo(xradius + cx, 0 + cy);
        target.curveTo(xradius + cx, (yradius * tanpi8) + cy, (xradius * cospi4) + cx, (yradius * sinpi4) + cy);
        target.curveTo((xradius * tanpi8) + cx, yradius + cy, 0 + cx, yradius + cy);
        target.curveTo(((-xradius) * tanpi8) + cx, yradius + cy, ((-xradius) * cospi4) + cx, (yradius * sinpi4) + cy);
        target.curveTo((-xradius) + cx, (yradius * tanpi8) + cy, (-xradius) + cx, 0 + cy);
        target.curveTo((-xradius) + cx, ((-yradius) * tanpi8) + cy, ((-xradius) * cospi4) + cx, ((-yradius) * sinpi4) + cy);
        target.curveTo(((-xradius) * tanpi8) + cx, (-yradius) + cy, 0 + cx, (-yradius) + cy);
        target.curveTo((xradius * tanpi8) + cx, (-yradius) + cy, (xradius * cospi4) + cx, ((-yradius) * sinpi4) + cy);
        target.curveTo(xradius + cx, ((-yradius) * tanpi8) + cy, xradius + cx, 0 + cy);		
	}
	
	/**
	 * Paths a circle
	 * @see #drawCircle()
	 * @see #fillCircle()
	 */
	public function circle(cx:Number, cy:Number, r:Number):void{
		//start at top center point
		ellipse(cx-r, cy-r, r*2, r*2);
//		target.moveTo(cx, cy - r);
//		target.curveTo(cx + r, cy - r, cx + r, cy);
//		target.curveTo(cx + r, cy + r, cx, cy + r);
//		target.curveTo(cx - r, cy + r, cx - r, cy);
//		target.curveTo(cx - r, cy - r, cx, cy - r);
	}
	
	/**
	 * Paths a round rect.
	 * @see #drawRoundRect()
	 * @see #fillRoundRect()
	 * @param radius top left radius, if other corner radius if undefined, will be set to this radius
	 */
	public function roundRect(x:Number,y:Number,width:Number,height:Number, radius:Number, trR:Number, blR:Number, brR:Number):void{
		var tlR:Number = radius;
		if(trR == undefined) trR = radius;
		if(blR == undefined) blR = radius;
		if(brR == undefined) brR = radius;
		//Bottom right
		target.moveTo(x+blR, y+height);
		target.lineTo(x+width-brR, y+height);
		target.curveTo(x+width, y+height, x+width, y+height-blR);
		//Top right
		target.lineTo (x+width, y+trR);
		target.curveTo(x+width, y, x+width-trR, y);
		//Top left
		target.lineTo (x+tlR, y);
		target.curveTo(x, y, x, y+tlR);
		//Bottom left
		target.lineTo (x, y+height-blR );
		target.curveTo(x, y+height, x+blR, y+height);
	}
	
	/**
	 * path a wedge.
	 */
	public function wedge(radius:Number, x:Number, y:Number, angle:Number, rot:Number):void {
		target.moveTo(0, 0);
		target.lineTo(radius, 0);
		var nSeg:Number = Math.floor(angle/30);
		var pSeg:Number = angle-nSeg*30;
		var a:Number = 0.268;
		var endx:Number;
		var endy:Number;
		var ax:Number;
		var ay:Number;
		var storeCount:Number=0;
		for (var i:Number = 0; i<nSeg; i++) {
			endx = radius*Math.cos((i+1)*30*(Math.PI/180));
			endy = radius*Math.sin((i+1)*30*(Math.PI/180));
			ax = endx+radius*a*Math.cos(((i+1)*30-90)*(Math.PI/180));
			ay = endy+radius*a*Math.sin(((i+1)*30-90)*(Math.PI/180));
			target.curveTo(ax, ay, endx, endy);
			storeCount=i+1;
		}
		if (pSeg>0) {
			a = Math.tan(pSeg/2*(Math.PI/180));
			endx = radius*Math.cos((storeCount*30+pSeg)*(Math.PI/180));
			endy = radius*Math.sin((storeCount*30+pSeg)*(Math.PI/180));
			ax = endx+radius*a*Math.cos((storeCount*30+pSeg-90)*(Math.PI/180));
			ay = endy+radius*a*Math.sin((storeCount*30+pSeg-90)*(Math.PI/180));
			target.curveTo(ax, ay, endx, endy);
		}
		target.lineTo(0, 0);
		target._rotation = rot;
		target._x = x;
		target._y = y;
	}	
	
	
}


}