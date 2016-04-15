package
{
	public class RadioState
	{
		private static const _ANIMATION:String = "Animation";
		private static const _IMAGE:String = "Image";
		
		public function RadioState()
		{
		}

		public static function get IMAGE():String
		{
			return _IMAGE;
		}

		public static function get ANIMATION():String
		{
			return _ANIMATION;
		}

	}
}