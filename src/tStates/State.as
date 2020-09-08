package tStates{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Xiler
	 */
	
	public interface State {
		
		function setTileDrag():void;
		function setJumpTileDrag():void;
		function setGridDrag():void;
		function setIsDeleting():void;
		function setMidpointing():void;
		function setSpecialCommandDrag():void;
		
		function mouseDownGrid(event:MouseEvent):void;
		function mouseMoveGrid(event:MouseEvent):void;
		function mouseUpGrid(event:MouseEvent):void;
	}
	
}