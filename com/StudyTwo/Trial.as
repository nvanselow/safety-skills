package com.StudyTwo
{

	public class Trial
	{
		private var _Sample:String;
		private var _ComparisonA:String;
		private var _ComparisonB:String;
		private var _ComparisonC:String;
		private var _IsCorrect:Boolean;
		
		
		private var _CorrectComparison:String;
		public static const COMP_A:String = "a";
		public static const COMP_B:String = "b";
		public static const COMP_C:String = "c";
		
		private var _Type:String;
		public static const NO:String = "no";
		public static const GO:String = "go";
		public static const TELL:String = "tell";

		public function Trial()
		{
			// constructor code
		}
		
		public function set SampleSource(s:String):void
		{
			_Sample = s;
		}
		
		public function get SampleSource():String
		{
			return _Sample;
		}
		
		public function set ComparisonA(s:String):void
		{
			_ComparisonA = s;
		}
		
		public function get ComparisonA():String
		{
			return _ComparisonA;
		}
		
		public function set ComparisonB(s:String):void
		{
			_ComparisonB = s;
		}
		
		public function get ComparisonB():String
		{
			return _ComparisonB;
		}
		
		public function set ComparisonC(s:String):void
		{
			_ComparisonC = s;
		}
		
		public function get ComparisonC():String
		{
			return _ComparisonC;
		}
		
		public function set CorrectComparison(s:String):void
		{
			_CorrectComparison = s;
		}
		
		public function get CorrectComparison():String
		{
			return _CorrectComparison;
		}
		
		public function set Type(t:String):void
		{
			_Type = t;
		}
		
		public function get Type():String
		{
			return _Type;
		}
		
		public function set IsCorrect(b:Boolean):void
		{
			_IsCorrect = b;
		}
		
		public function get IsCorrect():Boolean
		{
			return _IsCorrect;
		}

	}

}