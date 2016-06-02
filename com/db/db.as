package com.db
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.SQLEvent;
	import flash.events.SQLErrorEvent;
	import flash.data.SQLConnection;
	import flash.filesystem.File;
	import flash.errors.SQLError;
	import flash.data.SQLStatement;
	import flash.data.SQLResult;
	import fl.controls.ComboBox;
	import fl.controls.List;
	import fl.data.DataProvider;
	import fl.managers.StyleManager;
	import flash.text.TextFormat;
	import fl.controls.TileList;
	import com.Student;
	import com.Lesson;
	import flash.net.FileReference;

	public class db extends MovieClip
	{
		private var dbConn:SQLConnection = new SQLConnection();
		private var dbFile:File;
		var _dataArray:DataProvider = new DataProvider  ;
		var _list:List;
		var _tilelist:TileList;
		var _friends:Array;
		var _student:Student;
		var _lessons:Array;

		public function db()
		{

			dbFile = new File("app-storage:/safetyskills.db");
			init();
		}

		//------ DATABASE CODE -------------------------------------------------------------
		public function init():void
		{
			//add an event handler for the open event
			//dbConn.addEventListener(SQLEvent.OPEN, openHandler);
			//create the database if it doesn't exist, otherwise just opens it;

			dbFile = File.applicationStorageDirectory.resolvePath("safetyskills.db");
			if (! dbFile.exists)
			{
				var newfilelocation:FileReference = dbFile;
				var oldFile:File = File(File.applicationDirectory.resolvePath("safetyskills.db"));
				oldFile.copyTo(newfilelocation);
			}

			dbConn.openAsync(dbFile);

		}


		function openHandler(event:SQLEvent):void
		{
			//retrieveData();
			//create a new sql statement
			var sql:SQLStatement=new SQLStatement();
			//set the statement to connect to our database
			sql.sqlConnection = dbConn;

			//parse the sql command that creates the table if it doesn't exist
			sql.text = "CREATE TABLE IF NOT EXISTS Locations (ID INTEGER PRIMARY KEY  UNIQUE , SkillID INTEGER NOT NULL REFERENCES Skills(ID) ON UPDATE CASCADE ON DELETE CASCADE , LevelID INTEGER NOT NULL REFERENCES Levels(ID) ON UPDATE CASCADE ON DELETE CASCADE , Note TEXT)";
			//add a new event listener to the sql when it completes creating the table
			//sql.addEventListener(SQLEvent.RESULT,retrieveData);
			//call the execute function to execute our statement
			sql.execute();

			var sqlc:SQLStatement = new SQLStatement();
			sqlc.sqlConnection = dbConn;

			var sqld:SQLStatement = new SQLStatement();
			sqld.sqlConnection = dbConn;

			var sqle:SQLStatement = new SQLStatement();
			sqle.sqlConnection = dbConn;

			var sqlf:SQLStatement = new SQLStatement();
			sqlf.sqlConnection = dbConn;

			var sqlg:SQLStatement = new SQLStatement();
			sqlg.sqlConnection = dbConn;

			var sqlh:SQLStatement = new SQLStatement();
			sqlh.sqlConnection = dbConn;

			var sqli:SQLStatement = new SQLStatement();
			sqli.sqlConnection = dbConn;

			sqlc.text = "CREATE TABLE IF NOT EXISTS Lessons (ID INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE, LessonNum INTEGER NOT NULL, SkillName STRING NOT NULL, LevelName STRING NOT NULL)";
			sqlc.execute();

			sqld.text = "CREATE TABLE IF NOT EXISTS Levels (ID INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , LevelNum INTEGER NOT NULL , Name STRING)";
			sqld.execute();

			sqle.text = "CREATE TABLE IF NOT EXISTS Skills (ID INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , SkillNum INTEGER NOT NULL , Name STRING)";
			sqle.execute();

			sqlf.text = "CREATE TABLE IF NOT EXISTS Scores (ID INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , StudentID INTEGER NOT NULL REFERENCES Student(ID)  ON UPDATE CASCADE ON DELETE CASCADE, LocationID INTEGER NOT NULL REFERENCES Location(ID)  ON UPDATE CASCADE, Attempt INTEGER NOT NULL , Score REAL, Trials INTEGER)";
			sqlf.execute();

			sqlg.text = "CREATE TABLE IF NOT EXISTS People (ID INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , FilePath TEXT NOT NULL , Stranger BOOL NOT NULL )";
			sqlg.execute();

			sqlh.text = "CREATE TABLE IF NOT EXISTS PeopleStudents (ID INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , PeopleID INTEGER NOT NULL REFERENCES People(ID) ON UPDATE CASCADE ON DELETE CASCADE , StudentID INTEGER NOT NULL REFERENCES Students(ID) ON UPDATE CASCADE ON DELETE CASCADE)";
			sqlh.execute();

			sqli.text = "CREATE TABLE IF NOT EXISTS Students (ID INTEGER PRIMARY KEY  AUTOINCREMENT  NOT NULL  UNIQUE , FirstName STRING NOT NULL , LastName STRING, CurrentLocationID INTEGER NOT NULL, ActOut BOOL NOT NULL )";
			sqli.execute();



		}

		function retrieveData(event:SQLEvent = null):void
		{
			//create a new sql statemant
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;
			//this sql command retrieves all the fields from our table in the database and orders it by id
			sql.text = "SELECT ID FROM Students";
			//add a new event listener if there is data to display it
			sql.addEventListener(SQLEvent.RESULT, populateDataGrid);
			sql.execute();
		}


		function populateDataGrid(event:SQLEvent):void
		{
			//then create a result variable that holds result
			var result:SQLResult = event.target.getResult();

			//we check if results is not empty
			if (result != null && result.data != null)
			{
				_dataArray.removeAll();
				for (var i:uint = 0; i < result.data.length; i++)
				{
					_dataArray.addItem({label:result.data[i].FirstName + " " + result.data[i].LastName, data:result.data[i].ID});
				}

				_list.dataProvider = _dataArray;
				//formatList(_list);
				_list.rowHeight = 25;
				//_list.rowCount = 3

			}

		}



		public function getStudentList(evt:SQLEvent = null):void
		{
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;
			sql.text = "SELECT ID, FirstName, LastName FROM Students";
			sql.addEventListener(SQLEvent.RESULT, populateDataGrid);
			try
			{
				sql.execute();
			}
			catch (errObject:Error)
			{
				trace(errObject.message);
				
			}


		}

		public function createStudent(f:String, l:String, act:Boolean):void
		{
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;

			if (f != "" && l != "")
			{
				sql.text = "INSERT INTO Students(FirstName,LastName,CurrentLocationID,ActOut) VALUES (@FirstName, @LastName, 0, @ActOut)";
				sql.parameters["@FirstName"] = f;
				sql.parameters["@LastName"] = l;
				sql.parameters["@ActOut"] = act;
				sql.addEventListener(SQLEvent.RESULT, getStudentList);
				sql.execute();

			}
		}

		public function deleteStudent():void
		{
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;

			if (_list.selectedIndex != -1)
			{
				sql.text = "DELETE FROM Students WHERE ID=" + _list.selectedItem.data;
				sql.addEventListener(SQLEvent.RESULT, getStudentList);
				sql.execute();
			}

		}

		public function getFriends(evt:SQLEvent = null):void
		{
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;

			sql.text = "SELECT FilePath FROM People WHERE Stranger=0";
			sql.addEventListener(SQLEvent.RESULT, populateFriendArray);
			sql.execute();
		}

		private function populateFriendArray(evt:SQLEvent):void
		{
			var result:SQLResult = evt.target.getResult();

			_friends = new Array  ;

			if (result != null && result.data != null)
			{
				for (var i:uint = 0; i < result.data.length; i++)
				{
					_friends.push(result.data[i].FilePath);
				}
			}

			dispatchEvent(new Event(Event.COMPLETE));
		}

		public function get friends():Array
		{
			return _friends;
		}


		public function getPeopleList(evt:SQLEvent = null):void
		{
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;

			sql.text = "SELECT ID, FilePath, Stranger FROM People";
			sql.addEventListener(SQLEvent.RESULT, populatePeopleDataGrid);
			sql.execute();

		}

		function populatePeopleDataGrid(event:SQLEvent):void
		{
			//then create a result variable that holds result
			var result:SQLResult = event.target.getResult();

			//we check if results is not empty
			if (result != null && result.data != null)
			{
				_dataArray.removeAll();
				for (var i:uint = 0; i < result.data.length; i++)
				{
					_dataArray.addItem({label:result.data[i].FilePath, source:result.data[i].FilePath, data:result.data[i].ID});
				}

				_tilelist.dataProvider = _dataArray;
				//formatList(_list);
				_tilelist.rowHeight = 100;
				_tilelist.columnWidth = 100;
				//_list.rowCount = 3

			}

		}

		public function createPerson(f:String):void
		{
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;

			if (f != "")
			{
				sql.text = "INSERT INTO People(FilePath,Stranger) VALUES (@FilePath, 0)";
				sql.parameters["@FilePath"] = f;
				sql.addEventListener(SQLEvent.RESULT, getPeopleList);
				sql.execute();

			}
		}

		public function deletePerson():void
		{
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;

			if (_tilelist.selectedIndex != -1)
			{
				sql.text = "DELETE FROM People WHERE ID=" + _tilelist.selectedItem.data;
				sql.addEventListener(SQLEvent.RESULT, getPeopleList);
				sql.execute();
			}

		}

		public function getStudentInfo(ID:int):void
		{
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;

			if (ID)
			{
				sql.text = "SELECT ID, FirstName, LastName, CurrentLocationID, ActOut FROM Students WHERE ID=@ID";
				sql.parameters["@ID"] = ID;
				sql.addEventListener(SQLEvent.RESULT, gotStudentInfo);
				sql.execute();
			}
		}

		private function gotStudentInfo(evt:SQLEvent):void
		{
			var result:SQLResult = evt.target.getResult();
			if (result != null && result.data != null)
			{
				var newStudent:Student = new Student  ;
				newStudent.ID = result.data[0].ID;
				newStudent.FirstName = result.data[0].FirstName;
				newStudent.LastName = result.data[0].LastName;
				newStudent.CurrentLocationID = result.data[0].CurrentLocationID;
				newStudent.ActOut = result.data[0].ActOut;

				_student = newStudent;
			}

			dispatchEvent(new Event(Event.COMPLETE));

		}

		public function newLessonData():void
		{
			trace("start new lesson data");
			var sql:SQLStatement = new SQLStatement();
			sql.sqlConnection = dbConn;
			sql.text = "SELECT LessonNum, SkillName, LevelName FROM Lessons ORDER BY LessonNum";
			sql.addEventListener(SQLEvent.RESULT, gotLessonData);
			sql.execute();
		}

		private function gotLessonData(evt:SQLEvent):void
		{
			trace("Create new array");
			var result:SQLResult = evt.target.getResult();
			if (result != null && result.data != null)
			{

				_lessons = new Array  ;

				for (var i:uint = 0; i < result.data.length; i++)
				{
					var newLesson:Lesson = new Lesson  ;
					newLesson.lessonNum = result.data[i].LessonNum;
					newLesson.skillName = result.data[i].SkillName;
					newLesson.levelName = result.data[i].LevelName;
					newLesson.isComplete = false;

					_lessons.push(newLesson);
				}

				trace("new lesson array = " + _lessons);

			}

			dispatchEvent(new Event(Event.CHANGE));
		}

		public function get student():Student
		{
			return _student;
		}


		public function set list(l:List):void
		{
			_list = l;
		}

		public function get list():List
		{
			return _list;
		}

		public function set tilelist(l:TileList):void
		{
			_tilelist = l;

		}

		public function get tilelist():TileList
		{
			return _tilelist;
		}

		public function get lessons():Array
		{
			return _lessons;
		}


	}


}