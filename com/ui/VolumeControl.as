package com.ui
{

	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.geom.Rectangle;
	import flash.display.FrameLabel;
	import flash.display.MovieClip;

	public class VolumeControl extends MovieClip
	{

		//---- CLASS WIDE VARIABLES AND PROPERTIES -------------------------
		private var _volume:Number = 1;
		private var _maxY:Number = 229;
		private var _minY:Number = 4;
		//Detects if button is being dragged to stop volume control from hiding if the users rolls out of the movieclip
		private var isMouseDown:Boolean = false;
		private var volControl:SoundTransform = SoundMixer.soundTransform;

		private const SHOW_SLIDER:String = "show_slider";
		private const HIDE_SLIDER:String = "hide_slider";
		private const NO_SLIDER:String = "no_slider";
		private const SLIDER:String = "slider";
		private const END_HIDE_SLIDER:String = "end_hide_slider";


		//-----PRIVATE FUNCTIONS AND METHODS ------------------------------
		public function VolumeControl()
		{
			// constructor code
			slidercontrol_mc.slider_btn.addEventListener(MouseEvent.MOUSE_DOWN, startControlDrag);
			speaker_btn.addEventListener(MouseEvent.ROLL_OVER, showSlider);
			gotoAndStop(NO_SLIDER);
			

		}

		private function showSlider(evt:MouseEvent):void
		{
			gotoAndPlay(SHOW_SLIDER);
			addEventListener(Event.ENTER_FRAME, endShowSlider);
			speaker_btn.removeEventListener(MouseEvent.ROLL_OVER, showSlider);
			addEventListener(MouseEvent.ROLL_OUT, hideSlider);
		}

		private function hideSlider(evt:MouseEvent):void
		{
			if (! isMouseDown)
			{
				gotoAndPlay(HIDE_SLIDER);
				addEventListener(Event.ENTER_FRAME, endHideSlider);
				speaker_btn.addEventListener(MouseEvent.ROLL_OVER, showSlider);
				removeEventListener(MouseEvent.ROLL_OUT, hideSlider);
			}
		}

		private function startControlDrag(evt:MouseEvent):void
		{
			isMouseDown = true;
			slidercontrol_mc.slider_btn.startDrag(false, new Rectangle(0, 4, 0, 225));
			slidercontrol_mc.slider_btn.removeEventListener(MouseEvent.MOUSE_DOWN, startControlDrag);
			stage.addEventListener(MouseEvent.MOUSE_UP, stopControlDrag);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, changeVolume);
		}

		private function stopControlDrag(evt:MouseEvent):void
		{
			isMouseDown = false;
			slidercontrol_mc.slider_btn.stopDrag();
			slidercontrol_mc.slider_btn.addEventListener(MouseEvent.MOUSE_DOWN, startControlDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, stopControlDrag);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, changeVolume);
		}

		private function changeVolume(evt:MouseEvent):void
		{

			_volume = 1- ((slidercontrol_mc.slider_btn.y - _minY) / (_maxY - _minY));
			volControl.volume = _volume;
			SoundMixer.soundTransform = volControl;

			dispatchEvent(new Event(Event.CHANGE));
		}

		public function set volume(vol:Number):void
		{
			_volume = vol;

			volControl.volume = _volume;
			SoundMixer.soundTransform = volControl;

			//if volume is changed using setter, update the position of the button on the slider
			slidercontrol_mc.slider_btn.y = 1-((_volume * (_maxY - _minY)) + _minY);

			dispatchEvent(new Event(Event.CHANGE));
		}

		private function endHideSlider(evt:Event):void
		{
			if (currentFrameLabel == END_HIDE_SLIDER)
			{
				gotoAndStop(NO_SLIDER);
			}
		}

		private function endShowSlider(evt:Event):void
		{
			if (currentFrameLabel == SLIDER)
			{
				gotoAndStop(SLIDER);
			}
		}

		//----- PROPERTIES -------------------------------------
		public function get volume():Number
		{
			return _volume;
		}

		public function set maxY(maximumY:Number):void
		{
			_maxY = maximumY;
		}

		public function get maxY():Number
		{
			return _maxY;
		}

		public function set minY(minimumY:Number):void
		{
			_minY = minimumY;
		}

		public function get minY():Number
		{
			return _minY;
		}



	}

}