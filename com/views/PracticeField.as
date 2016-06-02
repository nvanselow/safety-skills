package com.views
{

	import flash.display.MovieClip;
	import com.Student;
	import flash.events.Event;
	import com.MyVideo;

	public class PracticeField extends MovieClip
	{

		var nextScreen:String;

		public function PracticeField()
		{
			// constructor code

			addEventListener(Event.EXIT_FRAME, init);


		}

		private function startVideo(evt:Event):void
		{
			if (currentFrameLabel == "practice_field")
			{
				removeEventListener(Event.ENTER_FRAME, startVideo);
				var videoName:MyVideo = new MyVideo  ;

				if (checkTarget_mc.visible == true && checkSoccer_mc.visible == true && checkWaterTarget_mc.visible == true)
				{
					video_mc.source = videoName.Practice("Practice_04");
					Object(parent).addAllClickItem("VideoPractice-End");
					var currentTime:Date = new Date();
					Object(parent).addAllClickItem(currentTime);
				}
				else if (checkTarget_mc.visible == true && checkSoccer_mc.visible == false && checkWaterTarget_mc.visible == false)
				{
					video_mc.source = videoName.Practice("Practice_02");
					Object(parent).addAllClickItem("Target-End");
					var currentTime:Date = new Date();
					Object(parent).addAllClickItem(currentTime);

				}
				else if (checkTarget_mc.visible == true && checkSoccer_mc.visible == true && checkWaterTarget_mc.visible == false)
				{
					video_mc.source = videoName.Practice("Practice_03");
					Object(parent).addAllClickItem("Soccer-End");
					var currentTime:Date = new Date();
					Object(parent).addAllClickItem(currentTime);
				}
				else
				{
					video_mc.source = videoName.Practice("Practice_01");
					Object(parent).addAllClickItem("PracticeField-Begin");
					var currentTime:Date = new Date();
					Object(parent).addAllClickItem(currentTime);

				}

				video_mc.addEventListener(Event.COMPLETE, videoEnd);
				video_mc.playVideo();
			}
		}

		private function videoEnd(evt:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, videoEnd);
			if (checkTarget_mc.visible == true && checkSoccer_mc.visible == true && checkWaterTarget_mc.visible == true)
			{
				nextScreen = "room";
				gotoAndPlay("exit_practice_field");
				Object(parent).addAllClickItem("PracticeField-End");
				var currentTime:Date = new Date();
				Object(parent).addAllClickItem(currentTime);


			}
			else if (checkTarget_mc.visible == true && checkSoccer_mc.visible == false && checkWaterTarget_mc.visible == false)
			{
				nextScreen = "soccer";
				gotoAndPlay("go_to_soccer");
				Object(parent).addAllClickItem("Soccer-Begin");
				var currentTime:Date = new Date();
				Object(parent).addAllClickItem(currentTime);

			}
			else if (checkTarget_mc.visible == true && checkSoccer_mc.visible == true && checkWaterTarget_mc.visible == false)
			{
				nextScreen = "watertarget";
				gotoAndPlay("go_to_watertarget");
				Object(parent).addAllClickItem("WaterTarget-Begin");
				var currentTime:Date = new Date();
				Object(parent).addAllClickItem(currentTime);

			}
			else
			{
				nextScreen = "targets";
				gotoAndPlay("go_to_targets");
				Object(parent).addAllClickItem("Target-Begin");
				var currentTime:Date = new Date();
				Object(parent).addAllClickItem(currentTime);

			}

			addEventListener(Event.ENTER_FRAME, exit);
		}

		private function init(evt:Event):void
		{
			if (getChildByName("checkTarget_mc"))
			{
				removeEventListener(Event.EXIT_FRAME, init);

				checkTarget_mc.visible = Object(parent).TargetData.isComplete;
				checkSoccer_mc.visible = Object(parent).SoccerData.isComplete;
				checkWaterTarget_mc.visible = Object(parent).WaterData.isComplete;

				addEventListener(Event.ENTER_FRAME, startVideo);
			}
		}

		private function exit(evt:Event):void
		{
			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);
				switch (nextScreen)
				{
					case "targets" :
						Object(parent).gotoTargets();
						break;

					case "soccer" :
						Object(parent).gotoSoccer();
						break;

					case "watertarget" :
						Object(parent).gotoWaterGame();
						break;


					case "room" :
						Object(parent).gotoRoom();
						break;

				}

			}
		}


	}

}