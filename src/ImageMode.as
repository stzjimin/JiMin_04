package
{
	import flash.display.Bitmap;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;

	public class ImageMode extends Sprite
	{
		private var _imageSelectBar:Dropdownbar;
		private var _imageAddButton:ButtonObject;
		
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
			
			addChild(_imageSelectBar);
			addChild(_imageAddButton);
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
	}
}