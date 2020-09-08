package tStates.tCommands{
	import flash.geom.Point;
	import tStates.tCommands.tReceivers.IGrid;
	
	public class PlaceJumpTile extends CommandUndoRedo{
		private var receiver:IGrid;
		private var tilePoint:Point;
		private var type:uint;
		
		public function PlaceJumpTile(rec:IGrid, point:Point, type:uint):void {
			this.receiver = rec;
			this.tilePoint = point;
			this.type = type;
		}
		
		override public function execute(redo:Boolean = false):void {
			receiver.addJumpTile(this.tilePoint,this.type);
			super.execute(redo);
		}
		override public function undo( ):void{
			receiver.removeJumpTile(this.tilePoint);
			super.undo();
		}
	}
}