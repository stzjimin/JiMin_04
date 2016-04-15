package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import starling.textures.TextureAtlas;

	public class SpriteLoader
	{
		private var _file:File;
		
		private var _spriteSheet:Bitmap;
		private var _xml:XML;
		private var _name:String;
		
		private var _textureAtlas:TextureAtlas;
		private var _completeFunc:Function;
		
		public function SpriteLoader(completeFunc:Function)
		{
			_completeFunc = completeFunc;
			
			_file = new File();
			_file = File.documentsDirectory;
			_file.addEventListener(flash.events.Event.SELECT, onClickInputSelectButton);
			var pngFileFilter:FileFilter = new FileFilter("png","*.png");
			_file.browseForOpen("스프라이트시트 오픈",[pngFileFilter]);
		}
		
		public function get textureAtlas():TextureAtlas
		{
			return _textureAtlas;
		}

		private function onClickInputSelectButton(event:flash.events.Event):void
		{
			_file.removeEventListener(flash.events.Event.SELECT, onClickInputSelectButton);
			//	var urlRequest:URLRequest = new URLRequest(decodeURI(_file["url"]));
			var urlRequest:URLRequest = new URLRequest(_file.nativePath);
			//	trace(_file.nativePath);
			//	trace(urlRequest.url);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompletePngLoad);
			//	loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, uncaughtError);
			loader.load(urlRequest);
		}
		
		private function onCompletePngLoad(event:Event):void
		{
			//	var textureAtlas:TextureAtlas = new TextureAtlas(Texture.fromBitmap(event.currentTarget.loader.content as Bitmap));
			_spriteSheet = event.currentTarget.loader.content as Bitmap;
		//	var testImage:Image = new Image(Texture.fromBitmap(event.currentTarget.loader.content as Bitmap));
		//	testImage.width = Bitmap(event.currentTarget.loader.content).width;
		//	testImage.height = Bitmap(event.currentTarget.loader.content).height;
			event.currentTarget.removeEventListener(Event.COMPLETE, onCompletePngLoad);
		//	addChild(testImage);
			_name = _file.nativePath.replace(".png");
			
			var urlRequest:URLRequest = new URLRequest(_file.nativePath.replace("png","xml"));
			trace(urlRequest.url);
			var xmlLoader:URLLoader = new URLLoader();
			xmlLoader.addEventListener("complete", onCompleteXmlLoad);
			xmlLoader.load(urlRequest);
		}
		
		private function onCompleteXmlLoad(event:Event):void
		{
		//	trace(event.currentTarget.data);
			_xml = new XML(event.currentTarget.data);
			event.currentTarget.removeEventListener("complete", onCompleteXmlLoad);
			//	trace(textureAtlas.getFrame("iu3").x + ", " + textureAtlas.getFrame("iu3").y + ", " + textureAtlas.getFrame("iu3").width + ", " + textureAtlas.getFrame("iu3").height);
			//	trace(textureAtlas.getRegion("iu3"));
			_completeFunc(_xml.attribute("ImagePath"), _spriteSheet, _xml);
		}
	}
}