package Component
{	
	import Util.CustomizeEvent;
	
	import starling.events.Event;
	import starling.textures.Texture;

	public class RadioButton extends ButtonObject
	{	
		private var _key:String;
		private var _radioState:Boolean;
		
		private var _manager:RadioButtonManager;
		
		private var _emptyButtonTexture:Texture;
		private var _checkButtonTexture:Texture;
		
		/**
		 *라디오버튼에 대한 클래스입니다.
		 * 기본적으로 RadioButton은 ButtonObject를 상속해서 버튼의 속성을 띄게됩니다.
		 * 기존의 버튼과 차이점은 각 라디오버튼별로 key값을 가지고 radioState를 가지게됩니다.
		 * radioState가 true일 때는 해당 버튼이 눌려져있는 상태이고
		 * radioState가 false일 때는 해당버튼이 눌려져있지 않은 상태입니다.
		 * @param upState
		 * @param key
		 * 
		 */		
		public function RadioButton(emptyButtonTexutre:Texture, checkButtonTexture:Texture, key:String)
		{
			_key = key;
			_radioState = false;
			
			_emptyButtonTexture = emptyButtonTexutre;
			_checkButtonTexture = checkButtonTexture;
			
			super(emptyButtonTexutre);
			this.addEventListener(Event.TRIGGERED, onClick);
			this.addEventListener(CustomizeEvent.RadioButtonUnClick, onUnClick);
		}
		
		public function get manager():RadioButtonManager
		{
			return _manager;
		}

		public function set manager(value:RadioButtonManager):void
		{
			_manager = value;
		}

		private function onClick(event:Event):void
		{	
			if(!_manager)
				return;
			
			if(!_radioState)
			{
				this.buttonTexture = _checkButtonTexture;
				this.setStateTexture(_checkButtonTexture);
				_radioState = true;
				
				_manager.dispatchEvent(new Event(CustomizeEvent.RadioButtonClick, false, this));
			}
		}
		
		private function onUnClick(event:Event):void
		{
			_radioState = false;
			this.buttonTexture = _emptyButtonTexture;
			this.setStateTexture(_emptyButtonTexture);
		}
		
		public function get radioState():Boolean
		{
			return _radioState;
		}
		
		public function set radioState(value:Boolean):void
		{
			_radioState = value;
		}
		
		public function get key():String
		{
			return _key;
		}
	}
}