package com.ui.games
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;

	public class ExplodeTarget extends MovieClip
	{

		private const EXPLODE:String = "explode";
		private const LAST_FRAME:String = "last_frame";

		public function ExplodeTarget()
		{
			// constructor code
			stop();
			visible = true;
			addEventListener(MouseEvent.CLICK, sendSparks);
		}

		private function sendSparks(evt:MouseEvent):void
		{
			gotoAndPlay(EXPLODE);

			var newBang:Bang = new Bang  ;
			newBang.x = this.x + this.width / 2;
			newBang.y = this.y + this.height / 2;
			newBang.scaleX = .65;
			newBang.scaleY = .65;
			parent.addChild(newBang);
			Object(parent).targetClicked();
			addEventListener(Event.ENTER_FRAME, stopAnimation);
		}
		
		private function stopAnimation(evt:Event):void
		{
			if(currentFrameLabel == LAST_FRAME)
			{
				visible = false;
				stop();
				removeEventListener(Event.ENTER_FRAME, stopAnimation);
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}

	}

}