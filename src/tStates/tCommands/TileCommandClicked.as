package tStates.tCommands{
	import tStates.tCommands.tReceivers.ITileListCordinator;
	import tStates.tCommands.tReceivers.Tile;
	
	public class TileCommandClicked implements ICommand {
		
		private var stateWorker:Object;
		private var receiver:ITileListCordinator;
		private var tileGraphic:uint;
		
		public function TileCommandClicked(stateWorker:Object, rec:ITileListCordinator):void {
			this.stateWorker = stateWorker;
			this.receiver = rec;
		}
		public function changeTile(newTile:uint):void {
			this.tileGraphic = newTile;
		}
		public function execute(redo:Boolean = false):void {
			stateWorker.setTileDrag();
			receiver.startBlockDrag(new Tile(tileGraphic));
		}
	}
}