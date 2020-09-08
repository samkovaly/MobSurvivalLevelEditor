package tStates{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import tStates.tCommands.tReceivers.IGrid;
	import tStates.tCommands.tReceivers.Grid;
	import tStates.tCommands.CommandUndoRedo;
	import tStates.tCommands.RemoveTile;
	/**
	 * ...
	 * @author Xiler
	 */
	
	public class IsDeletingState implements State{
		private var stateWorker:StateWorker
		private var grid:IGrid=Grid.instance
		private var removeTile:CommandUndoRedo;
		
		public function IsDeletingState(stateWorker:StateWorker) {
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
			var mousePoint:Point=new Point(event.stageX, event.stageY)
			var tileCords:Point = grid.getTilePoint(mousePoint);
			if (!grid.validateTilePlacement(tileCords)){
				removeTile = new RemoveTile(grid, tileCords, grid.getTypeAt(tileCords));
				removeTile.execute();
			}
		}
		public function mouseUpGrid(event:MouseEvent):void {
			
		}
	}
}