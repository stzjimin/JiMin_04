package
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;

	public class FileIOManager
	{
		private var _file:File = new File();
		private var _completeFunc:Function;
		
		public function FileIOManager()
		{
			_file = File.documentsDirectory;
		}
		
		public function selectFile(title:String ,fileFilter:FileFilter, completeFunc:Function):void
		{
			_file.addEventListener(Event.SELECT, onClickInputSelectButton);
			_completeFunc = completeFunc;
			_file.browseForOpen(title,[fileFilter]);
		}
		
		public function saveFile(title:String, completeFunc:Function):void
		{
			_file.addEventListener(Event.SELECT, onClickOutputSelectButton);
			_completeFunc = completeFunc;
			_file.browseForSave(title);
		}
		
		private function onClickInputSelectButton(event:Event):void
		{
			_file.removeEventListener(Event.SELECT, onClickInputSelectButton);
			_completeFunc(_file.nativePath);
		}
		
		private function onClickOutputSelectButton(event:Event):void
		{
			_file.removeEventListener(Event.SELECT, onClickOutputSelectButton);
			_completeFunc(_file.nativePath);
		}
	}
}