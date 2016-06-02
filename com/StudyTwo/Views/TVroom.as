package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.StudyTwo.SafetyVideo;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.Student;

	public class TVroom extends MovieClip
	{

		private var _VideoArray:Array;
		private var _CurrentVideo:int = 0;
		public var s:Student;

		public function TVroom()
		{
			
		}
		
		public function Start():void
		{
			Main(this.parent).student.AddClick("Begin Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name + " Type: " + 
											   Main(this.parent).student.CurrentLesson.Type);
			_CurrentVideo = 0;
			_VideoArray = [];
			this.gotoAndPlay(1);
			addEventListener(Event.ENTER_FRAME, init);
		}

		private function init(event:Event):void
		{
			if (this.currentFrameLabel == "normal")
			{
				removeEventListener(Event.ENTER_FRAME, init);

				//Load videos
				_CurrentVideo = 0;
				_VideoArray = Main(this.parent).student.CurrentLesson.Videos;

				trace("play the first video");
				//Play the first video
				if (_CurrentVideo < _VideoArray.length)
				{
					PlayVideo();
				}
				else
				{
					this.addEventListener(Event.ENTER_FRAME, end);
					gotoAndPlay("exit");
				}

			}
		}

		private function PlayVideo():void
		{
			trace("video path: " + SafetyVideo(_VideoArray[_CurrentVideo]).Path);
			if (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.TV)
			{
				video_mcb.source = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				video_mcb.addEventListener(Event.COMPLETE, NextVideo);
				//video_mcb.Mask = true;
				video_mcb.playVideo();
			}
			else if (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.INSTRUCTION)
			{
				//Load swf
				var instr:instructionsvideo = new instructionsvideo();
				//this.addChild(instr);
				this.addChildAt(instr, (this.numChildren));
				instr.name = "clip";
				instr.x = 288;
				instr.y = 158;
				instr.width = 573;
				instr.height = 300;
				instr.gotoAndPlay(1);
				
				video_mc.source = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				video_mc.addEventListener(Event.COMPLETE, NextVideo);
				//video_mc.Mask = false;
				video_mc.playVideo();
			}
			else
			{
				video_mc.source = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				video_mc.addEventListener(Event.COMPLETE, NextVideo);
				//video_mc.Mask = true;
				video_mc.playVideo();
			}
		}

		private function NextVideo(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, NextVideo);
			
			if(this.getChildAt(this.numChildren - 1).name == "clip")
			{
				trace("removing instruction video swf");
				this.removeChild(this.getChildAt(this.numChildren - 1));
			}
			
			_CurrentVideo +=  1;

			if (_CurrentVideo < _VideoArray.length)
			{
				PlayVideo();
			}
			else
			{
				this.addEventListener(Event.ENTER_FRAME, end);
				gotoAndPlay("exit");
				Main(this.parent).student.AddClick("End Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name);
			}

		}

		private function end(event:Event):void
		{
			if (this.currentFrameLabel == "end")
			{
				this.removeEventListener(Event.ENTER_FRAME, end);
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}



	}

}