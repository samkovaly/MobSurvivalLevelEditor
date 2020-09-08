package tStates.tCommands{
	import tStates.tCommands.tReceivers.ITileListCordinator;
	import tStates.tCommands.tReceivers.JumpTile;
	
	public class JumpTileCommandClicked implements ICommand {
		
		private var stateWorker:Object;
		private var receiver:ITileListCordinator;
		private var tileGraphic:uint;
		
		public function JumpTileCommandClicked(stateWorker:Object, rec:ITileListCordinator):void {
			this.stateWorker = stateWorker;
			this.receiver = rec;
		}
		public function changeTile(newTile:uint):void {
			this.tileGraphic = newTile;
		}
		public function execute(redo:Boolean = false):void {
			stateWorker.setJumpTileDrag();
			receiver.startBlockDrag(new JumpTile(tileGraphic));
		}
	}
}