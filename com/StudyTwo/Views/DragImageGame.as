package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.StudyTwo.SafetyImage;
	import com.StudyTwo.SafetyVideo;
	import com.StudyTwo.Views.Main;
	import com.StudyTwo.Counter;
	import com.StudyTwo.Highlight;
	import uk.co.bigroom.utils.ObjectPool;
	import flash.utils.getQualifiedClassName;

	public class DragImageGame extends MovieClip
	{

		private var _ImageArray:Array = [];
		private var _ImageCount:int = 0;
		private var _VideoArray:Array = [];
		private var _CurrentVideo:int = 0;
		private var _Positions:XML = 
		<Positions>
		<Position>
		<xVal>48</xVal>
		<yVal>86</yVal>
		</Position>
		<Position>
		<xVal>253</xVal>
		<yVal>61</yVal>
		</Position>
		<Position>
		<xVal>428</xVal>
		<yVal>61</yVal>
		</Position>
		<Position>
		<xVal>558</xVal>
		<yVal>76</yVal>
		</Position>
		<Position>
		<xVal>719</xVal>
		<yVal>93</yVal>
		</Position>
		<Position>
		<xVal>5</xVal>
		<yVal>182</yVal>
		</Position>
		<Position>
		<xVal>149</xVal>
		<yVal>137</yVal>
		</Position>
		<Position>
		<xVal>287</xVal>
		<yVal>211</yVal>
		</Position>
		<Position>
		<xVal>452</xVal>
		<yVal>188</yVal>
		</Position>
		<Position>
		<xVal>360</xVal>
		<yVal>93</yVal>
		</Position>
		<Position>
		<xVal>559</xVal>
		<yVal>164</yVal>
		</Position>
		<Position>
		<xVal>79</xVal>
		<yVal>171</yVal>
		</Position>
		</Positions>;
		private var _Complete:Boolean = false;

		public function DragImageGame()
		{
			// constructor code

		}

		public function Start():void
		{
			Main(this.parent).student.AddClick("Begin Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name + " Type: " + 
			   Main(this.parent).student.CurrentLesson.Type);
			_ImageArray = [];
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

				_VideoArray = Main(this.parent).student.CurrentLesson.Videos;
				_ImageArray = Main(this.parent).student.CurrentLesson.Images;
				
				for (var i:uint = 0; i < _ImageArray.length; i++)
				{
					//Generate variable for safety image
					SafetyImage(_ImageArray[i]).width = 450;
					SafetyImage(_ImageArray[i]).height = 400;
				}

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

			trace("setting up game");

			//Start a new round of images
			_ImageCount = 0;

			var posArray:Array = [];
			var posLength:int = _Positions.Position.length();
			var posCount:int = 0;
			for (var b:uint = 0; b < _ImageArray.length; b++)
			{
				posArray.push(_Positions.Position[posCount]);
				posCount++;
				if (posCount >= posLength)
				{
					posCount = 0;
				}
			}

			trace("set image locations and sizes");
			for (var i:uint = 0; i < _ImageArray.length; i++)
			{
				//Generate variable for safety image
				var s:SafetyImage = SafetyImage(_ImageArray[i]);
				//Get a random number for a position
				var r:int = Math.floor(Math.random() * (1 + posArray.length - 1));
				//trace("x val: " + posArray[r].xVal + "  Y val: " + posArray[r].yVal);
				this.addChild(s);
				s.OrigX = posArray[r].xVal;
				s.OrigY = posArray[r].yVal;

				posArray.splice(r, 1);

				s.SetHitTargets(yes_mc, no_mc);
				//trace("hit game: " + yes_mc);
				trace("img " + i + " width: "+  s.width + " height: " + s.height);
				s.addEventListener(SafetyImage.HIT, imagehit);
				s.IsVisible = true;
				s.Draggable = true;
				_ImageCount++;

			}

			if (_ImageArray.length <= 0)
			{
				_Complete = true;
				NextVideo();
			}

		}

		private function imagehit(event:Event):void
		{
			var s:SafetyImage = SafetyImage(event.target);
			if (s.IsCorrect == true)
			{
				Main(this.parent).student.CurrentLesson.addCorrect();
				Counter(counter_mc).UpdatePosition(Main(this.parent).student.CurrentLesson.Points, 
				   Main(this.parent).student.CurrentLesson.MasteryPoints);
				Main(this.parent).student.AddClick("Correct! Type: " + s.Type + " Safe: " + s.IsSafe + " Path: " + s.Path);
			}
			else
			{
				Main(this.parent).student.CurrentLesson.addError();
				Main(this.parent).student.AddClick("Error. Type: " + s.Type + " Safe: " + s.IsSafe + " Path: " + s.Path);

				//Error correction;
				var h:Highlight = ObjectPool.getObject(Highlight);
				h.imageSource = s.HighlightPath;
				//Add highlight video source here...
				var v:SafetyVideo = ObjectPool.getObject(SafetyVideo);
				if (s.IsSafe == true)
				{
					h.videoSource = v.DragErrorSafe();
				}
				else
				{
					h.videoSource = v.DragErrorDanger();
				}
				ObjectPool.disposeObject(v);
				this.addChild(h);
				h.Start();
			}

			s.addEventListener(Event.COMPLETE, MakeInvisible);
			s.IsVisible = false;

			_ImageCount--;
			if (_ImageCount <= 0 && Main(this.parent).student.CurrentLesson.Points < Main(this.parent).student.CurrentLesson.MasteryPoints)
			{
				SetupGame();


			}

		}

		private function MakeInvisible(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, MakeInvisible);
			this.removeChild(SafetyImage(event.target));

			if (Main(this.parent).student.CurrentLesson.Points >= Main(this.parent).student.CurrentLesson.MasteryPoints)
			{
				_Complete = true;
				NextVideo();
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

		private function NextVideo(event:Event = null):void
		{
			if (event == null)
			{
				//don't remove listener
			}
			else
			{
				MovieClip(event.target).removeEventListener(Event.COMPLETE, SetupGame);
			}

			if (_CurrentVideo < _VideoArray.length)
			{
				trace("play a video: " + _VideoArray[_CurrentVideo].Type);
				trace("Complete: " + _Complete);
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
			Main(this.parent).student.AddClick("End Lesson. Name: " + Main(this.parent).student.CurrentLesson.Name +
			   " Percentage: " + Main(this.parent).student.CurrentLesson.Percentage() +
			   " Correct: " + Main(this.parent).student.CurrentLesson.NumCorrect +
			   " Total: " + Main(this.parent).student.CurrentLesson.NumTotal);

			for (var i:int = 0; i < this.numChildren; i++)
			{
				if (flash.utils.getQualifiedClassName(this.getChildAt(i)) == "com.StudyTwo::SafetyImage")
				{
					SafetyImage(this.getChildAt(i)).IsVisible = false;
				}
				/*if(this.getChildAt(i).name == "counter_mc" || this.getChildAt(i).name == "yes_mc" ||
				   this.getChildAt(i).name == "no_mc" || this.getChildAt(i).name == "video_mc" || 
				this.getChildAt(i).name == "bg_mc")
				{
				//Don't remove
				}
				else
				{
				trace("Child name: " + this.getChildAt(i).name);
				SafetyImage(this.getChildAt(i)).IsVisible = false;
				}*/
			}


		}

		private function exit(event:Event):void
		{
			if (this.currentFrameLabel == "end")
			{
				this.removeEventListener(Event.ENTER_FRAME, exit);

				for (var i:int = 0; i < this.numChildren; i++)
				{
					if (flash.utils.getQualifiedClassName(this.getChildAt(i)) == "com.StudyTwo::SafetyImage")
					{
						this.removeChild(this.getChildAt(i));
					}
					/*if(this.getChildAt(i).name == "counter_mc" || this.getChildAt(i).name == "yes_mc" ||
					   this.getChildAt(i).name == "no_mc" || this.getChildAt(i).name == "video_mc" || 
					this.getChildAt(i).name == "bg_mc")
					{
					//Don't remove
					}
					else
					{
					this.removeChild(this.getChildAt(i));
					}*/
				}

				dispatchEvent(new Event(Event.COMPLETE));
			}
		}


	}

}