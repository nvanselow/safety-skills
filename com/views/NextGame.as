package com.views
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import com.MyVideo;
	import com.ui.InstructionPlayer;

	public class NextGame extends MovieClip
	{

		var _trialArray:Array;
		var _trial:int;
		var _correctComparison:String;

		var errorLevel:int = 0;

		var videoName:MyVideo = new MyVideo();
		
		var actout:Boolean;

		public function NextGame()
		{
			// constructor code

			addEventListener(Event.ENTER_FRAME, init);
			trace("load new next game");
		}

		private function init(evt:Event):void
		{
			if (instructions)
			{
				trace("initialize next game");
				actout = Object(parent).student.ActOut;
				
				
				removeEventListener(Event.ENTER_FRAME, init);
				InstructionPlayer(instructions).source = videoName.Next("Next_Instructions", false);
				instructions.addEventListener(Event.COMPLETE, videoEnd, false, 0, true);
				instructions.playVideo();

			}


		}

		private function videoEnd(evt:Event):void
		{
			btn_ok.addEventListener(MouseEvent.CLICK, btnClicked, false, 0, true);
			instructions.removeEventListener(Event.COMPLETE, videoEnd);
			//removeChild(video_mcb);
			getTrials();
			newTrial();
			cover_mc.visible = false;
		}

		private function btnClicked(evt:MouseEvent):void
		{
			if (_correctComparison == videoArray_mc.selected)
			{
				
				cover_mc.visible = true;
				if (errorLevel > 0)
				{
					Object(parent).addAllClickItem("Correct: After error");
				}
				else
				{
					Object(parent).NextData.addCorrect();
					Object(parent).addAllClickItem("Correct: Match");

				}
				_trial++;
				if (_trial < _trialArray.length)
				{

					switch (_trial)
					{
						case 1 :
							video_mc.source = videoName.Next("Correct_01", false);
							break;
						case 2 :
							video_mc.source = videoName.Next("Correct_02", false);
							break;
						case 3 :
							video_mc.source = videoName.Next("Correct_03", false);
							break;
						case 4 :
							video_mc.source = videoName.Next("Correct_01", false);
							break;
						case 5 :
							video_mc.source = videoName.Next("Correct_02", false);
							break;
						case 6 :
							video_mc.source = videoName.Next("Correct_03", false);
							break;
						default : 
							trace("this is the default, ran out of videos");
							video_mc.source = videoName.Next("Correct_02", false);
							break;
					}
					video_mc.addEventListener(Event.COMPLETE, correctEnd, false, 0, true);
					video_mc.playVideo();

					//if(errorLevel > 0)
					//{
					//_trial = _trial - 1;
					errorLevel = 0;
					//}
				}
				else
				{
					addEventListener(Event.ENTER_FRAME, exit, false, 0, true);
					gotoAndPlay("exit_choice_array");
					
					Object(parent).addAllClickItem("Next Game Complete");
					var currentTime:Date = new Date();
					Object(parent).addAllClickItem(currentTime);
				}

			}
			else
			{
				errorLevel +=  1;

				if (video_mc.source == videoName.Next("Error_general",false))
				{
					//do nothing
				}
				else
				{
					video_mc.source = videoName.Next("Error_general", false);
				}

				video_mc.playVideo();
				Object(parent).NextData.addError();
				Object(parent).addAllClickItem("Error: Missed match");
			}
		}

		private function correctEnd(evt:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, correctEnd);
			newTrial();
			cover_mc.visible = false;
		}

		private function exit(evt:Event):void
		{
			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);
				Object(parent).NextData.isComplete = true;
				
				//after testing go back to room
				Object(parent).returntoRoom();

			}
		}
		//Object(parent).removeNextGame();


		private function newTrial():void
		{
			Object(parent).addAllClickItem("Begin Trial " + _trial);
			videoArray_mc.reset();

			//var comparisons:Array = [];
			//trace(_trialArray + " new trial array");
			//trace(_trialArray[1] + " second trial");
			//trace(_trialArray[_trial] + " current trial");
			//comparisons.push(_trialArray[_trial] + "/comparisonA.flv");
			//trace("current trial " + _trialArray[_trial]);
			//comparisons.push(_trialArray[_trial] + "/comparisonB.flv");

			videoArray_mc.sampleSource = _trialArray[_trial] + "/sample.flv";
			//var randomNumber:Number = Math.floor(Math.random()*(comparisons.length));
			var correctNumber:Number = Math.round(Math.random()*(5 + 1));
			
			switch(correctNumber)
			{
				case 1 :
					_correctComparison = "comparisonA_vdo";
					videoArray_mc.compASource = _trialArray[_trial] + "/correct.flv";
					videoArray_mc.compBSource = _trialArray[_trial] + "/comparisonA.flv";
					videoArray_mc.compCSource = _trialArray[_trial] + "/comparisonB.flv";
					break;
				
				case 2 :
					_correctComparison = "comparisonA_vdo";
					videoArray_mc.compASource = _trialArray[_trial] + "/correct.flv";
					videoArray_mc.compBSource = _trialArray[_trial] + "/comparisonB.flv"; 
					videoArray_mc.compCSource = _trialArray[_trial] + "/comparisonA.flv";
					break;
					
				case 3 : 
					_correctComparison = "comparisonB_vdo";
					videoArray_mc.compBSource = _trialArray[_trial] + "/correct.flv";
					videoArray_mc.compASource = _trialArray[_trial] + "/comparisonA.flv";
					videoArray_mc.compCSource = _trialArray[_trial] + "/comparisonB.flv";
					break;
					
				case 4 :
					_correctComparison = "comparisonB_vdo";
					videoArray_mc.compBSource = _trialArray[_trial] + "/correct.flv";
					videoArray_mc.compCSource = _trialArray[_trial] + "/comparisonA.flv";
					videoArray_mc.compASource = _trialArray[_trial] + "/comparisonB.flv";
					break;
					
				case 5 :
					_correctComparison = "comparisonC_vdo";
					videoArray_mc.compCSource = _trialArray[_trial] + "/correct.flv";
					videoArray_mc.compBSource = _trialArray[_trial] + "/comparisonA.flv";
					videoArray_mc.compASource = _trialArray[_trial] + "/comparisonB.flv";
					break;
				
				case 6 : 
					_correctComparison = "comparisonC_vdo";
					videoArray_mc.compCSource = _trialArray[_trial] + "/correct.flv";
					videoArray_mc.compASource = _trialArray[_trial] + "/comparisonA.flv";
					videoArray_mc.compBSource = _trialArray[_trial] + "/comparisonB.flv";
					break;
					
				default : 
					trace("random number was invalid");
					_correctComparison = "comparisonA_vdo";
					videoArray_mc.compASource = _trialArray[_trial] + "/correct.flv";
					videoArray_mc.compBSource = _trialArray[_trial] + "/comparisonA.flv";
					videoArray_mc.compCSource = _trialArray[_trial] + "/comparisonB.flv";
					break;
			}
			
			
			/*
			if (correctNumber == 0)
			{
				videoArray_mc.compASource = _trialArray[_trial] + "/correct.flv";
				_correctComparison = "comparisonA_vdo";
			}
			else
			{
				videoArray_mc.compASource = comparisons[randomNumber];
				comparisons.splice(randomNumber, 1);
			}

			randomNumber = Math.floor(Math.random()*(comparisons.length));

			if (correctNumber == 1)
			{
				videoArray_mc.compBSource = _trialArray[_trial] + "/correct.flv";
				_correctComparison = "comparisonB_vdo";
			}
			else
			{
				videoArray_mc.compBSource = comparisons[randomNumber];
				comparisons.splice(randomNumber, 1);
			}

			randomNumber = Math.floor(Math.random()*(comparisons.length));

			if (correctNumber == 2)
			{
				videoArray_mc.compCSource = _trialArray[_trial] + "/correct.flv";
				_correctComparison = "comparisonC_vdo";
			}
			else
			{
				videoArray_mc.compCSource = comparisons[randomNumber];
				comparisons.splice(randomNumber, 1);
			}*/
		}

		private function getTrials():void
		{
			if(actout)
			{
				var nextDirectory:File = File.applicationDirectory.resolvePath("assets/video/abduction/next/actout/");
			}
			else
			{
				var nextDirectory:File = File.applicationDirectory.resolvePath("assets/video/abduction/next/noactout/");
			}
			var possibleTrials:Array = [];
			//trace("next directory listing= " + nextDirectory.getDirectoryListing());
			possibleTrials = nextDirectory.getDirectoryListing();
			_trialArray = new Array();
			//trace("setting up trial array");
			for (var i:uint = 0; i < possibleTrials.length; i++)
			{

				_trialArray.push(possibleTrials[i].nativePath);
				//trace("Pushing: " + possibleTrials[i].nativePath);

			}
			_trial = 0;

		}



	}

}