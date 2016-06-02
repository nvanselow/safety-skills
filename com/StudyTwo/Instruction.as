package  com.StudyTwo{
	import flash.display.MovieClip;
	import flash.events.Event;
	import uk.co.bigroom.utils.ObjectPool;
	
	public class Instruction extends MovieClip {

		public function Instruction() {
			// constructor code
		}
		
		public function Start():void
		{
			this.addEventListener(Event.ENTER_FRAME, init);
			this.gotoAndPlay("enter");
		}
		
		private function init(event:Event):void
		{
			if(this.currentFrameLabel == "normal")
			{
				this.removeEventListener(Event.ENTER_FRAME, init);
				video_mc.addEventListener(Event.COMPLETE, EndVideo);
				video_mc.playVideo();
				//video_mc.Mask = false;
			}
		}
		
		private function EndVideo(event:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, EndVideo);
			this.addEventListener(Event.ENTER_FRAME, end);
			this.gotoAndPlay("exit");
		}
		
		private function end(event:Event):void
		{
			if(this.currentFrameLabel == "end")
			{
				this.removeEventListener(Event.ENTER_FRAME, end);
				this.dispatchEvent(new Event(Event.COMPLETE));
				MovieClip(this.parent).removeChild(this);
				ObjectPool.disposeObject(this);
			}
		}
		
		public function set VideoSource(s:String):void
		{
			trace("instruction source: " + s);
			video_mc.source = s;
		}
		
		public function get VideoSource():String
		{
			return video_mc.source;
		}

	}
	
}
