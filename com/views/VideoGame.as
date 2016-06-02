package com.views
{

	import flash.events.Event;
	import fl.video.VideoEvent;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.ui.Mouse;
	import com.MyVideo;

	public class VideoGame extends MovieClip
	{
		var videoName:MyVideo = new MyVideo  ;
		var ticks:int = 0;
		var level:int = 0;

		public function VideoGame()
		{
			// constructor code

			addEventListener(Event.ENTER_FRAME, init);
		}

		private function init(evt:Event):void
		{
			if (getChildByName("video_mc"))
			{
				cover_mc.visible = true;
				video_mc.video_mc.stop();
				removeEventListener(Event.ENTER_FRAME, init);
				video_mc.video_mc.source = videoName.Click("Click_movie");
				trace("start mouse over");
				video_mcb.source = videoName.Click("Click_01");
				video_mcb.addEventListener(Event.COMPLETE, endFirstVideo);
				video_mcb.playVideo();
				
				Object(parent).addAllClickItem("Video Game Begin");
				var currentTime:Date = new Date();
				Object(parent).addAllClickItem(currentTime);

			}
		}

		private function endFirstVideo(evt:Event):void
		{
			cover_mc.visible = false;
			video_mcb.removeEventListener(Event.COMPLETE, endFirstVideo);
			video_mc.addEventListener(MouseEvent.ROLL_OVER, videoRollOver);
		}
		//addEventListener(Event.ENTER_FRAME, timeTick);


		/*private function timeTick(evt:Event):void
		{
		ticks += 1;
		if(ticks > 449)
		{
		ticks = 0;
		switch (level)
		{
		case 0:
		video_mcb.source = videoName.Click("ClickError_01");
		Object(parent).addAllClickItem("Error: No roll over in 15s");
		break;
		case 1:
		video_mcb.source = videoName.Click("ClickError_02");
		Object(parent).addAllClickItem("Error: No roll out in 15s");
		break;
		case 2:
		video_mcb.source = videoName.Click("ClickError_03");
		Object(parent).addAllClickItem("Error: No click in 15s");
		break;
		case 3:
		video_mcb.source = videoName.Click("ClickError_04");
		Object(parent).addAllClickItem("Error: No click OK button in 15s");
		break;
		
		}
		
		video_mcb.playVideo();
		Object(parent).VideoData.addError();
		
		}
		}*/

		private function videoRollOver(evt:MouseEvent):void
		{
			cover_mc.visible = true;
			video_mc.video_mc.addEventListener(VideoEvent.COMPLETE, rewindVideo);
			video_mc.video_mc.play();
			trace("rolled over");
			ticks = 0;
			trace("roll over success! Next roll out.");
			Object(parent).VideoData.addCorrect();
			Object(parent).addAllClickItem("Correct: Roll over video");
			video_mc.removeEventListener(MouseEvent.ROLL_OVER, videoRollOver);
			
			
			video_mcb.source = videoName.Click("ClickCorrect_01");
			video_mcb.addEventListener(Event.COMPLETE, video2End);
			video_mcb.playVideo();
			
			//Added roll out event listener early because many users were confused at this point in program
			video_mc.addEventListener(MouseEvent.ROLL_OUT, videoRollOut);
			
			level = 1;
		}
		
		private function rewindVideo(event:Event):void
		{
			video_mc.video_mc.play();
		}
		
		private function video2End(evt:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, video2End);
			video_mc.addEventListener(MouseEvent.ROLL_OUT, videoRollOut);
			ticks = 0;
			cover_mc.visible = false;
			
			
		}

		private function videoRollOut(evt:MouseEvent):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, video2End);
			video_mc.removeEventListener(MouseEvent.ROLL_OUT, videoRollOut);
			cover_mc.visible = true;
			video_mc.video_mc.removeEventListener(VideoEvent.COMPLETE, rewindVideo);
			video_mc.video_mc.stop();
			ticks = 0;
			trace("roll out success! Next click.");
			Object(parent).VideoData.addCorrect();
			Object(parent).addAllClickItem("Correct: Roll out video");
			video_mcb.source = videoName.Click("ClickCorrect_02");
			video_mcb.addEventListener(Event.COMPLETE, video3End);
			video_mcb.playVideo();
			level = 2;
		}
		
		private function video3End(evt:Event):void
		{
			ticks = 0;
			video_mcb.removeEventListener(Event.COMPLETE, video3End);
			cover_mc.visible = false;
			video_mc.addEventListener(MouseEvent.CLICK, videoClick);
		}

		private function videoClick(evt:MouseEvent):void
		{
			cover_mc.visible = true;
			
			video_mc.addEventListener(MouseEvent.ROLL_OVER, tempRoll);
			
			video_mc.checkbox_mc.isChecked = true;
			ticks = 0;
			trace("Click success! Next click OK.");
			Object(parent).VideoData.addCorrect();
			Object(parent).addAllClickItem("Correct: Click video");
			video_mc.removeEventListener(MouseEvent.CLICK, videoClick);
			
			video_mcb.source = videoName.Click("ClickCorrect_03");
			video_mcb.addEventListener(Event.COMPLETE, video4End);
			video_mcb.playVideo();
			level = 3;
		}
		
		private function tempRoll(event:Event):void
		{
			video_mc.removeEventListener(MouseEvent.ROLL_OVER, tempRoll);
			video_mc.addEventListener(MouseEvent.ROLL_OUT, tempOut);
			video_mc.video_mc.addEventListener(VideoEvent.COMPLETE, rewindVideo);
			video_mc.video_mc.play();
		}
		
		private function tempOut(event:Event):void
		{
			video_mc.addEventListener(MouseEvent.ROLL_OVER, tempRoll);
			video_mc.removeEventListener(MouseEvent.ROLL_OUT, tempOut);
			video_mc.video_mc.removeEventListener(VideoEvent.COMPLETE, rewindVideo);
			video_mc.video_mc.stop();
		}
		
		private function video4End(evt:Event):void
		{
			ticks = 0;
			video_mcb.removeEventListener(Event.COMPLETE, video4End);
			video_mc.removeEventListener(MouseEvent.ROLL_OVER, tempRoll);
			video_mc.removeEventListener(MouseEvent.ROLL_OUT, tempOut);
			video_mc.video_mc.stop();
			cover_mc.visible = false;
			btnOK.addEventListener(MouseEvent.CLICK, okClick);
		}

		private function okClick(evt:MouseEvent):void
		{
			video_mc.video_mc.removeEventListener(VideoEvent.COMPLETE, rewindVideo);
			video_mc.video_mc.stop();
			ticks = 0;
			trace("remove tick event listener");
			//removeEventListener(Event.ENTER_FRAME, timeTick);;
			trace("Btn OK click success! End game.");
			Object(parent).VideoData.addCorrect();
			Object(parent).addAllClickItem("Correct: Click OK");
			btnOK.removeEventListener(MouseEvent.CLICK, okClick);
			Object(parent).VideoData.isComplete = true;
			video_mcb.source = videoName.Click("Click_done");
			video_mcb.addEventListener(Event.COMPLETE, endVideo);
			video_mcb.playVideo();

		}

		private function endVideo(evt:Event):void
		{
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_videogame");
		}

		private function exit(evt:Event):void
		{
			if (currentFrameLabel == "end")
			{
				Object(parent).gotoPracticeField();
			}
		}

	}

}