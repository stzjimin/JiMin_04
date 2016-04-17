package
{
	import flash.display.Bitmap;

	public class PackedData
	{
		private var _bitmap:Bitmap;
		private var _packedImageQueue:Vector.<ImageInfo>;
		
		public function PackedData()
		{
			_packedImageQueue = new Vector.<ImageInfo>();
		}

		public function get packedImageQueue():Vector.<ImageInfo>
		{
			return _packedImageQueue;
		}

		public function set packedImageQueue(value:Vector.<ImageInfo>):void
		{
			_packedImageQueue = value;
		}

		public function get bitmap():Bitmap
		{
			return _bitmap;
		}

		public function set bitmap(value:Bitmap):void
		{
			_bitmap = value;
		}

	}
}