package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PNGEncoderOptions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.utils.ByteArray;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class ImageMode extends Sprite
	{	
		private var _imageSelectBar:Dropdownbar;
		private var _imageAddButton:ButtonObject;
		private var _imageSaveButton:ButtonObject;
		private var _currentSaveButton:ButtonObject;
		
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
			
			_currentSaveButton = new ButtonObject(Texture.fromBitmap(Resource.resources["packing.png"] as Bitmap));
			_currentSaveButton.width = 40;
			_currentSaveButton.height = 40;
			_currentSaveButton.x = 270;
			_currentSaveButton.addEventListener(Event.TRIGGERED, onClickedPackButton);
			
			addChild(_imageSelectBar);
			addChild(_imageAddButton);
			addChild(_imageSaveButton);
			addChild(_currentSaveButton);
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
		
		private function onClickedPackButton(event:Event):void
		{
			var fileManager:FileIOManager = new FileIOManager();
			fileManager.saveFile("스프라이트 시트 저장", onCompleteSaveSheet);
		}
		
		private function onCompleteSaveSheet(filePath:String):void
		{
			var packedData:PackedData = new PackedData(1024, 1024);
			packedData.bitmapData = _spriteSheet.spriteBitmap.bitmapData;
			packedData.packedImageQueue = _spriteSheet.images;
			var encoder:Encoder = new Encoder();
			encoder.setFilePath(filePath);
			encoder.encode(packedData);
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
		
		private function onLoadedImage(filePath:String, fileName:String):void
		{
			var imageLoader:ImageLoader = new ImageLoader(onComleteLoad);
			imageLoader.startImageLoad(filePath, fileName);
			trace(fileName);
		}
		
		private function onComleteLoad(bitmap:Bitmap, imageInfo:ImageInfo):void
		{
			var packer:Packer = new Packer();
			packer.initPacker(_spriteSheet);
			trace(imageInfo.x + ", " + imageInfo.y);
			if(packer.addImage(bitmap, imageInfo))
			{
				_spriteSheet.images.push(imageInfo);
				_spriteSheet.subTextures[imageInfo.name] = Texture.fromBitmap(bitmap);
				_spriteSheet.spriteBitmap.bitmapData = packer.currentPackedData.bitmapData;
				_imageSelectBar.createList(imageInfo.name);
				dispatchEvent(new Event("ImageAdd", false, "Success"));
			}
			else
			{
				dispatchEvent(new Event("ImageAdd", false, "Fail"));
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
			var bitmapData:BitmapData = new BitmapData(rect.width, rect.height);
			var byteArray:ByteArray = new ByteArray();
			bitmapData.copyPixels(_spriteSheet.spriteBitmap.bitmapData, rect, new Point(0, 0));
			bitmapData.encode(new Rectangle(0, 0, rect.width, rect.height), new PNGEncoderOptions(), byteArray);
		//	_spriteSheet.spriteBitmap.bitmapData.encode(new Rectangle(rect.x, rect.y, rect.width, rect.height), new PNGEncoderOptions(), byteArray);
			
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
		
		private function orderPixels(data1:ImageInfo, data2:ImageInfo):int
		{
			if(data1.width*data1.height > data2.width*data2.height) 
			{ 
				return -1;
			} 
			else if(data1.width*data1.height < data2.width*data2.height) 
			{ 
				return 1; 
			} 
			else 
			{ 
				return 0; 
			} 
		}
	}
}