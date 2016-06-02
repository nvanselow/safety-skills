package com.views
{

	import com.MyVideo;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class ActGame extends MovieClip
	{

		var videoName:MyVideo = new MyVideo  ;
		var trials:int = 0;
		var ticks:int = 0;
		var tmr:Timer = new Timer(3000);
		var tooFast:Boolean = true;

		public function ActGame()
		{
			// constructor code

			addEventListener(Event.EXIT_FRAME, init);
		}

		private function init(evt:Event):void
		{
			if (video_mc)
			{
				removeEventListener(Event.EXIT_FRAME,init);
				trials = 1;
				ticks = 0;
				instructionVideos();

			}

		}

		private function instructionVideos():void
		{
			switch (trials)
			{
				case 1 :
					video_mc.source = videoName.Act("Act_01");
					break;
				case 2 :
					video_mc.source = videoName.Act("Act_02");
					btnGo.addEventListener(MouseEvent.CLICK, goClick);
					break;

				case 3 :
					video_mc.source = videoName.Act("Act_05");
					break;
				case 4 :
					video_mc.source = videoName.Act("Act_06");
					break;
				case 5 :
					video_mc.source = videoName.Act("Act_07");
					break;
				case 6 :
					video_mc.source = videoName.Act("Act_08");
					trials++;
					break;
			}

			video_mc.addEventListener(Event.COMPLETE,endVideo);
			video_mc.playVideo();
		}

		private function endVideo(evt:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE,endVideo);
			var playStranger:Boolean = true;
			switch (trials)
			{
				case 1 :
					video_mcb.source = videoName.Act("Stranger_01");
					trials++;
					break;
				case 2 :
					addEventListener(Event.ENTER_FRAME, reminder, false, 0, true);
					ticks = 0;
					tmr.addEventListener(TimerEvent.TIMER, timerTick);
					trace("start timer");
					tmr.start();
					cover_mc.visible = false;
					playStranger = false;
					break;
				case 3 :
					video_mcb.source = videoName.Act("Stranger_02");
					break;
				case 4 :
					video_mcb.source = videoName.Act("Stranger_03");
					break;
				case 5 :
					video_mcb.source = videoName.Act("Stranger_04");
					break;
				case 6 :
					video_mcb.source = videoName.Act("Stranger_05");
					break;
				case 7 :
					playStranger = false;
					endAct();
					break;

			}

			if (playStranger)
			{
				video_mcb.addEventListener(Event.COMPLETE, endStranger);
				video_mcb.playVideo();
			}
		}

		private function endStranger(evt:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, endStranger);
			if (trials == 2)
			{
				instructionVideos();
			}
			else
			{
				btnGo.addEventListener(MouseEvent.CLICK, goClick);
				cover_mc.visible = false;
				addEventListener(Event.ENTER_FRAME, reminder);
				ticks = 0;
				tmr.addEventListener(TimerEvent.TIMER, timerTick);
				tmr.reset();
				trace("start timer end stranger");
				tmr.start();
				tooFast = true;
			}
		}

		private function timerTick(event:TimerEvent):void
		{
			//Set tooFast == false so that player can continue
			tmr.removeEventListener(TimerEvent.TIMER, timerTick);
			tmr.stop();
			tooFast = false;
			trace("too fast is true now");

		}

		private function goClick(evt:MouseEvent):void
		{
			trace("too fast = " + tooFast);
			if (tooFast == false)
			{
				tooFast = true;
				
				Object(parent).ActOutData.addCorrect();

				Object(parent).addAllClickItem("Correct: Click Go after stranger");
				var currentTime:Date = new Date();
				Object(parent).addAllClickItem(currentTime);

				removeEventListener(Event.ENTER_FRAME, reminder);
				btnGo.removeEventListener(MouseEvent.CLICK, goClick);
				cover_mc.visible = true;
				trials++;
				instructionVideos();
			}
			else
			{
				video_mc.source = videoName.Act("Error_01");
				video_mc.playVideo();
				tmr.reset();
				trace("timer start again after click");
				tmr.start();
				Object(parent).addAllClickItem("Error: Click Go less than 3s");
				Object(parent).ActOutData.addError();
			}

		}

		private function reminder(evt:Event):void
		{
			ticks++;
			if (ticks > 599)
			{
				ticks = 0;
				video_mc.source = videoName.Act("Act_04");
				video_mc.playVideo();
			}
		}

		private function endAct():void
		{
			Object(parent).ActOutData.isComplete = true;
			Object(parent).addAllClickItem("End Act Out Game");
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_act");

			Object(parent).addAllClickItem("Act Game Complete");
			var currentTime:Date = new Date();
			Object(parent).addAllClickItem(currentTime);

		}

		private function exit(evt:Event):void
		{
			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);
				Object(parent).returntoRoom();

			}
		}



	}

}