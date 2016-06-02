package  com.ui{
	import flash.display.MovieClip;
	import flash.events.TextEvent;
	
	public class CustomTextBox extends MovieClip {

		var _text:String;

		public function CustomTextBox() {
			// constructor code
			//txt.addEventListener(TextEvent.TEXT_INPUT, updateText);
		}
		
		/*private function updateText():void
		{
			_text = txt.text;
		}
		*/
		public function set text(t:String):void
		{
			_text = t;
			txt.text = _text;
			
		}
		
		public function get text():String
		{
			return _text;
		}

	}
	
}
