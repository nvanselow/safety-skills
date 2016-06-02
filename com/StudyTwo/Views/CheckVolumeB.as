﻿package com.StudyTwo.Views 
{

	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import com.StudyTwo.SafetyVideo;


	public class CheckVolumeB extends MovieClip
	{
		var videoName:SafetyVideo = new SafetyVideo();
		
		public function CheckVolumeB()
		{
			// constructor code
			btnOK.addEventListener(MouseEvent.CLICK, nextScreen);
			addEventListener(Event.ENTER_FRAME, init);
		}
		
		private function init(evt:Event):void
		{
			if(video_mc)
			{
				removeEventListener(Event.ENTER_FRAME, init);
				video_mc.source = videoName.Intro("Volume_01");
				video_mc.playVideo();
			}
		}
		
		private function nextScreen(evt:MouseEvent):void
		{
			video_mc.stopVideo();
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_volume_check");
		}
		
		private function exit(evt:Event):void
		{
			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);
				
				dispatchEvent(new Event(Event.COMPLETE));
				
			}
		}


	}

}