package com.ui.games
{

	import flash.display.*;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import fl.video.VideoEvent;
	import com.ui.newVideoPlayer;

	public class ChoiceArray extends MovieClip
	{

		//Paths for videos to be loaded
		var _compAPath:String;
		var _compBPath:String;
		var _compCPath:String;
		var _samplePath:String;
		var _selectedVideo:String;

		private var sample:newVideoPlayer;
		private var comparisonA:newVideoPlayer;
		private var comparisonB:newVideoPlayer;
		private var comparisonC:newVideoPlayer;


		public function ChoiceArray()
		{
			// constructor code

			sample = sample_vdo;
			comparisonA = comparisonA_vdo;
			comparisonB = comparisonB_vdo;
			comparisonC = comparisonC_vdo;

			sample.checkbox_mc.isChecked = false;
			sample.checkBoxEnabled = false;

			reset();
			
			comparisonA.addEventListener(MouseEvent.CLICK, compClicked, false, 0, true);
			comparisonB.addEventListener(MouseEvent.CLICK, compClicked, false, 0, true);
			comparisonC.addEventListener(MouseEvent.CLICK, compClicked, false, 0, true);
			

		}
		
		private function compClicked(evt:MouseEvent):void
		{
			
			reset();
			
			newVideoPlayer(evt.currentTarget).checkBox();
			//evt.currentTarget.isChecked = true;
			//evt.currentTarget.showBox();
			_selectedVideo = evt.currentTarget.name;
			
			
			
		}
		
		public function reset():void
		{
			comparisonA.checkbox_mc.isChecked = false;
			comparisonA.hideBox();
			comparisonB.checkbox_mc.isChecked = false;
			comparisonB.hideBox();
			comparisonC.checkbox_mc.isChecked = false;
			comparisonC.hideBox();
			_selectedVideo = "none";
			
		}
		
		public function get selected():String
		{
			return _selectedVideo;
		}
		
		public function set compASource(s:String):void
		{
			_compAPath = s;
			comparisonA.source = _compAPath;
		}
		
		public function get compASource():String
		{
			return _compAPath;
		}
		
		public function set compBSource(s:String):void
		{
			_compBPath = s;
			comparisonB.source = _compBPath;
		}
		
		public function get compBSource():String
		{
			return _compBPath;
		}
		
		public function set compCSource(s:String):void
		{
			_compCPath = s;
			comparisonC.source = _compCPath;
		}
		
		public function get compCSource():String
		{
			return _compCPath;
		}
		
		public function set sampleSource(s:String):void
		{
			_samplePath = s;
			sample.source = _samplePath;
		}
		
		
		public function get sampleSource():String
		{
			return _samplePath;
		}
/*		
		public function set promptAVisible(b:Boolean):void
		{
			promptA.visible = b;
		}
		
		public function set promptBVisible(b:Boolean):void
		{
			promptB.visible = b;
		}

		public function set promptCVisible(b:Boolean):void
		{
			promptC.visible = b;
		}*/

	}

}