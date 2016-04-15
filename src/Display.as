package
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class Display extends Sprite
	{		
		private var _content:Sprite;
		private var _backGround:Quad;
		
		private var _mode:String = RadioState.ANIMATION;
		private var _spriteSheet:SpriteSheet;
		private var _spriteTexture:Texture;
		private var _spriteImage:Image;
		
		private var _width:int;
		private var _height:int;
		
		public function Display(width:int, height:int)
		{
			_content = new Sprite();
		//	_content.scaleX = _content.scaleY = 1.0;
			
			_width = width;
			_height = height;
			
			_backGround = new Quad(width, height);
			_backGround.color = Color.SILVER;
			
		//	_backGround.scale = 1.1;
		//	trace(this.width);
		//	_content.width = 650;
		//	_content.height = 500;
		//	trace(_content.width);
			addChild(_backGround);
			addChild(_content);
			trace(_content.width);
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
				_mode = RadioState.ANIMATION;
			else if(value == "Image" || value == "image" || value == "IMAGE")
				_mode = RadioState.IMAGE;
			else
				_mode = RadioState.ANIMATION;
		}
		
		public function viewSprite():void
		{
		//	_spriteImage = new Image(_spriteTexture);
		//	_spriteImage.width = 540;
		//	_spriteImage.height = 890;
			var testImage:Image = new Image(_spriteSheet.subTextures["iu3"]);
		//	trace(testImage.width);
		//	var testImage:Image = new Image(Texture.fromBitmap(_spriteSheet.spriteBitmap));
			var testImage2:Image = new Image(_spriteSheet.subTextures["iu2"]);
		//	trace(_spriteSheet.subTextures["iu3"]);
			
			testImage.width = getLocalWidth(testImage.width);
			testImage.height = getLocalHeight(testImage.height);
			
			testImage2.width = getLocalWidth(testImage2.width);
			testImage2.height = getLocalHeight(testImage2.height);
			
		//	testImage2.width = (testImage2.width/100)*_width;
		//	testImage2.height = (testImage2.height/100)*_height;
			
			_content.addChild(testImage);
			_content.addChild(testImage2);
		}
		
		private function getLocalWidth(width:Number):Number
		{
			return width*_width / 1024;
		}
		private function getLocalHeight(height:Number):Number
		{
			return height*_height / 1024;
		}
	}
}