package Component
{	
	import flash.utils.Dictionary;
	
	import Util.CustomizeEvent;
	
	import starling.events.Event;
	import starling.events.EventDispatcher;

	public class RadioButtonManager extends EventDispatcher
	{	
		private var _radioButtons:Dictionary;
		
		public function RadioButtonManager()
		{
			_radioButtons = new Dictionary();
			
			this.addEventListener(CustomizeEvent.RadioButtonClick, onClickButton);
		}
			
		/**
		 *RadioButtonManager가 관리하게될 라디오버튼을 추가합니다.
		 * 이 때 같은 키값을 가진 라디오버튼이 존재한다면 동작은 실패합니다. 
		 * @param radioButton
		 * 
		 */		
		public function addButton(radioButton:RadioButton):void
		{
			if(_radioButtons[radioButton.key] != null)
				return;
			
			radioButton.manager = this;
			_radioButtons[radioButton.key] = radioButton;
		}
		
		/**
		 *라디오 매니저가 관리하는 버튼이 클릭이되면 호출되는 함수입니다.
		 * 현재 모드를 해당버튼의 key값으로 변경해주며 원래있었던 모드의 버튼은 눌리지않은 상태로 바꿔줍니다.  
		 * @param event
		 * 
		 */		
		public function onClickButton(event:Event):void
		{	
			for(var key:String in _radioButtons)
			{
				if(_radioButtons[key] != event.data as RadioButton)
					RadioButton(_radioButtons[key]).dispatchEvent(new Event(CustomizeEvent.RadioButtonUnClick));
			}
			
			dispatchEvent(new Event(CustomizeEvent.ModeChange, false, RadioButton(event.data).key));
		}
	}
}