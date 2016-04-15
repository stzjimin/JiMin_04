package
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;

	public class FileInput
	{
		private var _file:File = new File();
		private var _completeFunc:Function;
		
		public function FileInput()
		{
			_file = File.documentsDirectory;
			_file.addEventListener(Event.SELECT, onClickInputSelectButton);
		}
		
		public function selectFile(title:String ,fileFilter:FileFilter, completeFunc:Function):void
		{
			_completeFunc = completeFunc;
			_file.browseForOpen(title,[fileFilter]);
		}
		
		private function onClickInputSelectButton(event:flash.events.Event):void
		{
			_file.removeEventListener(flash.events.Event.SELECT, onClickInputSelectButton);
			_completeFunc(_file.nativePath);
		}
	}
}