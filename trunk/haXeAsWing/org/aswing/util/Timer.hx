/*
 Copyright aswing.org, see the LICENCE.txt.
*/
package org.aswing.util;

import haxe.Timer;	 
 
import org.aswing.event.AWEvent;
/**
 * Fires one or more action events after a specified delay.  
 * For example, an animation object can use a <code>Timer</code>
 * as the trigger for drawing its frames.
 *
 * <p>
 * Setting up a timer
 * involves creating a <code>Timer</code> object,
 * registering one or more action listeners on it,
 * and starting the timer using
 * the <code>start</code> method.
 * For example, 
 * the following code creates and starts a timer
 * that fires an action event once per second
 * (as specified by the first argument to the <code>Timer</code> constructor).
 * The second argument to the <code>Timer</code> constructor
 * specifies a listener to receive the timer's action events.
 * </p>
 * <pre>
 *  var delay:Number = 1000; //milliseconds
 *  var listener:Object = new Object();
 *  listener.taskPerformer = function(e:Event) {
 *          <em>//...Perform a task...</em>
 *      }
 *  var timer:Timer = new Timer(delay);
 *  timer.addActionListener(listener.taskPerformer);
 *  timer.start();
 * </pre>
 *
 * <p>
 * @author paling
 */
class Timer extends AbstractImpulser , implements Impulser{
	private var intervalID:haxe.Timer;
	
	/**
	 * Construct Timer.
	 * @see #setDelay()
     * @throws Error when init delay <= 0 or delay == null
	 */
	public function new(delay:Int, repeats:Int=0){
		super(delay, repeats);
		repeatCount = repeats;
		this.intervalID = null;
		
	}
	private function setInterval(f : Void -> Void, time_ms : Int ):haxe.Timer
	{
		var lID:haxe.Timer = new haxe.Timer(time_ms);
		lID.run=f;
		return lID;
	}
	private function clearInterval(lID:haxe.Timer):Void
	{
		if (lID != null)
		{
			lID.stop();
			lID = null;
		}
	}
    /**
     * Starts the <code>Timer</code>,
     * causing it to start sending action events
     * to its listeners.
     *
     * @see #stop()
     */
    override public function start():Void{
    	isInitalFire = true;
    	clearInterval(intervalID);
		intervalID = setInterval(fireActionPerformed,getDelay());
   
    }
    
    /**
     * Returns <code>true</code> if the <code>Timer</code> is running.
     *
     * @see #start()
     */
    override public function isRunning():Bool{
    	return intervalID != null;
    }
    
    /**
     * Stops the <code>Timer</code>,
     * causing it to stop sending action events
     * to its listeners.
     *
     * @see #start()
     */
    override public function stop():Void{
    	clearInterval(intervalID);
     
    }
    
    /**
     * Restarts the <code>Timer</code>,
     * canceling any pending firings and causing
     * it to fire with its initial delay.
     */
    override public function restart():Void {
		super.restart();
        stop();
		
        start();
    }
   
    private function fireActionPerformed():Void {
		
    	if(isInitalFire)	{
    		isInitalFire = false;
			dispatchEvent(new AWEvent(AWEvent.ACT));
			if(isRepeats())	{
    			start();
				
    		}else {
				repeats  = repeats - 1; 
				if (repeats > 0)
				{  
					start();
				}else
				{
					stop(); 
					
					dispatchEvent(new AWEvent(AWEvent.ACT_COMPLETE));
				}   
			} 
				
    	}
		
		
	
 
    	
    }
    

	
}
