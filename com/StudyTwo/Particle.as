package 
{

	import flash.display.DisplayObjectContainer;
	import flash.display.DisplayObject;

	public class Particle
	{

		public var clip:DisplayObject;

		public var xVel:Number = 0;
		public var yVel:Number = 0;

		public var drag:Number = 1;

		public var gravity:Number = 0;

		public var shrink:Number = 1;
		public var fade:Number = 0;

		public function Particle(symbolclass:Class, target:DisplayObjectContainer, xpos:Number, ypos:Number)
		{
			// constructor code

			//Make the particle clip
			clip = new symbolclass();

			//add it to the target (usually the stage)
			target.addChild(clip);

			//Move to starting position
			clip.x = xpos;
			clip.y = ypos;
		}

		public function update():void
		{
			clip.x +=  xVel;
			clip.y +=  yVel;

			//apply drag
			xVel *=  drag;
			yVel *=  drag;

			yVel +=  gravity;

			clip.scaleX *=  shrink;
			clip.scaleY *=  shrink;

			clip.alpha -=  fade;
		}

		public function randRange(max:Number, min:Number):Number
		{
			return Math.random()*(max-min)+min;
		}

		public function destroy():void
		{
			clip.parent.removeChild(clip);
		}

	}

}