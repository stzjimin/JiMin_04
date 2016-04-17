package
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.PNGEncoderOptions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class ImageMode extends Sprite
	{	
		private var _imageSelectBar:Dropdownbar;
		private var _imageAddButton:ButtonObject;
		private var _imageSaveButton:ButtonObject;
		
		private var _spriteSheet:SpriteSheet;
		
		public function ImageMode()
		{
			_imageSelectBar = new Dropdownbar(150, Texture.fromBitmap(Resource.resources["dropdown.png"] as Bitmap), Texture.fromBitmap(Resource.resources["arrowUp.png"] as Bitmap), Texture.fromBitmap(Resource.resources["arrowDown.png"] as Bitmap));
			_imageSelectBar.y = 10;
			_imageSelectBar.addEventListener("ListChange", onChangeImage);
			
			_imageAddButton = new ButtonObject(Texture.fromBitmap(Resource.resources["imageAdd.png"] as Bitmap));
			_imageAddButton.width = 40;
			_imageAddButton.height = 40;
			_imageAddButton.x = 170;
			_imageAddButton.addEventListener(Event.TRIGGERED, onClickedAddButton);
			
			_imageSaveButton = new ButtonObject(Texture.fromBitmap(Resource.resources["saveImage.png"] as Bitmap));
			_imageSaveButton.width = 40;
			_imageSaveButton.height = 40;
			_imageSaveButton.x = 220;
			_imageSaveButton.addEventListener(Event.TRIGGERED, onClickedSaveButton);
			
			addChild(_imageSelectBar);
			addChild(_imageAddButton);
			addChild(_imageSaveButton);
		}
		
		public function set spriteSheet(value:SpriteSheet):void
		{
			_spriteSheet = value;
			setImages();
		}

		public function get imageSelectBar():Dropdownbar
		{
			return _imageSelectBar;
		}
		
		private function setImages():void
		{
			_imageSelectBar.initList();
			if(_spriteSheet != null)
			{
				for(var i:int = 0; i < _spriteSheet.images.length; i++)
					_imageSelectBar.createList(_spriteSheet.images[i].name);
			}
			_imageSelectBar.refreshList();
		}
		
		private function onChangeImage(event:Event):void
		{
			dispatchEvent(new Event("ImageChange"));
		}
		
		private function onClickedAddButton(event:Event):void
		{
			var fileManager:FileIOManager = new FileIOManager();
			var imageFileFilter:FileFilter = new FileFilter("Images","*.jpg;*.png");
			fileManager.selectFile("이미지를 선택하세요", imageFileFilter, onLoadedImage);
		}
		
		private function onLoadedImage(filePath:String):void
		{
			var imageLoader:ImageLoader = new ImageLoader(onComleteLoad);
			imageLoader.startImageLoad(filePath);
		}
		
		private function onComleteLoad(bitmap:Bitmap):void
		{
			trace("aa");
			var spacePixel:int = 0;
			for(var i:int = 0; i < _spriteSheet.images.length; i++)
				spacePixel += _spriteSheet.images[i].width*_spriteSheet.images[i].height;
			var imagePixel:int = bitmap.width * bitmap.height;
			if(spacePixel >= imagePixel)
			{
				//packer
			}
		}
		
		private function onClickedSaveButton(event:Event):void
		{
			var fileManager:FileIOManager = new FileIOManager();
			fileManager.saveFile("이미지 저장", onCompleteSave);
		}
		
		private function onCompleteSave(filePath:String):void
		{
			trace(filePath);
			var rect:Rectangle = searchImageRect(_imageSelectBar.currentViewList.text);
			trace(rect.x + ", " + rect.y + ", " + rect.width + ", " + rect.height);
			var byteArray:ByteArray = new ByteArray();
			_spriteSheet.spriteBitmap.bitmapData.encode(new Rectangle(rect.x, rect.y, rect.width, rect.height), new PNGEncoderOptions(), byteArray);
			
			var localPngFile:File = File.desktopDirectory.resolvePath(filePath + ".png");
			var fileAccess:FileStream = new FileStream();
			fileAccess.open(localPngFile, FileMode.WRITE);
			fileAccess.writeBytes(byteArray, 0, byteArray.length);
			fileAccess.close();
			dispatchEvent(new Event("CompleteSave"));
		}
		
		private function searchImageRect(subTextureName:String):Rectangle
		{
			var rect:Rectangle = new Rectangle();
			for(var i:int = 0; i < _spriteSheet.images.length; i++)
			{
				if(_spriteSheet.images[i].name == subTextureName)
				{
					rect.x = _spriteSheet.images[i].x;
					rect.y = _spriteSheet.images[i].y;
					rect.width = _spriteSheet.images[i].width;
					rect.height = _spriteSheet.images[i].height;
				}
			}
			return rect;
		}
	}
}