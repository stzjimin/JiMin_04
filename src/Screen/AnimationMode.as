package Screen
{
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import Component.ButtonObject;
	import Data.Resource;
	import Util.CustomizeEvent;

	public class AnimationMode extends Sprite
	{	
		private var _startButton:ButtonObject;
		private var _stopButton:ButtonObject;
		private var _deleteButton:ButtonObject;
		
		public function AnimationMode()
		{	
			_startButton = new ButtonObject(Texture.fromBitmap(Resource.resources["start.png"] as Bitmap));
			_startButton.width = 64;
			_startButton.height = 64;
			_startButton.x = 20;
			_startButton.addEventListener(Event.TRIGGERED, onClickStartButton);
			
			_stopButton = new ButtonObject(Texture.fromBitmap(Resource.resources["stop.png"] as Bitmap));
			_stopButton.width = 64;
			_stopButton.height = 64;
			_stopButton.x = 90;
			_stopButton.addEventListener(Event.TRIGGERED, onClickStopButton);
			
			_deleteButton = new ButtonObject(Texture.fromBitmap(Resource.resources["delete.png"] as Bitmap));
			_deleteButton.width = 64;
			_deleteButton.height = 64;
			_deleteButton.x = 160;
			_deleteButton.addEventListener(Event.TRIGGERED, onClickDeleteButton);
			
			addChild(_startButton);
			addChild(_stopButton);
			addChild(_deleteButton);
		}
		
		private function onClickStartButton(event:Event):void
		{
			dispatchEvent(new Event(CustomizeEvent.AnimationStart));
		}
		
		private function onClickStopButton(event:Event):void
		{
			dispatchEvent(new Event(CustomizeEvent.AnimationStop));
		}
		
		private function onClickDeleteButton(event:Event):void
		{
			dispatchEvent(new Event(CustomizeEvent.SpriteDelete));
		}
	}
}