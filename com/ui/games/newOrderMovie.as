package  com.ui.games {
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.*;
	import com.ui.newVideoClip;
	import com.MyVideo;
	
	
	public class newOrderMovie extends MovieClip {
		
		private var origX:Number;
		private var origY:Number;
		var target:DisplayObject;
		
		private var _vid:newVideoClip;

		private var _turnOffDrag:Boolean = false;

		private var _source:String;

		public function newOrderMovie() {
			// constructor code
			origX = x;
			origY = y;
			addEventListener(MouseEvent.MOUSE_DOWN, fl_ClickToDrag, false, 0, true);
			
			_vid = player_mc;
			
			_vid.rewind = true;
			_vid.hideVideo = false;
			addEventListener(MouseEvent.ROLL_OVER, playVideo);
		}
		
		private function playVideo(evt:MouseEvent):void
		{
			removeEventListener(MouseEvent.ROLL_OVER, playVideo);
			addEventListener(MouseEvent.ROLL_OUT, stopVideo);
			_vid.playVideo();

		}
		
		private function stopVideo(evt:MouseEvent):void
		{
			removeEventListener(MouseEvent.ROLL_OUT, stopVideo);
			addEventListener(MouseEvent.ROLL_OVER, playVideo);
			_vid.stopVideo();
		}
		
		function fl_ClickToDrag(event:MouseEvent):void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, fl_ClickToDrag);
			stage.addEventListener(MouseEvent.MOUSE_UP, fl_ReleaseToDrop);
			Object(parent).addChild(this);
			startDrag();
		}

		function fl_ReleaseToDrop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, fl_ReleaseToDrop);
			addEventListener(MouseEvent.MOUSE_DOWN, fl_ClickToDrag);
			stopDrag();

			if (hitTestObject(target))
			{
				//visible = false;
				Object(parent).match(this);

			}
			else
			{
				Object(parent.parent.parent).OrderData.addError();
				Object(parent.parent.parent).addAllClickItem("Error: Missed match");
				var videoName:MyVideo = new MyVideo();
				Object(parent.parent).video_mc.source = videoName.Order("Error_01", false);
				Object(parent.parent).video_mc.playVideo();
			}

			x = origX;
			y = origY;

		}
		
		public function set source(s:String):void
		{
			_vid.source = s;
		}
		
		public function get source():String
		{
			return _vid.source;
		}
		
		public function updateSource(s:String):void
		{
			_vid.source = s;
			_vid.stopVideo();
		}
		
		public function set turnOffDrag(b:Boolean):void
		{
			_turnOffDrag = b;
			if (_turnOffDrag == true)
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
