package com.ui
{

	import flash.display.*;
	import flash.events.MouseEvent;
	import fl.text.TLFTextField;

	public class ListItem extends MovieClip
	{

		private var _label:String;
		private var _id:int;

		private const UP:String = "up";
		private const DOWN:String = "down";
		private const OVER:String = "over";

		public function ListItem()
		{
			// constructor code

			upState();

		}

		private function mouseOverItem(evt:MouseEvent):void
		{
			gotoAndStop(OVER);

			removeEventListener(MouseEvent.MOUSE_OVER, mouseOverItem);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutItem);
		}
		
		public function upState():void
		{
			gotoAndStop(UP);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverItem);
			removeEventListener(MouseEvent.MOUSE_OUT, mouseOutItem);
		}
		
		public function overState():void
		{
			gotoAndStop(OVER);
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverItem);
		}
		
		public function downState():void
		{
			gotoAndStop(DOWN);
				removeEventListener(MouseEvent.MOUSE_OVER, mouseOverItem);
				removeEventListener(MouseEvent.MOUSE_OUT, mouseOutItem);
		}

		private function mouseOutItem(evt:MouseEvent):void
		{
			upState();

		}

		private function mouseClickItem(evt:MouseEvent):void
		{

			if (currentFrameLabel == OVER)
			{
				downState();
			}
			else
			{
				overState();

			}
		}

		public function set label(newLabel:String):void
		{
			_label = newLabel;
			label_txt.text = _label;

		}

		public function get label():String
		{
			return _label;
		}
		
		public function draw(w:Number):void
		{
			scaleX = scaleY = 1;
			width = w;
			//height = h;
			
		}
		
		public function set id(ID:int):void
		{
			_id = ID;
		}
		
		public function get id():int
		{
			return _id;
		}

	}

}