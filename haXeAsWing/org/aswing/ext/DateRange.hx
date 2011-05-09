package org.aswing.ext;
import flash.errors.Error;



/**
 * The definition of a date range.
 * For a single day, you can set rangeStart and rangeEnd to be a same date, 
 * If rangeStart == null, means all date before rangeEnd(included) is in range,  
 * If rangeEnd == null, means all date after rangeStart(included) is in range.
 * @author paling (Burstyx Studio)
 */
class DateRange{
	
	private var rangeStart:Date;
	private var rangeEnd:Date;
	
	public function new(rangeStart:Date, rangeEnd:Date){
		this.rangeStart = rangeStart;
		this.rangeEnd = rangeEnd;
		resetInDay(this.rangeStart);
		resetInDay(this.rangeEnd);
		if(rangeStart!=null && rangeEnd!=null){
			if(rangeStart.getTime() > rangeEnd.getTime()){
				throw new Error("rangeStart can not be later than rangeEnd.");  
			}
		}
	}
	
	public static function singleDay(day:Date):DateRange{
		return new DateRange(day, day);
	} 
	
	public function getStart():Date{
		return rangeStart;
	}
	
	public function getStartMonth():Date {
	//(Std.int(date.getTime()), 0,0,0,0,0)	
		return resetInMonth(new Date(Std.int(rangeStart.getTime()), 0,0,0,0,0));
	}
	
	public function getEnd():Date{
		return rangeEnd;
	}
	
	public function getEndMonth():Date{
		return resetInMonth( new Date(Std.int(rangeEnd.getTime()), 0,0,0,0,0));
	}
	
	public function isInRange(date:Date):Bool{
		resetInDay(date); //reset the day
		if(rangeStart!=null && rangeEnd!=null){
			return date.getTime() >= rangeStart.getTime() && date.getTime() <= rangeEnd.getTime();
		}else if(null == rangeStart){
			return date.getTime() <= rangeEnd.getTime();
		}else if(null == rangeEnd){
			return date.getTime() >= rangeStart.getTime();
		}
		return true;
	}
	
	public static function resetInMonth(date:Date):Date{
	//why	date.setDate(1);
		resetInDay(date);
		return date;
	}
	
	public static function resetInDay(date:Date):Date{
		if(date!=null)	{
	//why		date.setHours(0, 0, 0, 0);
		}
		return date;
	}
}