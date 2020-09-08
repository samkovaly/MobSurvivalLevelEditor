package tStates.tCommands.tReceivers{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Xiler
	 */
	// ABSTRACT CLASS
	public class DynamicBlock extends MovieClip {
		private var sizeOfSquare:int = 30;
		private var graphicOfBlock:int;
		
		public function DynamicBlock(newGraphic:uint) {
			this.graphic = newGraphic;
		}
		
		public function set graphic(newGraphic:uint):void {
			this.graphicOfBlock= newGraphic;
			this.gotoAndStop(this.graphicOfBlock);
		}
		public function get graphic():uint {
			return this.graphicOfBlock;
		}
		
		public function get size():uint {
			return this.sizeOfSquare;
		}
		
		//ABSTRACT FUNCTION
		public function getInstance(newGraphic:uint):DynamicBlock {
			return null;
		};
		
		public  function get allTypes():Array {
			var totalFrames:uint = this.totalFrames;
			var newArray:Array = new Array();
			for (var i:int = 1; i <= totalFrames; i++) {
				newArray.push(i);
			}
			return newArray;
		}
	}
}