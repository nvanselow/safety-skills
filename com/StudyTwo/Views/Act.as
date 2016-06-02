package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.SafetyVideo;
	import com.StudyTwo.Instruction;
	import com.StudyTwo.Counter;
	import uk.co.bigroom.utils.ObjectPool;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;


	public class Act extends MovieClip
	{
		private var t:Timer = new Timer(3500);

		private var _CurrentVideo:int;
		private var _VideoArray:Array;
		private var _Complete:Boolean;
		private var _CurrentTrial:int;
		private var _ConsecutiveErrors:int = 0;

		//Is True 3s after trial starts
		private var _Wait:Boolean;
		private var _TrialError:Boolean;

		public function Act()
		{
			// constructor code
		}

		public function Start():void
		{
			this.addEventListener(Event.ENTER_FRAME, init);
			this.gotoAndPlay("enter");

			_Complete = false;
			_CurrentVideo = 0;
			_CurrentTrial = 0;
			_ConsecutiveErrors = 0;
			_VideoArray = Main(this.parent).student.CurrentLesson.Videos;
			

			Main(this.parent).student.AddClick("Begin Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name + " Type: " + 
			   Main(this.parent).student.CurrentLesson.Type);
		}

		private function init(event:Event):void
		{
			if (this.currentFrameLabel == "normal")
			{
				this.removeEventListener(Event.ENTER_FRAME, init);
				
				//Update counter;
				Counter(counter_mc).UpdatePosition(Main(this.parent).student.CurrentLesson.Points, 
				   Main(this.parent).student.CurrentLesson.MasteryPoints);
				
				NextVideo();
			}
		}

		private function NextVideo(event:Event = null):void
		{
			trace("current video: " + _CurrentVideo);
			if (event == null)
			{
				//Do not remove event listener
			}
			else
			{
				MovieClip(event.target).removeEventListener(Event.COMPLETE, NextVideo);
			}

			if (_CurrentVideo < _VideoArray.length)
			{
				//PlayVideo();
				//trace("play a video: " + _VideoArray[_CurrentVideo].Type);
				//trace("Complete: " + _Complete);
				if (_Complete == false && (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.INSTRUCTION || 
				   SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.NORMAL ||
				   SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.STRANGER))
				{
					trace("play intro video");
					PlayVideo();
				}
				else if (_Complete == true && SafetyVideo(_VideoArray[(_VideoArray.length - 1)]).Type == SafetyVideo.END_VIDEO)
				{
					trace("play complete video");
					_CurrentVideo = _VideoArray.length - 1;
					PlayVideo();
				}
				else
				{
					trace("end game");
					EndGame();
				}
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
			trace("VideoNum: " + _CurrentVideo + " Video: " + SafetyVideo(_VideoArray[_CurrentVideo]).Path);

			if (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.INSTRUCTION)
			{
				var i:Instruction = ObjectPool.getObject(Instruction);
				i.VideoSource = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				i.addEventListener(Event.COMPLETE, NextVideo);
				this.addChild(i);
				i.Start();
			}
			else if (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.NORMAL)
			{
				video_mc.x = -154.75;
				video_mc.y = 366.2;
				video_mc.source = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				//if (_CurrentVideo == 2)
				//{
				//video_mc.addEventListener(Event.COMPLETE, SetupGame);
				//}
				//else
				//{
				//video_mc.addEventListener(Event.COMPLETE, NextVideo);
				//}
				video_mc.addEventListener(Event.COMPLETE, NextVideo);
				video_mc.playVideo();
			}
			else if (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.STRANGER)
			{
				video_mc.x = 217.45;
				video_mc.y = 135.25;
				video_mc.source = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				//if (_CurrentVideo < 2)
				//{
				//video_mc.addEventListener(Event.COMPLETE, NextVideo);
				//}
				//else
				//{
				//video_mc.addEventListener(Event.COMPLETE, SetupGame);
				//}
				video_mc.addEventListener(Event.COMPLETE, SetupGame);
				video_mc.playVideo();
				trace("playing stranger");
			}
			else
			{
				video_mc.source = SafetyVideo(_VideoArray[_CurrentVideo]).Path;
				video_mc.addEventListener(Event.COMPLETE, NextVideo);
				video_mc.x = -154.75;
				video_mc.y = 366.2;
				video_mc.playVideo();
			}

			_CurrentVideo +=  1;
		}

		private function SetupGame(event:Event):void
		{
			trace("setting up game");
			if (event == null)
			{
				//Do not remove event listener
			}
			else
			{
				trace("remove setup game event listener");
				MovieClip(event.target).removeEventListener(Event.COMPLETE, SetupGame);
			}

			_Wait = false;
			_TrialError = false;

			ok_btn.addEventListener(MouseEvent.CLICK, OKClick);

			t.addEventListener(TimerEvent.TIMER, Tick);
			t.delay = 3500;
			t.start();

			this.gotoAndPlay("show_btn");
		}

		private function Tick(event:TimerEvent):void
		{
			t.removeEventListener(TimerEvent.TIMER, Tick);
			trace("wait is true");
			_Wait = true;
			t.reset();
			t.addEventListener(TimerEvent.TIMER, NoClick);
			t.delay = 8000;
			t.start();
		}

		private function NoClick(event:TimerEvent):void
		{
			var s:SafetyVideo = ObjectPool.getObject(SafetyVideo);
			video_mc.source = s.ActNoClick();
			ObjectPool.disposeObject(s);
			video_mc.x = -112;
			video_mc.y = 376;
			video_mc.playVideo();
		}

		private function OKClick(event:MouseEvent):void
		{
			//t.reset();
			//t.delay = 8000;
			//t.start();

			t.stop();
			t.removeEventListener(TimerEvent.TIMER, NoClick);
			ok_btn.removeEventListener(MouseEvent.CLICK, OKClick);

			if (_Wait == true)
			{
				Main(this.parent).student.AddClick("Correct. Trial: " + _CurrentTrial);
				Main(this.parent).student.CurrentLesson.addCorrect();

				//Update counter;
				Counter(counter_mc).UpdatePosition(Main(this.parent).student.CurrentLesson.Points, 
				   Main(this.parent).student.CurrentLesson.MasteryPoints);


				if (Main(this.parent).student.CurrentLesson.Points >= Main(this.parent).student.CurrentLesson.MasteryPoints)
				{
					_Complete = true;
				}

				if (Main(this.parent).student.CurrentLesson.Points < Main(this.parent).student.CurrentLesson.MasteryPoints &&
				   _CurrentVideo >= (_VideoArray.length - 1))
				{
					_CurrentVideo = 3;
				}

				_CurrentTrial++;
				_ConsecutiveErrors = 0;
				this.gotoAndPlay("hide_btn");
				NextVideo();
			}
			else
			{
				_ConsecutiveErrors++;
				Main(this.parent).student.AddClick("Error. Trial: " + _CurrentTrial);
				Main(this.parent).student.CurrentLesson.addError();

				//If a student has multiple consective errors, program prompts teacher assistance;
				if (_ConsecutiveErrors >= 3)
				{
					trace("start teacher prompt: " + _ConsecutiveErrors);
					//Show get teacher message
					var getTeach:GetTeacher = new GetTeacher();
					getTeach.addEventListener(Event.COMPLETE, TeacherPromptComplete);
					stage.addChild(getTeach);
					getTeach.Reset();

					//Record prompt
					Main(this.parent).student.AddClick("Act Out Teacher Prompt");
				}
				else
				{
					//Play the errror video
					var s:SafetyVideo = ObjectPool.getObject(SafetyVideo);
					var i:Instruction = ObjectPool.getObject(Instruction);
					i.VideoSource = s.ActError();
					i.addEventListener(Event.COMPLETE, ErrorComplete);
					this.addChild(i);
					i.Start();
					ObjectPool.disposeObject(s);
				}

				if (Main(this.parent).student.CurrentLesson.Points < Main(this.parent).student.CurrentLesson.MasteryPoints &&
				   _CurrentVideo >= (_VideoArray.length - 1))
				{
					_CurrentVideo = 3;
				}

				_CurrentTrial++;
				this.gotoAndPlay("hide_btn");

			}







			//if(_Wait == true)
			//{
			//t.removeEventListener(TimerEvent.TIMER, NoClick);
			//ok_btn.removeEventListener(MouseEvent.CLICK, OKClick);
			//
			//if(_TrialError == false)
			//{
			////trial is correct
			//Main(this.parent).student.AddClick("Correct. Trial: " + _CurrentTrial);
			//Main(this.parent).student.CurrentLesson.addCorrect();
			//
			////Update counter
			//Counter(counter_mc).UpdatePosition(Main(this.parent).student.CurrentLesson.Points, 
			//   Main(this.parent).student.CurrentLesson.MasteryPoints);
			//}
			//else
			//{
			////Trial correct after error
			//Main(this.parent).student.AddClick("Correct after not waiting (prompt). Trial: " + _CurrentTrial);
			//Main(this.parent).student.CurrentLesson.AddPrompted();
			//}
			//
			//if(Main(this.parent).student.CurrentLesson.Points < Main(this.parent).student.CurrentLesson.MasteryPoints &&
			//   _CurrentVideo >= (_VideoArray.length - 1))
			//{
			//_CurrentVideo = 3
			//}
			//
			//if(Main(this.parent).student.CurrentLesson.Points >= Main(this.parent).student.CurrentLesson.MasteryPoints)
			//{
			//_Complete = true;
			//}
			//
			//_CurrentTrial++;
			//this.gotoAndPlay("hide_btn");
			//NextVideo();
			//
			//}
			//else
			//{
			//t.stop();
			//
			////Trial is an error, try again
			//_TrialError = true;
			//
			////Play error video
			//var s:SafetyVideo = ObjectPool.getObject(SafetyVideo);
			//var i:Instruction = ObjectPool.getObject(Instruction);
			//i.VideoSource = s.ActErrorLong();
			//i.addEventListener(Event.COMPLETE, ErrorComplete);
			//this.addChild(i);
			//i.Start();
			//
			///*video_mc.source = s.ActError();
			//ObjectPool.disposeObject(s);
			//video_mc.x = -112;
			//video_mc.y = 376;
			//video_mc.playVideo();*/
			//
			//Main(this.parent).student.AddClick("Error. Trial: " + _CurrentTrial);
			//
			//Main(this.parent).student.CurrentLesson.addError();
			//
			//}
		}

		private function TeacherPromptComplete(event:Event):void
		{
			trace("teacher prompt ended");
			Main(this.parent).student.AddClick("Teacher prompt ended");

			//Remove any complete events;
			event.target.removeEventListener(Event.COMPLETE, TeacherPromptComplete);

			//Remove this object from view and continue program
			stage.removeChild(MovieClip(event.target));

			NextVideo();
		}

		private function ErrorComplete(event:Event):void
		{
			MovieClip(event.target).removeEventListener(Event.COMPLETE, ErrorComplete);
			//t.delay = 3000;
			//t.start();

			NextVideo();
		}

		private function EndGame():void
		{
			Main(this.parent).student.AddClick("End Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name +
			   " Percentage: " + Main(this.parent).student.CurrentLesson.Percentage() +
			   " Correct: " + Main(this.parent).student.CurrentLesson.NumCorrect +
			   " Total: " + Main(this.parent).student.CurrentLesson.NumTotal);

			this.addEventListener(Event.ENTER_FRAME, end);
			this.gotoAndPlay("exit");


		}

		private function end(event:Event):void
		{
			if (this.currentFrameLabel == "end")
			{
				this.removeEventListener(Event.ENTER_FRAME, end);
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}
	}

}