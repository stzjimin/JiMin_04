package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
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
		
		public function Main()
		{
			_resourceLoader = new ResourceLoader("GUI_resources", completeResourceLoad);
			_resourceLoader.loadResource(_resources);
		}
		
		private function completeResourceLoad():void
		{
			_loadeButton = new ButtonObject(Texture.fromBitmap(_resources["load.png"] as Bitmap));
			_loadeButton.width = 50;
			_loadeButton.height = 40;
			_loadeButton.x = 30;
			_loadeButton.y = 550;
			_loadeButton.addEventListener(Event.TRIGGERED, onClickLoadButton);
			
			_display = new Display();
			_display.x = 25;
			_display.y = 25;
			_display.width = 650;
			_display.height = 500;
			
			addChild(_display);
			addChild(_loadeButton);
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