package tStates.tCommands{
	import tStates.tCommands.tReceivers.Commands;
	import tStates.tCommands.tReceivers.ITileListCordinator;
	
	public class DeleteCommandClicked implements ICommand {
		
		private var stateWorker:Object;
		private var receiver:ITileListCordinator;
		
		public function DeleteCommandClicked(stateWorker:Object, rec:ITileListCordinator):void {
			this.stateWorker = stateWorker;
			this.receiver = rec;
		}
		public function execute(redo:Boolean = false):void {
			stateWorker.setIsDeleting();
			receiver.startBlockDrag(new Commands(Commands.DELETE));
		}
	}
}