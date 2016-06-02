package com.StudyTwo
{
	//Still need to add video telling user to select a color in video_mc
	import flash.display.MovieClip;
	import uk.co.bigroom.utils.ObjectPool;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import fl.motion.Color;

	public class ChooseColor extends MovieClip
	{

		private var _newColor:Color;

		public function ChooseColor()
		{
			// constructor code
		}

		public function Start():void
		{
			this.gotoAndPlay(1);
			_newColor = ObjectPool.getObject(Color);

			yellow_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			orange_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			purple_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			black_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			pink_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			red_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			blue_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);
			green_mc.addEventListener(MouseEvent.CLICK, ChoosenColor);

			var v:SafetyVideo = ObjectPool.getObject(SafetyVideo);
			video_mc.source = v.ChooseStickFigure();
			video_mc.playVideo();


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

			switch (event.target.name)
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