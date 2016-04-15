package
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class Display extends Sprite
	{		
		private var _content:Sprite;
		private var _backGround:Quad;
		
		private var _mode:String = RadioState.ANIMATION;
		private var _spriteSheet:SpriteSheet;
		private var _spriteTexture:Texture;
		
		private var _width:int;
		private var _height:int;
		
		private var _currentImage:Image;
		private var _currentAnimation:Image;
		
		private var _animationCounter:int;
		
		public function Display(width:int, height:int)
		{
			_content = new Sprite();
			
			_width = width;
			_height = height;
			
			_backGround = new Quad(width, height);
			_backGround.color = Color.SILVER;
			
			_currentImage = new Image(null);
			_currentImage.pivotX = _currentImage.width / 2;
		 	_currentImage.pivotY = _currentImage.height / 2;
			_currentImage.x = _width / 2;
			_currentImage.y = _height / 2;
			_currentImage.width = 1;
			_currentImage.height = 1;
			_currentImage.visible = false;
			
			_currentAnimation = new Image(null);
			_currentAnimation.pivotX = _currentAnimation.width / 2;
			_currentAnimation.pivotY = _currentAnimation.height / 2;
			_currentAnimation.x = _width / 2;
			_currentAnimation.y = _height / 2;
			_currentAnimation.width = 1;
			_currentAnimation.height = 1;
			_currentAnimation.visible = false;
			
			addChild(_backGround);
			addChild(_content);
			_content.addChild(_currentImage);
			_content.addChild(_currentAnimation);
		}
		
		public function get spriteSheet():SpriteSheet
		{
			return _spriteSheet;
		}

		public function set spriteSheet(value:SpriteSheet):void
		{
			_spriteSheet = value;
			_animationCounter = 0;
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
			{
				_mode = RadioState.ANIMATION;
				_currentImage.visible = false;
				_currentAnimation.visible = true;
			}
			else if(value == "Image" || value == "image" || value == "IMAGE")
			{
				_mode = RadioState.IMAGE;
				_currentAnimation.visible = false;
				_currentImage.visible = true;
			}
			else
			{
				_mode = RadioState.ANIMATION;
				_currentImage.visible = false;
				_currentAnimation.visible = true;
			}
		}
		
		public function startAnimation():void
		{
			if(_spriteSheet != null)
			{
			//	trace("aa");
				_currentAnimation.addEventListener(Event.ENTER_FRAME, goAnimation);
			}
		}
		
		private function goAnimation(event:Event):void
		{
		//	trace("goAnimation");
			_currentAnimation.texture = _spriteSheet.subTextures[_spriteSheet.images[_animationCounter].name];
			_currentAnimation.width = getLocalWidth(_spriteSheet.subTextures[_spriteSheet.images[_animationCounter].name].width);
			_currentAnimation.height = getLocalHeight(_spriteSheet.subTextures[_spriteSheet.images[_animationCounter].name].height);
			_animationCounter++;
			if(_animationCounter >= _spriteSheet.images.length)
			{
				_animationCounter = 0;
				_currentAnimation.removeEventListener(Event.ENTER_FRAME, goAnimation);
			}
		}
		
		public function viewImage(textureName:String):void
		{
			if(textureName != null)
			{
				_currentImage.width = getLocalWidth(_spriteSheet.subTextures[textureName].width);
				_currentImage.height = getLocalHeight(_spriteSheet.subTextures[textureName].height);
			}
			else
			{
				_currentImage.width = 1;
				_currentImage.height = 1;
			}
			_currentImage.texture = _spriteSheet.subTextures[textureName];
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