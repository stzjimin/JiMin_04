package
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
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
			_animationButton = _radioManager.createButton("Animation");
			_imageButton = _radioManager.createButton("Image");
			
			_loadeButton = new ButtonObject(Texture.fromBitmap(_resources["load.png"] as Bitmap));
			_loadeButton.width = 50;
			_loadeButton.height = 40;
			_loadeButton.x = 30;
			_loadeButton.y = 550;
			_loadeButton.addEventListener(Event.TRIGGERED, onClickLoadButton);
			
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
		}
		
		private function onChangeMode(event:Event):void
		{
			_display.mode = _radioManager.mode;
			
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