package com.ui.games
{

	import flash.display.*;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.net.dns.AAAARecord;
	import flash.geom.Rectangle;

	public class WhoImage extends Sprite
	{

		private var _source:String = "assets/pictures/strangers/stranger01.jpg";
		private var _isStranger:Boolean = true;
		private var _setLocation:int = 1;
		public var loader:Loader = new Loader();
		private var prompt:Sprite = new Sprite();

		public const TOP_LEFT:int = 1;
		public const TOP_RIGHT:int = 2;
		public const BOTTOM_LEFT:int = 3;
		public const BOTTOM_RIGHT:int = 4;

		public function WhoImage()
		{
			// constructor code
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, fileLoaded);
			this.addChild(prompt);
			prompt.graphics.lineStyle(3, 0XFFFFFF);
			prompt.graphics.beginFill(0x0094FF);
			prompt.graphics.drawRect(0, 0, 275, 275);
			prompt.graphics.endFill();
			prompt.visible = false;
			//loadNewSource();


		}

		private function loadNewSource():void
		{

			loader.load(new URLRequest(_source));
		}

		private function fileLoaded(evt:Event):void
		{

			updateLocation();
			addChild(loader);

		}

		public function set source(s:String):void
		{
			_source = s;
			loadNewSource();
		}

		public function get source():String
		{
			return _source;
		}

		public function set isStranger(s:Boolean):void
		{
			_isStranger = s;
		}

		public function get isStranger():Boolean
		{
			return _isStranger;
		}

		public function set setLocation(l:int):void
		{
			_setLocation = l;
			loadNewSource();
		}

		public function get setLocation():int
		{
			return _setLocation;
		}

		private function updateLocation():void
		{
			switch (_setLocation)
			{
				case TOP_LEFT :
					loader.content.x = 220;
					prompt.x = 205;
					loader.content.y = 30;
					prompt.y = 15;
					break;

				case TOP_RIGHT :
					loader.content.x = 580;
					prompt.x = 565;
					loader.content.y = 30;
					prompt.y = 15;
					break;

				case BOTTOM_LEFT :
					loader.content.x = 220;
					prompt.x = 205;
					loader.content.y = 350;
					prompt.y = 335;
					break;

				case BOTTOM_RIGHT :
					loader.content.x = 580;
					prompt.x = 565;
					loader.content.y = 350;
					prompt.y = 335;
					break;

			}

			loader.content.width = 260;
			loader.content.height = 260;
		}

		public function showPrompt():void
		{
			prompt.visible = true;
		}

		public function hidePrompt():void
		{
			prompt.visible = false;
		}

		public function isPrompted():Boolean
		{
			var prompted:Boolean = prompt.visible;
			return prompted;
		}

	}



}