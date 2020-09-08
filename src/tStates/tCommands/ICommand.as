package tStates.tCommands{
	public interface ICommand {
		function execute(redo:Boolean=false):void;
	}
}