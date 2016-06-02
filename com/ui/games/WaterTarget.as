package com.ui.games
{

	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.display.MovieClip;
	import com.MyVideo;

	public class WaterTarget extends MovieClip
	{

		public const RISING_WATER_FINAL_FRAME = "final_frame";
		var videoName:MyVideo = new MyVideo  ;

		public function WaterTarget()
		{
			// constructor code
			trace("initializing water game");
			splash.visible = false;
			risingWater.stop();

			addEventListener(MouseEvent.ROLL_OVER, startWater);
			addEventListener(MouseEvent.CLICK, errorClick);
		}

		private function startWater(evt:MouseEvent):void
		{
			target.gotoAndStop(2);
			Object(parent.parent).addAllClickItem("Correct: Mouse over water target");
			Object(parent.parent).WaterData.addCorrect();
			Object(parent).video_mc.source = videoName.Water("Correct_01");
			Object(parent).video_mc.playVideo();
			splash.visible = true;
			risingWater.play();
			removeEventListener(MouseEvent.ROLL_OVER, startWater);
			addEventListener(MouseEvent.ROLL_OUT, stopWater);
			addEventListener(MouseEvent.CLICK, errorClick);
			addEventListener(Event.ENTER_FRAME, stopAnimation);
			//Object(parent.parent).WaterData.addCorrect():
			Object(parent.parent).addAllClickItem("Correct: Mouse over water target");
		}

		private function stopWater(evt:MouseEvent):void
		{
			risingWater.stop();
			Object(parent.parent).addAllClickItem("Error: Mouse out of water target");
			Object(parent.parent).WaterData.addError();
			splash.visible = false;
			target.gotoAndStop(1);
			removeEventListener(MouseEvent.ROLL_OUT, stopWater);
			addEventListener(MouseEvent.ROLL_OVER, startWater);
			removeEventListener(Event.ENTER_FRAME, stopAnimation);
			Object(parent.parent).WaterData.addError();
			Object(parent).video_mc.source = videoName.Water("Error_01");
			Object(parent).video_mc.playVideo();
			Object(parent.parent).addAllClickItem("Error: Moved off target");


		}

		private function stopAnimation(evt:Event=null):void
		{
			if (risingWater.currentFrameLabel == RISING_WATER_FINAL_FRAME)
			{
				removeEventListener(Event.ENTER_FRAME, stopAnimation);
				removeEventListener(MouseEvent.ROLL_OUT, stopWater);
				removeEventListener(MouseEvent.CLICK, errorClick);
				risingWater.gotoAndStop(RISING_WATER_FINAL_FRAME);
				splash.visible = false;
				target.gotoAndStop(1);
				dispatchEvent(new Event(Event.COMPLETE));

			}



		}

		private function errorClick(evt:MouseEvent):void
		{
			risingWater.gotoAndPlay(1);
			Object(parent.parent).addAllClickItem("Error: Click Target");
			Object(parent.parent).WaterData.addError();

			removeEventListener(MouseEvent.ROLL_OVER, startWater);
			stopAnimation();
			Object(parent.parent).WaterData.addError();
			Object(parent).video_mc.source = videoName.Water("Error_02");
			Object(parent).video_mc.addEventListener(Event.COMPLETE, endVideo);
			Object(parent).video_mc.playVideo();
			Object(parent.parent).addAllClickItem("Error: Clicked water target");

		}

		private function endVideo(evt:Event):void
		{
			addEventListener(MouseEvent.ROLL_OVER, startWater);
		}

	}

}