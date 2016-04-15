package
{
	import flash.utils.Dictionary;

	public class Resource
	{
		private static var _rasources:Dictionary = new Dictionary();
		
		public function Resource()
		{
		}

		public static function get rasources():Dictionary
		{
			return _rasources;
		}

		public static function set rasources(value:Dictionary):void
		{
			_rasources = value;
		}

	}
}