package tStates.tCommands{
	import tStates.tCommands.tReceivers.FileOperator
	
	public class Load implements ICommand{
		private var receiver:FileOperator;
		
		public function Load(rec:FileOperator):void{
			this.receiver = rec;
		}
		public function execute(redo:Boolean = false):void {
			receiver.load();
		}
	}
}