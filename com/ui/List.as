package com.ui
{
	//import com.ui.ScrollBar;
	import flash.display.*;
	import flash.events.*;

	public class List extends MovieClip
	{
		public var items:Array = [];
		public var currentValue:String;
		public var currentID:int;
		//public var scrollbar:ScrollBar = scrollbar_mc;

		private var _rowHeight:uint = 4;
		private var listItemContainer:MovieClip;
		

		public function List()
		{
			// constructor code

			/*liMask = new Sprite();
			addChild(liMask);*/
			listItemContainer = new MovieClip();
			addChild(listItemContainer);
			addChild(border_mc);
			addChild(scrollbar_mc);
			
			
			
			//This can remove background shape if desired
			/*for (var i:uint = 0; i < numChildren; i++)
			{
				if (getChildAt(i) is Shape)
				{
					removeChild(getChildAt(i));
				}
			}*/

		}
		
		/*public function draw(w:Number, h:Number):void
		{
			scaleX = scaleY = 1;
			scrollbar = scrollbar_mc;
			scrollbar.y = 0;
			scrollbar.x = w - scrollbar.width;
			scrollbar.height = items[0].height * _rowHeight;
			scrollbar.draw(w, scrollbar.height);
			addChild(scrollbar);
			
			scrollbar.addEventListener(Event.CHANGE, updateListScroll);
			
			width = w;
			height = items[0].height * items.length;
			
			liMask.graphics.beginFill(0x000000, 1);
			liMask.graphics.drawRect(0, 0, w, items[0].height * _rowHeight);
			liMask.graphics.endFill();
			for(var i:uint = 0; i < items.length; i++)
			{
				items[i].draw(width);
				
			}
			
			listItemContainer.mask = liMask;
		}*/
		
		public function addItem(l:String, id:uint = 0):void
		{
			var item:ListItem = new ListItem();
			item.y = items.length * item.height;
			item.label = l;
			item.id = id;
			listItemContainer.addChild(item);
			item.addEventListener(MouseEvent.CLICK, handleClick);
			items.push(item);
			
			if(items.length > _rowHeight)
			{
				scrollbar_mc.textField = listItemContainer;
			}
			
			bg_mc.width = item.width - 35;
			scrollbar_mc.x = bg_mc.x + bg_mc.width;
			liMask_mc.width = bg_mc.width + scrollbar_mc.width;
			liMask_mc.x = bg_mc.x - 1;
			liMask_mc.y = bg_mc.y;
			liMask_mc.height = bg_mc.height + 1;
			border_mc.width = bg_mc.width;
			border_mc.height = bg_mc.height + 5;
			border_mc.x = bg_mc.x;
			border_mc.y = bg_mc.y;
			
			
			//draw(item.width, height);
			
			//embeds if else statement
			
			//scrollbar.visible = (items.length > _rowHeight);
			
		}
		
		private function handleClick(evt:MouseEvent):void
		{
			var item:ListItem;
			for(var i:uint = 0; i < items.length; i++)
			{
				item = items[i];
				item.upState();
			}
			item = ListItem(evt.currentTarget);
			item.downState();
			currentValue = item.label;
			currentID = item.id;
			dispatchEvent(new Event(Event.CHANGE));

		}
		
		public function set rowHeight(h:uint):void
		{
			_rowHeight = rowHeight
			//draw(width, height / _rowHeight);
		}
		
		public function get rowHeight():uint
		{
			return _rowHeight;
		}
		
		/*private function updateListScroll(event:Event):void
		{
			listItemContainer.y = scrollbar.value * (liMask.height - listItemContainer.height);
			listItemContainer.mask = liMask;
		}
*/
	}

}