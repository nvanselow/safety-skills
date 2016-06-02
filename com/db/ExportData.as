package com.db
{


	import com.Student;
	import com.LessonData;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;

	import flash.xml.*;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class ExportData extends EventDispatcher
	{

		public function ExportData()
		{



		}

		public function Export(s:Student, Instructions:LessonData, Look:LessonData, Next:LessonData, Order:LessonData, ActOut:LessonData, Target:LessonData, Soccer:LessonData, Water:LessonData, VideoData:LessonData, AllClicks:Array):void
		{
			//Export lesson data
			var lessonData:XML = <Data>
			<Lesson>
			<Name>"Targets"</Name>
			<Correct>{Target.correct}</Correct>
			<Total>{Target.total}</Total>
			<Percentage>{Target.percentageCorrect}</Percentage>
			</Lesson>
			<Lesson>
			<Name>"Soccer"</Name>
			<Correct>{Soccer.correct}</Correct>
			<Total>{Soccer.total}</Total>
			<Percentage>{Soccer.percentageCorrect}</Percentage>
			</Lesson>
			<Lesson>
			<Name>"Water"</Name>
			<Correct>{Water.correct}</Correct>
			<Total>{Water.total}</Total>
			<Percentage>{Water.percentageCorrect}</Percentage>
			</Lesson>
			<Lesson>
			<Name>"Video"</Name>
			<Correct>{VideoData.correct}</Correct>
			<Total>{VideoData.total}</Total>
			<Percentage>{VideoData.percentageCorrect}</Percentage>
			</Lesson>
			<Lesson>
			<Name>"Instructions"</Name>
			<Correct>{Instructions.correct}</Correct>
			<Total>{Instructions.total}</Total>
			<Percentage>{Instructions.percentageCorrect}</Percentage>
			</Lesson>
			<Lesson>
			<Name>"Next"</Name>
			<Correct>{Next.correct}</Correct>
			<Total>{Next.total}</Total>
			<Percentage>{Next.percentageCorrect}</Percentage>
			</Lesson>
			<Lesson>
			<Name>"Order"</Name>
			<Correct>{Order.correct}</Correct>
			<Total>{Order.total}</Total>
			<Percentage>{Order.percentageCorrect}</Percentage>
			</Lesson>
			<Lesson>
			<Name>"ActOut"</Name>
			<Correct>{ActOut.correct}</Correct>
			<Total>{ActOut.total}</Total>
			<Percentage>{ActOut.percentageCorrect}</Percentage>
			</Lesson>
			</Data>;
			var file:File;
			file = File.desktopDirectory.resolvePath("lessondata.xml");

			WriteToFile(file, lessonData, true);

			//Export All Clicks
			var allClickString:String = "<Data>";
			var i:int;
			for (i = 0; i < AllClicks.length; i++)
			{
				allClickString = allClickString + "<Click>" + AllClicks[i].toString() + "</Click>";
				/*if (allClickString)
				{
					allClickString = allClickString + "<Click>" + AllClicks[i].toString() + "</Click>";
				}
				else
				{
					allClickString = "<Click>" + AllClicks[i].toString() + "</Click>";
				}*/
			}
			
			allClickString = allClickString + "</Data>";
			trace("allclicks: " + allClickString);
			var allclickXML:XML = new XML(allClickString);
			var fileB:File = File.desktopDirectory.resolvePath("allclicks.xml");

			WriteToFile(fileB, allclickXML, false);


		}

		private function WriteToFile(file:File, xmlData:XML, lessonData:Boolean):void
		{
			var fileNum:int = 0;
			if (file.exists)
			{
				while (file.exists && fileNum < 100)
				{
					fileNum++;
					if (lessonData)
					{
						file = File.desktopDirectory.resolvePath("lessondata" + fileNum + ".xml");
					}
					else
					{
						file = File.desktopDirectory.resolvePath("allclicks" + fileNum + ".xml");
					}
				}
			}

			var stream:FileStream = new FileStream();
			stream.open(file, FileMode.WRITE);
			stream.writeUTFBytes(xmlData.toXMLString());
			stream.close();
		}

	}

}