package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

	public class ImageLoader
	{
		private var _completeFunc:Function;
		
		public function ImageLoader(completeFunc:Function)
		{
			_completeFunc = completeFunc;
		}
		
		public function startImageLoad(filePath:String):void
		{
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
			_completeFunc(bitmap);
		}
	}
}