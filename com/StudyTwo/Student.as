package com.StudyTwo
{
	import com.StudyTwo.Click;
	import com.StudyTwo.Lesson;
	import uk.co.bigroom.utils.ObjectPool;

	public class Student
	{
		//Participant information
		private var _Name:String = "none";
		private var _Condition:String = "none";
		public static const ACTOUT:String = "act out";
		public static const NOACT:String = "no act out";
		public static const STUDYTWO:String = "Study 2";
		public static const AWAY:String = "away";
		public static const ACTPLUS:String = "act plus";
		
		//Lesson information
		private var _Lessons:Array = [];
		public var _CurrentLesson:int = -1;
		private var _Clicks:Array = [];
		

		public function Student()
		{
			// constructor code
		}

		public function Reset():void
		{
			_Lessons = [];
			_CurrentLesson = -1;
			_Clicks = [];

		}

		public function AddClick(description:String):void
		{
			//Add a new Click to the array with the current tiem and description
			var c:Click = new Click();
			c.CreateClick(description);
			_Clicks.push(c);
		}
		
		public function get Clicks():Array
		{
			
			return _Clicks;
		}

		public function AddLesson(lesson:Lesson):void
		{
			_Lessons.push(lesson);
		}

		public function LessonComplete():void
		{
			//Mark the current lesson as complete and increment currentlesson number
			Lesson(_Lessons[_CurrentLesson]).Complete = true;
			_CurrentLesson +=  1;
		}

		public function get CurrentLesson():Lesson
		{
			if (_CurrentLesson >= _Lessons.length)
			{
				//If there are no more lessons, return the last available lesson
				trace("current lessons is greater than array length");
				_CurrentLesson = _Lessons.length - 1;
			}

			//return Lesson(_Lessons[1]);
			return Lesson(_Lessons[_CurrentLesson]);

		}

		public function get Lessons():Array
		{
			return _Lessons;
		}
		
		public function set Name(n:String):void
		{
			_Name = n;
		}
		
		public function get Name():String
		{
			return _Name;
		}
		
		public function set Condition(c:String):void
		{
			_Condition = c;
		}
		
		public function get Condition():String
		{
			return _Condition;
		}


	}

}