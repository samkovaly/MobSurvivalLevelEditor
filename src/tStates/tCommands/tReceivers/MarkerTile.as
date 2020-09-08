package tStates.tCommands.tReceivers{
	/**
	 * ...
	 * @author Xiler
	 */
	
	public class MarkerTile extends DynamicBlock {
		private var draggingSize:Number = 1.25;
		//(in acordence to frame)
		public static const PLAYER:uint = 1;
		
		public function MarkerTile(newGraphic:uint) {
			super(newGraphic);
			this.scaleX = 1
			this.scaleY = 1
		}
		override public function getInstance(newGraphic:uint):DynamicBlock {
			var newInstance:DynamicBlock = new MarkerTile(newGraphic);
			newInstance.scaleX = draggingSize;
			newInstance.scaleY = draggingSize;
			return newInstance;
		}
	}
}
