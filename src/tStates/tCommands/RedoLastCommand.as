package tStates.tCommands{
	import flash.errors.IllegalOperationError;
	public class RedoLastCommand extends CommandUndoRedo {
		
		override public function execute(redo:Boolean=false):void {
			if (possibleRedos.length) {
				var redoneCommad:CommandUndoRedo = possibleRedos.pop();
				redoneCommad.redo();
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