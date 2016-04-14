package
{
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Display extends DisplayObjectContainer
	{
		private const AnimationMode:String = "Animation";
		private const ImageMode:String = "Image";
		
		private var _content:Sprite;
		private var _mode:String = AnimationMode;
		private var _spriteSheet:SpriteSheet;
		private var _spriteTexture:Texture;
		private var _spriteImage:Image;
		
		public function Display()
		{
			_content = new Sprite();
		//	_content.width = this.width;
		//	_content.height = this.height;
			addChild(_content);
		}
		
		public function get spriteSheet():SpriteSheet
		{
			return _spriteSheet;
		}

		public function set spriteSheet(value:SpriteSheet):void
		{
			_spriteSheet = value;
			_spriteTexture = Texture.fromBitmap(value.spriteBitmap);
		}

		public function get mode():String
		{
			return _mode;
		}

		/**
		 *디스플레이모드의 디폴트는 "Animation"입니다. 
		 * @param value
		 * 
		 */		
		public function set mode(value:String):void
		{
			if(value == "Animation" || value == "animation" || value == "ANIMATION")
				_mode = AnimationMode;
			else if(value == "Image" || value == "image" || value == "IMAGE")
				_mode = ImageMode;
			else
				_mode = AnimationMode;
		}
		
		public function viewSprite():void
		{
		//	_spriteImage = new Image(_spriteTexture);
		//	_spriteImage.width = 540;
		//	_spriteImage.height = 890;
			var testImage:Image = new Image(_spriteSheet.subTextures["iu3"]);
		//	var testImage2:Image = new Image(_spriteSheet.subTextures["iu2"]);
		//	trace(_spriteSheet.subTextures["iu3"]);
			_content.addChild(testImage);
		//	_content.addChild(testImage2);
		}
	}
}