package
{
	import flash.display.Sprite;
	import starling.core.Starling;
	
	[SWF(width="1024", height="1024", frameRate="60", backgroundColor="#FFFFF0")]
	public class Assignment_04 extends Sprite
	{
		private var _starling:Starling;
		
		public function Assignment_04()
		{
			_starling = new Starling(Main, stage);
			_starling.start();
			_starling.showStats = true;
		}
	}
}