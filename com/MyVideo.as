package  com {
	
	import flash.filesystem.File;
	import flash.events.StorageVolumeChangeEvent;
	
	
	public class MyVideo {

		public function MyVideo() {
			// constructor code
		}
		
		public function Intro(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Intro").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;

		}
		
		public function Act(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Act").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;

		}
		
		public function Classroom(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Classroom").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;
		}
		
		public function Click(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Click").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;
		}
		
		public function Instructions(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Instructions").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;
		}
		
		public function Look(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Look").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;
		}
		
		public function Next(n:String, actout:Boolean):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Next").nativePath;
			
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			
			
			return videoLocation;
		}
				
		public function Order(n:String, actout:Boolean):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Order").nativePath;
			
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			
			return videoLocation;
		}
		
		public function Practice(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Practice_Field").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;
		}
		
		public function Soccer(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Soccer").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;
		}
		
		public function Target(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Target").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;
		}
		
		public function Water(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Water").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;
		}
		
		public function Who(n:String):String
		{
			var videoLocation:String = File.applicationDirectory.resolvePath("assets/video/Who").nativePath;
			videoLocation = videoLocation + "/" +  n + ".flv";
			
			return videoLocation;
		}

	}
	
}
