package
{
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	import starling.display.ButtonState;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	public class ButtonObject extends DisplayObjectContainer
	{
		private const _downStateScale:Number = 0.9;
		
		private var _upState:Texture;
		private var _state:String = ButtonState.UP;
		private var _currentImage:Image;
		private var _contents:Sprite;
		
		private var _useHandCursor:Boolean;
		private var _enabled:Boolean;
		private var _triggerBounds:Rectangle;
		
		public function ButtonObject(upState:Texture)
		{
		//	if (upState == null) throw new ArgumentError("Texture 'upState' cannot be null");
			
			_upState = upState;
			
			_state = ButtonState.UP;
			_currentImage = new Image(upState);
			
			_enabled = true;
			_useHandCursor = true;

			_triggerBounds = new Rectangle();
			
			_contents = new Sprite();
			_contents.addChild(_currentImage);
			addChild(_contents);
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function get state():String { return _state; }
		
		public function set state(value:String):void
		{
			_state = value;
			_contents.x = _contents.y = 0;
			_contents.scaleX = _contents.scaleY = _contents.alpha = 1.0;
			
			switch (_state)
			{
				case ButtonState.DOWN:
					_contents.scaleX = _contents.scaleY = _downStateScale;
					_contents.x = (1.0 - _downStateScale) / 2.0 * _currentImage.width;
					_contents.y = (1.0 - _downStateScale) / 2.0 * _currentImage.height;
					break;
				case ButtonState.UP:
					setStateTexture(_upState);
					break;
				default:
					throw new ArgumentError("Invalid button state: " + _state);
			}
		}
		
		public function setStateTexture(stateTexture:Texture):void
		{
			_currentImage.texture = stateTexture;
		}
		
		private function onTouch(event:TouchEvent):void
		{
			Mouse.cursor = (_useHandCursor && _enabled && event.interactsWith(this)) ?
				MouseCursor.BUTTON : MouseCursor.AUTO;
			
			var touch:Touch = event.getTouch(this);
			var isWithinBounds:Boolean;
			
			if (!_enabled)
			{
				return;
			}
			else if (touch == null)
			{
				state = ButtonState.UP;
			}
			else if (touch.phase == TouchPhase.HOVER)
			{
				state = ButtonState.UP;
			}
			else if (touch.phase == TouchPhase.BEGAN && _state != ButtonState.DOWN)
			{
				_triggerBounds = getBounds(stage, _triggerBounds);
			//	_triggerBounds.inflate(MAX_DRAG_DIST, MAX_DRAG_DIST);
				
				state = ButtonState.DOWN;
			}
			else if (touch.phase == TouchPhase.MOVED)
			{
				isWithinBounds = _triggerBounds.contains(touch.globalX, touch.globalY);
				
				if (_state == ButtonState.DOWN && !isWithinBounds)
				{
					// reset button when finger is moved too far away ...
					state = ButtonState.UP;
				}
				else if (_state == ButtonState.UP && isWithinBounds)
				{
					// ... and reactivate when the finger moves back into the bounds.
					state = ButtonState.DOWN;
				}
			}
			else if (touch.phase == TouchPhase.ENDED && _state == ButtonState.DOWN)
			{
				state = ButtonState.UP;
				if (!touch.cancelled) dispatchEventWith(Event.TRIGGERED, true);
			}
		}
	}
}