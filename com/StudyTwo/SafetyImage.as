package com.StudyTwo
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import fl.containers.UILoader;

	public class SafetyImage extends MovieClip
	{
		private var _IsVisible:Boolean = false;
		private var _IsSafe:Boolean = false;
		private var _IsCorrect:Boolean = false;
		private var _Draggable:Boolean = false;
		private var _Type:String;
		private var _Path:String;
		private var _HighlightPath:String;
		private var _Highlight:Boolean = false;
		private var _OrigX:Number;
		private var _OrigY:Number;
		private var _YesTarget:DisplayObject;
		private var _NoTarget:DisplayObject;
		
		//Types
		public static const DRINK:String = "drink";
		public static const POOL:String = "pool";
		public static const TOY:String = "toy";
		public static const OCEAN:String = "ocean";
		public static const GUN:String = "gun";
		public static const ICE:String = "ice";
		public static const STRANGER:String = "stranger";
		
		//Hit event
		public static const HIT:String = "hit";
		
		
		public function SafetyImage()
		{
			// constructor code
			UILoader(loader_mc.loader_mc).maintainAspectRatio = true;
			UILoader(loader_mc.loader_mc).scaleContent = true;
			
		}
		
		public function Drop(event:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, Drop);
			stopDrag();
			
			var hitATarget:Boolean = false;
			if(hitTestObject(_YesTarget))
			{
				hitATarget = true;
				trace("hit yes target");
				if(_IsSafe == true)
				{
					this.IsCorrect = true;
				}
				else
				{
					this.IsCorrect = false;
				}
			}
			
			if(hitTestObject(_NoTarget))
			{
				trace("hit the no target");
				hitATarget = true;
				if(_IsSafe == false)
				{
					this.IsCorrect = true;
				}
				else
				{
					this.IsCorrect = false;
				}
			}
			
			trace("hit target: " + hitATarget);
			if(hitATarget == true)
			{
				dispatchEvent(new Event(SafetyImage.HIT));
			}
			else
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
				this.x = this.OrigX;
				this.y = this.OrigY;
			}
			
		}
		
		public function Drag(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, Drag);
			stage.addEventListener(MouseEvent.MOUSE_UP, Drop);
			MovieClip(this.parent).addChild(this);
			startDrag();
		}
		
		
		public function Reset():void
		{
			this.IsVisible = false;
			_IsSafe = false;
			_IsCorrect = false;
			_Draggable = false;
			_Type = "";
			_Path = "";
			_HighlightPath = "";
			_Highlight = false;
			this.removeEventListener(MouseEvent.MOUSE_DOWN, Drag);
		}
		
		public function SetHitTargets(YesTarget:DisplayObject, NoTarget:DisplayObject):void
		{
			_YesTarget = YesTarget;
			_NoTarget = NoTarget;
		}
		
		public function set OrigX(xpos:Number):void
		{
			_OrigX = xpos;
			this.x = xpos;
		}
		
		public function get OrigX():Number
		{
			return _OrigX;
		}
		
		public function set OrigY(ypos:Number):void
		{
			_OrigY = ypos;
			this.y = ypos;
		}
		
		public function get OrigY():Number
		{
			return _OrigY;
		}
		
		public function set IsVisible(v:Boolean):void
		{
			_IsVisible = v;
			if(v == true)
			{
				this.gotoAndPlay("enter");
			}
			else
			{
				this.gotoAndPlay("exit");
			}
			
		}
		
		public function get IsVisible():Boolean
		{
			return _IsVisible;
		}
		
		public function set IsSafe(s:Boolean):void
		{
			_IsSafe = s;
		}
		
		public function get IsSafe():Boolean
		{
			return _IsSafe;
		}
		
		public function set IsCorrect(c:Boolean):void
		{
			_IsCorrect = c;
		}
		
		public function get IsCorrect():Boolean
		{
			return _IsCorrect;
		}
		
		public function set Draggable(d:Boolean):void
		{
			_Draggable = d;
			
			//True then add event listeners for dragging
			//False then remove event listeners for dragging
			if(d == true)
			{
				this.addEventListener(MouseEvent.MOUSE_DOWN, Drag);
			}
			else
			{
				this.removeEventListener(MouseEvent.MOUSE_DOWN, Drag);
				this.removeEventListener(MouseEvent.MOUSE_UP, Drop);
			}
		}
		
		public function get Draggable():Boolean
		{
			return _Draggable;
		}
		
		public function set Type(s:String):void
		{
			_Type = s;
		}
		
		public function get Type():String
		{
			return _Type;
		}
		
		public function set Path(p:String):void
		{
			_Path = p;
			UILoader(this.loader_mc.loader_mc).source = p; 
			//Update image to show current path
		}
		
		public function get Path():String
		{
			return _Path;
		}
		
		public function set HighlightPath(p:String):void
		{
			_HighlightPath = p;
		}
		
		public function get HighlightPath():String
		{
			return _HighlightPath;
		}
		
		public function set Highlight(h:Boolean):void
		{
			_Highlight = h;
			
			
			if(h == true)
			{
				//If true, show highlight image
				UILoader(this.loader_mc.loader_mc).source = this.HighlightPath;
			}
			else
			{
				//If flase, remove highlight image 
				UILoader(this.loader_mc.loader_mc).source = this.Path;
				
			}
			
			
		}
		
		public function get Highlight():Boolean
		{
			return _Highlight;
		}
		
		
		

	}

}