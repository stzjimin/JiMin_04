package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class Main extends Sprite
	{	
		private var _loadeButton:Button;
		private var _resourceLoader:ResourceLoader;
		private var _resources:Dictionary = new Dictionary();
		private var _file:File;
		
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
			_file = new File();
			_file = File.documentsDirectory;
			_file.addEventListener(flash.events.Event.SELECT, onClickInputSelectButton);
			var pngFileFilter:FileFilter = new FileFilter("png","*.png");
			_file.browseForOpen("스프라이트시트 오픈",[pngFileFilter]);
		}
		
		private function onClickInputSelectButton(event:flash.events.Event):void
		{
			_file.removeEventListener(flash.events.Event.SELECT, onClickInputSelectButton);
		//	var urlRequest:URLRequest = new URLRequest(decodeURI(_file["url"]));
			var urlRequest:URLRequest = new URLRequest(_file.nativePath);
		//	trace(_file.nativePath);
		//	trace(urlRequest.url);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, onCompleteLoad);
		//	loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, uncaughtError);
			loader.load(urlRequest);
		}
		
		private function onCompleteLoad(event:flash.events.Event):void
		{
			_spriteSheets.push(event.currentTarget.loader.content as Bitmap);
		//	var testImage:Image = new Image(Texture.fromBitmap(event.currentTarget.loader.content as Bitmap));
		//	testImage.width = Bitmap(event.currentTarget.loader.content).width;
		//	testImage.height = Bitmap(event.currentTarget.loader.content).height;
			event.currentTarget.removeEventListener(Event.COMPLETE, onCompleteLoad);
		//	addChild(testImage);
		}
	}
}