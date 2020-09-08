package tStates.tCommands.tReceivers{
	/**
	 * ...
	 * @author Xiler
	 */
	
	public class JumpTile extends DynamicBlock {
		
		public function JumpTile(newGraphic:uint) {
			super(newGraphic);
		}
		override public function getInstance(newGraphic:uint):DynamicBlock {
			return new JumpTile(newGraphic);
		}
	}
}