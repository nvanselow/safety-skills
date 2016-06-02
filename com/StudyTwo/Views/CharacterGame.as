package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.SafetyImage;
	import com.StudyTwo.SafetyVideo;
	import com.StudyTwo.Counter;
	import com.StudyTwo.Character;
	import com.StudyTwo.ChooseColor;
	//import com.StudyTwo.Highlight;
	import uk.co.bigroom.utils.ObjectPool;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class CharacterGame extends MovieClip
	{
		private var _ImageArray:Array = [];
		private var _VideoArray:Array = [];
		private var _CurrentImage:int = 0;
		private var _CurrentVideo:int = 0;
		private var _Complete:Boolean = false;

		private var _ThinkTimer:Timer = new Timer(5000);

		public function CharacterGame()
		{
			// constructor code


		}

		public function Start():void
		{
			Main(this.parent).student.AddClick("Begin Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name + " Type: " + 
			   Main(this.parent).student.CurrentLesson.Type);
			_ImageArray = [];
			_VideoArray = [];
			_CurrentImage = 0;
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

				_Complete = false;

				//Show videos
				_VideoArray = Main(this.parent).student.CurrentLesson.Videos;
				_ImageArray = Main(this.parent).student.CurrentLesson.Images;
				_CurrentImage = 0;
				_CurrentVideo = 0;

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
			Character(stick_mc).Wave();
		}

		private function MakeInvisible(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, MakeInvisible);
			this.removeChild(SafetyImage(event.target));

		}

		private function SetupGame(event:Event = null):void
		{
			if (event == null)
			{
				//don't remove listener
			}
			else
			{
				MovieClip(event.target).removeEventListener(Event.COMPLETE, SetupGame);
			}

			if (_CurrentImage > 0)
			{
				SafetyImage(this.getChildByName("img" + String(_CurrentImage - 1))).addEventListener(Event.COMPLETE, MakeInvisible);
				SafetyImage(this.getChildByName("img" + (_CurrentImage - 1))).IsVisible = false;
			}

			if (_CurrentImage >= _ImageArray.length)
			{
				_CurrentImage = 0;
			}


			if (Main(this.parent).student.CurrentLesson.Points >= Main(this.parent).student.CurrentLesson.MasteryPoints || _ImageArray.length <= 0)
			{
				_Complete = true;
				NextVideo();
			}
			else
			{
				var img:SafetyImage = _ImageArray[_CurrentImage];
				this.addChild(img);
				img.x = 108;
				img.y = 198;
				img.width = 400;
				img.height = 500;
				img.Draggable = false;
				img.name = "img" + _CurrentImage;

				img.IsVisible = true;


				//Add event listeners for buttons
				yes_btn.addEventListener(MouseEvent.CLICK, YesClick);
				no_btn.addEventListener(MouseEvent.CLICK, NoClick);

				_ThinkTimer.delay = 5000;
				_ThinkTimer.addEventListener(TimerEvent.TIMER, ThinkTimerTick);
				_ThinkTimer.start();
			}

			_CurrentImage++;



		}

		private function ThinkTimerTick(event:TimerEvent):void
		{
			Character(stick_mc).Think();
		}

		private function YesClick(event:MouseEvent):void
		{
			yes_btn.removeEventListener(MouseEvent.CLICK, YesClick);
			no_btn.removeEventListener(MouseEvent.CLICK, NoClick);

			_ThinkTimer.removeEventListener(TimerEvent.TIMER, ThinkTimerTick);
			_ThinkTimer.stop();

			Character(stick_mc).WalkTo();

			var img:SafetyImage = SafetyImage(this.getChildByName("img" + (_CurrentImage-1)));
			if (img.IsSafe == true)
			{
				Main(this.parent).student.CurrentLesson.addCorrect();
				img.IsCorrect = true;

				Main(this.parent).student.AddClick("Correct! Type: " + img.Type + " Safe: " + img.IsSafe + " Path: " + img.Path);

				Counter(counter_mc).UpdatePosition(Main(this.parent).student.CurrentLesson.Points, 
				   Main(this.parent).student.CurrentLesson.MasteryPoints);

				NextVideo();
			}
			else
			{
				Main(this.parent).student.CurrentLesson.addError();
				img.IsCorrect = false;
				Main(this.parent).student.AddClick("Error. Type: " + img.Type + " Safe: " + img.IsSafe + " Path: " + img.Path);

				ErrorCorrection(img.HighlightPath,img.IsSafe);
			}



		}

		private function NoClick(event:MouseEvent):void
		{
			yes_btn.removeEventListener(MouseEvent.CLICK, YesClick);
			no_btn.removeEventListener(MouseEvent.CLICK, NoClick);

			_ThinkTimer.removeEventListener(TimerEvent.TIMER, ThinkTimerTick);
			_ThinkTimer.stop();

			Character(stick_mc).WalkAway();

			var img:SafetyImage = SafetyImage(this.getChildByName("img" + (_CurrentImage-1)));
			if (img.IsSafe == false)
			{
				Main(this.parent).student.CurrentLesson.addCorrect();
				img.IsCorrect = true;
				Main(this.parent).student.AddClick("Correct! Type: " + img.Type + " Safe: " + img.IsSafe + " Path: " + img.Path);

				Counter(counter_mc).UpdatePosition(Main(this.parent).student.CurrentLesson.Points, 
				   Main(this.parent).student.CurrentLesson.MasteryPoints);

				NextVideo();
			}
			else
			{
				Main(this.parent).student.CurrentLesson.addError();
				img.IsCorrect = false;
				Main(this.parent).student.AddClick("Error. Type: " + img.Type + " Safe: " + img.IsSafe + " Path: " + img.Path);
				trace("creating error correction");
				ErrorCorrection(img.HighlightPath,img.IsSafe);
			}


		}

		private function ErrorCorrection(i:String, safe:Boolean):void
		{
			trace("Create highlight");
			var h:Highlight = ObjectPool.getObject(Highlight);
			h.imageSource = i;
			var v:SafetyVideo = ObjectPool.getObject(SafetyVideo);
			if (safe == true)
			{
				h.videoSource = v.CharacterErrorSafe();
			}
			else
			{
				h.videoSource = v.CharacterErrorDanger();
			}
			ObjectPool.disposeObject(v);
			this.addChild(h);
			h.addEventListener(Event.COMPLETE, ErrorComplete);
			h.Start();
		}

		private function ErrorComplete(event:Event):void
		{
			Highlight(event.target).removeEventListener(Event.COMPLETE, ErrorComplete);
			NextVideo();
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