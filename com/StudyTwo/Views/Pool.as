package com.StudyTwo.Views
{
	import flash.display.MovieClip;
	import com.StudyTwo.Student;
	import com.StudyTwo.Lesson;
	import com.StudyTwo.Views.Main;
	import flash.events.Event;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.MouseEvent;
	import com.StudyTwo.Particle;
	import flash.filters.BlurFilter;

	public class Pool extends MovieClip
	{

		private var currentvideo:int = 0;
		private var t:Timer = new Timer(2500,0);
		private var waterheight:int = 0;

		private var particles:Array = new Array();
		private var framecount:int = 0;

		public function Pool()
		{
			// constructor code
			trace("constructing pool");
		}

		public function Start():void
		{
			trace("starting pool screen...");
			this.addEventListener(Event.ENTER_FRAME, init);
			this.gotoAndPlay("enter");

		}

		private function init(event:Event):void
		{
			if (this.currentFrameLabel == "normal")
			{
				this.removeEventListener(Event.ENTER_FRAME, init);
				diver_mc.gotoAndPlay("think");

				video_mc.addEventListener(Event.COMPLETE, endVideo);
				if (currentvideo < Main(this.parent).student.CurrentLesson.Videos.length)
				{
					trace("Video: " + Main(this.parent).student.CurrentLesson.Videos[currentvideo].Path);
					video_mc.source = Main(this.parent).student.CurrentLesson.Videos[currentvideo].Path;
					video_mc.playVideo();
				}
				else
				{
					CheckWater();
				}

			}
		}

		private function endVideo(event:Event):void
		{
			CheckWater();
		}

		private function CheckWater():void
		{
			//Get water height by dividing current lesson by total lessons
			//Always start water at frame 5, add frames depending on number of lessons (50 is total frames)
			trace("Current lesson: " + Main(this.parent).student._CurrentLesson + "  Total lessons: " + (Main(this.parent).student.Lessons.length - 1));
			waterheight = Math.round(((Main(this.parent).student._CurrentLesson / (Main(this.parent).student.Lessons.length - 1)) 
			 * 45) + 5);

			pool_mc.addEventListener(Event.ENTER_FRAME, PlayWater);
			MovieClip(pool_mc).play();
		}

		private function PlayWater(event:Event):void
		{
			if (MovieClip(pool_mc).currentFrame >= waterheight)
			{
				pool_mc.stop();
				pool_mc.removeEventListener(Event.ENTER_FRAME, PlayWater);

				//If water is full, show dive button
				//Else start the timer to exit
				if (waterheight >= 50)
				{
					trace("water reached height");
					this.gotoAndPlay("show_dive");
					dive_btn.addEventListener(MouseEvent.CLICK, dive);
				}
				else
				{
					t.addEventListener(TimerEvent.TIMER, tick);
					t.start();
				}
			}
		}

		private function dive(event:MouseEvent):void
		{
			dive_btn.removeEventListener(MouseEvent.CLICK, dive);
			dive_btn.visible = false;
			diver_mc.addEventListener(Event.ENTER_FRAME, DoneDiving);
			diver_mc.gotoAndPlay("dive");
		}

		private function DoneDiving(event:Event):void
		{
			if (diver_mc.currentFrameLabel == "end")
			{
				diver_mc.removeEventListener(Event.ENTER_FRAME, DoneDiving);
				finalexit();
			}
		}

		private function tick(event:TimerEvent):void
		{
			t.removeEventListener(TimerEvent.TIMER, tick);
			t.stop();

			exit();
		}

		private function exit():void
		{
			this.addEventListener(Event.ENTER_FRAME, end);
			this.gotoAndPlay("exit");
		}

		private function finalexit():void
		{
			this.addEventListener(Event.ENTER_FRAME, end);
			this.gotoAndPlay("finalexit");
		}

		private function end(event:Event):void
		{
			if (this.currentFrameLabel == "end")
			{
				this.stop();
				this.removeEventListener(Event.ENTER_FRAME, end);
				this.dispatchEvent(new Event(Event.COMPLETE));
			}
		}

		public function StartSplash():void
		{
			trace("start splash");
			addEventListener(Event.ENTER_FRAME, frameLoop);
		}

		private function frameLoop(event:Event):void
		{
			trace("running particles");
			var particle:WaterParticle;

			// loop through the array of particles and update each one
			for (var i : int = 0; i < particles.length; i++)
			{
				// update the particle at index i
				particles[i].update();
			}

			if (framecount < 10)
			{
				// make a new particle
				for (var n:int = 0; n < 8; n++)
				{
					particle = new WaterParticle(Spark, this, 540, 375);
					//var particle:Particle = new Particle(Spark, this, -217, 815);
					//particle.MakeParticle(Spark, this, -217, 815);
					//particle = new Particle();

					// set our particle's velocity
					particle.xVel = particle.randRange(-10,10);
					particle.yVel = particle.randRange(-25,-5);

					// add drag
					particle.drag = 0.97;
					// add gravity
					particle.gravity = 0.7;

					// randomise initial particle size
					particle.clip.scaleX = particle.clip.scaleY = particle.randRange(0.5,3);
					// add shrink
					particle.shrink = .98;
					// add fade 
					particle.fade = .001;


					// and add it to the array of particles
					particles.push(particle);
				}
			}

			// if there are more than 60 particles delete the first 
			// one in the array... 
			while (particles.length>100)
			{
				particle = particles.shift();
				particle.destroy();

			}

			framecount++;

			if (framecount > 80)
			{
				removeEventListener(Event.ENTER_FRAME, frameLoop);

				while (particles.length > 0)
				{
					particle = particles.shift();
					particle.destroy();
				}
			}
		}


	}

}