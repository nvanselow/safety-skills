package com.ui.games
{

	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import fl.video.VideoEvent;


	public class OrderMovie extends MovieClip
	{

		var origX:Number;
		var origY:Number;
		var target:DisplayObject;
		
		private var _turnOffDrag:Boolean = false;
		
		private var _source:String;

		public function OrderMovie()
		{
			// constructor code
			origX = x;
			origY = y;
			addEventListener(MouseEvent.MOUSE_DOWN, fl_ClickToDrag);
			
			player_mc.autoRewind = true;
			updateSource(_source);
			addEventListener(MouseEvent.ROLL_OVER, showBox);

		}
		
		function fl_ClickToDrag(event:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, fl_ReleaseToDrop);
			Object(parent).addChild(this);
			startDrag();
		}
		
		function fl_ReleaseToDrop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, fl_ReleaseToDrop);
			stopDrag();
			
			if(hitTestObject(target))
			{
				//visible = false;
				Object(parent).match(this);

			}
			else
			{
				Object(parent.parent.parent).OrderData.addError();
				Object(parent.parent.parent).addAllClickItem("Error: Missed match");
				trace(Object(parent.parent.parent).name);
			}
			
			x = origX;
			y = origY;
			
		}
		
		private function showBox(evt:MouseEvent):void
		{
			
			removeEventListener(MouseEvent.ROLL_OVER, showBox);
			addEventListener(MouseEvent.ROLL_OUT, hideBox);
			
			player_mc.play();

		}

		private function hideBox(evt:MouseEvent):void
		{
			
			addEventListener(MouseEvent.ROLL_OVER, showBox);
			removeEventListener(MouseEvent.ROLL_OUT, hideBox);

			player_mc.pause();
		}
		
		public function set source(videoFilePath:String):void
		{
			_source = videoFilePath;
			updateSource(_source);
		}

		public function get source():String
		{
			return _source;
		}
		
		public function updateSource(filePath:String):void
		{
			
			player_mc.addEventListener(ProgressEvent.PROGRESS, trackLoadProgress);
			loader.loadPercent = "0";
			loader.visible = true;
			player_mc.source = filePath;
			trace(filePath);

		}
		
		private function trackLoadProgress(evt:ProgressEvent):void
		{
			loader.loadPercent = String(Math.round((evt.bytesLoaded/evt.bytesTotal)*100));
			if(evt.bytesLoaded == evt.bytesTotal)
			{
				player_mc.removeEventListener(ProgressEvent.PROGRESS, trackLoadProgress);
				player_mc.addEventListener(VideoEvent.READY, videoReady);
				
				
			}
		}
		
		private function videoReady(evt:VideoEvent):void
		{
			player_mc.removeEventListener(VideoEvent.READY, videoReady);
			loader.visible = false;
			player_mc.pause();
		
		}
		
		public function set turnOffDrag(b:Boolean):void
		{
			_turnOffDrag = b;
			if(_turnOffDrag == true)
			{
				removeEventListener(MouseEvent.MOUSE_DOWN, fl_ClickToDrag);
			}
			else
			{
				addEventListener(MouseEvent.MOUSE_DOWN, fl_ClickToDrag);
			}
		}
		
		public function get turnOffDrag():Boolean
		{
			return _turnOffDrag;
		}
		

	}

}