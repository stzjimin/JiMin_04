package
{
	import flash.utils.Dictionary;

	public class Resource
	{
		private static var _resources:Dictionary = new Dictionary();
		
		public function Resource()
		{
		}

		public static function get resources():Dictionary
		{
			return _resources;
		}

		public static function set resources(value:Dictionary):void
		{
			_resources = value;
		}

	}
}