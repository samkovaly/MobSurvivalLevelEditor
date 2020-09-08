package tStates{
	import flash.events.MouseEvent;
	import tStates.tCommands.tReceivers.IGrid;
	import tStates.tCommands.tReceivers.Grid;
	/**
	 * ...
	 * @author Xiler
	 */
	
	public class MidpointingState implements State{
		private var stateWorker:StateWorker
		private var grid:IGrid = Grid.instance;
		
		public function MidpointingState(stateWorker:StateWorker) {
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
			stateWorker.state = stateWorker.sIsDeleting
		}
		public function setMidpointing():void {
		}
		public function setSpecialCommandDrag():void {
			stateWorker.state = stateWorker.sSpecialCommandDrag;
		}
		
		public function mouseDownGrid(event:MouseEvent):void {
			grid.setFirstMidpointMeasure(event);
		}
		public function mouseMoveGrid(event:MouseEvent):void {
			grid.moveWithMidpointMeasure(event);
		}
		public function mouseUpGrid(event:MouseEvent):void {
			grid.endMidpointMeasure(event);
		}
	}
}