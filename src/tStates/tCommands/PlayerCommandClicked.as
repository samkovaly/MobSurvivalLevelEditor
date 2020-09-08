package tStates.tCommands{
	import tStates.tCommands.tReceivers.MarkerTile;
	import tStates.tCommands.tReceivers.ITileListCordinator;
	
	public class PlayerCommandClicked implements ICommand {
		
		private var stateWorker:Object;
		private var receiver:ITileListCordinator;
		
		public function PlayerCommandClicked(stateWorker:Object , rec:ITileListCordinator):void {
			this.stateWorker = stateWorker;
			this.receiver = rec;
		}
		public function execute(redo:Boolean = false):void {
			stateWorker.setSpecialCommandDrag();
			receiver.startBlockDrag(new MarkerTile(MarkerTile.PLAYER));
		}
	}
}