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
	import fl.controls.CheckBox;

	public class NewSignIn extends MovieClip
	{


		public function NewSignIn()
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
				var videoName:MyVideo = new MyVideo  ;
				video_mc.source = videoName.Intro("Signin_01b");
				video_mc.playVideo();


			}
		}



		private function startGame(evt:MouseEvent):void
		{
			go_btn.removeEventListener(MouseEvent.CLICK, startGame);
			Object(parent).resetGame();
			var p:Student = new Student();
			p.ActOut = CheckBox(act_chk).selected;
			Object(parent).student = p;
			video_mc.stopVideo();
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_choose_student");

		}




		private function exit(evt:Event):void
		{
			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);

				Object(parent).gotoCheckVolume();

			}
		}
		
		

	}

}