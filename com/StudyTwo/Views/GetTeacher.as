package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	//import flash.display.Stage;

	public class GetTeacher extends MovieClip
	{

		var ctrlPress:Boolean = false;

		public function GetTeacher()
		{
			// constructor code
			
		}
		
		public function Reset():void
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, KeyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, KeyUp);
		}

		private function KeyPressed(event:KeyboardEvent):void
		{
			trace("key pressed: " + String.fromCharCode(event.charCode) + " (Key code: " + event.keyCode + " Character code: " + event.charCode + ")");

			if (event.keyCode == Keyboard.CONTROL)
			{
				ctrlPress = true;
			}

			if (ctrlPress == true && event.keyCode == Keyboard.T)
			{
				trace("exit");
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, KeyPressed);
				stage.removeEventListener(KeyboardEvent.KEY_UP, KeyUp);
				
				//Dispatch complete event
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		private function KeyUp(event:KeyboardEvent):void
		{
			trace("key up: " + String.fromCharCode(event.charCode));

			if (event.keyCode == Keyboard.CONTROL)
			{
				ctrlPress = false;
			}
		}

	}

}