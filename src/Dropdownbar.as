package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Quad;
	import starling.display.Sprite;
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
		private var _listY:Number;
		
		private var _dropButton:ButtonObject;
		private var _currentList:TextField;
		private var _currentSelected:int;
		
		private var _backGround:Quad;
		private var _content:Sprite;
		
		public function Dropdownbar(width:int)
		{
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
			
			_content = new Sprite();
			_content.y = 20;
			_content.visible = false;
			_content.addChild(_backGround);
			
			addChild(_currentList);
			addChild(_dropButton);
			addChild(_content);
		}
		
		public function togleVisible():void
		{
			_content.visible = !_content.visible;
			if(_content.visible)
			{
			//	_content.addChild(_list[_currentSelected]);
				for(var i:int = 0; i < 4; i++)
				{
					try
					{
						_content.addChild(_list[_currentSelected+i]);
						_list[_currentSelected+i].y += i*20;
					}
					catch(error:Error)
					{
						
					}
				}
				trace("aa");
			}
			else
			{
				for(var j:int = 1; j < 5; j++)
				{
					try
					{
						_content.getChildAt(j).y -= (j-1)*20;
						_content.removeChildAt(j);
					}
					catch(error:Error)
					{
						
					}
				}
				trace("bb");
			//	_currentSelected++;
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
			list.y = _listY / 2;
			list.addEventListener(TouchEvent.TOUCH, onClickList);
			_list.push(list);
		//	_content.addChild(list);
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
				trace(TextField(event.currentTarget).text);
				_currentSelected = _content.getChildIndex(TextField(event.currentTarget));
				_currentList = TextField(event.currentTarget);
				togleVisible();
			}
		}
	}
}