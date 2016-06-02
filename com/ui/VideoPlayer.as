package com.ui
{

	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import fl.video.VideoEvent;
	import flash.net.URLRequest;
	import fl.video.FLVPlayback;

	public class VideoPlayer extends MovieClip
	{


		//---- PROPERTIES -------------------------
		private var _source:String;
		private var _checkBoxEnabled:Boolean = true;


		public function VideoPlayer()
		{
			// constructor code
			addEventListener(MouseEvent.ROLL_OVER, showBox, false, 0, true);
			addEventListener(MouseEvent.CLICK, checkBox, false, 0, true);
			//player_mc.autoRewind = true;
			player_mc.stop();
			checkbox_mc.isChecked = false;
			loader.visible = false;



		}

		//----- FUNCTIONS AND METHODS -------------

		private function rewindVideo(evt:VideoEvent):void
		{
			player_mc.play();
		}

		public function showBox(evt:MouseEvent = null):void
		{

			removeEventListener(MouseEvent.ROLL_OVER, showBox);
			addEventListener(MouseEvent.ROLL_OUT, hideBox, false, 0, true);
			player_mc.addEventListener(VideoEvent.COMPLETE, rewindVideo, false, 0, true);

			if (_checkBoxEnabled == true)
			{
				checkbox_mc.alpha = 1;
				checkbox_mc.enlargeCheck();

			}

			player_mc.play();


		}

		public function hideBox(evt:MouseEvent = null):void
		{


			addEventListener(MouseEvent.ROLL_OVER, showBox, false, 0, true);
			removeEventListener(MouseEvent.ROLL_OUT, hideBox);
			player_mc.removeEventListener(VideoEvent.COMPLETE, rewindVideo);

			if (! checkbox_mc.isChecked)
			{
				checkbox_mc.alpha = 0;
			}
			checkbox_mc.shrinkCheck();

			player_mc.stop();
		}


		private function checkBox(evt:MouseEvent):void
		{
			checkbox_mc.updateChecked();
		}


		public function set source(videoFilePath:String):void
		{
			if (_source == videoFilePath)
			{
				trace("video and original source are the same");
				
			}
			else
			{
				//FLVPlayback(player_mc).getVideoPlayer(FLVPlayback(player_mc).activeVideoPlayerIndex).close();
				_source = videoFilePath;
				updateSource(_source);
			}
		}

		public function get source():String
		{
			return _source;
		}

		public function set checkBoxEnabled(c:Boolean):void
		{
			_checkBoxEnabled = c;

		}

		public function get checkBoxEnabled():Boolean
		{
			return _checkBoxEnabled;
		}

		private function updateSource(filePath:String):void
		{
			player_mc.addEventListener(ProgressEvent.PROGRESS, trackLoadProgress, false, 0, true);
			loader.loadPercent = "0";
			loader.visible = true;
			player_mc.stop();
			FLVPlayback(player_mc).getVideoPlayer(FLVPlayback(player_mc).activeVideoPlayerIndex).clear();
			FLVPlayback(player_mc).source = filePath;


		}

		private function trackLoadProgress(evt:ProgressEvent):void
		{
			loader.loadPercent = String(Math.round((evt.bytesLoaded/evt.bytesTotal)*100));
			if (evt.bytesLoaded == evt.bytesTotal)
			{
				player_mc.removeEventListener(ProgressEvent.PROGRESS, trackLoadProgress);
				player_mc.addEventListener(VideoEvent.READY, videoReady, false, 0, true);


			}
		}

		private function videoReady(evt:VideoEvent):void
		{
			player_mc.removeEventListener(VideoEvent.READY, videoReady);
			loader.visible = false;
			player_mc.stop();

		}


		public function set isChecked(c:Boolean):void
		{
			checkbox_mc.isChecked = c;
		}

		public function get isChecked():Boolean
		{
			return checkbox_mc.isChecked;
		}


	}

}