package tStates.tCommands {
	import tStates.tCommands.tReceivers.FileOperator
	
	public class SaveAs implements ICommand {
		private var receiver:FileOperator;
		
		public function SaveAs(rec:FileOperator):void {
			this.receiver = rec;
		}
		
		public function execute(redo:Boolean = false):void {
			receiver.saveAs();
		}
	}
}