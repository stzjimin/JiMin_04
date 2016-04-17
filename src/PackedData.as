package
{
	import flash.display.BitmapData;

	public class PackedData
	{
		private var _name:String;
		private var _bitmapData:BitmapData;
		private var _packedImageQueue:Vector.<ImageInfo>;
		
		public function PackedData(name:String, width:int, height:int)
		{
			_name = name;
			_packedImageQueue = new Vector.<ImageInfo>();
			_bitmapData = new BitmapData(width, height);
		}

		public function get name():String
		{
			return _name;
		}

		public function set name(value:String):void
		{
			_name = value;
		}

		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}

		public function set bitmapData(value:BitmapData):void
		{
			_bitmapData = value;
		}

		public function get packedImageQueue():Vector.<ImageInfo>
		{
			return _packedImageQueue;
		}

		public function set packedImageQueue(value:Vector.<ImageInfo>):void
		{
			_packedImageQueue = value;
		}
	}
}