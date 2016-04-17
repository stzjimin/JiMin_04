package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class ImageLoader
	{
		private var _completeFunc:Function;
		private var _name:String;
		
		public function ImageLoader(completeFunc:Function)
		{
			_completeFunc = completeFunc;
		}
		
		public function startImageLoad(filePath:String, fileName:String):void
		{
			_name = fileName;
			var urlRequest:URLRequest = new URLRequest(filePath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteImageLoad);
			//	loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, uncaughtError);
			loader.load(urlRequest);
		}
		
		private function onCompleteImageLoad(event:Event):void
		{
			var bitmap:Bitmap = event.currentTarget.loader.content as Bitmap;
			event.currentTarget.removeEventListener(Event.COMPLETE, onCompleteImageLoad);
			var imageInfo:ImageInfo = new ImageInfo();
			imageInfo.name = _name;
			trace(imageInfo.name);
			imageInfo.x = bitmap.x;
			imageInfo.y = bitmap.y;
			imageInfo.width = bitmap.width;
			imageInfo.height = bitmap.height;
			_completeFunc(bitmap, imageInfo);
		}
	}
}