package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.Timer;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.SafetyVideo;
	import uk.co.bigroom.utils.ObjectPool;
	import flash.events.TimerEvent;

	public class TargetGame extends MovieClip
	{

		private var _CurrentVideo:int;
		private var _VideoArray:Array;
		private var t:Timer = new Timer(8000);
		private var _Complete:Boolean;

		public function TargetGame()
		{
			// constructor code
		}

		public function Start():void
		{
			a_mc.visible = true;
			b_mc.visible = true;
			c_mc.visible = true;
			d_mc.visible = true;
			e_mc.visible = true;

			a_mc.gotoAndStop("normal");
			b_mc.gotoAndStop("normal");
			c_mc.gotoAndStop("normal");
			d_mc.gotoAndStop("normal");
			e_mc.gotoAndStop("normal");

			this.addEventListener(Event.ENTER_FRAME, init);
			this.gotoAndPlay("enter");

			_CurrentVideo = 0;
			_VideoArray = Main(this.parent).student.CurrentLesson.Videos;
			_Complete = false;
		}

		public function init(event:Event):void
		{
			if (this.currentFrameLabel == "normal")
			{
				this.removeEventListener(Event.ENTER_FRAME, init);
				NextVideo();
			}
		}

		private function NextVideo(event:Event = null):void
		{
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
				//trace("play a video: " + _VideoArray[_CurrentVideo].Type);
				//trace("Complete: " + _Complete);
				if (_Complete == false && (SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.INSTRUCTION || 
										   SafetyVideo(_VideoArray[_CurrentVideo]).Type == SafetyVideo.NORMAL))
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
			if(event == null)
			{
				//don't remove listener
			}
			else
			{
				MovieClip(event.target).removeEventListener(Event.COMPLETE, SetupGame);
			}
			
			a_mc.addEventListener(Event.COMPLETE, Hit);
			b_mc.addEventListener(Event.COMPLETE, Hit);
			c_mc.addEventListener(Event.COMPLETE, Hit);
			d_mc.addEventListener(Event.COMPLETE, Hit);
			e_mc.addEventListener(Event.COMPLETE, Hit);

			t.addEventListener(TimerEvent.TIMER, Tick);
			t.start();
		}

		private function Hit(event:Event):void
		{
			MovieClip(event.target).removeEventListener(Event.COMPLETE, Hit);
			t.reset();
			t.start();

			video_mc.stopVideo();

			Main(this.parent).student.CurrentLesson.addCorrect();
			Main(this.parent).student.AddClick("Correct! Clicked target.");

			if (Main(this.parent).student.CurrentLesson.Points >= Main(this.parent).student.CurrentLesson.MasteryPoints)
			{
				t.stop();
				t.removeEventListener(TimerEvent.TIMER, Tick);

				a_mc.removeEventListener(Event.COMPLETE, Hit);
				b_mc.removeEventListener(Event.COMPLETE, Hit);
				c_mc.removeEventListener(Event.COMPLETE, Hit);
				d_mc.removeEventListener(Event.COMPLETE, Hit);
				e_mc.removeEventListener(Event.COMPLETE, Hit);

				_Complete = true;
				NextVideo();

			}

		}

		private function Tick(event:TimerEvent):void
		{
			trace("palying target error");
			var n:SafetyVideo = new SafetyVideo();
			video_mc.source = n.TargetError();
			video_mc.playVideo();
		}


		private function EndGame():void
		{
			this.addEventListener(Event.ENTER_FRAME, end);
			this.gotoAndPlay("exit");

			Main(this.parent).student.AddClick("End Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name +
			   " Percentage: " + Main(this.parent).student.CurrentLesson.Percentage() +
			   " Correct: " + Main(this.parent).student.CurrentLesson.NumCorrect +
			   " Total: " + Main(this.parent).student.CurrentLesson.NumTotal);
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