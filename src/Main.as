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
		
		private var _spriteSheets:Dictionary = new Dictionary();
		
		private var _loadeButton:ButtonObject;
		private var _display:Display;
		private var _displayBound:Quad;
		private var _radioManager:RadioButtonManager;
		private var _animationButton:RadioButton;
		private var _imageButton:RadioButton;
		private var _animaionText:TextField;
		private var _imageText:TextField;
		private var _animationMode:AnimationMode;
		private var _imageMode:ImageMode;
		private var _SpriteSheetDrop:Dropdownbar;
		
		public function Main()
		{
			_resourceLoader = new ResourceLoader("GUI_resources", completeResourceLoad);
			_resourceLoader.loadResource(Resource.rasources);
		}
		
		private function completeResourceLoad():void
		{
			_radioManager = new RadioButtonManager(Texture.fromBitmap(Resource.rasources["emptyRadio.png"] as Bitmap), Texture.fromBitmap(Resource.rasources["checkRadio.png"] as Bitmap));
			_radioManager.mode = RadioState.ANIMATION;
			_radioManager.addEventListener("ModeChange",onChangeMode);
			
			_animaionText = new TextField(100, 20, "Animation");
			_animaionText.border = true;
			_animaionText.x = 200;
			_animaionText.y = 550;
			
			_imageText = new TextField(100, 20, "Image");
			_imageText.border = true;
			_imageText.x = 200;
			_imageText.y = 580;
			
			_animationButton = _radioManager.createButton(RadioState.ANIMATION);
			_animationButton.width = 20;
			_animationButton.height = 20;
			_animationButton.x = 180;
			_animationButton.y = 550;
			
			_imageButton = _radioManager.createButton(RadioState.IMAGE);
			_imageButton.width = 20;
			_imageButton.height = 20;
			_imageButton.x = 180;
			_imageButton.y = 580;
			
			_loadeButton = new ButtonObject(Texture.fromBitmap(Resource.rasources["load.png"] as Bitmap));
			_loadeButton.width = 50;
			_loadeButton.height = 40;
			_loadeButton.x = 30;
			_loadeButton.y = 540;
			_loadeButton.addEventListener(Event.TRIGGERED, onClickLoadButton);
			
			_animationMode = new AnimationMode();
			_animationMode.x = 370;
			_animationMode.y = 550;
			_animationMode.visible = false;
			
			_imageMode = new ImageMode();
			_imageMode.x = 370;
			_imageMode.y = 550;
			_imageMode.visible = false;
			_imageMode.addEventListener("ImageChange", onChangeImage);
			
			_display = new Display(650, 500);
			_display.x = 25;
			_display.y = 25;
			
			_SpriteSheetDrop = new Dropdownbar(150, Texture.fromBitmap(Resource.rasources["dropdown.png"] as Bitmap), Texture.fromBitmap(Resource.rasources["arrowUp.png"] as Bitmap), Texture.fromBitmap(Resource.rasources["arrowDown.png"] as Bitmap));
			_SpriteSheetDrop.x = 10;
			_SpriteSheetDrop.y = 590;
			_SpriteSheetDrop.addEventListener("ListChange", onChangeSprite);
		//	_SpriteSheetDrop.createList("test1");
		//	_SpriteSheetDrop.createList("test2");
		//	_SpriteSheetDrop.createList("test3");
		//	_drop.createList("test4");
		//	_drop.createList("test5");
			
			addChild(_display);
			addChild(_loadeButton);
			addChild(_animationButton);
			addChild(_imageButton);
			addChild(_animaionText);
			addChild(_imageText);
			addChild(_animationMode);
			addChild(_imageMode);
			addChild(_SpriteSheetDrop);
		}
		
		private function onChangeImage(event:Event):void
		{
			_display.viewImage(_imageMode.imageSelectBar.currentList.name);
		}
		
		private function onChangeSprite(event:Event):void
		{
			_display.spriteSheet = _spriteSheets[Dropdownbar(event.currentTarget).currentList.name];
		//	_display.viewSprite();
			_imageMode.setSpriteSheet(_spriteSheets[Dropdownbar(event.currentTarget).currentList.name]);
		}
		
		private function onChangeMode(event:Event):void
		{
			_display.mode = _radioManager.mode;
			if(_display.mode == RadioState.ANIMATION)
			{
				_imageMode.visible = false;
				_animationMode.visible = true;
			}
			else if(_display.mode == RadioState.IMAGE)
			{
				_animationMode.visible = false;
				_imageMode.visible = true;
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
			_spriteSheets[name] = spriteSheet;
		//	addChild(_spriteSheets[0].spriteBitmap);
		//	var testImage:Image = new Image(Texture.fromBitmap(_spriteSheets[0].spriteBitmap));
		//	addChild(testImage);
		//	for(var i:int = 0; i < _spriteSheets[0].images.length; i++)
		//		trace(_spriteSheets[0].images[i].name);
		//	trace(loadXml);
		//	trace(loadXml.child("SubTexture").name());
		//	trace(loadXml.child("SubTexture")[0].attribute("name"));
		//	_display.spriteSheet = _spriteSheets[name];
		//	_display.viewSprite();
			_SpriteSheetDrop.createList(name);
		}
	}
}