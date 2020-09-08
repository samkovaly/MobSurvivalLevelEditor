package tStates.tCommands.tReceivers{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class TileListCordinator extends Sprite implements ITileListCordinator {
		private static var theTileListCordinatorInstance:ITileListCordinator;
		
		private const alphaOfDrag:Number = 1;
		private var displayParent:DisplayObjectContainer;
		
		private  var mouseDown:Boolean;
		private static var dragging:Boolean;
		
		private static var blockBeingDragged:DynamicBlock;
		
		
		public function TileListCordinator(parent:DisplayObjectContainer) {
			theTileListCordinatorInstance = this;
			
			this.displayParent = parent;
			displayParent.addChild(this);
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		
		public static function get instance():ITileListCordinator {
			return theTileListCordinatorInstance;
		}
		
		public static function get typeOfDraggingTile():uint {
			if (dragging) return DynamicBlock(blockBeingDragged).graphic;
			return null;
		}
		
		
		public function startBlockDrag(newDrag:DynamicBlock):void {
			if (isDragging()) stopCurrentDrag();
			
			newDrag.alpha = alphaOfDrag;
			addChild(newDrag);
			blockBeingDragged = newDrag;
			dragging = true;
			displayParent.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
			
			
			mouseMoveListener();
			
		}
		public function stopCurrentDrag():void {
			
			displayParent.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveListener);
			removeChild(blockBeingDragged);
			blockBeingDragged = null;
			dragging = false;
		}
		public function isDragging():Boolean {
			return dragging;
		}
		private function mouseMoveListener(event:MouseEvent = null):void {
			blockBeingDragged.x = displayParent.stage.mouseX - (blockBeingDragged.width / 2);
			blockBeingDragged.y = displayParent.stage.mouseY - (blockBeingDragged.height / 2);
		}
		
		public function toggleShowCurrentDrag(show:Boolean):void {
			if (dragging) blockBeingDragged.visible = show;
		}
		
		
		public function toggleUI(UIArray:Array):void {
			for (var i in UIArray) {
				UIArray[i].visible=!UIArray[i].visible
			}
		}
	}
}