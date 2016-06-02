package com
{

	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	public class LoadingSymbol extends MovieClip
	{

		private var _loader:Loader;
		
		public function LoadingSymbol()
		{
			// constructor code
			visible = false;
			stop();

		}
		
		private function loadStarted(evt:Event):void
		{
			visible = true;
			play();
		}
		
		private function loadFinished(evt:Event):void
		{
			visible = false;
		}
		
		private function fileLoading(evt:ProgressEvent):void
		{
			
			var percent:Number = Math.round((evt.bytesLoaded/evt.bytesTotal)*100);
			load_txt.text = percent + "%";
			
			
		}
		
		public function set loader(l:Loader):void
		{
			
			_loader = l;
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, fileLoading);
			_loader.contentLoaderInfo.addEventListener(Event.OPEN, loadStarted);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadFinished);
			
		}
		
		public function get loader():Loader
		{
			return _loader;
		}
		
		public function set loadPercent(p:String):void
		{
			load_txt.text = p + "%";
		}
		
		public function get loadPercent():String
		{
			return load_txt.text;
		}
		
		

	}

}