package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.SafetyVideo;
	import uk.co.bigroom.utils.ObjectPool;
	import com.StudyTwo.Counter;
	import com.StudyTwo.Trial;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import com.StudyTwo.TrialVideo;

	public class Order extends MovieClip
	{

		private var _CurrentVideo:int;
		private var _VideoArray:Array;
		private var _CurrentTrial:int;
		private var _TrialArray:Array;
		private var _Complete:Boolean;

		private var _PromptA:int;
		private var _PromptB:int;
		private var _PromptC:int;

		private var _LastX:int;
		private var _LastY:int;
		private var _LastVideo:MovieClip;

		//Store original location of videos
		private var _AX:int;
		private var _AY:int;
		private var _BX:int;
		private var _BY:int;
		private var _CX:int;
		private var _CY:int;

		//Store videos
		private var a_mc:TrialVideo;
		private var b_mc:TrialVideo;
		private var c_mc:TrialVideo;

		private var _AMatch:Boolean;
		private var _BMatch:Boolean;
		private var _CMatch:Boolean;

		private var t:Timer = new Timer(1500);

		public function Order()
		{
			// constructor code
		}

		public function Start():void
		{
			_CurrentVideo = 0;
			_CurrentTrial = 0;
			_TrialArray = [];
			_VideoArray = [];
			_Complete = false;

			a_mc = vid.a_mc;
			b_mc = vid.b_mc;
			c_mc = vid.c_mc;

			counter_mc.Reset();
			
			a_mc.HideVideo = false;
			b_mc.HideVideo = false;
			c_mc.HideVideo = false;

			this.addEventListener(Event.ENTER_FRAME, init);
			this.gotoAndPlay("enter");

			Main(this.parent).student.AddClick("Begin Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name + " Type: " + 
			   Main(this.parent).student.CurrentLesson.Type);
		}

		private function init(event:Event):void
		{
			if (this.currentFrameLabel == "normal")
			{
				this.removeEventListener(Event.ENTER_FRAME, init);

				_TrialArray = Main(this.parent).student.CurrentLesson.Trials;
				_VideoArray = Main(this.parent).student.CurrentLesson.Videos;

				if (_CurrentVideo < _VideoArray.length)
				{
					NextVideo();
				}
				else
				{
					SetupGame();
				}

				_AX = a_mc.x;
				_AY = a_mc.y;
				_BX = b_mc.x;
				_BY = b_mc.y;
				_CX = c_mc.x;
				_CY = c_mc.y;

				//Add click event listeners
				a_mc.addEventListener(MouseEvent.MOUSE_DOWN, Play);
				b_mc.addEventListener(MouseEvent.MOUSE_DOWN, Play);
				c_mc.addEventListener(MouseEvent.MOUSE_DOWN, Play);
			}
		}

		private function Play(event:MouseEvent):void
		{
			StopAll();
			if (event.target is TrialVideo)
			{
				TrialVideo(event.target).Play();
			}
			else
			{
				TrialVideo(MovieClip(event.target).parent).Play();
			}

		}

		private function StopAll():void
		{
			a_mc.Stop();
			b_mc.Stop();
			c_mc.Stop();
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
			
			_PromptA = 0;
			_PromptB = 0;
			_PromptC = 0;

			_AMatch = false;
			_BMatch = false;
			_CMatch = false;

			if (Main(this.parent).student.CurrentLesson.Points < Main(this.parent).student.CurrentLesson.MasteryPoints)
			{

				/*//Reset visibilty
				a_mc.alpha = 1;
				b_mc.alpha = 1;
				c_mc.alpha = 1;*/

				if (_CurrentTrial >= _TrialArray.length)
				{
					_CurrentTrial = 0;
				}

				//Load videos
				var rand:int = Math.floor(Math.random() * (1+5+0));
				switch (rand)
				{
					case 0 :
						a_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonA;
						a_mc.Name = Trial.COMP_A;
						b_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonB;
						b_mc.Name = Trial.COMP_B;
						c_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonC;
						c_mc.Name = Trial.COMP_C;
						break;

					case 1 :
						a_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonA;
						a_mc.Name = Trial.COMP_A;
						c_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonB;
						c_mc.Name = Trial.COMP_B;
						b_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonC;
						b_mc.Name = Trial.COMP_C;
						break;

					case 2 :
						b_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonA;
						b_mc.Name = Trial.COMP_A;
						c_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonB;
						c_mc.Name = Trial.COMP_B;
						a_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonC;
						a_mc.Name = Trial.COMP_C;
						break;

					case 3 :
						b_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonA;
						b_mc.Name = Trial.COMP_A;
						a_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonB;
						a_mc.Name = Trial.COMP_B;
						c_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonC;
						c_mc.Name = Trial.COMP_C;
						break;

					case 4 :
						c_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonA;
						c_mc.Name = Trial.COMP_A;
						a_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonB;
						a_mc.Name = Trial.COMP_B;
						b_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonC;
						b_mc.Name = Trial.COMP_C;
						break;

					case 5 :
						c_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonA;
						c_mc.Name = Trial.COMP_A;
						b_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonB;
						b_mc.Name = Trial.COMP_B;
						a_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).ComparisonC;
						a_mc.Name = Trial.COMP_C;
						break;
				}

				this.gotoAndPlay("show_videos");
				
				//Add drag event listeners
				a_mc.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
				b_mc.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
				c_mc.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
			}
			else
			{
				_Complete = true;
				NextVideo();
			}

		}

		private function Drag(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, Drop);

			var s:Rectangle = ObjectPool.getObject(Rectangle);
			s.x = 0;
			s.y = 0;
			s.height = 650;
			s.width = 900;

			if (event.target is TrialVideo)
			{
				trace("is trial video");
				_LastX = MovieClip(event.target).x;
				_LastY = MovieClip(event.target).y;
				_LastVideo = MovieClip(event.target);
				//MovieClip(event.target).parent.addChild(MovieClip(event.target));
				MovieClip(event.target).startDrag(false, s);
			}
			else
			{
				trace("is not trial video");
				_LastX = MovieClip(event.target.parent).x;
				_LastY = MovieClip(event.target.parent).y;
				_LastVideo = MovieClip(event.target.parent);
				//MovieClip(event.target.parent.parent).parent.addChild(MovieClip(event.target.parent));
				MovieClip(event.target.parent).startDrag(false, s);
			}
			ObjectPool.disposeObject(s);
			
			switch (TrialVideo(_LastVideo).Name)
				{
					case Trial.COMP_A :
						if (_PromptA > 1)
						{
							promptA.gotoAndPlay("enter");
						}
						break;

					case Trial.COMP_B :
						if (_PromptB > 1)
						{
							promptB.gotoAndPlay("enter");
						}
						break;

					case Trial.COMP_C :
						if (_PromptC > 1)
						{
							promptC.gotoAndPlay("enter");
						}
						break;
				}
		}

		private function Drop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, Drop);
			_LastVideo.stopDrag();

			//Determine if hit one of the answer boxes;
			var hitname:String;
			if (MovieClip(Ans.A).hitTestObject(_LastVideo))
			{
				hitname = Trial.COMP_A;
			}
			else if (MovieClip(Ans.B).hitTestObject(_LastVideo))
			{
				hitname = Trial.COMP_B;
			}
			else if (MovieClip(Ans.C).hitTestObject(_LastVideo))
			{
				hitname = Trial.COMP_C;
			}
			else
			{
				hitname = "none";
			}

			if (TrialVideo(_LastVideo).Name == hitname)
			{
				_LastVideo.removeEventListener(MouseEvent.MOUSE_DOWN, Drag);
				_LastVideo.x = 630;
				switch (hitname)
				{
					case Trial.COMP_A :
						_AMatch = true;
						MovieClip(checkA.parent).addChild(checkA);
						checkA.x = 685;
						_LastVideo.y = 2;
						break;
					case Trial.COMP_B :
						_BMatch = true;
						MovieClip(checkB.parent).addChild(checkB);
						checkB.x = 685;
						_LastVideo.y = 225.6;
						break;
					case Trial.COMP_C :
						_CMatch = true;
						MovieClip(checkC.parent).addChild(checkC);
						checkC.x = 685;
						_LastVideo.y = 446;
						break;
				}
				Main(this.parent).student.AddClick("Match! Trial: " + _CurrentTrial + " Video: " + TrialVideo(_LastVideo).Name);
			}
			else if (hitname == "none")
			{
				//Missed boxes
				trace("missed");
				Main(this.parent).student.AddClick("Missed. Trial: " + _CurrentTrial + " Video: " + TrialVideo(_LastVideo).Name);
				ResetLocation();
			}
			else
			{
				//Trial is an error
				trace("error");
				ResetLocation();

				//Main(this.parent).student.CurrentLesson.addError();
				Main(this.parent).student.AddClick("Error. Trial: " + _CurrentTrial + " Video: " + TrialVideo(_LastVideo).Name);

				switch (TrialVideo(_LastVideo).Name)
				{
					case Trial.COMP_A :
						_PromptA++;
						break;

					case Trial.COMP_B :
						_PromptB++;
						break;

					case Trial.COMP_C :
						_PromptC++;
						break;
				}
			}

			trace("Matched: " + _AMatch + " " + _BMatch + " " + _CMatch);
			if (_AMatch == true && _BMatch == true && _CMatch == true)
			{
				//Stop all videos before continuing
				StopAll();
				
				//Trial is correct

				if (_PromptA < 2 && _PromptB < 2 && _PromptC < 2)
				{
					trace("correct");
					//Score correct
					Main(this.parent).student.CurrentLesson.addCorrect();
					Main(this.parent).student.AddClick("Correct! Trial: " + _CurrentTrial + " Video: " + TrialVideo(_LastVideo).Name);

					//Update counter
					Counter(counter_mc).UpdatePosition(Main(this.parent).student.CurrentLesson.Points, 
					   Main(this.parent).student.CurrentLesson.MasteryPoints);

					if (Main(this.parent).student.CurrentLesson.Points >= Main(this.parent).student.CurrentLesson.MasteryPoints)
					{
						_Complete = true;
					}
				}
				else
				{
					trace("correct after prompt");
					//Score prompted
					Main(this.parent).student.CurrentLesson.AddPrompted();
					Main(this.parent).student.AddClick("Correct after prompt. Trial: " + _CurrentTrial + " Video: " + TrialVideo(_LastVideo).Name);
				}

				_CurrentTrial++;
				this.gotoAndPlay("hide_videos");
				
				checkA.x = 938;
				checkB.x = 938;
				checkC.x = 938;
				
				//Update the counter
				t.addEventListener(TimerEvent.TIMER, Tick);
				t.start();

			}
		}

		private function ResetLocation():void
		{
			_LastVideo.x = _LastX;
			_LastVideo.y = _LastY;
		}

		private function Tick(event:TimerEvent):void
		{
			t.stop();
			t.removeEventListener(TimerEvent.TIMER, Tick);

			//Reset video position
			a_mc.x = _AX;
			a_mc.y = _AY;
			b_mc.x = _BX;
			b_mc.y = _BY;
			c_mc.x = _CX;
			c_mc.y = _CY;

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

		private function EndGame():void
		{

			//remove click event listeners
			a_mc.removeEventListener(MouseEvent.MOUSE_DOWN, Play);
			b_mc.removeEventListener(MouseEvent.MOUSE_DOWN, Play);
			c_mc.removeEventListener(MouseEvent.MOUSE_DOWN, Play);

			Main(this.parent).student.AddClick("End Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name +
			   " Percentage: " + Main(this.parent).student.CurrentLesson.Percentage() +
			   " Correct: " + Main(this.parent).student.CurrentLesson.NumCorrect +
			   " Prompted: " + Main(this.parent).student.CurrentLesson.NumPrompted +
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