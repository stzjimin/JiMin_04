package
{
	import starling.textures.Texture;

	public class RadioButton extends ButtonObject
	{	
		private var _key:String;
		private var _radioState:Boolean;
		
		public function RadioButton(upState:Texture, key:String)
		{
			_key = key;
			super(upState);
		}

		public function get radioState():Boolean
		{
			return _radioState;
		}

		public function set radioState(value:Boolean):void
		{
			_radioState = value;
		}

		public function get key():String
		{
			return _key;
		}
	}
}