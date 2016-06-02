package com.ui.games
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.filesystem.File;
	import com.db.db;
	import flash.events.MouseEvent;
	import com.MyVideo;

	public class WhoGame extends MovieClip
	{

		private var top_left_image:WhoImage = new WhoImage();
		private var top_right_image:WhoImage = new WhoImage();
		private var bottom_left_image:WhoImage = new WhoImage();
		private var bottom_right_image:WhoImage = new WhoImage();

		private var _totalTrials:int = 5;
		private var _trials:int = 0;

		private var _strangers:Array;
		private var _strangersCopy:Array;
		private var _friends:Array;
		private var _friendsCopy:Array;
		private var _friendAdded:Boolean = false;

		private var errorLevel:int = 0;

		var mydb:db = new db  ;
		var videoName:MyVideo = new MyVideo  ;

		public function WhoGame()
		{
			// constructor code
			addEventListener(Event.EXIT_FRAME, init);



		}

		private function init(evt:Event):void
		{

			if (video_mc)
			{

				removeEventListener(Event.EXIT_FRAME, init);
				video_mc.source = videoName.Who("Who_01");
				video_mc.addEventListener(Event.COMPLETE, endVideo);
				video_mc.playVideo();
			}
		}

		private function endVideo(evt:Event):void
		{
			video_mc.removeEventListener(Event.COMPLETE, endVideo);

			video_mc.x = -99;
			video_mc.y = 403;
			video_mc.width = 375;
			video_mc.height = 281;

			addImages();

			//get list of stranger images
			var strangerDirectory:File = File.applicationDirectory.resolvePath("assets/pictures/strangers");;
			var possibleStrangers:Array = [];
			possibleStrangers = strangerDirectory.getDirectoryListing();
			_strangers = new Array  ;
			_strangersCopy = new Array  ;
			for (var i:uint = 0; i < possibleStrangers.length; i++)
			{
				if (File(possibleStrangers[i]).exists)
				{
					_strangers.push(possibleStrangers[i].nativePath);
				}
			}

			_strangersCopy = _strangers.concat();


			//get list of friends
			mydb.addEventListener(Event.COMPLETE, addFriends);
			mydb.getFriends();

		}

		private function addFriends(evt:Event):void
		{
			_friends = new Array  ;
			_friends = mydb.friends.concat();
			_friendsCopy = _friends.concat();

			_friendsCopy = mydb.friends;

			randomPeople();


		}

		private function randomPeople():void
		{

			//reset images
			top_left_image.isStranger = true;
			top_right_image.isStranger = true;
			bottom_left_image.isStranger = true;
			bottom_right_image.isStranger = true;
			_friendAdded = false;

			while (top_left_image.isStranger == true && top_right_image.isStranger == true && bottom_left_image.isStranger == true && bottom_right_image.isStranger == true)
			{
				getRandomPerson(top_left_image);
				getRandomPerson(top_right_image);
				getRandomPerson(bottom_left_image);
				getRandomPerson(bottom_right_image);
			}

			updateImages();

		}

		private function addImages():void
		{
			addChild(top_left_image);
			top_left_image.addEventListener(MouseEvent.CLICK, imageClicked);
			addChild(top_right_image);
			top_right_image.addEventListener(MouseEvent.CLICK, imageClicked);
			addChild(bottom_left_image);
			bottom_left_image.addEventListener(MouseEvent.CLICK, imageClicked);
			addChild(bottom_right_image);
			bottom_right_image.addEventListener(MouseEvent.CLICK, imageClicked);

		}

		private function imageClicked(evt:MouseEvent):void
		{

			if (evt.currentTarget.isStranger == false)
			{
				evt.currentTarget.showPrompt();
				top_left_image.removeEventListener(MouseEvent.CLICK, imageClicked);
				top_right_image.removeEventListener(MouseEvent.CLICK, imageClicked);
				bottom_left_image.removeEventListener(MouseEvent.CLICK, imageClicked);
				bottom_right_image.removeEventListener(MouseEvent.CLICK, imageClicked);

				if (errorLevel > 0)
				{
					Object(parent).addAllClickItem("Correct: Clicked safe adult after error");

				}
				else
				{

					Object(parent).WhoData.addCorrect();
					Object(parent).addAllClickItem("Correct: Clicked safe adult");
				}
				_trials++;
				trace(_trials);
				switch (_trials)
				{
					case 1 :

						trace("dont load video");

						video_mc.source = videoName.Who("Correct_01");

						//video_mc.playVideo();
						break;
					case 2 :
						video_mc.source = videoName.Who("Correct_02");
						//video_mc.playVideo();
						break;
					case 3 :
						video_mc.source = videoName.Who("Correct_03");
						//video_mc.playVideo();
						break;
					case 4 :
						video_mc.source = videoName.Who("Correct_04");
						//video_mc.playVideo();
						break;
					default :
						//video_mc.source = videoName.Who("Correct_01");
						correctEnd();
						break;
				}


				trace("play correct video");
				video_mc.addEventListener(Event.COMPLETE, correctEnd);
				video_mc.playVideo();



			}
			else
			{
				errorLevel++;

				if (errorLevel > 3)
				{
					errorLevel = 3;
				}
				trace("error level: " + errorLevel);
				switch (errorLevel)
				{
					case 1 :
						video_mc.source = videoName.Who("Error_01");
						break;
					case 2 :
						video_mc.source = videoName.Who("Error_02");
						break;
					case 3 :
						video_mc.source = videoName.Who("Error_03");

						if (top_left_image.isStranger == false)
						{
							top_left_image.showPrompt();
						}
						else if (top_right_image.isStranger == false)
						{
							top_right_image.showPrompt();
						}
						else if (bottom_left_image.isStranger == false)
						{

							bottom_left_image.showPrompt();
						}
						else if (bottom_right_image.isStranger == false)
						{
							bottom_right_image.showPrompt();
						}
						break;
					default :
						video_mc.source = videoName.Who("Error_02");
						break;
				}
				video_mc.playVideo();
				Object(parent).WhoData.addError();
				Object(parent).addAllClickItem("Error: Clicked Stranger");
			}
		}

		private function correctEnd(evt:Event = null):void
		{
			video_mc.removeEventListener(Event.COMPLETE, correctEnd);
			errorLevel = 0;




			//{;
			//if (errorLevel > 0);
			//{;

			//updateImages();

			//}
			//else
			//{


			if (_trials >= _totalTrials)
			{
				trace("end who game");

				Object(parent).WhoData.isComplete = true;
				top_left_image.removeEventListener(MouseEvent.CLICK, imageClicked);
				top_right_image.removeEventListener(MouseEvent.CLICK, imageClicked);
				bottom_left_image.removeEventListener(MouseEvent.CLICK, imageClicked);
				bottom_right_image.removeEventListener(MouseEvent.CLICK, imageClicked);

				video_mc.source = videoName.Who("Who_done");
				video_mc.addEventListener(Event.COMPLETE, endGame);
				video_mc.playVideo();
				Object(parent).addAllClickItem("Who Game End");

			}
			else
			{


				top_right_image.hidePrompt();
				top_left_image.hidePrompt();
				bottom_right_image.hidePrompt();
				bottom_left_image.hidePrompt();
				newTrial();
				top_left_image.addEventListener(MouseEvent.CLICK, imageClicked);
				top_right_image.addEventListener(MouseEvent.CLICK, imageClicked);
				bottom_left_image.addEventListener(MouseEvent.CLICK, imageClicked);
				bottom_right_image.addEventListener(MouseEvent.CLICK, imageClicked);
			}
		}
		//};


		private function endGame(evt:Event):void
		{
			addEventListener(Event.ENTER_FRAME, exit);
			gotoAndPlay("exit_whogame");

		}

		private function newTrial()
		{
			trace("new trial");
			randomPeople();
		}

		private function updateImages():void
		{
			top_left_image.setLocation = top_left_image.TOP_LEFT;

			top_right_image.setLocation = top_right_image.TOP_RIGHT;

			bottom_left_image.setLocation = bottom_left_image.BOTTOM_LEFT;

			bottom_right_image.setLocation = bottom_right_image.BOTTOM_RIGHT;

		}

		private function getRandomPerson(i:WhoImage):void
		{
			var isStranger:Number;
			var randomNumber:Number;

			isStranger = Math.floor(Math.random()*(1 + 1));
			if (isStranger == 1 && _friendAdded == false)
			{
				randomNumber = Math.floor(Math.random()*(_friends.length));
				i.source = _friends[randomNumber];
				i.isStranger = false;
				_friends.splice(randomNumber, 1);
				if (_friends.length < 1)
				{
					_friends = _friendsCopy.concat();
				}

				_friendAdded = true;



			}
			else
			{
				randomNumber = Math.floor(Math.random()*(_strangers.length));
				i.source = _strangers[randomNumber];

				i.isStranger = true;
				_strangers.splice(randomNumber, 1);
				if (_strangers.length < 1)
				{
					_strangers = _strangersCopy.concat();
				}
			}
		}

		private function exit(evt:Event):void
		{
			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exit);
				trace("call returntoRoom function on parent");
				Object(parent).returntoRoom();
			}
		}

	}

}