package
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;

	public class Packer
	{
		private const MaxWidth:int = 1024;
		private const MaxHeight:int = 1024;
		
		private var _dataQueue:Vector.<ImageInfo>;
		private var _currentPackedData:PackedData;
		private var _spriteSheet:BitmapData;
		
		private var _completeFunc:Function;
		
		private var _count:int;
		private var _spaceArray:Vector.<Rectangle>;
		
		public function Packer(completeFunc:Function)
		{
			_completeFunc = completeFunc;
		}
		
		public function initPacker(dataVector:Vector.<ImageInfo>):void
		{
		//	_currentPackedData = new BitmapData(MaxWidth, MaxHeight);
			_dataQueue = clone(dataVector);
			_dataQueue = _dataQueue.sort(orderPixels);
			
			_count = 0;
			_spaceArray = new Vector.<Rectangle>();
			var firstRect:Rectangle = new Rectangle(0, 0, MaxWidth, MaxHeight);
			
			_spaceArray.push(firstRect);
		}
		
		public function startPacker(spriteSheetBitmapData:BitmapData):void
		{
			_spriteSheet = spriteSheetBitmapData;
		}
		
		/*
		private function addImage():void
		{
			var image:ImageInfo = _dataQueue.shift();
			var nonFlag:Boolean = true;
			for(var i:int = 0; i < _spaceArray.length; i++)
			{
				if(_spaceArray[i].containsRect(new Rectangle(_spaceArray[i].x, _spaceArray[i].y, image.width, image.height)))
				{
					var point:Point = new Point(_spaceArray[i].x, _spaceArray[i].y);
					var imageRect:Rectangle = new Rectangle(image.x, image.y, image.width, image.height);
					
					image.x = imageRect.x = _spaceArray[i].x;
					image.y = imageRect.y = _spaceArray[i].y;
					
					_currentPackedDatamerge(image.bitmap.bitmapData, image.bitmap.bitmapData.rect, point, 0xFF,0xFF,0xFF,0xFF);
					_currentPackedData.packedImageQueue.push(image);
					
					//이미지와 겹쳐지는 공간이 있다면 해당 공간을 분할
					searchIntersects(_spaceArray, imageRect);
					
					nonFlag = false;
					break;
				}
			}
			
			//추가하려는 이미지가  들어갈 수 있는 공간이 없을 경우
			if(nonFlag)
			{
				_count++;
				_dataQueue.push(image);
				if(_dataQueue.length <= _count)
					_changeFunc(_currentPackedData);
				return null;
			}
			
			_spaceArray.sort(orderYvalue);	//여유공간을  y값으로 정렬하여 상대적으로 아래쪽에 있는 공간은 나중에 선택이 되도록 합니다
			return image;
		}
		*/
		
		private function clone(source:Object):*
		{
			var clone:ByteArray = new ByteArray();
			clone.writeObject(source);
			clone.position = 0;
			return(clone.readObject());
		}
		
		private function orderPixels(data1:ImageInfo, data2:ImageInfo):int
		{
			if(data1.width*data1.height > data2.width*data2.height) 
			{ 
				return -1;
			} 
			else if(data1.width*data1.height < data2.width*data2.height) 
			{ 
				return 1; 
			} 
			else 
			{ 
				return 0; 
			} 
		}
	}
}