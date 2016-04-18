package 
{
	import flash.display.Sprite;
	import starling.core.Starling;
	import Screen.Main;
	
	[SWF(width="700", height="700", frameRate="60", backgroundColor="#FFFFF0")]
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