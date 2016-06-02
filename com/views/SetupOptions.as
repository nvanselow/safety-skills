package com.views
{
	import flash.events.MouseEvent;
	import flash.display.*;
	import flash.events.Event;
	import com.MyVideo;

	public class SetupOptions extends MovieClip
	{
		var nextScreen:String;

		public function SetupOptions()
		{
			// constructor code
			btnPeople.addEventListener(MouseEvent.CLICK, peopleClick);
			btnAddEdit.addEventListener(MouseEvent.CLICK, addEditClick);
			btnHome.addEventListener(MouseEvent.CLICK, goHome);
			btnHelp.addEventListener(MouseEvent.CLICK, replayVideo);
			addEventListener(Event.ENTER_FRAME, startVideo);

		}
		
		private function replayVideo(evt:MouseEvent):void
		{
			video_mc.stopVideo();
			video_mc.playVideo();
		}
		
		private function startVideo(evt:Event):void
		{
			if(currentFrameLabel == "setup")
			{
				removeEventListener(Event.ENTER_FRAME, startVideo);
				/*var videoName:MyVideo = new MyVideo;
				video_mc.source = videoName.Intro("setup");
				video_mc.playVideo();*/
			}
		}

		private function peopleClick(evt:MouseEvent):void
		{
			addEventListener(Event.ENTER_FRAME, exitScreen);
			nextScreen = "people";
			gotoAndPlay("exit_setup");
		}

		private function addEditClick(evt:MouseEvent):void
		{
			addEventListener(Event.ENTER_FRAME, exitScreen);
			nextScreen = "students";
			gotoAndPlay("exit_setup");
		}

		private function goHome(evt:MouseEvent):void
		{
			addEventListener(Event.ENTER_FRAME, exitScreen);
			nextScreen = "signin";
			gotoAndPlay("exit_setup");
		}

		private function exitScreen(evt:Event):void
		{
			
			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exitScreen);
	
				switch (nextScreen)
				{
					case "signin" :
						Object(parent).gotoSignIn();
						break;

					case "people" :
						Object(parent).gotoPeople();
						break;

					case "students" :
						Object(parent).gotoEditStudents();
						break;
				}
			}

		}


	}

}