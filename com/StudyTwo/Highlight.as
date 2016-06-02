package com.StudyTwo
{
	import com.StudyTwo.SafetyImage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import uk.co.bigroom.utils.ObjectPool;
	import flash.events.TimerEvent;
	
	public class Highlight extends MovieClip 
	{
		private var _videoSource:String = "";
		private var _image:SafetyImage = ObjectPool.getObject(SafetyImage);
		private var _imageSource:String = "";
		private var t:Timer = new Timer(2500, 0);
		
		public function Highlight()
		{
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
				_image.IsVisible = false;
				this.addChild(_image);
				_image.x = 374;
				_image.y = 294;
				_image.HighlightPath = _imageSource;
				_image.Highlight = true;
				_image.IsVisible = true;
				
				if(_videoSource.length > 0)
				{
					video_mc.source = _videoSource;
					video_mc.addEventListener(Event.COMPLETE, endVideo);
					video_mc.playVideo();
				}
				else
				{
					t.addEventListener(TimerEvent.TIMER, tick);
					t.start();
				}
				
			}
		}
		
		private function endVideo(event:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, endVideo);
			exit();
		}
		
		private function tick(event:TimerEvent):void
		{
			t.removeEventListener(TimerEvent.TIMER, tick);
			t.stop();
			exit();
		}
		
		private function exit():void
		{
			this.addEventListener(Event.ENTER_FRAME, end);
			this.gotoAndPlay("exit");
			_image.IsVisible = false;
		}
		
		private function end(event:Event):void
		{
			if(this.currentFrameLabel == "end")
			{
				this.removeEventListener(Event.ENTER_FRAME, end);
				this.dispatchEvent(new Event(Event.COMPLETE));
				this.removeChild(_image);
				ObjectPool.disposeObject(_image);
				_videoSource = "";
				MovieClip(this.parent).removeChild(this);
				ObjectPool.disposeObject(this);
			}
		}
		
		
		public function set videoSource(s:String):void
		{
			_videoSource = s;
		}
		
		public function get videoSource():String
		{
			return _videoSource;
		}
		
		public function set imageSource(s:String):void
		{
			_imageSource = s;
		}
		
		public function get image():String
		{
			return _imageSource;
		}
		

	}

}