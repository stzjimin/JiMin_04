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
			_animationMode.addEventListener("StartAnimation", onStartAnimation);
			_animationMode.addEventListener("StopAnimation", onStopAnimation);
			
			_imageMode = new ImageMode();
			_imageMode.x = 370;
			_imageMode.y = 550;
			_imageMode.visible = false;
			_imageMode.addEventListener("ImageChange", onChangeImage);
			_imageMode.addEventListener("CompleteSave", onCompleteSave);
			
			_display = new Display(650, 500);
			_display.x = 25;
			_display.y = 25;
			
			_SpriteSheetDrop = new Dropdownbar(150, Texture.fromBitmap(Resource.rasources["dropdown.png"] as Bitmap), Texture.fromBitmap(Resource.rasources["arrowUp.png"] as Bitmap), Texture.fromBitmap(Resource.rasources["arrowDown.png"] as Bitmap));
			_SpriteSheetDrop.x = 10;
			_SpriteSheetDrop.y = 590;
			_SpriteSheetDrop.addEventListener("ListChange", onChangeSprite);
			
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
		
		private function onStopAnimation(event:Event):void
		{
			_display.stopAnimation();
		}
		
		private function onStartAnimation(event:Event):void
		{
			_display.startAnimation();
		}
		
		private function onChangeImage(event:Event):void
		{
			_display.viewImage(_imageMode.imageSelectBar.currentList.name);
		}
		
		private function onCompleteSave(event:Event):void
		{
			var messageBox:MessageBox = new MessageBox();
			messageBox.showMessageBox("Save Complete", 120, _display);
		}
		
		private function onChangeSprite(event:Event):void
		{
			_display.spriteSheet = _spriteSheets[Dropdownbar(event.currentTarget).currentList.name];
			_imageMode.spriteSheet = _spriteSheets[Dropdownbar(event.currentTarget).currentList.name];
			_imageMode.imageSelectBar.currentViewList.text = ""
			_imageMode.imageSelectBar.refreshList();
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
				_display.stopAnimation();
			}
		}
		
		private function onClickLoadButton(event:Event):void
		{
			var spriteLoader:SpriteLoader = new SpriteLoader(completeLoad);
		}
		
		private function completeLoad(name:String, loadSprite:Bitmap, loadXml:XML):void
		{
			var messageBox:MessageBox = new MessageBox();
			if(_spriteSheets[name] == null)
			{
				var spriteSheet:SpriteSheet = new SpriteSheet(name, loadSprite, loadXml);
				_spriteSheets[name] = spriteSheet;
				_SpriteSheetDrop.createList(name);
				messageBox.showMessageBox("Load Success", 120, _display);
			}
			else
			{
				messageBox.showMessageBox("Load Fail", 120, _display);
			}
		}
	}
}