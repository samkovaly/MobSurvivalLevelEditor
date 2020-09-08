package tStates.tCommands.tReceivers{
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public interface IGrid {
		
		function set ratio(newRatio:Number):void;
		function get ratio():Number;
		
		function set tiles(newTiles:Array):void;
		function get tiles():Array;
		function set markers(newMarkers:Array):void;
		function get markers():Array;
		function set mapRect(newRect:Rectangle):void;
		function get mapRect():Rectangle;
		
		
		function updateGridLines():void;
		
		function addTile(tileCords:Point, type:uint):void;
		function removeTile(tileCords:Point):void;
		
		function addJumpTile(tileCords:Point, type:uint):void;
		function removeJumpTile(tileCords:Point):void;
		
		function setMarkerTile(type:uint, tileCords:Point):void;
		function removeMarkerTile(type:uint):void;
		function isMarkerTileSet(type:uint):Boolean;
		
		function validateTilePlacement(tileCords:Point):Boolean;
		
		function getTypeAt(tileCords:Point):uint;
		function getTilePoint(stagePoint:Point):Point;
		
		function startGridMove(event:MouseEvent):void;
		function moveGrid(event:MouseEvent):void;
		
		function newGrid():void;
		
		function set file(newFile:String):void;
		function get file():String;
		
		function toggleGridLines():void;
		
		function setFirstMidpointMeasure(event:MouseEvent):void;
		function moveWithMidpointMeasure(event:MouseEvent):void;
		function endMidpointMeasure(event:MouseEvent):void;
		
	}
}