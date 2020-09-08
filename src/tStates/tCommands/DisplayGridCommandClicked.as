package tStates.tCommands{
	import tStates.tCommands.tReceivers.IGrid;
	
	public class DisplayGridCommandClicked implements ICommand {
		
		private var receiver:IGrid;
		
		public function DisplayGridCommandClicked(rec:IGrid):void {
			this.receiver = rec
		}
		public function execute(redo:Boolean = false):void {
			receiver.toggleGridLines();
		}
	}
}