package com.ui.games
{

	import flash.display.*;
	import flash.events.Event;

	public class OrderArray extends MovieClip
	{

		private var dragdrops:Array;
		private var numOfMatches:uint = 0;
		private var _vidAAnswer:String = "A";
		private var _vidBAnswer:String = "B";
		private var _vidCAnswer:String = "C";
		private var _vidASource:String;
		private var _vidBSource:String;
		private var _vidCSource:String;

		public function OrderArray()
		{
			// constructor code
			reset();
			
			
		}
		
		public function match(currentMovie:newOrderMovie = null):void
		{
			numOfMatches++;
			trace(currentMovie.target.name + " = Current target for this movie");
			getChildByName(currentMovie.target.name + "_check").visible = true;
			getChildByName(currentMovie.target.name + "_ans").visible = true;
			currentMovie.visible = false;
			trace("Match!");
			Object(parent.parent).addAllClickItem("Match " + numOfMatches);
			
			if (numOfMatches >= dragdrops.length)
			{
				//Show winning screen
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		public function reset():void
		{
			dragdrops = [orderA_vdo, orderB_vdo, orderC_vdo];
			var answers:Array = [_vidAAnswer, _vidBAnswer, _vidCAnswer] 
			var currentObject:newOrderMovie;
			for (var i:uint = 0; i < dragdrops.length; i++)
			{
				currentObject = dragdrops[i];
				currentObject.target = getChildByName("box" + answers[i]);
				currentObject.visible = true;
				getChildByName("box" + answers[i] + "_check").visible = false;
				getChildByName("box" + answers[i] + "_ans").visible = false;
			}
			
			numOfMatches = 0;
		}
		
		public function vidASource(s:String, ans:String):void
		{
			_vidASource = s;
			_vidAAnswer = ans;
			orderA_vdo.updateSource(_vidASource);
			Object(getChildByName("box" + _vidAAnswer + "_ans")).updateSource(_vidASource);
			Object(getChildByName("box" + _vidAAnswer + "_ans")).turnOffDrag = true;
		}
		
		public function get vidAAnswer():String
		{
			return vidAAnswer;
		}
		
		public function vidBSource(s:String, a:String):void
		{
			_vidBSource = s;
			_vidBAnswer = a;
			orderB_vdo.updateSource(_vidBSource);
			Object(getChildByName("box" + _vidBAnswer + "_ans")).updateSource(_vidBSource);
			Object(getChildByName("box" + _vidAAnswer + "_ans")).turnOffDrag = true;
		}
		
		public function get vidBAnswer():String
		{
			return vidBAnswer;
		}
		
		public function vidCSource(s:String, a:String):void
		{
			_vidCSource = s;
			_vidCAnswer = a;
			orderC_vdo.updateSource(_vidCSource);
			Object(getChildByName("box" + _vidCAnswer + "_ans")).updateSource(_vidCSource);
			Object(getChildByName("box" + _vidCAnswer + "_ans")).turnOffDrag = true;
		}
		
		public function get vidCAnswer():String
		{
			return vidCAnswer;
		}

	}

}