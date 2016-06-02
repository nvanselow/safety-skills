package com.views
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import com.ui.games.OrderArray;
	import com.MyVideo;

	public class OrderGame extends MovieClip
	{

		private var _trialArray:Array;
		private var _trial:int;
		private var videoName:MyVideo = new MyVideo();
		
		private var actout:Boolean;

		public function OrderGame()
		{
			// constructor code
			addEventListener(Event.ENTER_FRAME, init, false, 0, true);
		}

		private function init(evt:Event):void
		{
			if (instructions)
			{
				actout = Object(parent).student.ActOut;
				
				removeEventListener(Event.ENTER_FRAME, init);
				array_cover.visible = true;
				instructions.source = videoName.Order("Order_Instructions", false);
				instructions.addEventListener(Event.COMPLETE, endVideo, false, 0, true);
				instructions.playVideo();
			}
		}

		private function endVideo(evt:Event):void
		{
			instructions.removeEventListener(Event.COMPLETE, endVideo);
			//removeChild(video_mcb);
			getTrials();
			newTrial();
		}


		private function newTrial():void
		{
			Object(parent).addAllClickItem("Begin Trial " + _trial);
			
			var randomNumber:Number = Math.round(Math.random()*(5) + 1);
			
			switch(randomNumber)
			{
				case 1 : 
					orderArray_mc.vidASource(_trialArray[_trial] + "/A.flv", "A");
					orderArray_mc.vidBSource(_trialArray[_trial] + "/B.flv", "B");
					orderArray_mc.vidCSource(_trialArray[_trial] + "/C.flv", "C");
					break;
					
				case 2 :
					orderArray_mc.vidASource(_trialArray[_trial] + "/A.flv", "A");
					orderArray_mc.vidBSource(_trialArray[_trial] + "/C.flv", "C");
					orderArray_mc.vidCSource(_trialArray[_trial] + "/B.flv", "B");
					break;
					
				case 3 :
					orderArray_mc.vidASource(_trialArray[_trial] + "/B.flv", "B");
					orderArray_mc.vidBSource(_trialArray[_trial] + "/A.flv", "A");
					orderArray_mc.vidCSource(_trialArray[_trial] + "/C.flv", "C");
					break;
					
				case 4 :
					orderArray_mc.vidASource(_trialArray[_trial] + "/B.flv", "B");
					orderArray_mc.vidBSource(_trialArray[_trial] + "/C.flv", "C");
					orderArray_mc.vidCSource(_trialArray[_trial] + "/A.flv", "A");
					break;
					
				case 5 : 
					orderArray_mc.vidASource(_trialArray[_trial] + "/C.flv", "C");
					orderArray_mc.vidBSource(_trialArray[_trial] + "/A.flv", "A");
					orderArray_mc.vidCSource(_trialArray[_trial] + "/B.flv", "B");
					break;
					
				case 6 : 
					orderArray_mc.vidASource(_trialArray[_trial] + "/C.flv", "C");
					orderArray_mc.vidBSource(_trialArray[_trial] + "/B.flv", "B");
					orderArray_mc.vidCSource(_trialArray[_trial] + "/A.flv", "A");
					break;
					
				default : 
					trace("random number was invalid");
					orderArray_mc.vidASource(_trialArray[_trial] + "/A.flv", "A");
					orderArray_mc.vidBSource(_trialArray[_trial] + "/B.flv", "B");
					orderArray_mc.vidCSource(_trialArray[_trial] + "/C.flv", "C");
					break;
					
			}
			
			
			/*
			trace("Random number = " + randomNumber);
			if (randomNumber == 0)
			{
				orderArray_mc.vidASource(_trialArray[_trial] + "/A.flv", "A");
				orderArray_mc.vidBSource(_trialArray[_trial] + "/B.flv", "B");
				orderArray_mc.vidCSource(_trialArray[_trial] + "/C.flv", "C");

			}
			else if (randomNumber == 1)
			{
				orderArray_mc.vidASource(_trialArray[_trial] + "/B.flv", "B");
				orderArray_mc.vidBSource(_trialArray[_trial] + "/C.flv", "C");
				orderArray_mc.vidCSource(_trialArray[_trial] + "/A.flv", "A");
			}
			else
			{
				orderArray_mc.vidASource(_trialArray[_trial] + "/C.flv", "C");
				orderArray_mc.vidBSource(_trialArray[_trial] + "/A.flv", "A");
				orderArray_mc.vidCSource(_trialArray[_trial] + "/B.flv", "B");
			}

*/

			orderArray_mc.reset();
			orderArray_mc.addEventListener(Event.COMPLETE, allMatched, false, 0, true);
			array_cover.visible = false;
		}

		private function allMatched(evt:Event):void
		{
			array_cover.visible = true;
			orderArray_mc.removeEventListener(Event.COMPLETE, allMatched);
			_trial++;


			Object(parent).OrderData.addCorrect();
			if (_trial >= _trialArray.length)
			{
				trace("end order game");
				Object(parent).addAllClickItem("Order Game End");
				Object(parent).OrderData.isComplete = true;
				video_mc.source = videoName.Order("Correct_01", false);
				video_mc.addEventListener(Event.COMPLETE, lastVideo, false, 0, true);
				video_mc.playVideo();

			}
			else
			{
				//video_mc.stopVideo();
				switch (_trial)
				{
					case 1 :
						video_mc.source = videoName.Order("Correct_01", false);
						break;
					case 2 :
						video_mc.source = videoName.Order("Correct_02", false);
						break;
					case 3 :
						video_mc.source = videoName.Order("Correct_03", false);
						break;
					case 4 : 
						video_mc.source = videoName.Order("Correct_01", false);
						break;
					case 5 :
						video_mc.source = videoName.Order("Correct_02", false);
						break;
					case 6 : 
						video_mc.source = videoName.Order("Correct_03", false);
						break;
					default :
						video_mc.source = videoName.Order("Correct_02", false);
						trace("set default video");
						break;
				}
				video_mc.addEventListener(Event.COMPLETE, gotoNextTrial, false, 0, true);
				video_mc.playVideo();

			}
		}

		private function gotoNextTrial(evt:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, gotoNextTrial);
			newTrial();
		}

		private function lastVideo(evt:Event):void
		{
			Object(parent).addAllClickItem("Order Game Complete");
			var currentTime:Date = new Date();
			Object(parent).addAllClickItem(currentTime);
			
			video_mc.removeEventListener(Event.COMPLETE, lastVideo);
			Object(parent).returntoRoom();
		}

		private function getTrials():void
		{
			if(actout)
			{
				var nextDirectory:File = File.applicationDirectory.resolvePath("assets/video/abduction/order/actout/");
			}
			else
			{
				var nextDirectory:File = File.applicationDirectory.resolvePath("assets/video/abduction/order/noactout/");
			}
			var possibleTrials:Array = [];
			possibleTrials = nextDirectory.getDirectoryListing();
			_trialArray = new Array  ;
			for (var i:uint = 0; i < possibleTrials.length; i++)
			{

				_trialArray.push(possibleTrials[i].nativePath);

			}
			_trial = 0;

		}

	}

}