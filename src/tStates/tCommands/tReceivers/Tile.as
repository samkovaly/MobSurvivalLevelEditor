package tStates.tCommands.tReceivers{
	/**
	 * ...
	 * @author Xiler
	 */
	
	public class Tile extends DynamicBlock {
		
		public function Tile(newGraphic:uint) {
			super(newGraphic);
		}
		override public function getInstance(newGraphic:uint):DynamicBlock {
			return new Tile(newGraphic);
		}
	}
}