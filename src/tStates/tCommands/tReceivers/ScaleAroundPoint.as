package tStates.tCommands.tReceivers{
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.display.DisplayObject;
	import flash.geom.Point;
	
	public class  ScaleAroundPoint{
		public function ScaleAroundPoint (object:DisplayObject, offsetX:Number, offsetY:Number, absScaleX:Number, absScaleY:Number ){
			var relScaleX:Number = absScaleX / object.scaleX;
			var relScaleY:Number = absScaleY / object.scaleY;
			var AC:Point = new Point( offsetX, offsetY );
			AC = object.localToGlobal( AC );
			AC = object.parent.globalToLocal( AC );
			var AB:Point = new Point( object.x, object.y );
			var CB:Point = AB.subtract( AC );
			CB.x *= relScaleX;
			CB.y *= relScaleY;
			AB = AC.add( CB );
			object.scaleX *= relScaleX;
			object.scaleY *= relScaleY;
			object.x = AB.x;
			object.y = AB.y;
		}
	}
	
}