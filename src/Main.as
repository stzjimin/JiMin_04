package
{
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class Main extends Sprite
	{	
		private var _loadeButton:Button;
		private var _resourceLoader:ResourceLoader;
		private var _resources:Dictionary = new Dictionary();
		
		public function Main()
		{
			_resourceLoader = new ResourceLoader("GUI_resources", completeResourceLoad);
			_resourceLoader.loadResource(_resources);
		}
		
		private function completeResourceLoad():void
		{
		//	trace(_resources["iu3.jpg"].width);
			/*
			var testImage:Image = new Image(Texture.fromBitmap(_resources["button.png"] as Bitmap));
			testImage.width = _resources["button.png"].width;
			testImage.height = _resources["button.png"].height;
			testImage.x = 20;
			*/
		//	trace(_resources["iu3.jpg"].width);
		//	addChild(testImage);
			var loadButton:Button = new Button(Texture.fromBitmap(_resources["button.png"] as Bitmap));
			loadButton.width = _resources["button.png"].width;
			loadButton.height = _resources["button.png"].height;
			
		}
	}
}