package tStates.tCommands.tReceivers{
	/**
	 * ...
	 * @author Xiler
	 */
	
	public class Commands extends DynamicBlock {
		private var draggingSize:Number = 1.5;
		//(in acordence to frame)
		public static const MOVE:uint = 1;
		public static const DELETE:uint = 2;
		public static const MIDPOINT:uint = 3;
		
		public function Commands(newGraphic:uint) {
			super(newGraphic);
			this.scaleX = 1
			this.scaleY = 1
		}
		override public function getInstance(newGraphic:uint):DynamicBlock {
			var newInstance:DynamicBlock = new Commands(newGraphic);
			Commands(newInstance).commandOutline.visible = false;
			newInstance.scaleX = draggingSize;
			newInstance.scaleY = draggingSize;
			return newInstance;
		}
	}
}
