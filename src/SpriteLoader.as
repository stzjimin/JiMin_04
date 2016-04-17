package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import starling.textures.TextureAtlas;

	public class SpriteLoader
	{
		private var _spritePath:String;
		
		private var _spriteSheet:Bitmap;
		private var _xml:XML;
		private var _name:String;
		
		private var _textureAtlas:TextureAtlas;
		private var _completeFunc:Function;
		private var _fileManager:FileIOManager;
		
		public function SpriteLoader(completeFunc:Function)
		{
			_completeFunc = completeFunc;
			_fileManager = new FileIOManager();
			var pngFileFilter:FileFilter = new FileFilter("png","*.png");
			_fileManager.selectFile("스프라이트시트 오픈", pngFileFilter, onInputPNG);
		}
		
		public function get textureAtlas():TextureAtlas
		{
			return _textureAtlas;
		}

		private function onInputPNG(filePath:String):void
		{
			_spritePath = filePath;
			var urlRequest:URLRequest = new URLRequest(_spritePath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompletePngLoad);
			//	loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, uncaughtError);
			loader.load(urlRequest);
		}
		
		private function onCompletePngLoad(event:Event):void
		{
			_spriteSheet = event.currentTarget.loader.content as Bitmap;
			event.currentTarget.removeEventListener(Event.COMPLETE, onCompletePngLoad);
			_name = _spritePath.replace(".png");
			
			var urlRequest:URLRequest = new URLRequest(_spritePath.replace("png","xml"));
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener("complete", onCompleteXmlLoad);
			xmlLoader.load(urlRequest);
		}
		
		private function onCompleteXmlLoad(event:Event):void
		{
			_xml = new XML(event.currentTarget.data);
			event.currentTarget.removeEventListener("complete", onCompleteXmlLoad);
			_completeFunc(_xml.attribute("ImagePath"), _spriteSheet, _xml);
		}
	}
}