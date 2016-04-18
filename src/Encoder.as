package
{
	import flash.display.BitmapData;
	import flash.display.PNGEncoderOptions;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public class Encoder
	{
		private const binaryReg:RegExp = new RegExp("^10*$", "m");
		
		private var _filePath:String;
		
		public function Encoder()
		{
		}
		
		public function setFilePath(filePath:String):void
		{
			_filePath = filePath;
		}
		
		public function encode(packedData:PackedData):void
		{
			getXmlEncode(packedData);
			getPngEncode(packedData);
		}
		
		private function getPngEncode(packedData:PackedData):void
		{
			var bitmapData:BitmapData = packedData.bitmapData;
			var byteArray:ByteArray = new ByteArray();
			
			var binary:String = packedData.width.toString(2);
			if(!binary.match(binaryReg))
				packedData.width = Math.pow(2,binary.length);
			
			binary = packedData.height.toString(2);
			if(!binary.match(binaryReg))
				packedData.height = Math.pow(2,binary.length);
			
			bitmapData.encode(new Rectangle(0, 0, packedData.width, packedData.height), new PNGEncoderOptions(), byteArray);
			
			var localPngFile:File = File.desktopDirectory.resolvePath(_filePath + ".png");
			var fileAccess:FileStream = new FileStream();
			fileAccess.open(localPngFile, FileMode.WRITE);
			fileAccess.writeBytes(byteArray, 0, byteArray.length);
			fileAccess.close();
		}
		
		private function getXmlEncode(packedData:PackedData):void
		{
			var localXmlFile:File = File.desktopDirectory.resolvePath(_filePath + ".xml");
			var fileAccess:FileStream = new FileStream();
			
			var maxWidth:int = 0;
			var maxHeight:int = 0;
			
			fileAccess.open(localXmlFile, FileMode.WRITE);
			fileAccess.writeUTFBytes("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			fileAccess.writeUTFBytes("<TextureAtlas ImagePath=\"" + localXmlFile.name.replace(".xml",".png") + "\">\n");
			for(var i:int = 0; i < packedData.packedImageQueue.length; i ++)
			{
				var image:ImageInfo = packedData.packedImageQueue[i];
				fileAccess.writeUTFBytes("<SubTexture name=\"" + image.name + "\" x=\"" + image.x + "\" y=\"" + image.y + "\" width=\"" + image.width + "\" height=\"" + image.height + "\"/>\n");
				if(image.x+image.width > maxWidth)
					maxWidth = image.x+image.width;
				if(image.y+image.height > maxHeight)
					maxHeight = image.y+image.height;
			}
			packedData.width = maxWidth;
			packedData.height = maxHeight;
			fileAccess.writeUTFBytes("</TextureAtlas>");
			fileAccess.close();
		}
	}
}