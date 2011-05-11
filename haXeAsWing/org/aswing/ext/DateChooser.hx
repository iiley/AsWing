package org.aswing.ext;


import flash.errors.Error;
import flash.events.Event;
import flash.events.MouseEvent;
 

import org.aswing.ASColor;
import org.aswing.BorderLayout;
import org.aswing.BoxLayout;
import org.aswing.Container;
import org.aswing.JButton;
import org.aswing.JComboBox;
import org.aswing.JLabel;
import org.aswing.JLabelButton;
import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.SoftBoxLayout;
import org.aswing.WeightBoxLayout;
import org.aswing.event.InteractiveEvent;
import org.aswing.event.SelectionEvent;
import org.aswing.util.ArrayList;
import org.aswing.util.HashSet;

/**
 * Dispatched when the datechooser's display page changed etc. 
 * @eventType org.aswing.event.InteractiveEvent.STATE_CHANGED
 */
// [Event(name="stateChanged", type="org.aswing.event.InteractiveEvent")]

/**
 *  Dispatched when the datechooser's selection changed.
 * 
 *  @eventType org.aswing.event.InteractiveEvent.SELECTION_CHANGED
 */
// [Event(name="selectionChanged", type="org.aswing.event.InteractiveEvent")]

/**
 * A Date Chooser for multipule or single date selection.<br/>
 * The language can be changed by defaultDayNames, defaultMonthNames static members.
 * @author paling (Burstyx Studio)
 */
class DateChooser extends JPanel{
	
	inline public static var defaultDayNames:Array<Dynamic>= [" Su ", " Mo ", " Tu ", " We ", " Th ", " Fr ", " Sa "];
	inline public static var defaultMonthNames:Array<Dynamic>= ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"];
	
	private  var allowMultipleSelection:Bool;
	private var dayNames:Array<Dynamic>;
	private var monthNames:Array<Dynamic>;
	private var disabledDays:HashSet;
	private var disabledRanges:Array<Dynamic>;
	private var displayedMonth:Int;
	private var displayedYear:Int;
	private var selectableRange:DateRange;
	private var selectedDate:Date;
	private var selectedDates:Array<Dynamic>;
	private var displayDate:Date;
	private var displayMonthDays:Int;//the day count of displaying month
	
	private var monthCombo:JComboBox;
	private var yearCombo:JComboBox;
	private var leftButton:JButton;
	private var rightButton:JButton;
	
	private var datePane:Container;
	private var headerLabels:Array<Dynamic>; //7
	private var tileLabels:Array<Dynamic>; //31
	private var dateGridLayout:DateGridLayout;
	
	public function new(){
		allowMultipleSelection=false;
			super();
		dayNames = defaultDayNames.copy();
		monthNames = defaultMonthNames.copy();
		var today:Date = new Date(0,0,0,0,0,0);
		disabledDays = new HashSet();
		selectedDates = [];
		selectableRange = new DateRange(
			new Date(Std.int(today.getFullYear()-100), 0,0,0,0,0), 
			new Date(Std.int(today.getFullYear()+50), 0,0,0,0,0));
		createComponents();
		setDisplayDate(today.getFullYear(), today.getMonth());
	}
		
	private function createComponents():Void{
		monthCombo  = new JComboBox(monthNames);
		yearCombo   = new JComboBox(getYearLabels());
		leftButton  = new JButton(" < ");
		rightButton = new JButton(" > ");
		
		var headerBar:JPanel = new JPanel(new BoxLayout(BoxLayout.X_AXIS, 2));
		var dayPane:JPanel = new JPanel(dateGridLayout = new DateGridLayout(6, 7, 2, 2));
		datePane = dayPane;
		
		var i:Int= 0;
		headerLabels = [];
		tileLabels   = [];
		for(i in 0...7){
			var label:JLabel = createHeaderLabel(dayNames[i]);
			headerLabels.push(label);
			headerBar.append(label);
		}
		for(i in 1...31){
			var labelB:DateLabel = createDateLabel(i);
			labelB.addEventListener(MouseEvent.MOUSE_DOWN, __dateLabelPress);
			tileLabels.push(labelB);
			dayPane.append(labelB);
		}
		
		var topBar:JPanel = new JPanel(new BorderLayout(4, 4));
		topBar.append(leftButton, BorderLayout.WEST);
		topBar.append(rightButton, BorderLayout.EAST);
		var topCenter:JPanel = new JPanel(new WeightBoxLayout(WeightBoxLayout.X_AXIS, 4));
		topCenter.append(monthCombo, 0.6);
		topCenter.append(yearCombo, 0.4);
		var tcSoft:Container = new Container();
		tcSoft.setLayout(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 0, SoftBoxLayout.CENTER));
		tcSoft.append(topCenter);
		topBar.append(tcSoft, BorderLayout.CENTER);
		
		setLayout(new BorderLayout(4, 4));
		var topPart:JPanel = new JPanel(new SoftBoxLayout(SoftBoxLayout.Y_AXIS, 4));
		topPart.appendAll([topBar, headerBar]);
		append(topPart, BorderLayout.NORTH);
		append(dayPane, BorderLayout.CENTER);
		
		initHandlers();
	}
	
	private function initHandlers():Void{
		leftButton.addActionListener(__left);
		rightButton.addActionListener(__right);
		yearCombo.addSelectionListener(__yearChanged);
		monthCombo.addSelectionListener(__monthChanged);
	}
	
	private function __left(e:Event):Void{
		var month:Int= displayDate.getMonth();
		var year:Int= displayDate.getFullYear();
		if(isCanPageLeft()){
			month--;
			if(month < 0){
				month = 11;
				year--;
			}
			setDisplayDate(year, month, false);
		}
	}
	
	private function __right(e:Event):Void{
		var month:Int= displayDate.getMonth();
		var year:Int= displayDate.getFullYear();
		if(isCanPageRight()){
			month++;
			if(month > 11){
				month = 0;
				year++;
			}
			setDisplayDate(year, month, false);
		}
	}
	
	private function __yearChanged(e:InteractiveEvent):Void{
		if(!e.isProgrammatic()){
			setDisplayDate(displayStartYear+yearCombo.getSelectedIndex(), displayedMonth, false);
		}
	}
	
	private function __monthChanged(e:InteractiveEvent):Void{
		if(!e.isProgrammatic()){
			setDisplayDate(displayedYear, displayStartMonth+monthCombo.getSelectedIndex(), false);
		}
	}
	
	private function __dateLabelPress(e:MouseEvent):Void{
		var label:DateLabel = flash.Lib.as(e.currentTarget,DateLabel)	;
		var labelDate:Date = getDisplayLabelDate(label);
		if(allowMultipleSelection)	{
			if(!addSelection(labelDate, false)){
				removeSelection(labelDate, false);
			}
		}else{
			setSelectedDate(labelDate, false);
		}
	}
	
	public function addSelection(date:Date, programmatic:Bool=true):Bool{
		if(null == date || isDateSelected(date)){
			return false;
		}
		selectedDates.push(Date.fromTime(Std.int(date.getTime())));
		selectedDate = date;
		updateDateLabels();
		dispatchEvent(new InteractiveEvent(InteractiveEvent.SELECTION_CHANGED, programmatic));
		return true;
	}
	
	public function removeSelection(date:Date, programmatic:Bool=true):Bool{
		if(null == date){
			return false;
		}
		var n:Int= selectedDates.length;
		for(i in 0...n){
			var d:Date = selectedDates[i];
			if(d.getTime() == date.getTime()){
				selectedDates.splice(i, 1);
				if(n > 1){
					selectedDate = selectedDates[0];
				}else{
					selectedDate = null;
				}
				updateDateLabels();
				dispatchEvent(new InteractiveEvent(InteractiveEvent.SELECTION_CHANGED, programmatic));
				return true;
			}
		}
		return false;
	}
	
	public function setSelectedDate(date:Date, programmatic:Bool=true):Void{
		if(selectedDate!=null)	{
			if(date != null && selectedDate.getTime() == date.getTime()){
				return;
			}
		}else{
			if(date == null){
				return;
			}
		}
		if(date!=null)	{
			selectedDate = Date.fromTime(Std.int(date.getTime()));
			selectedDates = [selectedDate];
		}else{
			selectedDate = null;
			selectedDates = [];
		}
		updateDateLabels();
		dispatchEvent(new InteractiveEvent(InteractiveEvent.SELECTION_CHANGED, programmatic));
	}
	
	public function setSelectedDates(dates:Array<Dynamic>, programmatic:Bool=true):Void{
		var arr:Array<Dynamic>= [];
		for (date in dates ){
			arr.push(DateRange.resetInDay(date));
		}
		selectedDates = arr;
		updateDateLabels();
		dispatchEvent(new InteractiveEvent(InteractiveEvent.SELECTION_CHANGED, programmatic));
	}
	
	/**
	 * Return the selected date, null if there is no date selected
	 */
	public function getSelectedDate():Date{
		if(selectedDate!=null)	{
			return Date.fromTime(Std.int(selectedDate.getTime()) );
		}else{
			return null;
		}
	}
	
	/**
	 * Return the selected date array, empty arry [] will be returned if there is no date selected
	 */	
	public function getSelectedDates():Array<Dynamic>{
		return selectedDates.copy();
	}
	
	private function getDisplayLabelDate(label:DateLabel):Date {
	//	function new(year : Int, month : Int, day : Int, hour : Int, min : Int, sec : Int ) : Void;	
		var date:Date =   Date.fromTime(Std.int(displayDate.getTime()));
	 
		//why date.setDate(label.getDate());
		var datafloat:Float=convertToFloat(
			{
				year: date.getFullYear(),
				month: date.getMonth(),
				day: label.getDate(),
				hours: date.getHours(),
				minutes: date.getMinutes(),
				seconds: date.getSeconds()
			});
		return Date.fromTime(Std.int(datafloat));
	}
	
	private function updateDateLabels():Void{
		var days:Int= displayMonthDays;
		var i:Int= 0;
		var label:DateLabel;
		var date:Date =  Date.fromTime(Std.int(displayDate.getTime()));
		for(i in 0...days){
			label = tileLabels[i];
			label.setVisible(true);
			var datafloat:Float=convertToFloat(
			{
				year: date.getFullYear(),
				month: date.getMonth(),
				day: i+1,
				hours: date.getHours(),
				minutes: date.getMinutes(),
				seconds: date.getSeconds()
			});
			//why date.setDate(i+1);
			var _date:Date = Date.fromTime(Std.int(datafloat));
			label.setDateEnabled(isDateEnabled(_date));
			label.setSelected(isDateSelected(_date));
		}
		//hide no exists dates
		for(i  in 0...tileLabels.length){
			label = tileLabels[i] ;
			label.setVisible(false);
		}
	}
	
	/**
	 * @param date a date, time must be 00:00
	 */
	public function isDateSelected(date:Date):Bool{
		if(null == date){
			return false;
		}
		if(allowMultipleSelection)	{
			for (i in selectedDates ){
				if(i.getTime() == date.getTime()){
					return true;
				}
			}
		}else{
			if(selectedDate!=null)	{
				return selectedDate.getTime() == date.getTime();
			}
		}
		return false;
	}
	
	public function isDateEnabled(date:Date):Bool{
		if(disabledDays.contains(date.getDay())||disabledRanges==null){
			return false;
		}
				 
		for (  r  in disabledRanges ) {
		 
			if(r.isInRange(date)){
				return false;
			}
		}
		return selectableRange.isInRange(date);
	}
	
	private function createHeaderLabel(text:String):JLabel{
		var label:JLabel = new JLabel(text+"");
		label.setOpaque(true);
		label.setBackground(this.getBackground().brighter());
		return label;
	}
	
	private function createDateLabel(date:Int):DateLabel{
		return new DateLabel(date);
	}
	
	private function getMonthLabels():Array<Dynamic>{
		var arr:Array<Dynamic>= monthNames.copy();
 
		if(displayEndMonth < 11){
			arr = arr.splice(displayEndMonth, 11-displayEndMonth);
		}
		if(displayStartMonth > 0){
			arr = arr.splice(displayStartMonth, displayStartMonth);
		}
		return arr;
	}
	
	private function getYearLabels():Array<Dynamic>{
		var start:Int= selectableRange.getStart().getFullYear();
		var end:Int= selectableRange.getEnd().getFullYear();
		var labels:Array<Dynamic>= [];
		var n:Int= end - start + 1;
		for(i in 0...n){
			labels[i] = (start+i) + "";
		}
		return labels;
	}
		
	public function highlightToday():Void{
		//TODO imp
	}
	
	public function setDisplayDate(year:Int, month:Int, programmatic:Bool=true):Void{
		if(year < selectableRange.getStart().getFullYear()){
			year = selectableRange.getStart().getFullYear();
		}
		if(year > selectableRange.getEnd().getFullYear()){
			year = selectableRange.getEnd().getFullYear();
		}
		if(year == selectableRange.getStart().getFullYear()){
			if(month < selectableRange.getStart().getMonth()){
				month = selectableRange.getStart().getMonth();
			}
		}
		if(year == selectableRange.getEnd().getFullYear()){
			if(month > selectableRange.getEnd().getMonth()){
				month = selectableRange.getEnd().getMonth();
			}
		}
		if(year != displayedYear || month != displayedMonth){
			displayedYear = year;
			displayedMonth = month;
			displayPage();
			dispatchEvent(new InteractiveEvent(InteractiveEvent.STATE_CHANGED, programmatic));
		}
	}
	
	private function isCanPageLeft():Bool{
		var date:Date = DateRange.resetInMonth(Date.fromTime(Std.int(displayDate.getTime())));
		return date.getTime() > selectableRange.getStartMonth().getTime();
	}
	
	private function isCanPageRight():Bool{
		var date:Date = DateRange.resetInMonth(Date.fromTime(Std.int(displayDate.getTime())));
		return date.getTime() < selectableRange.getEndMonth().getTime();
	}
	
	private var displayStartMonth:Int;
	private var displayEndMonth:Int;
	private var displayStartYear:Int;
	
	private function displayPage():Void{
		displayDate = new Date(displayedYear, displayedMonth, 1, 0, 0, 0);
		displayStartYear = selectableRange.getStart().getFullYear();
		var indent:Int= displayDate.getDay();
		var days:Int= getDayCount(displayDate);
		displayMonthDays = days;
		dateGridLayout.setMonth(indent, days);
		
		var displayMonthStart:Date = new Date(displayedYear, 0, 1, 0, 0, 0);
		var displayMonthEnd:Date = new Date(displayedYear, 11, 1, 0, 0, 0);
		var selMonthStart:Date = selectableRange.getStartMonth();
		var selMonthEnd:Date = selectableRange.getEndMonth();
		displayStartMonth = 0;
		if(selMonthStart.getTime() > displayMonthStart.getTime()){
			displayStartMonth = selMonthStart.getMonth();
		}
		displayEndMonth = 11;
		if(selMonthEnd.getTime() < displayMonthEnd.getTime()){
			displayEndMonth = selMonthEnd.getMonth();
		}
		
		yearCombo.setSelectedIndex(displayedYear-displayStartYear);
		
		monthCombo.setListData(getMonthLabels());
		monthCombo.setSelectedIndex(displayedMonth-displayStartMonth);
		
		updateDateLabels();
		
		leftButton.setEnabled(isCanPageLeft());
		rightButton.setEnabled(isCanPageRight());
		datePane.revalidate();
	}
	
	//count the days of the month
	private function getDayCount(d:Date):Int{
		var date:Date = Date.fromTime(Std.int(d.getTime()));
		var month:Int = date.getMonth();
		return date.getDate();
		//why date.setDate(29);
		if(date.getMonth() != month){
			return 28;
		}
		//why date.setDate(30);
		if(date.getMonth() != month){
			return 29;
		}
		//why date.setDate(31);
		if(date.getMonth() != month){
			return 30;
		}
		return 31;
	}
	
	/**
	 * @param m, 0-January, 11-November
	 */
	public function setDisplayedMonth(m:Int):Void{
		if(m != displayedMonth){
			displayedMonth = m;
			displayPage();
		}
	}
	
	/**
	 * @return m, 0-January, 11-November
	 */	
	public function getDisplayedMonth():Int{
		return displayedMonth;
	}
	
	public function setDisplayedYear(year:Int):Void{
		if(year != displayedYear){
			displayedYear = year;
		}
	}
	
	public function getDisplayedYear():Int{
		return displayedYear;
	}
	
	public function setSelectableRange(r:DateRange):Void{
		if(r.getEnd() == null || r.getStart() == null){
			throw new Error("Selectable range must have start and end date both.");  
		}
		selectableRange = r;
		yearCombo.setListData(getYearLabels());
		if(!r.isInRange(displayDate)){
			setDisplayDate(r.getStart().getFullYear(), r.getStart().getMonth());
		}else{
			displayPage();
		}
	}
	
	public function getSelectableRange():DateRange{
		return selectableRange;
	}
	
	public function setDayNames(names:Array<Dynamic>):Void{
		dayNames = names.copy();
		for(i in 0...headerLabels.length){
			var label:JLabel = headerLabels[i];
			label.setText(names[i]+"");
		}
		revalidate();
	}
	
	public function getDayNames():Array<Dynamic>{
		return dayNames.copy();
	}
	
	public function setMonthNames(names:Array<Dynamic>):Void{
		monthNames = names.copy();
		displayPage();
	}
	
	public function getMonthNames():Array<Dynamic>{
		return monthNames.copy();
	}
	
	public function setDisabledDays(days:Array<Dynamic>):Void{
		disabledDays.clear();
		if(days!=null)	{
			disabledDays.addAll(days);
		}
		updateDateLabels();
	}
	
	public function getDisabledDays():Array<Dynamic>{
		return disabledDays.toArray();
	}
	
	public function setDisabledRanges(rs:Array<Dynamic>):Void {
 
		if(rs!=null)	{
			disabledRanges = rs.copy();
		}else{
			disabledRanges = [];
		}
		updateDateLabels();
	}
	
	public function getDisabledRanges():Array<Dynamic>{
		return disabledRanges;
	}
	
	public function setAllowMultipleSelection(b:Bool):Void{
		allowMultipleSelection = b;
	}
	
	public function isAllowMultipleSelection():Bool{
		return allowMultipleSelection;
	}
	
	
	
	/**
		Take a Time Structure and convert to a JulianDay number
	*/
	public static function convertToFloat(ts:TimeStruct) : Float {
		var seconds : Int = (ts.hours * 3600) + (ts.minutes * 60) + ts.seconds;
		//trace(seconds);
		return calculate(ts.year,ts.month,ts.day, seconds);
	}
	/////////////////////////////////////////////////////////////////////
	//                     Static Methods                              //
	/////////////////////////////////////////////////////////////////////
	/**
		Return JulianDay number for UTC time
		Month is 0=January
	*/
	public static function calculate(year:Int, month:Int, day:Int, seconds:Int) : Float
	{
		var mLookup : Array<Int> =
			[0,-60,-30,0,31,61,92,122,153,184,214,245,275,306,337];
		// checked
		month = month + 1;
		var d : Float = day + secondsToDecimalDay(seconds);
		if(month < 3) {
			month = month + 12;
			year = year - 1;
		}
		var value = d
			//+ Tools.int((153 * month - 457) / 5)
			+ mLookup[month]
			+ 365 * year
			+ Math.floor(year / 4)
			- Math.floor(year / 100)
			+ Math.floor(year / 400)
			+ 1721118.5;

		return value;
	}
	/**
		Convert an integer number of seconds into a decimal
		day. 1 second = 0.00001157407407, 1 day = 1.0
	*/
	public static function secondsToDecimalDay(sec:Int) : Float {
		return sec/86400;
	}
}
typedef TimeStruct = {
	var year : Int;
	var month : Int;
	var day : Int;
	var hours : Int;
	var minutes : Int;
	var seconds : Int;
}
