package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class AnimationMode extends Sprite
	{
		private var _resources:Dictionary;
		
		private var _startButton:ButtonObject;
		private var _stopButton:ButtonObject;
		private var _deleteButton:ButtonObject;
		
		public function AnimationMode(resources:Dictionary)
		{
			_resources = resources;
			
			_startButton = new ButtonObject(Texture.fromBitmap(_resources["start.png"] as Bitmap));
			_startButton.width = 64;
			_startButton.height = 64;
			_startButton.x = 20;
		//	_startButton.y = 20;
			
			_stopButton = new ButtonObject(Texture.fromBitmap(_resources["stop.png"] as Bitmap));
			_stopButton.width = 64;
			_stopButton.height = 64;
			_stopButton.x = 90;
		//	_stopButton.y = 20;
			
			_deleteButton = new ButtonObject(Texture.fromBitmap(_resources["delete.png"] as Bitmap));
			_deleteButton.width = 64;
			_deleteButton.height = 64;
			_deleteButton.x = 160;
		//	_deleteButton.y = 20;
			
			addChild(_startButton);
			addChild(_stopButton);
			addChild(_deleteButton);
		}
	}
}