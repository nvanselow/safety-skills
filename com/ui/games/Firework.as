package com.ui.games
{
	
	import flash.display.MovieClip;
	
	public class Firework extends MovieClip
	{

		public function Firework()
		{
			// constructor code

			for (var n:uint = 1; n<50; n++)
			{
				var newParticle:Particle = new Particle();
				newParticle.name = "particle" + n;
				newParticle.rotation = RandomNumber(360);
				newParticle.alpha = RandomNumber(10) + 80;
				newParticle.scaleX = Math.random()*(.8+1);
				newParticle.scaleY = Math.random()*(.8+1);
				newParticle.x = 0;
				newParticle.y = 0;
				addChild(newParticle);
				newParticle.gotoAndPlay(RandomNumber(5));

			}

		}

		function RandomNumber(limit:Number):Number
		{
			var randomNumber:Number = Math.floor(Math.random()*(limit+1)+1);
			return randomNumber;
		}

	}

}