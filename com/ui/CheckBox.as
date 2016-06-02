package com.ui
{

	import flash.display.*;
	import flash.events.*;

	public class CheckBox extends MovieClip
	{

		var _isChecked:Boolean = false;
		public const NORMAL:String = "Normal";
		public const LARGE:String = "Large";
		public const SHADOW:String = "Shadow";

		public function CheckBox()
		{
			// constructor code
			buttonMode = true;
			check_mc.visible = _isChecked;
			checkshadow_mc.gotoAndStop(SHADOW);
			checkshadow_mc.visible = false;

			//Just added 03/29/11
			this.cacheAsBitmap = true;
			
			//addEventListener(MouseEvent.CLICK, updateChecked);
			//addEventListener(MouseEvent.ROLL_OVER, enlargeCheck);

		}

		public function updateChecked(evt:MouseEvent = null):void
		{
			_isChecked = !_isChecked;
			changeCheckBox();

		}
		
		private function changeCheckBox():void
		{
			if (_isChecked == true)
			{
				check_mc.gotoAndStop(LARGE);
				check_mc.visible = true;
				checkshadow_mc.visible = false;
			}
			else
			{
				check_mc.visible = false;
				checkshadow_mc.visible = true;
			}
		}

		public function set isChecked(checked:Boolean):void
		{
			_isChecked = checked;
			check_mc.visible = _isChecked;
			changeCheckBox();
			dispatchEvent(new Event(Event.CHANGE));
		}

		public function get isChecked():Boolean
		{
			return _isChecked;
		}


		public function enlargeCheck(evt:MouseEvent = null):void
		{
			if (_isChecked == true)
			{
				check_mc.gotoAndStop(LARGE);


			}
			else
			{

				checkshadow_mc.visible = true;

			}

			//removeEventListener(MouseEvent.ROLL_OVER, enlargeCheck);
			//addEventListener(MouseEvent.ROLL_OUT, shrinkCheck);
		}

		public function shrinkCheck(evt:MouseEvent = null):void
		{
			check_mc.gotoAndStop(NORMAL);
			checkshadow_mc.visible = false;


			//addEventListener(MouseEvent.ROLL_OVER, enlargeCheck);
			//removeEventListener(MouseEvent.ROLL_OUT, shrinkCheck);
		}

	}

}