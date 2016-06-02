package com
{

	public class LessonData
	{

		var _percentageCorrect:int = 0;
		var _correct:int = 0;
		var _total:int = 0;
		var _complete:Boolean;

		public function LessonData()
		{
			// constructor code
			_correct = 0;
			_total = 0;

		}

		public function get percentageCorrect():int
		{
			if (total > 0)
			{
				_percentageCorrect = _correct / _total * 100;
				//_percentageCorrect = Math.round(percentageCorrect);
			}
			else
			{
				_percentageCorrect = 0;
			}
			return _percentageCorrect;
		}

		public function set correct(c:int):void
		{
			_correct = c;
		}

		public function get correct():int
		{
			return _correct;
		}

		public function set total(t:int):void
		{
			_total = t;
		}

		public function get total():int
		{
			return _total;
		}

		public function addCorrect():void
		{
			_correct +=  1;
			_total +=  1;

		}

		public function addError():void
		{
			_total +=  1;
		}

		public function get isComplete():Boolean
		{
			return _complete;
		}

		public function set isComplete(b:Boolean):void
		{
			_complete = b;
		}

		public function countErrors():int
		{
			var errorCount:int = 0;
			errorCount = _total - _correct;
			return errorCount;
			trace("Error count is " + errorCount);
		}

	}

}