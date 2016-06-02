package com.views
{

	import flash.display.*;
	import com.db.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.ui.List;
	import com.Student;
	import com.MyVideo;
	import flash.filesystem.File;

	public class SignIn extends MovieClip
	{

		private var mydb:db = new db ();
		private var nextScreen:String;

		public function SignIn()
		{
			// constructor code
			btnSetup.addEventListener(MouseEvent.CLICK, setupClick);
			go_btn.addEventListener(MouseEvent.CLICK, selectStudent);

			mydb.list = list_mc.list_li;
			mydb.getStudentList();

			addEventListener(Event.ENTER_FRAME, initVideo);


		}

		private function initVideo(evt:Event):void
		{
			if (currentFrameLabel == "choose_student")
			{
				trace("initializing setup");
				removeEventListener(Event.ENTER_FRAME, initVideo);
				var videoName:MyVideo = new MyVideo  ;
				video_mc.source = videoName.Intro("Signin_01");
				video_mc.playVideo();

			}
		}

		private function selectStudent(evt:MouseEvent):void
		{
			if (list_mc.list_li.selectedIndex > -1)
			{
				trace("list of child elements");
				for (var i:uint = 0; i < Object(parent).numChildren; i++)
				{
					trace(Object(parent).getChildAt(i).name);
					if (Object(parent).getChildAt(i).name == "sun_clip" || Object(parent).getChildAt(i).name == "SignIn")
					{
						trace("no removed");
					}
					else
					{
						Object(parent).removeChildAt(i);
						trace("removed");
					}
				}
				Object(parent).resetGame();
				Object(parent).student = new Student  ;
				mydb.addEventListener(Event.COMPLETE, gotoNextStage);
				mydb.addEventListener(Event.CHANGE, setupStudent);
				mydb.getStudentInfo(list_mc.list_li.selectedItem.data);
				mydb.newLessonData();

			}
		}

		private function setupStudent(evt:Event):void
		{
			mydb.removeEventListener(Event.CHANGE, setupStudent);
			/*var Lessons:Array = [];
			Object(parent).Lessons = mydb.lessons;
			
			//Convert lesson array to lesson data
			Object(parent).NextData.isComplete = Lessons[].*/

			//No way to save student progress currently. New lessons are setup in SafetySkills.as
			dispatchEvent(new  Event(Event.COMPLETE));
		}

		private function gotoNextStage(evt:Event):void
		{
			mydb.removeEventListener(Event.COMPLETE, gotoNextStage);
			Object(parent).student = mydb.student;
			Object(parent).currentStudentID = mydb.student.ID;
			nextScreen = "volume";
			video_mc.stopVideo();
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_choose_student");

		}


		private function setupClick(evt:MouseEvent):void
		{
			video_mc.stopVideo();
			nextScreen = "setup";
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_choose_student");
		}

		private function exit(evt:Event):void
		{
			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);

				switch (nextScreen)
				{
					case "volume" :
						//Put back after testing
						Object(parent).gotoCheckVolume();
						//remove after testing;
						//Object(parent).gotoRoom();
						break;

					case "setup" :
						Object(parent).gotoSetup();
						break;

				}

			}
		}

	}

}