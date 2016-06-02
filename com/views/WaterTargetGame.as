package  com.views{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.MyVideo;
	
	
	public class WaterTargetGame extends MovieClip {
		
		var videoName:MyVideo = new MyVideo;

		public function WaterTargetGame() {
			// constructor code
			addEventListener(Event.EXIT_FRAME, init);
			
		}
		
		private function init(evt:Event):void
		{
			if(instructions)
			{
				removeEventListener(Event.EXIT_FRAME, init);
				cover_mc.visible = true;
				instructions.source = videoName.Water("Water_Instructions");
				instructions.addEventListener(Event.COMPLETE, videoComplete);
				instructions.playVideo();
				
			}
		}
		
		private function videoComplete(evt:Event):void
		{
			instructions.removeEventListener(Event.COMPLETE, videoComplete);
			water_mc.addEventListener(Event.COMPLETE, endGame);
			video_mc.x = 537;
			video_mc.y = 330;
			video_mc.width = 417;
			video_mc.height = 333;
			cover_mc.visible = false;
		}
		
		private function endGame(evt:Event)
		{
			Object(parent).WaterData.isComplete = true;
			Object(parent).addAllClickItem("Water Game complete");
			var currentTime:Date = new Date();
			Object(parent).addAllClickItem(currentTime);
			video_mc.source = videoName.Water("Water_done");
			video_mc.addEventListener(Event.COMPLETE, endVideo);
			video_mc.playVideo();
			
		}
		
		private function endVideo(evt:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, endVideo);
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_watergame");
		}
		
		private function exit(evt:Event):void
		{
			if(currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);
				Object(parent).gotoVideoGame();
			}
		}

	}
	
}
