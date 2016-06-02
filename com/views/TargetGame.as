package com.views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.LessonData;
	import com.MyVideo;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class TargetGame extends MovieClip 
	{	
		var _targetsClicked:int = 0
		var videoName:MyVideo = new MyVideo;
		var tmr:Timer = new Timer(5000);
		
		public function TargetGame()
		{
			// constructor code
			addEventListener(Event.ENTER_FRAME, init);

		}
		
		private function init(event:Event):void
		{
			if(instructions)
			{
				removeEventListener(Event.ENTER_FRAME, init);
				instructions.source = videoName.Target("Target_Instructions");
				instructions.addEventListener(Event.COMPLETE, startTimer);
				instructions.playVideo();
			}
		}
		
		
		
		private function startTimer(event:Event):void
		{
			cover_mc.visible = false;
			instructions.removeEventListener(Event.COMPLETE, startTimer);
			tmr.delay = 5000;
			tmr.addEventListener(TimerEvent.TIMER, timerTick);
			tmr.start();
		}
		
		private function timerTick(event:TimerEvent):void
		{
			video_mc.source = videoName.Target("Error_01");
			video_mc.playVideo();
			
			Object(parent).TargetData.addError();
			Object(parent).addAllClickItem("Error: No click in 5s");
		}
		
		public function targetClicked():void
		{
			//Reset the timer
			tmr.reset();
			
			video_mc.stopVideo();
			
			//Count the target
			_targetsClicked += 1;
			Object(parent).TargetData.addCorrect();
			Object(parent).addAllClickItem("Correct: Target clicked");
			if (_targetsClicked > 4)
			{
				Object(parent).TargetData.isComplete = true;
				video_mc.source = videoName.Target("Target_done");
				video_mc.addEventListener(Event.COMPLETE, leave);
				video_mc.playVideo();
				
			}
		}
		
		private function leave(event:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, leave);
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_targets");
		}
		
		private function exit(evt:Event):void
		{
			if(currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);
				Object(parent).gotoPracticeField();
			}
		}

	}

}