package com.ui.games
{

	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Room extends MovieClip
	{
		public const WHITE:String = "white";
		public const BLUE:String = "blue";
		public const RED:String = "red";
		public const ORANGE:String = "orange";
		public const YELLOW:String = "yellow";
		public const PINK:String = "pink";
		public const PURPLE:String = "purple";

		private var _roomColor:String = WHITE;

		public function Room()
		{
			// constructor code
			noColor();
			blue_btn.addEventListener(MouseEvent.CLICK, changeBlue);
			red_btn.addEventListener(MouseEvent.CLICK, changeRed);
			yellow_btn.addEventListener(MouseEvent.CLICK, changeYellow);
			orange_btn.addEventListener(MouseEvent.CLICK, changeOrange);
			pink_btn.addEventListener(MouseEvent.CLICK, changePink);
			purple_btn.addEventListener(MouseEvent.CLICK, changePurple);
		}

		public function set roomColor(c:String):void
		{
			_roomColor = c;
			changeColor(c);
		}
		
		public function get roomColor():String
		{
			return _roomColor;
		}

		private function changeBlue(evt:MouseEvent):void
		{
			changeColor(BLUE);
		}

		private function changeRed(evt:MouseEvent):void
		{
			changeColor(RED);

		}

		private function changeYellow(evt:MouseEvent):void
		{
			changeColor(YELLOW);
		}

		private function changeOrange(evt:MouseEvent):void
		{
			changeColor(ORANGE);
		}

		private function changePink(evt:MouseEvent):void
		{
			changeColor(PINK);
		}

		private function changePurple(evt:MouseEvent):void
		{
			changeColor(PURPLE);
		}


		public function invisibleButtons():void
		{
			blue_btn.visible = false;
			red_btn.visible = false;
			orange_btn.visible = false;
			yellow_btn.visible = false;
			pink_btn.visible = false;
			purple_btn.visible = false;
			text.visible = false;

			dispatchEvent(new Event(Event.CHANGE));
		}





		private function noColor():void
		{
			_roomColor = WHITE;
			bluewall.visible = false;
			redwall.visible = false;
			orangewall.visible = false;
			pinkwall.visible = false;
			purplewall.visible = false;
			yellowwall.visible = false;

		}

		private function blueColor():void
		{
			_roomColor = BLUE;
			bluewall.visible = true;
			redwall.visible = false;
			orangewall.visible = false;
			pinkwall.visible = false;
			purplewall.visible = false;
			yellowwall.visible = false;
			
			invisibleButtons()
		}

		private function redColor():void
		{
			_roomColor = RED;
			bluewall.visible = false;
			redwall.visible = true;
			orangewall.visible = false;
			pinkwall.visible = false;
			purplewall.visible = false;
			yellowwall.visible = false;
			
			invisibleButtons()
		}

		private function orangeColor():void
		{
			_roomColor = ORANGE;
			bluewall.visible = false;
			redwall.visible = false;
			orangewall.visible = true;
			pinkwall.visible = false;
			purplewall.visible = false;
			yellowwall.visible = false;
			
			invisibleButtons()

		}

		private function pinkColor():void
		{
			_roomColor = PINK;
			bluewall.visible = false;
			redwall.visible = false;
			orangewall.visible = false;
			pinkwall.visible = true;
			purplewall.visible = false;
			yellowwall.visible = false;
			
			invisibleButtons()

		}

		private function purpleColor():void
		{
			_roomColor = PURPLE;
			bluewall.visible = false;
			redwall.visible = false;
			orangewall.visible = false;
			pinkwall.visible = false;
			purplewall.visible = true;
			yellowwall.visible = false;
			
			invisibleButtons()

		}

		private function yellowColor():void
		{
			_roomColor = YELLOW;
			bluewall.visible = false;
			redwall.visible = false;
			orangewall.visible = false;
			pinkwall.visible = false;
			purplewall.visible = false;
			yellowwall.visible = true;
			
			invisibleButtons()

		}



		public function changeColor(colorName:String):void
		{
			switch (colorName)
			{
				case BLUE :
					blueColor();
					break;

				case RED :
					redColor();
					break;

				case ORANGE :
					orangeColor();
					break;

				case YELLOW :
					yellowColor();
					break;

				case PINK :
					pinkColor();
					break;

				case PURPLE :
					purpleColor();
					break;

				default :
					noColor();
					break;

			}


		}

	}

}