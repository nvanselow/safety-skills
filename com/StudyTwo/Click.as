package com.StudyTwo
{

	public class Click
	{
		private var _Time:String;
		private var _Description:String;
		
		public function Click()
		{
			// constructor code
		}
		
		public function Reset():void
		{
			_Time = "";
			_Description = "";
		}
		
		public function set Time(t:String):void
		{
			_Time = t;
		}
		
		public function get Time():String
		{
			return _Time;
		}
		
		public function set Description(d:String):void
		{
			_Description = d;
		}
		
		public function get Description():String
		{
			return _Description;
		}
		
		public function CreateClick(description:String):void
		{
			addTime();
			_Description = description;
			trace("ADDCLICK TIME: " + _Time + " Description: " + _Description);
		}
		
		public function addTime():void
		{
			var currentDate:Date = new Date();
			
			_Time = (currentDate.month + 1) + "/" + currentDate.date + "/" + currentDate.fullYear + " " + 
				currentDate.hours + ":" + currentDate.minutes + ":" + currentDate.seconds;
			
		}

	}

}