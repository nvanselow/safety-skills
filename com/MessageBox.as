package com
{
	import flash.display.Sprite;

	public class MessageBox extends Sprite
	{

		public function MessageBox()
		{
			// constructor code
			var msgbox:Sprite = new Sprite();

          // drawing a white rectangle
          msgbox.graphics.beginFill(0xFFFFFF); // white
          msgbox.graphics.drawRect(0,0,300,20); // x, y, width, height
          msgbox.graphics.endFill();
 
          // drawing a black border
          msgbox.graphics.lineStyle(2, 0x000000, 100);  // line thickness, line color (black), line alpha or opacity
          msgbox.graphics.drawRect(0,0,300,20); // x, y, width, height
        
          var textfield:TextField = new TextField()
          textfield.text = "Hi there!"

          addChild(msgbox)   
          addChild(textfield)
		}

	}

}