package tStates.tCommands{
	import flash.display.DisplayObject;
	import tStates.tCommands.tReceivers.ITileListCordinator;
	
	public class DisplayUICommandClicked implements ICommand {
		
		private var receiver:ITileListCordinator;
		private var UIArray:Array;
		
		public function DisplayUICommandClicked(UIArray:Array,rec:ITileListCordinator):void {
			this.receiver = rec;
			this.UIArray = UIArray;
		}
		public function setRefraneUI(UIToRefrane:DisplayObject) {
			var newArray:Array = new Array();
			for (var i in UIArray) {
				if (UIArray[i] != UIToRefrane) {
					newArray.push(UIArray[i]);
				}
			}
			UIArray = newArray;
		}
		public function execute(redo:Boolean = false):void {
			receiver.toggleUI(UIArray);
		}
	}
}