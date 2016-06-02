package com.ui
{
	import flash.events.Event;
	import flash.display.MovieClip;
	import fl.video.VideoEvent;

	public class InstructionPlayer extends MovieClip 
	{

		private var _source:String;

		public function InstructionPlayer()
		{
			// constructor code

		}

		private function playtheVideo(event:Event):void
		{
			if (currentFrameLabel == "stop")
			{
				removeEventListener(Event.ENTER_FRAME, playtheVideo);
				stop();
				video.player_mc.addEventListener(VideoEvent.STOPPED_STATE_ENTERED, videoEnd);
				video.player_mc.addEventListener(VideoEvent.REWIND, videoEnd);
				video.playVideo();
			}

		}
		
		private function videoEnd(event:VideoEvent):void
		{
			trace("end of instruction video");
			video.player_mc.removeEventListener(VideoEvent.STOPPED_STATE_ENTERED, videoEnd);
			video.player_mc.removeEventListener(VideoEvent.REWIND, videoEnd);
			video.stopVideo();
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("leave");
			
		}
		
		private function exit(event:Event):void
		{
			if(currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);
				stop();
				dispatchEvent(new Event(Event.COMPLETE));
				Object(parent).removeChild(this);
			}
		}

		public function playVideo():void
		{
			addEventListener(Event.ENTER_FRAME, playtheVideo);
		}

		public function set source(s:String):void
		{
			_source = s;
			video.source = _source;
		}

		public function get source():String
		{
			return _source;
		}

	}

}