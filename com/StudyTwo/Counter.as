package  com.StudyTwo {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Counter extends MovieClip {

		private var _CurrentPosition:int;
		
		public function Counter() {
			// constructor code
			
			_CurrentPosition = 0;
		}
		
		public function Reset():void
		{
			_CurrentPosition = 0;
			this.gotoAndStop(1);
		}
		
		public function UpdatePosition(CurrentPoints:uint, MasteryPoints:uint):void 
		{
			_CurrentPosition = (Math.round((CurrentPoints/MasteryPoints) * 149)) + 1;
			if(_CurrentPosition > 200)
			{
				this.gotoAndStop(200);
			}
			else
			{
				this.addEventListener(Event.ENTER_FRAME, StopPlane);
				this.play();
			}
			
		}
		
		public function StopPlane(event:Event):void
		{
			if(this.currentFrame >= _CurrentPosition)
			{
				this.stop();
			}
		}
		

	}
	
}
