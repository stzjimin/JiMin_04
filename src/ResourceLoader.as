package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	import starling.utils.AssetManager;

	public class ResourceLoader
	{
		private const appReg:RegExp = new RegExp(/app:\//);
		
		private var _resources:Dictionary;
		private var _resourcePath:String;
		private var _assetsLoader:AssetManager;
		private var _libName:String;
		
		private var _assetLength:int = 1;
		private var _assetCounter:int = 0;
		
		private var _completeFunc:Function;
		
		public function ResourceLoader(libName:String, completeFunc:Function)
		{
			_completeFunc = completeFunc;
			_libName = libName;
		}
		
		public function loadResource(resources:Dictionary):void
		{
			_resources = resources;
			pushDict(File.applicationDirectory.resolvePath(_libName));
		}
		
		private function pushDict(...rawAssets):void
		{
			if(!rawAssets["isDirectory"])
				_assetLength = _assetLength + rawAssets.length - 1;
			trace(_assetLength);
			for each(var rawAsset:Object in rawAssets)
			{
				if(rawAsset["isDirectory"])
					pushDict.apply(this, rawAsset["getDirectoryListing"]());
				else if(getQualifiedClassName(rawAsset) == "flash.filesystem::File")
				{
					var urlRequest:URLRequest = new URLRequest(decodeURI(rawAsset["url"]));
					var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteLoad);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, uncaughtError);
					loader.load(urlRequest);
				}
			}
		}
		
		/**
		 *이미지파일의 URL주소로 해당 이미지파일의 이름을 구하는 함수 
		 * @param rawAssetURL
		 * @return 
		 * 
		 */		
		private function getName(rawAssetURL:String):String
		{
			var fileName:String;
			
			fileName = rawAssetURL.replace(appReg,"").replace(_libName + "/","");
			
			return fileName;
		}
		
		/**
		 *로더의 IO애러시 호출될 함수 
		 * @param event
		 * 
		 */		
		private function uncaughtError(event:IOErrorEvent):void
		{
			trace("Please Check Directory's File!!");
			event.currentTarget.removeEventListener(Event.COMPLETE, onCompleteLoad);
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, uncaughtError);
			_assetCounter++;
		}
		
		/**
		 *로더가 개별 이미지의 로드를 했을 경우 호출될 함수 
		 * @param event
		 * 호출된 로더를 추적한 뒤 해당 로더가 가지고 있는 url과 content를 이용하여 BitmapImage객체 생성
		 */		
		private function onCompleteLoad(event:Event):void
		{
			_resources[getName(event.currentTarget.url)] = event.currentTarget.loader.content as Bitmap;
		//	trace(getName(event.currentTarget.url) + " = " + _resources[getName(event.currentTarget.url)]);
		//	trace(_resources[getName(event.currentTarget.url)]);
			event.currentTarget.removeEventListener(Event.COMPLETE, onCompleteLoad);
			event.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, uncaughtError);
			_assetCounter++;
			
			trace(_assetCounter + " / " + _assetLength);
			if(_assetCounter == _assetLength)
				_completeFunc();
		}
	}
}