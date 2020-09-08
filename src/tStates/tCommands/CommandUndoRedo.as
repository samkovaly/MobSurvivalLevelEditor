package tStates.tCommands{
	// ABSTRACT Class (should be subclassed and not instantiated)
	public class CommandUndoRedo implements ICommand{
		internal static var commandHistory:Array = new Array( );
		internal static var possibleRedos:Array = new Array();
		
		public function execute(redo:Boolean=false):void {
			commandHistory.push(this);
			if (!redo && possibleRedos.length) {
				possibleRedos = [];
			}
		}
		public function undo( ):void {
			possibleRedos.push(this);
		}
		public function redo( ):void { 
			this.execute(true);
		}
	}
}