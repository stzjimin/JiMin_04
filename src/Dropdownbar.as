package
{
	import flash.display.Bitmap;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class Dropdownbar extends DisplayObjectContainer
	{
		private var _list:Vector.<TextField>;
		
		private var _width:int;
		private var _listHeight:int;
		private var _listY:int;
		
		private var _dropButton:ButtonObject;
		private var _currentList:TextField;
		private var _selected:int;
		private var _currentView:int;
		
		private var _backGround:Quad;
		private var _upButton:ButtonObject;
		private var _downButton:ButtonObject;
		private var _content:Sprite;
		
		public function Dropdownbar(width:int)
		{
			_selected = 0;
			_list = new Vector.<TextField>();
			
			_width = width;
			
			_listHeight = 20;
			_listY = _listHeight / 2;
			
			_dropButton = new ButtonObject(Texture.fromBitmap(Resource.rasources["dropdown.png"] as Bitmap));
			_dropButton.width = _width / 5;
			_dropButton.height = 20;
			_dropButton.x = _width/5 * 4;
			
			_currentList = new TextField(_width/5*4, 20, "");
			_currentList.border = true;
			
			_backGround = new Quad(width, 80);
			_backGround.alpha = 0.5;
			_backGround.color = Color.SILVER;
			
			_upButton = new ButtonObject(Texture.fromBitmap(Resource.rasources["arrowUp.png"] as Bitmap));
			_upButton.width = _width / 5;
			_upButton.height = 40;
			_upButton.x = _width/5 * 4;
			_upButton.addEventListener(Event.TRIGGERED, onClickUpButton);
			
			_downButton = new ButtonObject(Texture.fromBitmap(Resource.rasources["arrowDown.png"] as Bitmap));
			_downButton.width = _width / 5;
			_downButton.height = 40;
			_downButton.x = _width/5 * 4;
			_downButton.y = 40;
			_downButton.addEventListener(Event.TRIGGERED, onClickDownButton);
			
			_content = new Sprite();
			_content.y = 20;
			_content.visible = false;
			_content.addChild(_backGround);
			_content.addChild(_upButton);
			_content.addChild(_downButton);
			
			addChild(_currentList);
			addChild(_dropButton);
			addChild(_content);
		}
		
		public function togleVisible():void
		{
			_content.visible = !_content.visible;
			if(_content.visible)
			{
				_currentView = _selected;
				for(var i:int = 0; i < 4; i++)
				{
					if((_list.length-1) >= _currentView+i)
					{
						_content.addChild(_list[_currentView+i]);
						_list[_currentView+i].y += i*20;
					}
				}
			}
			else
			{
				for(var j:int = _content.numChildren-1; j > 2; j--)
				{
					trace(_content.getChildAt(j));
					_content.getChildAt(j).y = _listY;
					_content.removeChildAt(j);
				}
			}
		}
		
		public function createList(name:String):void
		{
			var list:TextField = new TextField(_width/5*4, _listHeight, name);
			list.name = name;
			list.border = true;
			list.pivotX = list.width / 2;
			list.pivotY = list.height / 2;
			list.x += list.width / 2;
			list.y = _listY;
			list.addEventListener(TouchEvent.TOUCH, onClickList);
			_list.push(list);
		//	trace(_content.getChildIndex(list));
		//	_content.addChild(list);
		}
		
		private function onClickUpButton(event:Event):void
		{
			
		}
		
		private function onClickDownButton(event:Event):void
		{
			
		}
		
		private function onClickList(event:TouchEvent):void
		{
			if(event.getTouch(TextField(event.currentTarget), TouchPhase.BEGAN) != null)
			{
				TextField(event.currentTarget).scale = 0.9;
			//	trace(TextField(event.currentTarget).text);
			}
			
			if(event.getTouch(TextField(event.currentTarget), TouchPhase.ENDED) != null)
			{
				TextField(event.currentTarget).scale = 1.0;
				trace(_content.getChildIndex(TextField(event.currentTarget)));
				_selected = _list.indexOf(TextField(event.currentTarget));
				_currentList = TextField(event.currentTarget);
				togleVisible();
			}
		}
	}
}