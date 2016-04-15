package
{
	import flash.events.Event;
	import flash.filesystem.File;

	public class FileOutput
	{
		private var _file:File = new File();
		private var _completeFunc:Function;
		
		public function FileOutput()
		{
			_file = File.documentsDirectory;
			_file.addEventListener(Event.SELECT, onClickOutputSelectButton);
		}
		
		public function saveFile(title:String, completeFunc:Function):void
		{
			_completeFunc = completeFunc;
			_file.browseForSave(title);
		}
		
		private function onClickOutputSelectButton(event:flash.events.Event):void
		{
			_file.removeEventListener(flash.events.Event.SELECT, onClickOutputSelectButton);
			_completeFunc(_file.nativePath);
		}
	}
}