package tStates.tCommands{
	import flash.errors.IllegalOperationError;
	public class UndoLastCommand extends CommandUndoRedo {
		
		override public function execute(redo:Boolean=false):void {
			if (commandHistory.length){
				var lastCommand:CommandUndoRedo = commandHistory.pop( );
				lastCommand.undo( );
			}
		}
		override public function undo( ):void{
			throw new IllegalOperationError("undo operation not supported on this command");
		}
		override public function redo( ):void{
			throw new IllegalOperationError("redo operation not supported on this command");
		}
	}
}