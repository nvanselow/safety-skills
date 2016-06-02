package  com.ui{
	
	import flash.display.MovieClip;
	import fl.video.VideoEvent;
	import fl.video.FLVPlayback;
	import fl.video.VideoPlayer;
	import flash.events.Event;
	import fl.video.MetadataEvent;
	import fl.video.flvplayback_internal;
	
	
	
	public class VideoClip extends MovieClip {
		
		
		private var _source:String;
		//protected static var player_mc:FLVPlayback;

		public function VideoClip() {
			// constructor code
			
			
			
			//player_mc = new FLVPlayback();
			//addChild(player_mc);
			//player_mc.x = 0;
			//player_mc.y = 0;
			//player_mc.width = 500;
			//player_mc.height = 400;
			//player_mc.autoPlay = false;
			//removeChild(place_player);
			//stopVideo();
			//updateSource();
			//trace("go to function that starts checking for the cue point");
			//player_mc.addEventListener(VideoEvent.PLAYING_STATE_ENTERED, startCheckCuePoint);
			
		}
		
		/*private function startCheckCuePoint(evt:VideoEvent):void
		{
			player_mc.removeEventListener(VideoEvent.PLAYING_STATE_ENTERED, startCheckCuePoint);
			player_mc.addEventListener(VideoEvent.PAUSED_STATE_ENTERED, resetPlayListener);
			trace("add event listener for checkCuePoint");
			player_mc.addEventListener(MetadataEvent.CUE_POINT, checkCuePoint);
		}
		
		private function resetPlayListener(evt:VideoEvent):void
		{
			trace("reset listeners");
			player_mc.addEventListener(VideoEvent.PLAYING_STATE_ENTERED, startCheckCuePoint);
			player_mc.removeEventListener(VideoEvent.PAUSED_STATE_ENTERED, resetPlayListener);
		}*/
		
		private function checkCuePoint(evt:MetadataEvent):void
		{
			if(evt.info.name == "end")
			{
				player_mc.removeEventListener(MetadataEvent.CUE_POINT, checkCuePoint);
				dispatchEvent(new Event(Event.COMPLETE));
				stopVideo();
				
			}
		}
		
		public function playVideo():void
		{
			player_mc.addEventListener(MetadataEvent.CUE_POINT, checkCuePoint, false, 0, true);
			player_mc.play();
			this.alpha = 1;
		}
		
		public function stopVideo():void
		{
			this.alpha = 0;
			player_mc.stop();
			
		}
		
		
		private function updateSource():void
		{
			if(player_mc.source == _source)
			{
				//do nothing
			}
			else
			{
				//player_mc.attachVideo(null);
				player_mc.stop();
				FLVPlayback(player_mc).getVideoPlayer(FLVPlayback(player_mc).activeVideoPlayerIndex).clear();
				FLVPlayback(player_mc).source = _source;
			}
			
		}
		
		/*public function dispose():void
		{
			player_mc.stop();
						
			for(var i:uint = 0; i < FLVPlayback(player_mc).videoPlayers.length; i++)
			{
				var vp:VideoPlayer = FLVPlayback(player_mc).getVideoPlayer(i);
				vp.stop();
				vp.close();
				vp.clear();
			}
		}*/
		
		public function set source(s:String):void{
			_source = s;
			updateSource();
		}
		
		public function get source():String
		{
			return _source;
		}

	}
	
}
