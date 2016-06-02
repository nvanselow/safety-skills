package com.StudyTwo.Views
{
	import com.StudyTwo.Views.Main;
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;

	public class ChooseMouse extends MovieClip
	{

		private var _newColor:Color;

		public function ChooseMouse()
		{
			// constructor code

		}

		public function Start():void
		{
			_newColor = new Color();
			
			var yellow:Color = new Color();
			yellow.setTint(0xF2B705, 1);
			yellow_mc.inside.transform.colorTransform = yellow;

			var orange:Color= new Color();
			orange.setTint(0xF25C05, 1);
			orange_mc.inside.transform.colorTransform = orange;

			var purple:Color= new Color();
			purple.setTint(0x7B52AB, 1);
			purple_mc.inside.transform.colorTransform = purple;

			var black:Color= new Color();
			black.setTint(0x000000, 1);
			black_mc.inside.transform.colorTransform = black;

			var pink:Color= new Color();
			pink.setTint(0xF0788C, 1);
			pink_mc.inside.transform.colorTransform = pink;

			var red:Color= new Color();
			red.setTint(0x94090D, 1);
			red_mc.inside.transform.colorTransform = red;

			var blue:Color= new Color();
			blue.setTint(0x010340, 1);
			blue_mc.inside.transform.colorTransform = blue;

			var green:Color= new Color();
			green.setTint(0x044C29, 1);
			green_mc.inside.transform.colorTransform = green;

			yellow_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			orange_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			purple_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			black_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			pink_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			red_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			blue_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			green_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			
			this.addEventListener(Event.ENTER_FRAME, init);
			this.gotoAndPlay("enter");


		}
		
		private function init(event:Event):void
		{
			if(this.currentFrameLabel == "normal")
			{
				this.removeEventListener(Event.ENTER_FRAME, init);
				trace("play video: " + Main(this.parent).student.CurrentLesson.Videos[0].Path);
				if(Main(this.parent).student.CurrentLesson.Videos.length > 0)
				{
					video_mc.source = Main(this.parent).student.CurrentLesson.Videos[0].Path;
					video_mc.playVideo();
				}
			}
		}

		private function ChoosenColor(event:MouseEvent):void
		{
			video_mc.stopVideo();
			
			yellow_mc.removeEventListener(MouseEvent.CLICK, ChoosenColor);
			orange_mc.removeEventListener(MouseEvent.CLICK, ChoosenColor);
			purple_mc.removeEventListener(MouseEvent.CLICK, ChoosenColor);
			black_mc.removeEventListener(MouseEvent.CLICK, ChoosenColor);
			pink_mc.removeEventListener(MouseEvent.CLICK, ChoosenColor);
			red_mc.removeEventListener(MouseEvent.CLICK, ChoosenColor);
			blue_mc.removeEventListener(MouseEvent.CLICK, ChoosenColor);
			green_mc.removeEventListener(MouseEvent.CLICK, ChoosenColor);

			var n:String;
			if (event.target.name == "inside")
			{
				n = MovieClip(event.target).parent.name;
			}
			else
			{
				n = event.target.name;
			}

			switch (n)
			{
				case "yellow_mc" :
					_newColor.setTint(0xF2B705, 1);
					break;

				case "orange_mc" :
					_newColor.setTint(0xF25C05, 1);
					break;

				case "purple_mc" :
					_newColor.setTint(0x7B52AB, 1);
					break;

				case "black_mc" :
					_newColor.setTint(0x000000, 1);
					break;

				case "pink_mc" :
					_newColor.setTint(0xF0788C, 1);
					break;

				case "red_mc" :
					_newColor.setTint(0x94090D, 1);
					break;

				case "blue_mc" :
					_newColor.setTint(0x010340, 1);
					break;

				case "green_mc" :
					_newColor.setTint(0x044C29, 1);
					break;

				default :
					trace("did not match, using default color");
					_newColor.setTint(0x000000, 1);
					break;

			}

			this.addEventListener(Event.ENTER_FRAME, exit);
			this.gotoAndPlay("exit");


		}

		private function exit(event:Event):void
		{
			if (this.currentFrameLabel == "end")
			{
				trace("Name: " + this.parent.name);
				Main(this.parent).NewMouse(_newColor);
				//Main(this.parent).NewMouse(_newColor);
				this.removeEventListener(Event.ENTER_FRAME, exit);
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}


		public function get NewColor():Color
		{
			return _newColor;
		}

	}

}