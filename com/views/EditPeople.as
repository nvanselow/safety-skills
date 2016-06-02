package com.views
{

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.MovieClip;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import com.db.*;

	public class EditPeople extends MovieClip
	{

		var nextScreen:String;
		var fileRef:File;
		var mydb:db = new db;

		public function EditPeople()
		{
			// constructor code
			
			mydb.tilelist = tilelist_mc;
			mydb.getPeopleList();
			
			btnHome.addEventListener(MouseEvent.CLICK, goHome);
			btnBrowse.addEventListener(MouseEvent.CLICK, browsePerson);
			btnAdd.addEventListener(MouseEvent.CLICK, addPerson);
			btnDelete.addEventListener(MouseEvent.CLICK, deletePerson);

		}

		private function deletePerson(evt:MouseEvent):void
		{
			mydb.deletePerson();
			
		}

		private function addPerson(evt:MouseEvent):void
		{
			if (imagepath_txt.txt.text != "")
			{
				mydb.createPerson(imagepath_txt.txt.text);
			}
			
		}

		private function browsePerson(evt:MouseEvent):void
		{
			fileRef = new File ;
			fileRef.addEventListener(Event.SELECT, selectPerson);
			var myFilter:FileFilter = new FileFilter("Images","*.gif; *.png; *.jpg");
			fileRef.browseForOpen("Person Image",[myFilter]);
		}
		
		private function selectPerson(evt:Event):void
		{
			imagepath_txt.txt.text = fileRef.nativePath;
		}

		private function goHome(evt:MouseEvent):void
		{
			nextScreen = "signin";
			addEventListener(Event.ENTER_FRAME, exitScreen);
			gotoAndPlay("exit_edit_people");
		}


		private function exitScreen(evt:Event):void
		{

			if (currentFrameLabel == "end")
			{
				removeEventListener(Event.ENTER_FRAME, exitScreen);

				switch (nextScreen)
				{
					case "signin" :
						Object(parent).gotoSignIn();
						break;

					case "people" :
						Object(parent).gotoPeople();
						break;

					case "students" :
						Object(parent).gotoEditStudents();
						break;
				}
			}

		}

	}

}