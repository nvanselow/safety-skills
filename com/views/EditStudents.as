package com.views
{

	import flash.display.MovieClip;
	import com.db.*;
	import flash.events.MouseEvent;
	import flash.events.Event;


	public class EditStudents extends MovieClip
	{

		var mydb:db = new db ;
		var nextScreen:String;

		public function EditStudents()
		{
			// constructor code
			btnAdd.addEventListener(MouseEvent.CLICK, addStudent);
			btnDelete.addEventListener(MouseEvent.CLICK, deleteStudent);
			btnHome.addEventListener(MouseEvent.CLICK, goHome);
			btnExport.addEventListener(MouseEvent.CLICK, exportData);
			mydb.list = list_li;
			mydb.getStudentList();
		}

		private function addStudent(evt:MouseEvent):void
		{
			mydb.createStudent(firstName_txt.txt.text, lastName_txt.txt.text, actout_chk.selected);
		}

		private function deleteStudent(evt:MouseEvent):void
		{
			mydb.deleteStudent();
		}

		private function goHome(evt:MouseEvent):void
		{
			nextScreen = "signin";
			addEventListener(Event.ENTER_FRAME, exitScreen);
			gotoAndPlay("exit_edit_students");
		}
		
		private function exportData(evt:MouseEvent):void
		{
			//FIXME: Figure out how to store data within student for future export
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