package tStates.tCommands{
	import tStates.tCommands.tReceivers.FileOperator;
	
	public class Save implements ICommand{
		private var receiver:FileOperator;
		
		public function Save(rec:FileOperator):void{
			this.receiver = rec;
		}
		
		public function execute(redo:Boolean = false):void {
			receiver.save();
		}
	}
}