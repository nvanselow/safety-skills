package com.StudyTwo
{
	import com.StudyTwo.SafetyVideo;
	import com.StudyTwo.Trial;
	import flash.filesystem.File;
	
	public class Lesson
	{
		private var _Name:String;
		private var _NumCorrect:int;
		private var _NumPrompted:int;
		private var _NumTotal:int;
		private var _Type:String;
		private var _Images:Array = [];
		private var _Trials:Array = [];
		private var _Videos:Array = [];
		private var _Complete:Boolean = false;
		private var _Points:int;
		private var _MasteryPoints:int;
		
		//Constants
		public static const DRAG:String = "drag";
		public static const CHARACTER:String = "character";
		public static const VIDEO:String = "tv";
		public static const ORDER:String = "order";
		public static const NEXT:String = "next";
		public static const ACT:String = "act";
		public static const CLICK:String = "click";
		public static const SOCCER:String = "soccer";
		public static const POOL:String = "pool";
		public static const MOUSE:String = "mouse";
		public static const AWAY:String = "away";
		
		public function Lesson()
		{
			// constructor code
		}
		
		public function Reset():void
		{
			_Name = "";
			_NumCorrect = 0;
			_NumTotal = 0;
			_Type = "";
			_Images = [];
			_Videos = [];
			_Complete = false;
			_Points = 0;
			_MasteryPoints = 0;
		}
		
		public function set Name(n:String):void
		{
			_Name = n;
		}
		
		public function get Name():String
		{
			return _Name;
		}
		
		public function set NumCorrect(c:int):void
		{
			_NumCorrect = c;
		}
		
		public function get NumCorrect():int
		{
			return _NumCorrect;
		}
		
		public function addCorrect():void
		{
			_NumCorrect += 1;
			_Points+= 1;
			_NumTotal += 1;
			
		}
		
		public function addError():void
		{
			_NumTotal += 1;
		}
		
		public function AddPrompted():void
		{
			_NumPrompted += 1;
			_NumTotal += 1;
		}
		
		public function get NumPrompted():int
		{
			return _NumPrompted;
		}
		
		public function set NumTotal(n:int):void
		{
			_NumTotal = n;
		}
		
		public function get NumTotal():int
		{
			return _NumTotal;
		}
		
		public function Percentage():Number
		{
			var p:Number = _NumCorrect / _NumTotal * 100;
			return p;
		}
		
		public function PercentagePrompted():Number 
		{
			var p:Number = _NumPrompted / _NumTotal * 100;
			return p;
		}
		
		public function set Type(t:String):void
		{
			_Type = t;
		}
		
		public function get Type():String
		{
			return _Type;
		}
		
		public function set Complete(c:Boolean):void
		{
			_Complete = c;
		}
		
		public function get Complete():Boolean
		{
			return _Complete;
		}
		
		public function set Points(p:int):void
		{
			_Points = p;
		}
		
		public function get Points():int
		{
			return _Points;
		}
		
		public function set MasteryPoints(p:int):void
		{
			_MasteryPoints = p;
		}
		
		public function get MasteryPoints():int
		{
			return _MasteryPoints;
		}

		public function AddPoint():void
		{
			_Points += 1;
		}
		
		public function AddImage(img:SafetyImage):void
		{
			_Images.push(img);
			
		}
		
		public function set Images(i:Array):void
		{
			_Images = i;
		}
		
		public function get Images():Array
		{
			return _Images;
		}
		
		
		
		public function AddVideo(vdo:SafetyVideo):void
		{
			_Videos.push(vdo);
		}
		
		public function set Videos(v:Array):void
		{
			_Videos = v;
		}
		
		public function get Videos():Array
		{
			return _Videos;
		}
		
		public function AddTrial(tr:Trial):void
		{
			_Trials.push(tr);
		}
		
		public function set Trials(t:Array):void
		{
			_Trials = t;
		}
		
		public function get Trials():Array
		{
			return _Trials;
		}
	}

}