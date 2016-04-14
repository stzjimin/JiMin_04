package
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;

	public class SpriteSheet
	{
		private var _name:String;
		private var _spriteBitmap:Bitmap;
		private var _atlasTexture:Texture;
		
		private var _subTextures:Dictionary;
		private var _images:Vector.<ImageInfo>;
		
		public function SpriteSheet(name:String, spriteBitmap:Bitmap, xml:XML)
		{
			_name = name;
			_spriteBitmap = spriteBitmap;
			_atlasTexture = Texture.fromBitmap(spriteBitmap);
			readXML(xml);
			loadSubTexture();
		}
		
		public function get subTextures():Dictionary
		{
			return _subTextures;
		}

		public function get images():Vector.<ImageInfo>
		{
			return _images;
		}

		public function get spriteBitmap():Bitmap
		{
			return _spriteBitmap;
		}

		public function get name():String
		{
			return _name;
		}
		
		public function getTexture(name:String):void
		{
			return 
		}
		
		private function loadSubTexture():void
		{
			_subTextures = new Dictionary();
			for(var i:int = 0; i < _images.length; i++)
			{
				/*
				var transformationMatrix:Matrix = new Matrix();
				transformationMatrix.scale(_images[i].width  / _atlasTexture.width,
					_images[i].height / _atlasTexture.height);
				transformationMatrix.translate(_images[i].x  / _atlasTexture.width,
					_images[i].y  / _atlasTexture.height);
				*/
				var region:Rectangle = new Rectangle(_images[i].x, _images[i].y, _images[i].width, _images[i].height);
				
				var subTexture:Texture = Texture.fromTexture(_atlasTexture, region);
				_subTextures[_images[i].name] = subTexture;
			}
		}

		private function readXML(xml:XML):void
		{
			_images = new Vector.<ImageInfo>();
			
			for(var i:int = 0; i < xml.child("SubTexture").length(); i++)
			{
				var imageInfo:ImageInfo = new ImageInfo();
				imageInfo.name = xml.child("SubTexture")[i].attribute("name");
				imageInfo.x = xml.child("SubTexture")[i].attribute("x");
				imageInfo.y = xml.child("SubTexture")[i].attribute("y");
				imageInfo.width = xml.child("SubTexture")[i].attribute("width");
				imageInfo.height = xml.child("SubTexture")[i].attribute("height");
				
				_images.push(imageInfo);
			}
		}
	}
}