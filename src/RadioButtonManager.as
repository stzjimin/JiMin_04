package
{	
	import flash.utils.Dictionary;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;

	public class RadioButtonManager extends EventDispatcher
	{	
		private var _radioButtons:Dictionary;
		private var _mode:String;
		
		private var _emptyButtonTexture:Texture;
		private var _checkButtonTexture:Texture;
		
		public function RadioButtonManager(emptyButtonTexture:Texture, checkButtonTexture:Texture)
		{
			_radioButtons = new Dictionary();
			
			_emptyButtonTexture = emptyButtonTexture;
			_checkButtonTexture = checkButtonTexture;
		}
		
		public function get mode():String
		{
			return _mode;
		}

		public function set mode(value:String):void
		{
			_mode = value;
		}

		/**
		 *해당 라디오 메니저가 관리하게되는 라디오버튼들을 생성합니다. 
		 * @param key
		 * @return = RadioButton을 리턴해줍니다.
		 * RadioButton은 ButtonObject에서 상속을 받아서 만든 클래스입니다.
		 */		
		public function createButton(key:String):RadioButton
		{
			var button:RadioButton = new RadioButton(_emptyButtonTexture, key);
			button.addEventListener(Event.TRIGGERED, onClickButton);
			_radioButtons[key] = button;
			return button;
		}
		
		public function onClickButton(event:Event):void
		{
			if(!RadioButton(event.currentTarget).radioState)
			{
				_radioButtons[_mode].radioState = false;
				_radioButtons[_mode].upState = _emptyButtonTexture;
				_radioButtons[_mode].setStateTexture(_emptyButtonTexture);
				_mode = RadioButton(event.currentTarget).key;
			//	trace(_mode);
				/*
				for(var i:int = 0; i < _radioButtons.length; i++)
				{
					_radioButtons[i].radioState = false;
					_radioButtons[i].upState = _emptyButtonTexture;
					_radioButtons[i].setStateTexture(_emptyButtonTexture);
				}
				*/
				RadioButton(event.currentTarget).upState = _checkButtonTexture;
				RadioButton(event.currentTarget).setStateTexture(_checkButtonTexture);
				RadioButton(event.currentTarget).radioState = true;
				dispatchEvent(new Event("ModeChange"));
			}
		}
	}
}