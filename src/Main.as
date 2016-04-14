package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class Main extends Sprite
	{
		private var _resourceLoader:ResourceLoader;
		private var _resources:Dictionary = new Dictionary();
		
		private var _spriteSheets:Vector.<SpriteSheet> = new Vector.<SpriteSheet>();
		
		private var _loadeButton:ButtonObject;
		private var _display:Display;
		private var _displayBound:Quad;
		private var _radioManager:RadioButtonManager;
		private var _animationButton:RadioButton;
		private var _imageButton:RadioButton;
		private var _animaionText:TextField;
		private var _imageText:TextField;
		private var _animationMode:AnimationMode;
		
		public function Main()
		{
			_resourceLoader = new ResourceLoader("GUI_resources", completeResourceLoad);
			_resourceLoader.loadResource(_resources);
		}
		
		private function completeResourceLoad():void
		{
			_radioManager = new RadioButtonManager(Texture.fromBitmap(_resources["emptyRadio.png"] as Bitmap), Texture.fromBitmap(_resources["checkRadio.png"] as Bitmap));
			_radioManager.mode = "Animation";
			_radioManager.addEventListener("ModeChange",onChangeMode);
			
			_animaionText = new TextField(100, 20, "Animation");
			_animaionText.x = 150;
			_animaionText.y = 550;
			
			_imageText = new TextField(100, 20, "Image");
			_imageText.x = 150;
			_imageText.y = 580;
			
			_animationButton = _radioManager.createButton("Animation");
			_animationButton.width = 20;
			_animationButton.height = 20;
			_animationButton.x = 120;
			_animationButton.y = 550;
			
			_imageButton = _radioManager.createButton("Image");
			_imageButton.width = 20;
			_imageButton.height = 20;
			_imageButton.x = 120;
			_imageButton.y = 580;
			
			_loadeButton = new ButtonObject(Texture.fromBitmap(_resources["load.png"] as Bitmap));
			_loadeButton.width = 50;
			_loadeButton.height = 40;
			_loadeButton.x = 30;
			_loadeButton.y = 550;
			_loadeButton.addEventListener(Event.TRIGGERED, onClickLoadButton);
			
			_animationMode = new AnimationMode(_resources);
			_animationMode.x = 300;
			_animationMode.y = 550;
			_animationMode.visible = false;
			
			_display = new Display(650, 500);
			_display.x = 25;
			_display.y = 25;
			
			/*
			_displayBound = new Quad(_display.width, _display.height);
			_displayBound.x = 25;
			_displayBound.y = 25;
			_displayBound.color = Color.GRAY;
			_displayBound.scale = 1.1;
				
			addChild(_displayBound);
			*/
			addChild(_display);
			addChild(_loadeButton);
			addChild(_animationButton);
			addChild(_imageButton);
			addChild(_animaionText);
			addChild(_imageText);
			addChild(_animationMode);
		}
		
		private function onChangeMode(event:Event):void
		{
			_display.mode = _radioManager.mode;
			if(_display.mode == "Animation")
			{
				_animationMode.visible = true;
			}
			else if(_display.mode == "Image")
			{
				_animationMode.visible = false;
			}
			trace(_display.mode);
		}
		
		private function onClickLoadButton(event:Event):void
		{
		//	event.currentTarget.removeEventListener(Event.TRIGGERED, onClickLoadButton);
		//	Button(event.currentTarget).removeFromParent(true);
			var spriteLoader:SpriteLoader = new SpriteLoader(completeLoad);
		}
		
		private function completeLoad(name:String, loadSprite:Bitmap, loadXml:XML):void
		{
		//	var testImage:Image = new Image(Texture.fromBitmap(loadSprite));
		//	addChild(testImage);
			var spriteSheet:SpriteSheet = new SpriteSheet(name, loadSprite, loadXml);
			_spriteSheets.push(spriteSheet);
		//	addChild(_spriteSheets[0].spriteBitmap);
		//	var testImage:Image = new Image(Texture.fromBitmap(_spriteSheets[0].spriteBitmap));
		//	addChild(testImage);
		//	for(var i:int = 0; i < _spriteSheets[0].images.length; i++)
		//		trace(_spriteSheets[0].images[i].name);
		//	trace(loadXml);
		//	trace(loadXml.child("SubTexture").name());
		//	trace(loadXml.child("SubTexture")[0].attribute("name"));
			_display.spriteSheet = _spriteSheets[0];
			_display.viewSprite();
		}
	}
}