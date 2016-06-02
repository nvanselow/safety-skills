package com.views
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.MyVideo;
	import com.db.ExportData;
	import flash.display.NativeWindow;
	import flash.desktop.NativeApplication;

	public class MainRoom extends MovieClip
	{

		var _color:String;
		var videoName:MyVideo = new MyVideo  ;

		public function MainRoom()
		{
			// constructor code
			addEventListener(Event.ENTER_FRAME, beginRoom);
			mainroom_mc.addEventListener(Event.CHANGE, roomColorSelected);
		}

		private function beginRoom(event:Event):void
		{
			if (video_mc)
			{
				removeEventListener(Event.ENTER_FRAME, beginRoom);
				hideChecks();
				video_mc.source = videoName.Classroom("Classroom_01");
				video_mc.playVideo();
				video_mc.visible = true;
			}
		}

		private function roomColorSelected(evt:Event):void
		{
			mainroom_mc.removeEventListener(Event.CHANGE, roomColorSelected);

			//Update room with roomcolor and show checks and markers;
			_color = mainroom_mc.roomColor;
			Object(parent).addAllClickItem("Room color selected = " + _color);
			showMarkers();
			if (Object(parent).student.ActOut == false)
			{
				markers.act_btn.visible = false;
			}
			updateChecks();

			//Move video to new location
			video_mc.stopVideo();
			video_mc.visible = false;
			video_mcb.x = -70;
			video_mcb.y = 360;
			video_mcb.width = 385;
			video_mcb.height = 308;

			//Play color video
			switch (_color)
			{
				case "blue" :
					video_mcb.source = videoName.Classroom("Classroom_blue");
					break;
				case "red" :
					video_mcb.source = videoName.Classroom("Classroom_red");
					break;
				case "orange" :
					video_mcb.source = videoName.Classroom("Classroom_orange");
					break;
				case "yellow" :
					video_mcb.source = videoName.Classroom("Classroom_yellow");
					break;
				case "pink" :
					video_mcb.source = videoName.Classroom("Classroom_pink");
					break;
				case "purple" :
					video_mcb.source = videoName.Classroom("Classroom_purple");
					break;

			}
			video_mcb.addEventListener(Event.COMPLETE, instructionVideo);
			video_mcb.playVideo();


			//remove 2 lines after testing
			/*Object(parent).gotoTV();
			hideMarkers();
			addEventListener(Event.EXIT_FRAME, gotoStrangers);*/
		}

		private function instructionVideo(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, instructionVideo);

			video_mc.source = videoName.Classroom("Classroom_02");
			video_mc.addEventListener(Event.COMPLETE, gotoInstructionsCheck);
			video_mc.visible = true;
			video_mc.x = -70;
			video_mc.y = 360;
			video_mc.width = 385;
			video_mc.height = 308;
			video_mc.playVideo();
		}

		private function gotoInstructionsCheck(event:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, gotoInstructionsCheck);
			gotoNextSection();
		}

		private function gotoInstructions():void
		{
			trace("Going to TV");
			prepforgame();
			Object(parent).gotoTV();
		}

		public function gotoNextSection():void
		{

			//Deteremine which acitvities have been completed and play appropriate video
			if (Object(parent).InstructionsData.isComplete == false)
			{
				trace("instructions not complete");
				gotoInstructions();
			}
			else if (Object(parent).InstructionsData.isComplete == true && Object(parent).LookData.isComplete == false)
			{
				trace("Should play look video");
				video_mcb.source = videoName.Classroom("Classroom_04");
				video_mcb.addEventListener(Event.COMPLETE, gotoLook);
			}
			else if (Object(parent).LookData.isComplete == true && Object(parent).NextData.isComplete == false)
			{
				trace("Should play next video");
				video_mcb.source = videoName.Classroom("Classroom_05");
				video_mcb.addEventListener(Event.COMPLETE, gotoNextGame);

			}
			else if (Object(parent).NextData.isComplete == true && Object(parent).OrderData.isComplete == false)
			{
				try
				{
					Object(parent).removeNextGame();
				}
				catch (errObject:Error)
				{
					trace("Could not remove next game");
				}
				trace("should play order video");
				video_mcb.source = videoName.Classroom("Classroom_06");
				video_mcb.addEventListener(Event.COMPLETE, gotoOrderGame);
			}
			else if (Object(parent).OrderData.isComplete == true && Object(parent).ActOutData.isComplete == false)
			{
				try
				{
					Object(parent).removeOrderGame();
				}
				catch (errObject:Error)
				{
					trace("Could not remove order game");
				}
				if (Object(parent).student.ActOut)
				{
					trace("go to act out");
					video_mcb.source = videoName.Classroom("Classroom_08");
					video_mcb.addEventListener(Event.COMPLETE, gotoActOut);

				}
				else
				{
					trace("play classroom done no act out");
					video_mcb.source = videoName.Classroom("Classroom_done");
					video_mcb.addEventListener(Event.COMPLETE, finishGame);
				}
			}
			else if (Object(parent).ActOutData.isComplete == true)
			{
				try
				{
					Object(parent).removeActOut();
				}
				catch (errObject:Error)
				{
					trace("Could not remove act out");
				}
				trace("play classroom done");
				video_mcb.source = videoName.Classroom("Classroom_done");
				video_mcb.addEventListener(Event.COMPLETE, finishGame);
			}

			//Return room to previous visual state
			if (Object(parent).InstructionsData.isComplete)
			{
				trace("zooming out");
				gotoAndPlay("zoom_out");
				showMarkers();
				updateChecks();
				video_mcb.playVideo();
			}

		}

		//Preps the mainroom screen for a game (zoom in and hide markers)
		private function prepforgame():void
		{
			gotoAndPlay("zoom_in");
			hideMarkers();
			hideChecks();
		}

		private function gotoLook(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, gotoLook);
			Object(parent).gotoTV();
			prepforgame();
		}


		private function gotoNextGame(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, gotoNextGame);
			Object(parent).gotoNextGame();
			prepforgame();
			Object(parent).addAllClickItem("Begin Next Game");
		}

		private function gotoOrderGame(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, gotoOrderGame);
			Object(parent).gotoOrderGame();
			prepforgame();
			Object(parent).addAllClickItem("Begin Order Game");
		}

		private function gotoActOut(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, gotoActOut);
			Object(parent).gotoActOutGame();
			prepforgame();
		}

		private function finishGame(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, finishGame);
			trace("finish the game");
			var currentTime:Date = new Date();
			Object(parent).addAllClickItem(currentTime.toString());
			//Record data to xml file;
			var e:ExportData = new ExportData();
			var s:Object = Object(parent);
			e.Export(s.student, s.InstructionsData, s.LookData, s.NextData, s.OrderData, s.ActOutData, s.TargetData, s.SoccerData, s.WaterData, s.VideoData, s.AllClicks);

			//Close the game
			NativeWindow(NativeApplication.nativeApplication.openedWindows[0]).close();
		}

		/*private function gotoStrangers(evt:Event):void
		{
		if (!Object(parent).getChildByName("TV").exists)
		{
		removeEventListener(Event.EXIT_FRAME, gotoStrangers);
		updateChecks();
		Object(parent).addAllClickItem("Begin Who Game");
		Object(parent).gotoWhoGame();
		}
		}*/

		private function init(evt:Event):void
		{
			if (instructions_chk)
			{
				removeEventListener(Event.ENTER_FRAME, init);
				hideMarkers();
				updateChecks();
			}
			else
			{
				Object(parent).addAllClickItem("Enter school room");
			}
		}

		private function hideMarkers():void
		{
			markers.gotoAndStop(1);
		}

		private function showMarkers():void
		{
			markers.gotoAndPlay("show_markers");
			if (Object(parent).student.ActOut == false)
			{
				markers.act_btn.visible = false;
			}
		}

		private function updateChecks():void
		{
			instructions_chk.visible = Object(parent).InstructionsData.isComplete;
			//who_chk.visible = Object(parent).Lessons[5].isComplete;
			model_chk.visible = Object(parent).LookData.isComplete;
			next_chk.visible = Object(parent).NextData.isComplete;
			order_chk.visible = Object(parent).OrderData.isComplete;
			if (Object(parent).student.ActOut == true)
			{
				actout_chk.visible = Object(parent).ActOutData.isComplete;
			}
			else
			{
				actout_chk.visible = false;
			}


		}

		private function hideChecks():void
		{
			instructions_chk.visible = false;
			model_chk.visible = false;
			next_chk.visible = false;
			order_chk.visible = false;
			actout_chk.visible = false;
		}

	}

}