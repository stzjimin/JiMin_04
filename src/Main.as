package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class Main extends Sprite
	{	
		private var _loadeButton:Button;
		private var _resourceLoader:ResourceLoader;
		private var _resources:Dictionary = new Dictionary();
		
		private var _spriteSheets:Vector.<Bitmap> = new Vector.<Bitmap>();
		
		public function Main()
		{
			_resourceLoader = new ResourceLoader("GUI_resources", completeResourceLoad);
			_resourceLoader.loadResource(_resources);
		}
		
		private function completeResourceLoad():void
		{
		//	trace(_resources["iu3.jpg"].width);
			/*
			var testImage:Image = new Image(Texture.fromBitmap(_resources["button.png"] as Bitmap));
			testImage.width = _resources["button.png"].width;
			testImage.height = _resources["button.png"].height;
			testImage.x = 20;
			*/
		//	trace(_resources["iu3.jpg"].width);
		//	addChild(testImage);
			var loadButton:Button = new Button(Texture.fromBitmap(_resources["button.png"] as Bitmap));
			loadButton.width = _resources["button.png"].width;
			loadButton.height = _resources["button.png"].height;
			loadButton.addEventListener(Event.TRIGGERED, onClickLoadButton);
			addChild(loadButton);
		}
		
		private function onClickLoadButton(event:Event):void
		{
		//	event.currentTarget.removeEventListener(Event.TRIGGERED, onClickLoadButton);
		//	Button(event.currentTarget).removeFromParent(true);
			var spriteLoader:SpriteLoader = new SpriteLoader(completeLoad);
		}
		
		private function completeLoad(loadAtlas:TextureAtlas):void
		{
			var testImage:Image = new Image(loadAtlas.texture);
			addChild(testImage);
		}
	}
}