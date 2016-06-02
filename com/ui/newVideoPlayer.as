package  com.ui{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.ui.newVideoClip;
	
	public class newVideoPlayer extends MovieClip {
		
		private var _checkBoxEnabled:Boolean = true;
		private var _vid:newVideoClip;
		

		public function newVideoPlayer() {
			// constructor code
			//addEventListener(MouseEvent.CLICK, checkBox, false, 0, true);
			checkbox_mc.isChecked = false;
			_vid = player_mc;
			_vid.hideVideo = false;
			_vid.rewind = true;
			
			addEventListener(MouseEvent.ROLL_OVER, showBox);
			addEventListener(MouseEvent.ROLL_OUT, hideBox);
			
		}
		
		public function showBox(evt:MouseEvent = null):void
		{
			removeEventListener(MouseEvent.ROLL_OVER, showBox);
			addEventListener(MouseEvent.ROLL_OUT, hideBox);

			_vid.playVideo();
			
			
			if (_checkBoxEnabled == true)
			{
				checkbox_mc.alpha = 1;
				checkbox_mc.enlargeCheck();

			}

			
		}
		
		public function hideBox(evt:MouseEvent = null):void
		{
			removeEventListener(MouseEvent.ROLL_OUT, hideBox);
			addEventListener(MouseEvent.ROLL_OVER, showBox);
			
			_vid.stopVideo();
			
			if (! checkbox_mc.isChecked)
			{
				checkbox_mc.alpha = 0;
			}
			checkbox_mc.shrinkCheck();

		}
		
		public function checkBox():void
		{
			checkbox_mc.updateChecked();
			checkVisible();
		}
		
		private function checkVisible():void
		{
			if (_checkBoxEnabled == true && checkbox_mc.isChecked)
			{
				checkbox_mc.alpha = 1;
				checkbox_mc.enlargeCheck();

			}
		}
		
		public function set source(s:String):void
		{
			_vid.source = s;
		}
		
		public function get source():String
		{
			return _vid.source;
		}
		
		public function set checkBoxEnabled(c:Boolean):void
		{
			_checkBoxEnabled = c;

		}

		public function get checkBoxEnabled():Boolean
		{
			return _checkBoxEnabled;
		}
		
		public function set isChecked(c:Boolean):void
		{
			checkbox_mc.isChecked = c;
		}

		public function get isChecked():Boolean
		{
			return checkbox_mc.isChecked;
		}

	}
	
}
