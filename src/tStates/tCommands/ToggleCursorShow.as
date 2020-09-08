package tStates.tCommands{
	import tStates.tCommands.tReceivers.ITileListCordinator;
	import flash.ui.Mouse;
	
	public class ToggleCursorShow implements ICommand {
		
		private var receiver:ITileListCordinator;
		
		public function ToggleCursorShow(rec:ITileListCordinator):void {
			this.receiver = rec;
		}
		public function execute(redo:Boolean = false):void {
			// Should not be doing this :(
			if (redo) {
				Mouse.hide();
				receiver.toggleShowCurrentDrag(true);
			}else {
				Mouse.show();
				receiver.toggleShowCurrentDrag(false);
			}
		}
	}
}