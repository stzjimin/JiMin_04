package Screen
{
	import flash.display.Bitmap;
	import flash.system.System;
	import flash.utils.Dictionary;
	
	import Component.ButtonObject;
	import Component.Dropdownbar;
	import Component.MessageBox;
	import Component.RadioButton;
	import Component.RadioButtonManager;
	
	import Data.Resource;
	import IO.ResourceLoader;
	import IO.SpriteLoader;
	import Data.SpriteSheet;
	
	import Util.CustomizeEvent;
	import Util.RadioKeyValue;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.Color;

	public class Main extends Sprite
	{
		private var _resourceLoader:ResourceLoader;
		
		private var _spriteSheets:Dictionary = new Dictionary();
		
		private var _loadeButton:ButtonObject;
		private var _display:Display;
		private var _displayBound:Quad;
		private var _radioManager:RadioButtonManager;
		private var _animationButton:RadioButton;
		private var _imageButton:RadioButton;
		private var _animaionText:TextField;
		private var _imageText:TextField;
		private var _animationMode:AnimationMode;
		private var _imageMode:ImageMode;
		private var _SpriteSheetDrop:Dropdownbar;
		
		/**
		 *Main클래스는 시작할 때 리소스를 로드합니다. 
		 * 
		 */		
		public function Main()
		{
			_resourceLoader = new ResourceLoader("GUI_resources", completeResourceLoad);
			_resourceLoader.loadResource(Resource.resources);
		}
		
		/**
		 *리소스 로드가 끝나고나면 화면을 구성합니다. 
		 * 
		 */		
		private function completeResourceLoad():void
		{
			_radioManager = new RadioButtonManager();
//			_radioManager.mode = RadioKeyValue.ANIMATION;
			_radioManager.addEventListener(CustomizeEvent.ModeChange,onChangeMode);
			
			_animaionText = new TextField(100, 20, "Animation");
			_animaionText.border = true;
			_animaionText.x = 200;
			_animaionText.y = 550;
			
			_imageText = new TextField(100, 20, "Image");
			_imageText.border = true;
			_imageText.x = 200;
			_imageText.y = 580;
			
			/////라디오 버튼///////
			_animationButton = new RadioButton(Texture.fromBitmap(Resource.resources["emptyRadio.png"] as Bitmap), Texture.fromBitmap(Resource.resources["checkRadio.png"] as Bitmap), RadioKeyValue.ANIMATION);
			_animationButton.width = 20;
			_animationButton.height = 20;
			_animationButton.x = 180;
			_animationButton.y = 550;
			
			_imageButton = new RadioButton(Texture.fromBitmap(Resource.resources["emptyRadio.png"] as Bitmap), Texture.fromBitmap(Resource.resources["checkRadio.png"] as Bitmap), RadioKeyValue.IMAGE);
			_imageButton.width = 20;
			_imageButton.height = 20;
			_imageButton.x = 180;
			_imageButton.y = 580;
			
			_radioManager.addButton(_animationButton);
			_radioManager.addButton(_imageButton);
			//////////////////////
			
			_loadeButton = new ButtonObject(Texture.fromBitmap(Resource.resources["load.png"] as Bitmap));
			_loadeButton.width = 50;
			_loadeButton.height = 40;
			_loadeButton.x = 30;
			_loadeButton.y = 540;
			_loadeButton.addEventListener(Event.TRIGGERED, onClickLoadButton);
			
			_animationMode = new AnimationMode();
			_animationMode.x = 370;
			_animationMode.y = 550;
			_animationMode.visible = false;
			_animationMode.addEventListener(CustomizeEvent.AnimationStart, onStartAnimation);
			_animationMode.addEventListener(CustomizeEvent.AnimationStop, onStopAnimation);
			_animationMode.addEventListener(CustomizeEvent.SpriteDelete, onDeleteSheet);
			_animationMode.addEventListener(CustomizeEvent.SpeedChange, onChangeSpeed);
			
			_imageMode = new ImageMode();
			_imageMode.x = 370;
			_imageMode.y = 550;
			_imageMode.visible = false;
			_imageMode.addEventListener(CustomizeEvent.ImageChange, onChangeImage);
			_imageMode.addEventListener(CustomizeEvent.SaveComplete, onCompleteSave);
			_imageMode.addEventListener(CustomizeEvent.ImageAdd, onCompleteAdd);
			_imageMode.addEventListener(CustomizeEvent.PackingComplete, onCompletePack);
			
			_display = new Display(650, 500);
			_display.x = 25;
			_display.y = 25;
			
			_SpriteSheetDrop = new Dropdownbar(150, Texture.fromBitmap(Resource.resources["dropdown.png"] as Bitmap), Texture.fromBitmap(Resource.resources["arrowUp.png"] as Bitmap), Texture.fromBitmap(Resource.resources["arrowDown.png"] as Bitmap));
			_SpriteSheetDrop.x = 10;
			_SpriteSheetDrop.y = 590;
			_SpriteSheetDrop.addEventListener(CustomizeEvent.ListChange, onChangeSprite);
			
			addChild(_display);
			addChild(_loadeButton);
			addChild(_animationButton);
			addChild(_imageButton);
			addChild(_animaionText);
			addChild(_imageText);
			addChild(_animationMode);
			addChild(_imageMode);
			addChild(_SpriteSheetDrop);
			
			Resource.resources = null;		//리소스를 사용이 끝나고나면 메모리를 풀어줌
			System.gc();
			
		//	_animationButton.dispatchEvent(new Event(Event.TRIGGERED));
		}
		
		/**
		 *현재 보고있는 SpriteSheet를 목록에서 삭제합니다. 
		 * @param event
		 * 
		 */		
		private function onDeleteSheet(event:Event):void
		{
			var messageBox:MessageBox = new MessageBox();
			if(_SpriteSheetDrop.currentSelectList.text == "")
				messageBox.showMessageBox("Delete Fail", 120, _display, Color.RED);
			else
				messageBox.showMessageBox("Delete Sheet", 120, _display, Color.RED);
			_spriteSheets[_SpriteSheetDrop.currentSelectList.text] = null;
			_SpriteSheetDrop.deleteList(_SpriteSheetDrop.currentSelectList.text);
			_SpriteSheetDrop.currentSelectList.text = "";
			_SpriteSheetDrop.refreshList();
			_imageMode.spriteSheet = null;
			_display.stopAnimation();
			_display.spriteSheet = null;
		}
		
		/**
		 *현재 보고있는 에니메이션화면을 정지합니다. 
		 * @param event
		 * 
		 */		
		private function onStopAnimation(event:Event):void
		{
			_display.stopAnimation();
		}
		
		/**
		 *현재 선택되어있는 SpriteSheet의 에니메이션을 시작합니다. 
		 * @param event
		 * 
		 */		
		private function onStartAnimation(event:Event):void
		{
			_display.startAnimation();
		}
		
		private function onChangeSpeed(event:Event):void
		{
			_display.changeSpeed(event.data as int);
		}
		
		/**
		 *ImageMode에서 이미지추가에대한 결과보고를 받게되는 함수입니다.
		 * @param event
		 * 
		 */		
		private function onCompleteAdd(event:Event):void
		{
			var messageBox:MessageBox = new MessageBox();
			if(event.data == "Full")
				messageBox.showMessageBox("Not Enough Space", 120, _display, Color.RED);
			else if(event.data == "Used")
				messageBox.showMessageBox("Image Already Added", 120, _display, Color.RED);
			else if(event.data == "Success")
				messageBox.showMessageBox("Image Add", 120, _display);
			else
				messageBox.showMessageBox(event.data as String, 120, _display);
		}
		
		/**
		 *ImageMode에서 패킹에대한 결과보고를 받게되는 함수입니다.
		 * @param event
		 * 
		 */		
		private function onCompletePack(event:Event):void
		{
			var messageBox:MessageBox = new MessageBox();
			messageBox.showMessageBox("Complete Packing", 120, _display);
		}
		
		/**
		 *ImageMode에서 이미지가 변경됬을 때 호출되는 함수입니다. evnet와 함께 날아오는 data는 변경된 이미지의 이름입니다.
		 * @param event
		 * 
		 */		
		private function onChangeImage(event:Event):void
		{
			_display.viewImage(event.data as String);
		}
		
		/**
		 *ImageMode에서 현재보고있는 이미지에 대한 저장이 성공했을 때 호출되는 함수입니다. 
		 * @param event
		 * 
		 */		
		private function onCompleteSave(event:Event):void
		{
			var messageBox:MessageBox = new MessageBox();
			messageBox.showMessageBox("Save Complete", 120, _display);
		}
		
		/**
		 *_SpriteSheetDrop에서 SpriteSheet가 선택되었을 때 호출되는 함수입니다.
		 * _display와 _imageMode에 해당 스프라이트시트를 연결해줍니다. 
		 * @param event
		 * 
		 */		
		private function onChangeSprite(event:Event):void
		{
			_display.spriteSheet = _spriteSheets[Dropdownbar(event.currentTarget).currentSelectList.text];
			_imageMode.spriteSheet = _spriteSheets[Dropdownbar(event.currentTarget).currentSelectList.text];
		}
		
		/**
		 *_radioManager에 속해있는 버튼들 중 하나의 버튼이 클릭되면 호출되는 함수입니다.
		 * @param event
		 * 
		 */		
		private function onChangeMode(event:Event):void
		{
			_display.mode = event.data as String;
			trace(_display.mode);
			if(_display.mode == RadioKeyValue.ANIMATION)
			{
				_imageMode.visible = false;
				_animationMode.visible = true;
			}
			else if(_display.mode == RadioKeyValue.IMAGE)
			{
				_animationMode.visible = false;
				_imageMode.visible = true;
				_display.stopAnimation();
			}
		}
		
		/**
		 *SpriteLoad버튼이 눌렀을 때 호출되는 함수입니다. 
		 * @param event
		 * 
		 */		
		private function onClickLoadButton(event:Event):void
		{
			var spriteLoader:SpriteLoader = new SpriteLoader(completeLoad, uncompleteLoad);
		}
		
		/**
		 *spriteLoader가 로딩을 완료하게되면 호출되는 함수입니다.
		 * 로드된 png파일의 이름과 비트맵, xml파일로 새로운 SpriteSheet객체를 생성합니다.
		 * @param name
		 * @param loadSprite
		 * @param loadXml
		 * 
		 */		
		private function completeLoad(name:String, loadSprite:Bitmap, loadXml:XML):void
		{
			var messageBox:MessageBox = new MessageBox();
			if(_spriteSheets[name] == null)
			{
				var spriteSheet:SpriteSheet = new SpriteSheet(name, loadSprite, loadXml);
				_spriteSheets[name] = spriteSheet;
				_SpriteSheetDrop.createList(name);
				messageBox.showMessageBox("Load Success", 120, _display);
			}
			else
			{
				messageBox.showMessageBox("Already Added", 120, _display, Color.RED);
			}
		}
		
		private function uncompleteLoad(errorMessage:String):void
		{
			var messageBox:MessageBox = new MessageBox();
			messageBox.showMessageBox(errorMessage, 120, _display, Color.RED);
		}
	}
}