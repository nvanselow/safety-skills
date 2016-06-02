package  com {
	
	public class Student {

		var _ID:int;
		var _FirstName:String;
		var _LastName:String;
		var _CurrentLocationID:int;
		var _ActOut:Boolean;

		public function Student() {
			// constructor code
		}
		
		public function set ID(id:int):void
		{
			_ID = id;
		}
		
		public function get ID():int
		{
			return _ID;
		}
		
		public function set FirstName(fn:String):void
		{
			_FirstName = fn;
		}
		
		public function get FirstName():String
		{
			return _FirstName;
		}
		
		public function set LastName(ln:String):void
		{
			_LastName = ln;
		}
		
		public function get LastName():String
		{
			return _LastName;
		}
		
		public function set CurrentLocationID(id:int):void
		{
			_CurrentLocationID = id;
		}
		
		public function get CurrentLocationID():int
		{
			return _CurrentLocationID;
		}
		
		public function set ActOut(ao:Boolean):void
		{
			_ActOut = ao;
		}
		
		public function get ActOut():Boolean
		{
			return _ActOut
		}
		
		public function get FullName():String
		{
			var full:String = _FirstName + "_" + _LastName;
			return full;
		}

	}
	
}
