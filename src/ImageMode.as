package
{
	import flash.display.Bitmap;
	import flash.net.FileFilter;
	
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
			_imageSelectBar = new Dropdownbar(150, Texture.fromBitmap(Resource.rasources["dropdown.png"] as Bitmap), Texture.fromBitmap(Resource.rasources["arrowUp.png"] as Bitmap), Texture.fromBitmap(Resource.rasources["arrowDown.png"] as Bitmap));
			_imageSelectBar.y = 10;
			_imageSelectBar.addEventListener("ListChange", onChangeImage);
			
			_imageAddButton = new ButtonObject(Texture.fromBitmap(Resource.rasources["imageAdd.png"] as Bitmap));
			_imageAddButton.width = 40;
			_imageAddButton.height = 40;
			_imageAddButton.x = 170;
			_imageAddButton.addEventListener(Event.TRIGGERED, onClickedAddButton);
			
			_imageSaveButton = new ButtonObject(Texture.fromBitmap(Resource.rasources["saveImage.png"] as Bitmap));
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
			for(var i:int = 0; i < _spriteSheet.images.length; i++)
				_imageSelectBar.createList(_spriteSheet.images[i].name);
			_imageSelectBar.refreshList();
		}
		
		private function onChangeImage(event:Event):void
		{
			dispatchEvent(new Event("ImageChange"));
		}
		
		private function onClickedAddButton(event:Event):void
		{
			//	var pngFileFilter:FileFilter = new FileFilter("png","*.png");
			var fileManager:FileIOManager = new FileIOManager();
			var imageFileFilter:FileFilter = new FileFilter("Images","*.jpg;*.png");
			fileManager.selectFile("이미지를 선택하세요", imageFileFilter, onLoadedImage);
		}
		
		private function onLoadedImage(filePath:String):void
		{
			trace(filePath);
		}
		
		private function onClickedSaveButton(event:Event):void
		{
			var fileManager:FileIOManager = new FileIOManager();
			fileManager.saveFile("이미지 저장", onCompleteSave);
		}
		
		private function onCompleteSave(filePath:String):void
		{
			trace(filePath);
		}
	}
}