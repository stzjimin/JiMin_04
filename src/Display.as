package
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class Display extends Sprite
	{
		private const AnimationFram:int = 30;
		
		private var _content:Sprite;
		private var _backGround:Quad;
		
		private var _mode:String = RadioState.ANIMATION;
		private var _spriteSheet:SpriteSheet;
		private var _spriteTexture:Texture;
		
		private var _width:int;
		private var _height:int;
		
		private var _currentImage:Image;
		private var _currentAnimation:Image;
		private var _currentAnimationName:TextField;
		
		private var _animationCounter:int;
		private var _frameCounter:int;
		
	//	private var _imageWidth:int = _currentImage.width;
	//	private var _imageHeight:int = _currentImage.height;
		
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
			_currentImage.width = 300;
			_currentImage.height = 400;
			_currentImage.visible = false;
			_currentImage.addEventListener(TouchEvent.TOUCH, onClickImage);
			
			_currentAnimation = new Image(null);
			_currentAnimation.pivotX = _currentAnimation.width / 2;
			_currentAnimation.pivotY = _currentAnimation.height / 2;
			_currentAnimation.x = _width / 2;
			_currentAnimation.y = _height / 2;
			_currentAnimation.width = 300;
			_currentAnimation.height = 400;
			_currentAnimation.visible = false;
		//	_currentAnimation.addEventListener(TouchEvent.TOUCH, onClickImage);
			
			_currentAnimationName = new TextField(120, 20, "");
			_currentAnimationName.pivotX = _currentAnimationName.width / 2;
			_currentAnimationName.pivotY = _currentAnimationName.height / 2;
			_currentAnimationName.x = _width/6 * 5;
			_currentAnimationName.y = _height/6 * 5;
			_currentAnimationName.visible = false;
			
			addChild(_backGround);
			addChild(_content);
			_content.addChild(_currentImage);
			_content.addChild(_currentAnimation);
			_content.addChild(_currentAnimationName);
		}
		
		public function get spriteSheet():SpriteSheet
		{
			return _spriteSheet;
		}

		public function set spriteSheet(value:SpriteSheet):void
		{
			_spriteSheet = value;
			_animationCounter = 0;
			
			_currentImage.texture = null;
			_currentImage.width = 1;
			_currentImage.height = 1;
			
			_currentAnimation.texture = null;
			_currentAnimation.width = 1;
			_currentAnimation.height = 1;
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
				_currentAnimationName.visible = true;
			}
			else if(value == "Image" || value == "image" || value == "IMAGE")
			{
				_mode = RadioState.IMAGE;
				_currentAnimation.visible = false;
				_currentAnimationName.visible = false;
				_currentImage.visible = true;
			}
			else
			{
				_mode = RadioState.ANIMATION;
				_currentImage.visible = false;
				_currentAnimation.visible = true;
				_currentAnimationName.visible = true;
			}
		}
		
		public function stopAnimation():void
		{
			_currentAnimation.removeEventListener(Event.ENTER_FRAME, goAnimation);
		}
		
		public function startAnimation():void
		{
			if(_spriteSheet != null)
			{
				_frameCounter = 0;
				_currentAnimation.addEventListener(Event.ENTER_FRAME, goAnimation);
			}
		}
		
		private function goAnimation(event:Event):void
		{
			_frameCounter++;
			if(_frameCounter >= AnimationFram)
			{
				changeAnimation();
				_frameCounter = 0;
			}
		}
		
		private function onClickImage(event:TouchEvent):void
		{
			if(event.getTouch(_currentImage, TouchPhase.BEGAN) != null)
			{
				_currentImage.width = 300;
				_currentImage.height = 400;
			}
			
			if(event.getTouch(_currentImage, TouchPhase.ENDED) != null)
			{
				_currentImage.width = getLocalWidth(_currentImage.texture.width);
				_currentImage.height = getLocalHeight(_currentImage.texture.height);
			}
		}
		
		private function changeAnimation():void
		{
			_currentAnimation.texture = _spriteSheet.subTextures[_spriteSheet.images[_animationCounter].name];
			_currentAnimation.width = getLocalWidth(_spriteSheet.subTextures[_spriteSheet.images[_animationCounter].name].width);
			_currentAnimation.height = getLocalHeight(_spriteSheet.subTextures[_spriteSheet.images[_animationCounter].name].height);
			_currentAnimationName.text = _spriteSheet.images[_animationCounter].name;
			_animationCounter++;
			if(_animationCounter >= _spriteSheet.images.length)
			{
				_animationCounter = 0;
				_currentAnimation.removeEventListener(Event.ENTER_FRAME, goAnimation);
			}
		}
		
		public function viewImage(textureName:String):void
		{
			_currentImage.width = getLocalWidth(_spriteSheet.subTextures[textureName].width);
			_currentImage.height = getLocalHeight(_spriteSheet.subTextures[textureName].height);
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