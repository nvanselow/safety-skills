package com.StudyTwo.Views
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.SafetyVideo;
	import uk.co.bigroom.utils.ObjectPool;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class Soccer extends MovieClip
	{

		private var _CurrentVideo:int;
		private var _VideoArray:Array;
		private var _Complete:Boolean;

		private var _LastX:int;
		private var _LastY:int;
		private var _LastBall:MovieClip;

		public function Soccer()
		{
			// constructor code
		}

		public function Start():void
		{
			ball_a.visible = true;
			ball_b.visible = true;
			ball_c.visible = true;
			ball_d.visible = true;
			ball_e.visible = true;
			
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
			
			
			ball_a.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
			ball_b.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
			ball_c.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
			ball_d.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
			ball_e.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
		}

		private function Drag(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, Drop);
			_LastX = MovieClip(event.target).x;
			_LastY = MovieClip(event.target).y;
			_LastBall = MovieClip(event.target);

			var s:Rectangle = ObjectPool.getObject(Rectangle);
			s.x = 0;
			s.y = 0;
			s.height = 650;
			s.width = 900;
			MovieClip(event.target).startDrag(false, s);
			ObjectPool.disposeObject(s);
		}

		private function Drop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, Drop);
			_LastBall.stopDrag();


			if (MovieClip(net).hitTestObject(_LastBall))
			{
				trace("hit net");
				_LastBall.visible = false;
				goal_mc.gotoAndPlay(2);

				Main(this.parent).student.CurrentLesson.addCorrect();
				Main(this.parent).student.AddClick("Correct! Ball in net.");

				if (Main(this.parent).student.CurrentLesson.Points >= Main(this.parent).student.CurrentLesson.MasteryPoints)
				{
					_Complete = true;

					ball_a.removeEventListener(MouseEvent.MOUSE_DOWN, Drag);
					ball_b.removeEventListener(MouseEvent.MOUSE_DOWN, Drag);
					ball_c.removeEventListener(MouseEvent.MOUSE_DOWN, Drag);
					ball_d.removeEventListener(MouseEvent.MOUSE_DOWN, Drag);
					ball_e.removeEventListener(MouseEvent.MOUSE_DOWN, Drag);
				}

				NextVideo();
			}
			else
			{
				Main(this.parent).student.CurrentLesson.addError();
				Main(this.parent).student.AddClick("Error. Missed net.");
			}

			_LastBall.x = _LastX;
			_LastBall.y = _LastY;

		}

	}

}