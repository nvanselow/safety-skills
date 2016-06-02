package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.Trial;
	import com.StudyTwo.TrialVideo;
	import com.StudyTwo.Counter;
	import com.StudyTwo.SafetyVideo;
	import com.StudyTwo.Instruction;
	import uk.co.bigroom.utils.ObjectPool;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Timer;
	import flash.events.TimerEvent;

	public class NextGame extends MovieClip
	{

		private var _CurrentVideo:int = 0;
		private var _CurrentTrial:int = 0;
		private var _TrialArray:Array;
		private var _VideoArray:Array;
		private var _Complete:Boolean = false;
		private var _SelectedVideo:String;
		private var _PromptLevel:int;

		private var t:Timer = new Timer(505);
		private var cTimer:Timer = new Timer(20000, 1);
		
		private var _cTimerActive:Boolean = false;
		
		public function NextGame()
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
			
			counter_mc.Reset();
			
			sample_mc.HideVideo = false;
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
			if (this.currentFrameLabel == "sample_only")
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
				trace("end video");
			}
			trace("playing video");
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
			//Set video location
			//video_mc.x = -92.8;
			//video_mc.y = 102.7;
			//video_mc.width = 195.9;
			//video_mc.height = 286.8;
			
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
			
			a_mc.Checked = false;
			b_mc.Checked = false;
			c_mc.Checked = false;
			
			_PromptLevel = 0;

			if (_CurrentTrial >= _TrialArray.length)
			{
				trace("restart trials");
				_CurrentTrial = 0;
			}
			trace("Sample Source: " +  Trial(_TrialArray[_CurrentTrial]).SampleSource);
			sample_mc.VideoSource = Trial(_TrialArray[_CurrentTrial]).SampleSource;
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

			this.gotoAndPlay("show_sample");
			sample_mc.addEventListener(MouseEvent.CLICK, FirstSampleClick);
			trace("add sample event listener");



		}

		private function FirstSampleClick(event:MouseEvent):void
		{
			sample_mc.removeEventListener(MouseEvent.CLICK, FirstSampleClick);
			sample_mc.addEventListener(Event.COMPLETE, SampleDone);
			sample_mc.Play();
		}

		private function SampleDone(event:Event):void
		{
			sample_mc.removeEventListener(Event.COMPLETE, SampleDone);
			this.gotoAndPlay("show_comps");
			ok_btn.addEventListener(MouseEvent.CLICK, OKClick);
			a_mc.addEventListener(MouseEvent.CLICK, CompClick);
			b_mc.addEventListener(MouseEvent.CLICK, CompClick);
			c_mc.addEventListener(MouseEvent.CLICK, CompClick);
			sample_mc.addEventListener(MouseEvent.CLICK, SampleClick);
		}

		private function CompClick(event:MouseEvent):void
		{
			StopAll();
			a_mc.Checked = false;
			b_mc.Checked = false;
			c_mc.Checked = false;
			if (event.target is TrialVideo)
			{
				_SelectedVideo = TrialVideo(event.target).Name;
				TrialVideo(event.target).Checked = true;
				TrialVideo(event.target).Play();
			}
			else
			{
				_SelectedVideo = TrialVideo(MovieClip(event.target).parent).Name;
				TrialVideo(MovieClip(event.target).parent).Checked = true;
				TrialVideo(MovieClip(event.target).parent).Play();
			}
			
			if(_cTimerActive == false)
			{
				cTimer.addEventListener(TimerEvent.TIMER, CompTimer);
				_cTimerActive = true;
				cTimer.start();
				
			}

		}
		
		private function CompTimer(event:TimerEvent):void
		{
			//Remove the event listener
			cTimer.removeEventListener(TimerEvent.TIMER, CompTimer);
						
			//Show the OK button prompt if OK button not clicked 20 s after first comparison clicked.
			var promptVideo:VideoClip = ObjectPool.getObject(VideoClip);
			promptVideo.source = SafetyVideo.NextClickOK();
			promptVideo.addEventListener(Event.COMPLETE, CompPromptComplete);
			this.addChild(promptVideo);
			promptVideo.x = 175;
			promptVideo.y = 475;
			promptVideo.width = 300;
			promptVideo.height = 190;
			promptVideo.playVideo();
			
			
		}
		
		private function CompPromptComplete(event:Event):void
		{
			_cTimerActive = false;
			
			MovieClip(event.target).removeEventListener(Event.COMPLETE, CompPromptComplete);
			this.removeChild(MovieClip(event.target));
			ObjectPool.disposeObject(event.target);
		}

		private function StopAll():void
		{
			a_mc.Stop();
			b_mc.Stop();
			c_mc.Stop();
			sample_mc.Stop();
		}

		private function SampleClick(event:MouseEvent):void
		{
			StopAll();
			sample_mc.Play();
		}

		private function OKClick(event:MouseEvent):void
		{
			//Stop the ok prompt timer
			if(_cTimerActive == true)
			{
				cTimer.removeEventListener(TimerEvent.TIMER, CompTimer);
				_cTimerActive = false;
			}
			cTimer.reset();
			
			
			var tr:Trial = _TrialArray[_CurrentTrial];

			//Check if correct answer
			if (_SelectedVideo == tr.CorrectComparison)
			{
				//Stop videos before continuing
				StopAll();
				
				//Remove all event listeners
				ok_btn.removeEventListener(MouseEvent.CLICK, OKClick);
				a_mc.removeEventListener(MouseEvent.CLICK, CompClick);
				b_mc.removeEventListener(MouseEvent.CLICK, CompClick);
				c_mc.removeEventListener(MouseEvent.CLICK, CompClick);
				sample_mc.removeEventListener(MouseEvent.CLICK, SampleClick);


				if (_PromptLevel < 2)
				{
					//Score correct
					Main(this.parent).student.CurrentLesson.addCorrect();
					Main(this.parent).student.AddClick("Correct! Trial: " + _CurrentTrial + " Type: " + tr.Type);
					Counter(counter_mc).UpdatePosition(Main(this.parent).student.CurrentLesson.Points, 
					   Main(this.parent).student.CurrentLesson.MasteryPoints);

					if (Main(this.parent).student.CurrentLesson.Points >= Main(this.parent).student.CurrentLesson.MasteryPoints)
					{
						_Complete = true;
					}
				}
				else
				{
					//Score prompted
					Main(this.parent).student.CurrentLesson.AddPrompted();
					Main(this.parent).student.AddClick("Correct after prompt. Trial: " + _CurrentTrial + " Type: " + tr.Type);
				}

				_CurrentTrial++;
				this.gotoAndPlay("hide_comps");
				t.addEventListener(TimerEvent.TIMER, Tick);
				t.start();
			}
			else
			{
				//Score error
				Main(this.parent).student.CurrentLesson.addError();
				Main(this.parent).student.AddClick("Error. Trial: " + _CurrentTrial + " Type: " + tr.Type);
				_PromptLevel++;
				
				var s:SafetyVideo = ObjectPool.getObject(SafetyVideo);
				
				if (_PromptLevel == 1)
				{
					//State what is happening in the sample
					switch (tr.Type)
					{
						case Trial.NO :
							video_mc.source = s.NextAskA();
							break;

						case Trial.GO :
							video_mc.source = s.NextNoA();
							break;

						case Trial.TELL :
							video_mc.source = s.NextGoA();
							break;
					}
					video_mc.playVideo();
					trace("prompt level 1");
				}
				else if (_PromptLevel == 2)
				{
					//State what should happen next
					switch (tr.Type)
					{
						case Trial.NO :
							video_mc.source = s.NextAskB();
							break;

						case Trial.GO :
							video_mc.source = s.NextNoB();
							break;

						case Trial.TELL :
							video_mc.source = s.NextGoB();
							break;
					}
					video_mc.playVideo();
					trace("prompt level 2");
				}
				else
				{
					//Show an arrow pointing to the correct video
					if (a_mc.Name == tr.CorrectComparison)
					{
						a_mc.ShowPrompt();
					}
					else if (b_mc.Name == tr.CorrectComparison)
					{
						b_mc.ShowPrompt();
					}
					else if (c_mc.Name == tr.CorrectComparison)
					{
						c_mc.ShowPrompt();
					}
					trace("prompt level 3+");
				}
			}
		}
		
		private function Tick(event:TimerEvent)
		{
			t.stop();
			t.removeEventListener(TimerEvent.TIMER, Tick);
			NextVideo();
		}
		
		private function EndGame():void
		{
			this.addEventListener(Event.ENTER_FRAME, end);
			this.gotoAndPlay("exit");

			Main(this.parent).student.AddClick("End Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name +
			   " Percentage: " + Main(this.parent).student.CurrentLesson.Percentage() +
			   " Correct: " + Main(this.parent).student.CurrentLesson.NumCorrect +
			   " Prompted: " + Main(this.parent).student.CurrentLesson.NumPrompted +
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