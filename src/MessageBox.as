package
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.Color;

	public class MessageBox extends Sprite
	{
		private var _messageText:TextField;
		private var _frameCounter:int;
		private var _frameLate:int;
		
		public function MessageBox()
		{
			_messageText = new TextField(200, 30, "");
			addChild(_messageText);
			this.pivotX = this.width / 2;
			this.pivotY = this.height / 2;
			this.x = this.width / 2;
			this.y = this.height / 2;
			_messageText.format.font = "Arial";
			_messageText.format.size = 20;
		}
		
		public function showMessageBox(text:String, frameCount:int, parent:DisplayObjectContainer, color:uint = Color.AQUA):void
		{
			_messageText.format.color = color;
			_messageText.text = text;
			this.x = parent.width / 2;
			this.y = parent.height / 2;
			_frameLate = frameCount;
			_frameCounter = 0;
			_messageText.addEventListener(Event.ENTER_FRAME, onFrameEnter);
			parent.addChild(this);
		}
		
		private function onFrameEnter(event:Event):void
		{
			_frameCounter++;
			if(_frameCounter >= _frameLate)
			{
				_messageText.removeEventListener(Event.ENTER_FRAME, onFrameEnter);
				this.removeFromParent(true);
			}
		}
	}
}