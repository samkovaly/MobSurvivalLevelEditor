package tStates{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Xiler
	 */
	
	 import tStates.tCommands.PlaceTile;
	 import tStates.tCommands.CommandUndoRedo;
	 import tStates.tCommands.tReceivers.IGrid;
	 import tStates.tCommands.tReceivers.Grid;
	 import tStates.tCommands.tReceivers.TileListCordinator;
	 
	public class TileDraggingState implements State{
		private var stateWorker:StateWorker
		private var placeTile:CommandUndoRedo;
		
		private var grid:IGrid = Grid.instance;
		
		public function TileDraggingState(stateWorker:StateWorker) {
			this.stateWorker = stateWorker;
		}
		public function setTileDrag():void {
		}
		public function setJumpTileDrag():void {
			stateWorker.state = stateWorker.sJumpTileDragging;
		}
		public function setGridDrag():void {
			stateWorker.state = stateWorker.sGridDragging;
		}
		public function setIsDeleting():void {
			stateWorker.state = stateWorker.sIsDeleting;
		}
		public function setMidpointing():void {
			stateWorker.state = stateWorker.sMidpointing;
		}
		public function setSpecialCommandDrag():void {
			stateWorker.state = stateWorker.sSpecialCommandDrag;
		}
		
		public function mouseDownGrid(event:MouseEvent):void {
			mouseMoveGrid(event);
		}
		public function mouseMoveGrid(event:MouseEvent):void {
			var mousePoint:Point = new Point(event.stageX, event.stageY);
			var tileCords:Point = grid.getTilePoint(mousePoint);
			if (grid.validateTilePlacement(tileCords)) {
				placeTile = new PlaceTile(grid, tileCords, TileListCordinator.typeOfDraggingTile);
				placeTile.execute();
			}
		}
		public function mouseUpGrid(event:MouseEvent):void {
			
		}
	}
}