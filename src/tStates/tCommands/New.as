package tStates.tCommands{
	import tStates.tCommands.tReceivers.FileOperator
	
	public class New implements ICommand{
		private var receiver:FileOperator;
		
		public function New(rec:FileOperator):void{
			this.receiver = rec;
		}
		
		public function execute(redo:Boolean = false):void {
			receiver.newFile();
		}
	}
}