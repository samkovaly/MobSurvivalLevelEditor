package tStates.tCommands.tReceivers{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Xiler
	 */
	public interface ITileListCordinator {
		function isDragging():Boolean;
		function startBlockDrag(object:DynamicBlock):void;
		function stopCurrentDrag():void;
		function toggleShowCurrentDrag(show:Boolean):void;
		
		function toggleUI(UIArray:Array):void;
	}
}