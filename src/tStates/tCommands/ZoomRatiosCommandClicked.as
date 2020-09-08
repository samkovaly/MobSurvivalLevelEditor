package tStates.tCommands{
	import tStates.tCommands.tReceivers.IGrid
	
	public class ZoomRatiosCommandClicked implements ICommand {
		
		private var receiver:IGrid
		private var ratio:Number;
		
		public function ZoomRatiosCommandClicked(rec:IGrid):void {
			this.receiver = rec;
		}
		public function changeRatio(newRatio:Number) {
			this.ratio = newRatio;
		}
		public function execute(redo:Boolean = false):void {
			receiver.ratio = this.ratio;
		}
	}
}