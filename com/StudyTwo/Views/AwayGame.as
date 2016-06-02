package com.StudyTwo.Views
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.SafetyVideo;
	import com.StudyTwo.Counter;
	import com.StudyTwo.Character;
	import uk.co.bigroom.utils.ObjectPool;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.StudyTwo.ChooseColor;


	public class AwayGame extends MovieClip
	{

		private var _VideoArray:Array = [];
		private var _CurrentVideo:int = 0;
		private var _Complete:Boolean = false;

		private var _GoTimer:Timer = new Timer(5000);

		//Indicates whether go was early, late, or correct (on time)
		private var _GoStatus:String;
		private static const EARLY:String = "early";
		private static const CORRECT:String = "correct";
		private static const LATE:String = "late";

		private var _TrialCorrect:Boolean = false;

		public function AwayGame()
		{
			// constructor code
		}


		public function Start():void
		{
			Main(this.parent).student.AddClick("Begin Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name + " Type: " +
			   Main(this.parent).student.CurrentLesson.Type);
			_VideoArray = [];
			_CurrentVideo = 0;
			_Complete = false;
			counter_mc.Reset();
			this.gotoAndPlay(1);
			this.addEventListener(Event.ENTER_FRAME, init);
		}

		private function init(event:Event):void
		{
			if (this.currentFrameLabel == "normal")
			{
				this.removeEventListener(Event.ENTER_FRAME, init);

				//Show videos
				_VideoArray = Main(this.parent).student.CurrentLesson.Videos;

				var choose:ChooseColor = ObjectPool.getObject(ChooseColor);
				this.addChild(choose);
				choose.addEventListener(Event.COMPLETE, ColorChosen);
				choose.Start();
			}
		}

		private function ColorChosen(event:Event):void
		{
			MovieClip(event.target).removeEventListener(Event.COMPLETE, ColorChosen);

			MovieClip(stick_mc).transform.colorTransform = ChooseColor(event.target).NewColor;

			this.removeChild(MovieClip(event.target));
			ObjectPool.disposeObject(event.target);

			Character(stick_mc).addEventListener(Character.STANDING, CStand);
			Character(stick_mc).reset();

			if (_CurrentVideo < _VideoArray.length)
			{
				NextVideo();
			}
			else
			{
				SetupGame();
			}
		}

		private function CStand(event:Event):void
		{
			Character(stick_mc).removeEventListener(Character.STANDING, CStand);
			Character(stick_mc).Wave();
		}

		private function NextVideo(event:Event = null):void
		{
			if (event == null)
			{
				//don't remove listener
			}
			else
			{
				MovieClip(event.target).removeEventListener(Event.COMPLETE, NextVideo);
			}

			if (_CurrentVideo < _VideoArray.length)
			{
				//trace("play a video: " + _VideoArray[_CurrentVideo].Type);
				//trace("Complete: " + _Complete);
				trace("current video: " + _CurrentVideo);

				if (_Complete == false && (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.INSTRUCTION || 
				   SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.NORMAL || 
				   SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.STRANGER))
				{
					trace("play intro video");
					PlayVideo();
				}
				else if (_Complete == true && SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.END_VIDEO)
				{
					trace("play complete video");
					PlayVideo();
				}
				else
				{
					SetupGame();
				}
			}
			else if (_CurrentVideo >= _VideoArray.length && _Complete == false)
			{

				SetupGame();
			}
			else
			{
				//End the game
				EndGame();

			}

		}

		private function PlayVideo():void
		{
			//Play videos
			if (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.INSTRUCTION)
			{
				var i:Instruction = ObjectPool.getObject(Instruction);
				i.VideoSource = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				i.addEventListener(Event.COMPLETE, SetupGame);
				this.addChild(i);
				i.Start();
			}
			else if (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.NORMAL)
			{
				video_mc.source = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				video_mc.addEventListener(Event.COMPLETE, SetupGame);
				video_mc.playVideo();
			}
			else if (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.STRANGER)
			{
				video_mcb.source = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				video_mcb.addEventListener(Event.COMPLETE, StartStrangerTimer);
				video_mcb.playVideo();

				//Change status to correct
				_GoStatus = AwayGame.CORRECT;
			}
			else
			{
				video_mc.source = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				video_mc.addEventListener(Event.COMPLETE, NextVideo);
				video_mc.playVideo();
			}

			_CurrentVideo +=  1;
		}


		private function SetupGame(event:Event = null):void
		{
			if (event == null)
			{
				//don't remove event listener
			}
			else
			{
				MovieClip(event.target).removeEventListener(Event.COMPLETE, SetupGame);
			}

			if (Main(this.parent).student.CurrentLesson.Points < Main(this.parent).student.CurrentLesson.MasteryPoints &&
			   _CurrentVideo >= (_VideoArray.length - 1))
			{
				_CurrentVideo = 3;
			}

			if (Main(this.parent).student.CurrentLesson.Points >= Main(this.parent).student.CurrentLesson.MasteryPoints)
			{
				_Complete = true;
				EndGame();
			}
			else
			{
				_GoStatus = AwayGame.EARLY;
				go_btn.addEventListener(MouseEvent.CLICK, GoClick);
				NextVideo();
			}
		}

		private function StartStrangerTimer(event:Event):void
		{
			//Start timer
			_GoTimer.addEventListener(TimerEvent.TIMER, TooLate);
			_GoTimer.start();
		}

		private function TooLate(event:TimerEvent):void
		{
			_GoTimer.removeEventListener(TimerEvent.TIMER, TooLate);
			_GoTimer.reset();
			_GoStatus = AwayGame.LATE;
		}

		private function GoClick(event:MouseEvent):void
		{
			go_btn.removeEventListener(MouseEvent.CLICK, GoClick);

			_GoTimer.removeEventListener(TimerEvent.TIMER, TooLate);
			_GoTimer.reset();

			video_mc.removeEventListener(Event.COMPLETE, SetupGame);
			video_mc.stopVideo();
			video_mcb.removeEventListener(Event.COMPLETE, StartStrangerTimer);
			video_mcb.stopVideo();

			var v:SafetyVideo = ObjectPool.getObject(SafetyVideo);
			switch (_GoStatus)
			{
				case AwayGame.EARLY :
					Main(this.parent).student.CurrentLesson.addError();
					Main(this.parent).student.AddClick("Error: Too early");
					video_mc.source = v.AwayEarly();
					break;

				case AwayGame.LATE :
					Main(this.parent).student.CurrentLesson.addError();
					Main(this.parent).student.AddClick("Error: Too late");
					video_mc.source = v.AwayLate();
					break;

				case AwayGame.CORRECT :
					Main(this.parent).student.CurrentLesson.addCorrect();
					Main(this.parent).student.AddClick("Correct!");
					video_mc.source = v.AwayCorrect();

					Counter(counter_mc).UpdatePosition(Main(this.parent).student.CurrentLesson.Points, 
					   Main(this.parent).student.CurrentLesson.MasteryPoints);
					break;
			}

			Character(stick_mc).WalkAway();

			video_mc.addEventListener(Event.COMPLETE, SetupGame);
			video_mc.playVideo();

		}

		private function EndGame():void
		{
			this.addEventListener(Event.ENTER_FRAME, exit);
			this.gotoAndPlay("exit");
			Character(stick_mc).Exit();

			Main(this.parent).student.AddClick("End Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name +
			   " Percentage: " + Main(this.parent).student.CurrentLesson.Percentage() +
			   " Correct: " + Main(this.parent).student.CurrentLesson.NumCorrect +
			   " Total: " + Main(this.parent).student.CurrentLesson.NumTotal);
		}

		private function exit(event:Event):void
		{
			if (this.currentFrameLabel == "end")
			{
				this.removeEventListener(Event.ENTER_FRAME, exit);
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}

	}

}