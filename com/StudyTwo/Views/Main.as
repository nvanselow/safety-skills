package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import flash.events.Event;

	//Import object pool
	import uk.co.bigroom.utils.ObjectPool;
	import com.StudyTwo.Student;
	import flash.filesystem.File;
	import com.StudyTwo.Lesson;
	import com.StudyTwo.SafetyImage;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import com.StudyTwo.SafetyVideo;
	import com.StudyTwo.Trial;
	import com.StudyTwo.ExportData;
	import flash.display.NativeWindow;
	import flash.desktop.NativeApplication;
	import fl.motion.Color;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import com.StudyTwo.Views.GetTeacher;


	public class Main extends MovieClip
	{
		//Screens
		public static const SIGN_IN:String = "sign_in";
		public static const VOLUME:String = "volume";

		public var student:Student = new Student();

		//Holds variable for the symbol mouse
		private var _CursorChosen:Boolean = false;
		private var cursor:Cursor = new Cursor();

		public function Main()
		{
			// constructor code
			addEventListener(Event.ENTER_FRAME, init);
		}

		public function NewMouse(c:Color):void
		{
			if (_CursorChosen == false)
			{
				AddMouse();
			}
			MovieClip(cursor).transform.colorTransform = c;
		}

		private function init(event:Event):void
		{
			
		
	
			
			removeEventListener(Event.ENTER_FRAME, init);

			//Checks throughout for children added to bring mouse symbol to front
			stage.addEventListener(Event.ADDED, ChildAdded);

			//Show sign in screen
			var screen:signIn_scrn = ObjectPool.getObject(signIn_scrn);
			screen.addEventListener(Event.COMPLETE, LoadLessons);
			this.addChild(screen);
		}

		private function LoadLessons(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, LoadLessons);
			this.removeChild(MovieClip(event.target));
			ObjectPool.disposeObject(event.target);

			//Load lessons from xml file;
			var lessonXML:XML;
			var xmlLoader:File;
			trace("condition: " + this.student.Condition);
			
			if (this.student.Condition == Student.ACTOUT)
			{
				trace("ACT XML");
				xmlLoader = File.applicationDirectory.resolvePath("StudyTwoAssets/LessonDataAct.xml");
			}
			else if (this.student.Condition == Student.NOACT)
			{
				trace("NO ACT XML");
				xmlLoader = File.applicationDirectory.resolvePath("StudyTwoAssets/LessonDataNoAct.xml");
			}
			else if (this.student.Condition == Student.STUDYTWO)
			{
				trace("STUDY TWO XML");
				xmlLoader = File.applicationDirectory.resolvePath("StudyTwoAssets/LessonDataTwo.xml");
			}
			else if (this.student.Condition == Student.AWAY)
			{
				trace("Away Game XML");
				xmlLoader = File.applicationDirectory.resolvePath("StudyTwoAssets/Away.xml");
			}
			else if (this.student.Condition == Student.ACTPLUS)
			{
				trace("Act Plus XML");
				xmlLoader = File.applicationDirectory.resolvePath("StudyTwoAssets/LessonDataActPlus.xml");
			}
			else
			{
				trace("GENERIC XML");
				xmlLoader = File.applicationDirectory.resolvePath("StudyTwoAssets/LessonData.xml");
			}



			trace(xmlLoader.nativePath);

			var xmlStream:FileStream = new FileStream();
			xmlStream.open(xmlLoader, FileMode.READ);
			lessonXML = new XML(xmlStream.readUTFBytes(xmlStream.bytesAvailable));
			xmlStream.close();

			//Iterate through all lessons and push to Lesson array in Student variable;
			for (var i:uint = 0; i < lessonXML.Lesson.length(); i++)
			{
				var lFile:File = File.applicationDirectory.resolvePath("StudyTwoAssets/Lessons/" + lessonXML.Lesson[i].Folder + "/");

				trace("FOLDER=   " + lFile.nativePath);
				var l:Lesson = new Lesson();
				trace("i: " + i + "  Lesson: " + lessonXML.Lesson[i].Name +  " Type: " + lessonXML.Lesson[i].Type);
				l.Name = lessonXML.Lesson[i].Name;
				l.Type = lessonXML.Lesson[i].Type;
				l.MasteryPoints = int(lessonXML.Lesson[i].MasteryPoints);

				//Loop through all images and add those

				for (var b:uint = 0; b < lessonXML.Lesson[i].Images.Image.length(); b++)
				{
					var img:SafetyImage = new SafetyImage();
					if (lessonXML.Lesson[i].Images.Image[b].IsSafe == "true")
					{
						img.IsSafe = true;
					}
					else
					{
						img.IsSafe = false;
					}
					img.Type = lessonXML.Lesson[i].Images.Image[b].Type;

					if (img.IsSafe == true)
					{
						trace("this works: " + lFile.resolvePath("Images/Safe/" + lessonXML.Lesson[i].Images.Image[b].Path + ".png").nativePath);
						trace("Image " + b + "  path: " + lFile.resolvePath("Images/Safe/" + lessonXML.Lesson[i].Images.Image[b].Path + ".png").nativePath);
						img.Path = lFile.resolvePath("Images/Safe/" + lessonXML.Lesson[i].Images.Image[b].Path + ".png").nativePath;
						img.HighlightPath = lFile.resolvePath("Images/Safe/" + lessonXML.Lesson[i].Images.Image[b].HighlightPath + ".png").nativePath;

					}
					else
					{
						img.Path = lFile.resolvePath("Images/Unsafe/" + lessonXML.Lesson[i].Images.Image[b].Path + ".png").nativePath;
						img.HighlightPath = lFile.resolvePath("Images/Unsafe/" + lessonXML.Lesson[i].Images.Image[b].HighlightPath + ".png").nativePath;
					}
					trace(img.Path);
					l.AddImage(img);
				}


				for (var c:uint = 0; c < lessonXML.Lesson[i].Videos.Video.length(); c++)
				{
					var vdo:SafetyVideo = new SafetyVideo();
					vdo.Path = lFile.resolvePath("Video/" + lessonXML.Lesson[i].Videos.Video[c].Path + ".flv").nativePath;
					vdo.Type = lessonXML.Lesson[i].Videos.Video[c].Type;
					l.AddVideo(vdo);
				}

				var trFile:File = File.applicationDirectory.resolvePath("StudyTwoAssets/TrialVideo/");
				for (var d:uint = 0; d < lessonXML.Lesson[i].Trials.Trial.length(); d++)
				{
					var tr:Trial = new Trial();
					tr.SampleSource = trFile.resolvePath(lessonXML.Lesson[i].Trials.Trial[d].SampleSource + ".flv").nativePath;
					tr.ComparisonA = trFile.resolvePath(lessonXML.Lesson[i].Trials.Trial[d].ComparisonA + ".flv").nativePath;
					tr.ComparisonB = trFile.resolvePath(lessonXML.Lesson[i].Trials.Trial[d].ComparisonB + ".flv").nativePath;
					tr.ComparisonC = trFile.resolvePath(lessonXML.Lesson[i].Trials.Trial[d].ComparisonC + ".flv").nativePath;
					tr.CorrectComparison = lessonXML.Lesson[i].Trials.Trial[d].CorrectComparison;
					tr.Type = lessonXML.Lesson[i].Trials.Trial[d].Type;
					l.AddTrial(tr);
				}

				student.AddLesson(l);
				//trace("Images: " + student.Lessons[0].Images.length + "   Videos: " + student.Lessons[0].Videos.length);
			}

			trace("lessons added = " + student.Lessons.length);

			//Check volume
			volumecheck();
		}

		private function volumecheck(event:Event = null):void
		{
			var screen:VolumeCheck_scrn = ObjectPool.getObject(VolumeCheck_scrn);
			MovieClip(screen).name = "volume";
			screen.addEventListener(Event.COMPLETE, NextLesson);
			this.addChild(screen);

		}

		private function NextLesson(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, NextLesson);
			this.removeChild(MovieClip(event.target));
			ObjectPool.disposeObject(event.target);

			trace("this is not a volume screen so complete the lesson");
			if (student._CurrentLesson >= 0)
			{
				student.LessonComplete();
			}
			else
			{
				student._CurrentLesson +=  1;
			}


			trace("starting next lesson....");

			if (student.CurrentLesson.Complete == false)
			{
				trace("current lesson is not complete");
				trace("Name: " + student.CurrentLesson.Name + "  Type: " + student.CurrentLesson.Type);
				switch (student.CurrentLesson.Type)
				{
					case Lesson.VIDEO :
						trace("lesson is video");
						//Next lesson is an instruction lesson so show video screen
						var screen:TV_scrn = ObjectPool.getObject(TV_scrn);
						screen.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screen);
						screen.Start();
						break;

					case Lesson.DRAG :
						trace("lesson is drag");
						//Next lesson is a drag game so show drag game screen
						var screenb:Drag_scrn = ObjectPool.getObject(Drag_scrn);
						screenb.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screenb);
						screenb.Start();
						break;

					case Lesson.CHARACTER :
						trace("lesson is character");
						//Next lesson is a character game so show that screen
						var screenc:Character_scrn = ObjectPool.getObject(Character_scrn);
						screenc.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screenc);
						screenc.Start();
						break;

					case Lesson.POOL :
						trace("lesson is a pool");
						var screend:Pool_scrn = ObjectPool.getObject(Pool_scrn);
						screend.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screend);
						screend.Start();
						break;

					case Lesson.NEXT :
						trace("lesson is next game");
						var screene:Next_scrn = ObjectPool.getObject(Next_scrn);
						screene.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screene);
						screene.Start();
						break;

					case Lesson.CLICK :
						trace("lesson is Click/target game");
						var screenf:Target_scrn = ObjectPool.getObject(Target_scrn);
						screenf.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screenf);
						screenf.Start();
						break;

					case Lesson.SOCCER :
						trace("lesson is Drag/Soccer game");
						var screeng:Soccer_scrn = ObjectPool.getObject(Soccer_scrn);
						screeng.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screeng);
						screeng.Start();
						break;

					case Lesson.ORDER :
						trace("lesson is Order game");
						var screenh:Order_scrn = ObjectPool.getObject(Order_scrn);
						screenh.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screenh);
						screenh.Start();
						break;

					case Lesson.ACT :
						trace("lesson is act game");
						var screeni:Act_scrn = ObjectPool.getObject(Act_scrn);
						screeni.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screeni);
						screeni.Start();
						break;

					case Lesson.MOUSE :
						trace("Lesson is mouse choice");
						var screenj:Mouse_scrn = ObjectPool.getObject(Mouse_scrn);
						screenj.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screenj);
						screenj.Start();
						break;
						
					case Lesson.AWAY :
						trace("Lesson is away game");
						var screenk:Away_scrn = ObjectPool.getObject(Away_scrn);
						screenk.addEventListener(Event.COMPLETE, NextLesson);
						this.addChild(screenk);
						screenk.Start();
						break;
				}
			}
			else
			{
				//Save data
				trace("saving data...");
				var e:ExportData = new ExportData();

				e.addEventListener(Event.COMPLETE, DataComplete);
				e.Export(this.student);



			}


		}

		private function DataComplete(event:Event):void
		{
			//End the program
			trace("end of program");

			//Close the game
			NativeWindow(NativeApplication.nativeApplication.openedWindows[0]).close();
		}



		private function AddMouse():void
		{
			stage.addChild(cursor);
			Mouse.hide();
			_CursorChosen = true;
			MovieClip(cursor).mouseEnabled = false;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, CursorMove);
			stage.addEventListener(MouseEvent.RIGHT_CLICK, RightMouse);
		}
		
		private function RightMouse(event:MouseEvent):void
		{
			Mouse.hide();
		}

		private function CursorMove(event:MouseEvent):void
		{
			cursor.x = event.stageX;
			cursor.y = event.stageY;
			event.updateAfterEvent();
		}

		private function ChildAdded(event:Event):void
		{
			if (event.target != cursor && _CursorChosen == true)
			{
				stage.addChild(cursor);
			}
		}


	}

}