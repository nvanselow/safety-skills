package com.StudyTwo.Views
{

	import flash.display.*;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.StudyTwo.SafetyVideo;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.Student;
	import fl.controls.CheckBox;
	import fl.text.TLFTextField;

	public class SignIn extends MovieClip
	{


		public function SignIn()
		{
			// constructor code
			addEventListener(Event.ENTER_FRAME, initVideo);

		}

		private function initVideo(evt:Event):void
		{
			if (go_btn && video_mc)
			{
				removeEventListener(Event.ENTER_FRAME, initVideo);
				go_btn.addEventListener(MouseEvent.CLICK, startGame);
				var videoName:SafetyVideo = new SafetyVideo();
				video_mc.source = videoName.Intro("Signin_01b");
				video_mc.playVideo();


			}
		}

		private function startGame(evt:MouseEvent):void
		{
			go_btn.removeEventListener(MouseEvent.CLICK, startGame);
			video_mc.stopVideo();

			//Update participant and condition
			Main(this.parent).student.Name = TLFTextField(name_txt).text;
			if (CheckBox(two_chk).selected == true)
			{
				Main(this.parent).student.Condition = Student.STUDYTWO;
			}
			else if (CheckBox(act_chk).selected == true)
			{
				Main(this.parent).student.Condition = Student.ACTOUT;
			}
			else if (CheckBox(away_chk).selected == true)
			{
				Main(this.parent).student.Condition = Student.AWAY;
			}
			else if (CheckBox(actplus_chk).selected == true)
			{
				Main(this.parent).student.Condition = Student.ACTPLUS;
			}
			else
			{
				Main(this.parent).student.Condition = Student.NOACT;
			}


			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_choose_student");

		}




		private function exit(evt:Event):void
		{
			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);

				dispatchEvent(new Event(Event.COMPLETE));

			}
		}



	}

}