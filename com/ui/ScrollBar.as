package com.ui
{

	import flash.display.*;
	import flash.events.*;
	import flash.geom.Rectangle;
	import flash.text.*;


	public class ScrollBar extends MovieClip
	{

		public var value:Number;
		public var padding:Number = 5;
		
		private var _textField:MovieClip;
		private var max:Number;
		private var min:Number;


		public function ScrollBar()
		{
			// constructor code
			//draw(width, height);
			
			drag_mc.addEventListener(MouseEvent.MOUSE_DOWN, dragHandle);
			
			
		}
		
		/*public function draw(w:Number, h:Number):void
		{
			scaleX = scaleY = 1;
			bar_mc.height = h - ((up_btn.height - padding) * 2);
			bar_mc.y = up_btn.height - padding;
			down_btn.y = bar_mc.height + bar_mc.y - padding;
						
			min = bar_mc.y + 1;
			max = bar_mc.height - drag_mc.height;
			
			drag_mc.y = min;
		}*/
		
		private function dragHandle(evt:MouseEvent):void
		{
			min = bar_mc.y + 1;
			max = bar_mc.height - drag_mc.height;
			
			
					
			drag_mc.startDrag(false, new Rectangle(drag_mc.x, min, 0, max));
			
			drag_mc.removeEventListener(MouseEvent.MOUSE_DOWN, dragHandle);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopDragHandle);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updateValue);
			
			
		}
		
		private function stopDragHandle(evt:MouseEvent):void
		{
			drag_mc.stopDrag();
			
			drag_mc.addEventListener(MouseEvent.MOUSE_DOWN, dragHandle);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopDragHandle);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateValue);
		}
		
		private function updateValue(evt:MouseEvent = null):void
		{
			value = (drag_mc.y - min) / max;
			
			if(_textField && evt)
			{
				_textField.y = Math.ceil(value * (max - _textField.height) + this.y);
				
				
			}
			
			dispatchEvent(new Event(Event.CHANGE));
			
			
		}
		
		public function set textField(tf:MovieClip):void
		{
			_textField = tf;
			
			
			
		}
		
		public function get textField():MovieClip
		{
			return _textField;
		}

	}

}