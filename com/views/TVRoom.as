package com.views {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.MyVideo;
	
	public class TVRoom extends MovieClip {

		var videoName:MyVideo = new MyVideo;
		var ivid:instructionsvideo = new instructionsvideo();
			
		public function TVRoom() {
			// constructor code
			
			addEventListener(Event.ENTER_FRAME, init);
		}
		
		private function init(evt:Event):void
		{
			if(video_mc)
			{
				removeEventListener(Event.ENTER_FRAME, init);
				if(Object(parent).InstructionsData.isComplete == true)
				{
					video_mc.source = videoName.Look("Look_01");
					video_mc.addEventListener(Event.COMPLETE, lookend);
				}
				else
				{
					Object(parent).addAllClickItem("Instructions Begin");
					var currentTime:Date = new Date();
					Object(parent).addAllClickItem(currentTime);
					video_mc.source = videoName.Instructions("Instructions_01_orig");
					addChild(ivid);
					ivid.x = 199.1;
					ivid.y = 103.5;
					ivid.cacheAsBitmap = true;
					video_mc.addEventListener(Event.COMPLETE, videoEnd);
					
				}
				video_mc.playVideo();
				
			}
		}
		
		private function videoEnd(evt:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, videoEnd);
			removeChild(ivid);
			Object(parent).InstructionsData.isComplete = true;
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_tv_room");
			
			Object(parent).addAllClickItem("Instructions End");
			var currentTime:Date = new Date();
			Object(parent).addAllClickItem(currentTime);
		}
		
		private function lookend(evt:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, lookend);
			video_mcb.source = videoName.Look("boy_correct_01");
			video_mcb.addEventListener(Event.COMPLETE, look1end);
			video_mcb.playVideo();
			trace("boy 1 correct");
			
		}
		
		private function look1end(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, look1end);
			video_mc.source = videoName.Look("Look_boy_02");
			video_mc.addEventListener(Event.COMPLETE, look2end);
			video_mc.playVideo();
			trace("look boy 2");
		}
		
		private function look2end(event:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, look2end);
			video_mcb.source = videoName.Look("girl_no_01");
			video_mcb.addEventListener(Event.COMPLETE, look3end);
			video_mcb.playVideo();
			trace("girl_no_01");
			
		}
		
		private function look3end(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, look3end);
			video_mc.source = videoName.Look("Look_girl_01");
			video_mc.addEventListener(Event.COMPLETE, look4end);
			video_mc.playVideo();
			trace("look girl 01");
		}
		
		private function look4end(event:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, look4end);
			video_mcb.source = videoName.Look("girl_go_01");
			video_mcb.addEventListener(Event.COMPLETE, look5end);
			video_mcb.playVideo();
			trace("girl_go_01");
		}
		
		private function look5end(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, look5end);
			video_mc.source = videoName.Look("Look_girl_03");
			video_mc.addEventListener(Event.COMPLETE, look6end);
			video_mc.playVideo();
			trace("look girl 03");
		}
		
		private function look6end(event:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, look6end);
			video_mcb.source = videoName.Look("boy_wrong");
			video_mcb.addEventListener(Event.COMPLETE, look7end);
			video_mcb.playVideo();
			trace("boy wrong");
		}
		
		private function look7end(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, look7end);
			video_mc.source = videoName.Look("Look_boy_04");
			video_mc.addEventListener(Event.COMPLETE, look8end);
			video_mc.playVideo();
			trace("look boy 04");
		}
		
		private function look8end(event:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, look8end);
			video_mcb.source = videoName.Look("girl_correct");
			video_mcb.addEventListener(Event.COMPLETE, look9end);
			video_mcb.playVideo();
			trace("Girl correct");
		}
		
		private function look9end(event:Event):void
		{
			video_mcb.removeEventListener(Event.COMPLETE, look9end);
			video_mc.source = videoName.Look("Look_both_01");
			video_mc.addEventListener(Event.COMPLETE, exitLook);
			video_mc.playVideo();
			trace("look both 01");
			
		}
		
		private function exitLook(event:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, exitLook);
			Object(parent).LookData.isComplete = true;
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_tv_room");
		}
		
		private function exit(evt:Event):void
		{
			if(currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);
				Object(parent).returntoRoom();
				//dispatchEvent(new Event(Event.COMPLETE));
				//Object(parent).removeTV();
				
			}
		}

	}
	
}
