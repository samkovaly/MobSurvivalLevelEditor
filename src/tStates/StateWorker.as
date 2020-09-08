package tStates{
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.events.MouseEvent;
	 
	public class  StateWorker {
//States here
		private var tileDraggingState:State;
		private var jumpTileDraggingState:State;
		private var gridDraggingState:State;
		private var isDeletingState:State;
		private var midpointingState:State;
		private var specialCommandDrag:State;
		
		private var currentState:State;
		public function StateWorker() {
//New states
			tileDraggingState = new TileDraggingState(this);
			jumpTileDraggingState = new JumpTileDraggingState(this);
			gridDraggingState = new GridDraggingState(this);
			isDeletingState = new IsDeletingState(this);
			midpointingState = new MidpointingState(this);
			specialCommandDrag = new SpecialCommandDraggingState(this);
			
			currentState = tileDraggingState;
		}
//Commands for sates to do
		public function setTileDrag():void {
			currentState.setTileDrag();
		}
		public function setJumpTileDrag():void {
			currentState.setJumpTileDrag();
		}
		public function setGridDrag():void {
			currentState.setGridDrag();
		}
		public function setIsDeleting():void {
			currentState.setIsDeleting();
		}
		public function setMidpointing():void {
			currentState.setMidpointing();
		}
		public function setSpecialCommandDrag():void {
			currentState.setSpecialCommandDrag();
		}
		
		public function mouseDownGrid(event:MouseEvent):void {
			currentState.mouseDownGrid(event);
		}
		public function mouseMoveGrid(event:MouseEvent):void {
			currentState.mouseMoveGrid(event);
		}
		public function mouseUpGrid(event:MouseEvent):void {
			currentState.mouseUpGrid(event);
		}
//Set/Get state
		public function set state(newState:State):void {
			this.currentState = newState;
		}
		public function get state():State {
			return currentState;
		}
//Getters for states
		public function get sTileDragging():State {
			return this.tileDraggingState;
		}
		public function get sJumpTileDragging():State {
			return this.jumpTileDraggingState;
		}
		public function get sGridDragging():State {
			return this.gridDraggingState;
		}
		public function get sIsDeleting():State {
			return this.isDeletingState;
		}
		public function get sMidpointing():State {
			return this.midpointingState;
		}
		public function get sSpecialCommandDrag():State {
			return this.specialCommandDrag;
		}
	}
}