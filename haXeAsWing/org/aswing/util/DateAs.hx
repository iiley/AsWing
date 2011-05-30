package util;

/**
 * ...
 * @author 
 */

class DateAs  extends Date
{

	public function new(year : Int, month : Int, day : Int, hour : Int, min : Int, sec : Int) 
	{
		super(year , month , day , hour , min , sec );
	}
	  
	public function setTime(value: Float):Void {
		this = Date.fromTime(value);
	}

		/**
			Returns the hours value of the date (0-23 range).
		**/
	public 	function setHours(value: Int):Void {
		//
		  var date :Date = new Date(0, 0, 0, value, 0, 0);
		  var gt:Float = date.getTime() + this.getTime();
		  this.setTime(gt);
	}

		/**
			Returns the minutes value of the date (0-59 range).
		**/
	public 	function setMinutes(value: Int):Void {
		 var date :Date = new Date(0, 0, 0, 0, value, 0);
		  var gt:Float = date.getTime() + this.getTime();
		  this.setTime(gt);
	}

		/**
			Returns the seconds of the date (0-59 range).
		**/
	public 	function setSeconds(value: Int):Void {
		 var date :Date = new Date(0, 0, 0, 0, 0, value);
		  var gt:Float = date.getTime() + this.getTime();
		  this.setTime(gt);
	}

		/**
			Returns the full year of the date.
		**/
	public 	function setFullYear(value: Int):Void {
		 var date :Date = new Date(value, 0, 0, 0, 0, 0);
		  var gt:Float = date.getTime() + this.getTime();
		  this.setTime(gt);
		}

		/**
			Returns the month of the date (0-11 range).
		**/
	public 	function setMonth(value: Int):Void {
		var date :Date = new Date(0,value,  0, 0, 0, 0);
		  var gt:Float = date.getTime() + this.getTime();
		  this.setTime(gt);
		}

		/**
			Returns the day of the date (1-31 range).
		**/
	public 	function setDate(value: Int):Void {
		 var date :Date = new Date(0,  0, value,0, 0, 0);
		  var gt:Float = date.getTime() + this.getTime();
		  this.setTime(gt);
	}

	 
	
}