package
{	
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import starling.textures.Texture;

	public class RadioButtonManager extends EventDispatcher
	{	
		private var _radioButtons:Array;
		private var _mode:String;
		
		private var _emptyButtonTexture:Texture;
		private var _checkButtonTexture:Texture;
		
		public function RadioButtonManager(emptyButtonTexture:Texture, checkButtonTexture:Texture)
		{
			_radioButtons = new Array();
			
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

		public function createButton(key:String):RadioButton
		{
			var button:RadioButton = new RadioButton(_emptyButtonTexture, key);
			button.addEventListener(Event.TRIGGERED, onClickButton);
			_radioButtons.push(button);
			return button;
		}
		
		public function onClickButton(event:Event):void
		{
			if(!RadioButton(event.currentTarget).radioState)
			{
				_mode = RadioButton(event.currentTarget).key;
			//	trace(_mode);
				for(var i:int = 0; i < _radioButtons.length; i++)
				{
					_radioButtons[i].radioState = false;
					_radioButtons[i].upState = _emptyButtonTexture;
					_radioButtons[i].setStateTexture(_emptyButtonTexture);
				}
				RadioButton(event.currentTarget).upState = _checkButtonTexture;
				RadioButton(event.currentTarget).setStateTexture(_checkButtonTexture);
				RadioButton(event.currentTarget).radioState = true;
				dispatchEvent(new Event("ModeChange"));
			}
		}
	}
}