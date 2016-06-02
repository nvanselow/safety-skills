package com.StudyTwo
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import flash.xml.*;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import com.StudyTwo.Lesson;
	import com.StudyTwo.Click;
	import com.StudyTwo.Student;

	public class ExportData extends EventDispatcher
	{

		private var _fileNum:int;
		private var s:Student;

		public function ExportData()
		{
			// constructor code
		}

		public function Export(student:Student):void
		{
			s = student;
			ExportSummary();
			ExportClicks();
			this.dispatchEvent(new Event(Event.COMPLETE));
		}

		private function ExportSummary():void
		{
			var lessonString:String = "<Lessons>";

			for (var i:int = 0; i < s.Lessons.length; i++)
			{
				var l:Lesson = s.Lessons[i];
				lessonString += "<Lesson><Name>" + l.Name + "</Name>" +
				"<Type>" + l.Type + "</Type>" +
				"<Percentage>" + l.Percentage() + "</Percentage>" +
				"<PercentagePrompted>" + l.PercentagePrompted() + "</PercentagePrompted>" +
				"<Correct>" + l.NumCorrect + "</Correct>" +
				"<Prompted>" + l.NumPrompted + "</Prompted>" +
				"<Total>" + l.NumTotal + "</Total>" +
				"<Points>" + l.Points + "</Points>" +
				"<MasteryPoints>" + l.MasteryPoints + "</MasteryPoints></Lesson>";
			}


			lessonString +=  "</Lessons>";


			var participantXML:XML = <Data>
			<Participant>
			<Name>{s.Name}</Name>
			<Condition>{s.Condition}</Condition>
			</Participant>
			{XML(lessonString)}
			</Data>;;
			_fileNum = 0;
			var file:File;
			file = File.desktopDirectory.resolvePath(s.Name + "_Summary.xml");

			if (file.exists)
			{
				while (file.exists && _fileNum < 100)
				{
					_fileNum++;
					file = File.desktopDirectory.resolvePath(s.Name + "_Summary_" + _fileNum + ".xml");

				}
			}

			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(participantXML.toXMLString());
			stream.close();
		}

		private function ExportClicks():void
		{
			var clickString:String = "<Data><Participant>" + s.Name + "</Participant><Condition>" + s.Condition + "</Condition><Clicks>";
			
			for (var i:int = 0; i < s.Clicks.length; i++)
			{
				var c:Click = s.Clicks[i];
				clickString += "<Click><Time>" + c.Time + "</Time><Description>" + c.Description + "</Description></Click>";
			}
			
			clickString += "</Clicks></Data>"
			
			var participantXML:XML = XML(clickString);
			
			_fileNum = 0;
			var file:File;
			file = File.desktopDirectory.resolvePath(s.Name + "_Clicks.xml");

			if (file.exists)
			{
				while (file.exists && _fileNum < 100)
				{
					_fileNum++;
					file = File.desktopDirectory.resolvePath(s.Name + "_Clicks_" + _fileNum + ".xml");

				}
			}

			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(participantXML.toXMLString());
			stream.close();
		}







	}

}