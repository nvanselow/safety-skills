package com.StudyTwo
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Character extends MovieClip 
	{
		public static const STANDING:String = "stand";

		public function Character()
		{
			// constructor code
		}
		
		public function reset():void
		{
			this.addEventListener(Event.ENTER_FRAME, Stand);
			this.gotoAndPlay("enter");
		}
		
		private function Stand(event:Event):void
		{
			if(this.currentFrameLabel == "stand")
			{
				this.removeEventListener(Event.ENTER_FRAME, Stand);
				this.dispatchEvent(new Event(Character.STANDING));
			}
		}
		
		public function WalkTo():void
		{
			this.gotoAndPlay("walk_to");
		}
		
		public function WalkAway():void
		{
			this.gotoAndPlay("walk_away");
		}
		
		public function Wave():void
		{
			this.gotoAndPlay("wave");
		}
		
		public function Think():void
		{
			this.gotoAndPlay("think");
		}
		
		public function Exit():void
		{
			this.gotoAndPlay("exit");
		}

	}

}