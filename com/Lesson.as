package  com{
	
	public class Lesson {

		private var _lessonNum:int;
		private var _skillName:String;
		private var _levelName:String;
		private var _isComplete:Boolean = false;

		public function Lesson() {
			// constructor code
			
			
			
		}
		
		public function set lessonNum(l:int):void
		{
			_lessonNum = l;
		}
		
		public function get lessonNum():int
		{
			return _lessonNum;
		}
		
		public function set skillName(s:String):void
		{
			_skillName = s;
		}
		
		public function get skillName():String
		{
			return _skillName;
		}
			
		public function set levelName(s:String):void
		{
			_levelName = s;
		}
		
		public function get levelName():String
		{
			return _levelName;
		}
		
		public function set isComplete(c:Boolean):void
		{
			_isComplete = c;
		}
		
		public function get isComplete():Boolean
		{
			return _isComplete;
		}
		
		

	}
	
}
