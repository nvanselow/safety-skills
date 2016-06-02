package com.StudyTwo
{
	import flash.filesystem.File;
	
	public class SafetyVideo
	{
		
		private var _Path:String;
		private var _Type:String;
		
		
		//Constant video types
		public static const INSTRUCTION:String = "instruction";
		public static const END_VIDEO:String = "end_video";
		public static const TV:String = "tv";
		public static const NORMAL:String = "normal";
		public static const STRANGER:String = "stranger";

		public function SafetyVideo()
		{
			// constructor code
		}
		
		public function Reset():void
		{
			_Path = "";
			_Type = "";
		}
		
		public function GetLessonVideo(LessonNum:int):String
		{
			var p:String;
			//Have a switch case for all the folders with lessons
			
			return p;
		}
		
		public function Intro(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Intro").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;

		}
		
		public function TargetError():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Target/Error_01.flv").nativePath;
			return videoLocation;
		}
		
		public function NextAskA():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Next/Error_askA.flv").nativePath;
			return videoLocation;
		}
		
		public function NextAskB():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Next/Error_askB.flv").nativePath;
			return videoLocation;
		}
		
		public function NextNoA():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Next/Error_noA.flv").nativePath;
			return videoLocation;
		}
		
		public function NextNoB():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Next/Error_noB.flv").nativePath;
			return videoLocation;
		}
		
		public function NextGoA():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Next/Error_goA.flv").nativePath;
			return videoLocation;
		}
		
		public function NextGoB():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Next/Error_goB.flv").nativePath;
			return videoLocation;
		}
		
		
		public static function NextClickOK():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Next/Error_ok.flv").nativePath;
			
			return videoLocation;
		}
		
		public function ActError():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Act/Error_01.flv").nativePath;
			return videoLocation;
		}
		
		public function ActErrorLong():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Act/Error_03.flv").nativePath;
			return videoLocation;
		}
		
		public function ActNoClick():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Act/Error_02.flv").nativePath;
			return videoLocation;
		}
		
		public function AwayEarly():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Away/Early.flv").nativePath;
			return videoLocation;
		}
		
		public function AwayLate():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Away/Late.flv").nativePath;
			return videoLocation; 
		}
		
		public function AwayCorrect():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Away/Correct.flv").nativePath;
			return videoLocation; 
		}
		
		public function CharacterErrorSafe():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Character/ErrorSafe.flv").nativePath;
			return videoLocation; 
		}
		
		public function CharacterErrorDanger():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Character/ErrorDanger.flv").nativePath;
			return videoLocation; 
		}
		
		public function DragErrorSafe():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Drag/ErrorSafe.flv").nativePath;
			return videoLocation; 
		}
		
		public function DragErrorDanger():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Drag/ErrorDanger.flv").nativePath;
			return videoLocation; 
		}
		
		public function ChooseStickFigure():String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("StudyTwoAssets/Video/Choose/Choose.flv").nativePath;
			return videoLocation; 
		}
		
		public function set Path(p:String):void
		{
			_Path = p;
		}
		
		public function get Path():String
		{
			return _Path;
		}
		
		public function set Type(t:String):void
		{
			_Type = t;
		}
		
		public function get Type():String
		{
			return _Type;
		}

	}

}