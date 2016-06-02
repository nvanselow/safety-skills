package com.StudyTwo
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class TrialVideo extends MovieClip
	{
		private var _Name:String;
		private var _Enabled:Boolean = true;

		public function TrialVideo()
		{
			// constructor code
			this.Checked = false;
			this.HidePrompt();
		}

		public function set Checked(c:Boolean):void
		{

			check_mc.visible = c;
		}

		public function get Checked():Boolean
		{
			return check_mc.visible;
		}

		public function set VideoSource(s:String):void
		{
			video_mc.source = s;
		}

		public function get VideoSource():String
		{
			return video_mc.source;
		}

		public function set Name(n:String):void
		{
			_Name = n;
		}

		public function get Name():String
		{
			return _Name;
		}

		public function ShowPrompt():void
		{
			this.gotoAndStop("show_prompt");
			prompt_mc.addEventListener(Event.ENTER_FRAME, HidePrompt);
			
			prompt_mc.x = 62.9;
			prompt_mc.y = -100.2;
			prompt_mc.height = 151.95;
			prompt_mc.width = 157.35;
			
			prompt_mc.gotoAndPlay("enter");
			
			prompt_mc.visible = true;
		}

		public function HidePrompt(event:Event = null):void
		{
			if (prompt_mc.currentFrameLabel == "end" || event == null)
			{
				trace("hiding prompt");
				prompt_mc.removeEventListener(Event.ENTER_FRAME, HidePrompt);
				this.gotoAndStop("hide_prompt");
				
				prompt_mc.x = 62.9;
				prompt_mc.y = -7.15;
				prompt_mc.height = 2;
				
				prompt_mc.visible = false;
				MovieClip(prompt_mc).enabled = false;
			}

		}

		/*public function set Enabled(e:Boolean):void
		{
		_Enabled = e;
		
		if(_Enabled == true)
		{
		this.addEventListener(MouseEvent.CLICK, Clicked, false, 0, true);
		}
		else
		{
		this.removeEventListener(MouseEvent.CLICK, Clicked, false, 0 true);
		}
		}*/

		/*private function Clicked(event:MouseEvent):void
		{
		video_mc.addEventListener(Event.COMPLETE, EndVideo, false, 0, true);
		video_mc.stopVideo();
		video_mc.playVideo();
		}*/

		private function EndVideo(event:Event = null):void
		{
			video_mc.removeEventListener(Event.COMPLETE, EndVideo);
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		/*public function get Enabled():Boolean
		{
		return _Enabled;
		}*/

		public function Stop():void
		{
			EndVideo();
			video_mc.stopVideo();
			
		}

		public function Play():void
		{
			video_mc.addEventListener(Event.COMPLETE, EndVideo);
			video_mc.playVideo();
		}

		public function set HideVideo(b:Boolean):void
		{
			video_mc.HideVideo = b;
		}

	}

}