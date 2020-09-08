package tStates.tCommands{
	import tStates.tCommands.tReceivers.Commands;
	import tStates.tCommands.tReceivers.ITileListCordinator;
	
	public class MidpointCommandClicked implements ICommand {
		
		private var stateWorker:Object;
		private var receiver:ITileListCordinator;
		
		public function MidpointCommandClicked(stateWorker:Object, rec:ITileListCordinator):void {
			this.stateWorker = stateWorker;
			this.receiver = rec;
		}
		public function execute(redo:Boolean = false):void {
			stateWorker.setMidpointing();
			receiver.startBlockDrag(new Commands(Commands.MIDPOINT));
		}
	}
}