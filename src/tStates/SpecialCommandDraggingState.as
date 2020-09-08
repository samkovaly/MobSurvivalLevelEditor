package tStates{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import tStates.tCommands.tReceivers.IGrid;
	import tStates.tCommands.tReceivers.Grid;
	import tStates.tCommands.tReceivers.MarkerTile;
	import tStates.tCommands.tReceivers.ITileListCordinator
	import tStates.tCommands.tReceivers.TileListCordinator
	/**
	 * ...
	 * @author Xiler
	 */
	
	//(AKA: MARKER TILE DRAGGING STATE)
	public class SpecialCommandDraggingState implements State{
		private var stateWorker:StateWorker
		private var grid:IGrid = Grid.instance;
		private var currentDraggingDynamicBlockType:uint;
		
		public function SpecialCommandDraggingState(stateWorker:StateWorker) {
			this.stateWorker = stateWorker;
		}
		public function setTileDrag():void {
			stateWorker.state = stateWorker.sTileDragging;
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
			
		}
		
		public function mouseDownGrid(event:MouseEvent):void {
			currentDraggingDynamicBlockType = TileListCordinator.typeOfDraggingTile;
			mouseMoveGrid(event);
		}
		public function mouseMoveGrid(event:MouseEvent):void {
			var tileCords:Point = grid.getTilePoint(new Point(event.stageX, event.stageY));
			if (grid.validateTilePlacement(tileCords)) {
				if (grid.isMarkerTileSet(currentDraggingDynamicBlockType)) {
					grid.removeMarkerTile(currentDraggingDynamicBlockType);
				}
				grid.setMarkerTile(currentDraggingDynamicBlockType, tileCords);
			}
		}
		public function mouseUpGrid(event:MouseEvent):void {
			
		}
	}
}