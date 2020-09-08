package tStates.tCommands.tReceivers{
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import flash.geom.Rectangle;
	
	
	public class  Grid extends Sprite implements IGrid {
		private static var theGridInstance:IGrid;
// constancts for grid graphics
		private const gridSize:uint = GlobalConstants.gridSize;
		private const gridLineThickness:Number = 1;
		private const gridLineColor:Number = 0x024AD2;
		private const gridLineAlpha:Number = .35;
		
		private const gridCordinateThickness:Number = 1.5;
		private const gridCordinateColor:Number = 0x00FF00;
		private const gridCordinateAlpha:Number = .75;
		
		private const gridBackgroundColor:Number = 0x000000;
		private const gridBackgroundAlpha:Number = .9;
		
		private const midpointAnchorThickness:Number = 4;
		private const midpointAnchorColor:uint = 0xFFFF00;
		private const midpointColor:uint = 0xCC2000;
		
		private const REG_TILE:String = GlobalConstants.REG_TILE
		private const JUMP_TILE:String = GlobalConstants.JUMP_TILE;
// Sprites for display hierarchy
		private var tileHolder:Sprite;
		private var gridHolder:Sprite;
		private var measureHolder:Sprite;
//Other classes references
		private var displayParent:Sprite;
		private var tileListDirector:ITileListCordinator;
		private var currentFileText:DynamicText;
// long-term data
		private var mapRectangle:Rectangle;
		
		
		private var tilesArray:Array;
		private var markerTileArray:Array;
		private var currentRatio:Number = 1;
		private var fileName:String;
		private var zoomRatiosArray:Array = new Array(600,250,175, 100, 65, 35,10);
//fast paced data
		private var lastTilePlaced:Point;
		private var lastLeftGridDraggedCorner:Point = new Point(0, 0);
		private var lastGridMovingMousePoint:Point;
		private var gridIsShown:Boolean = true;
// Midpoint Measure Tool
		private var firstMidpointPoint:Point;
		private var endMidpointPoint:Point;
		private var midPoint:Point;
		private var lastStretchPoint:Point;
		
		
		public function Grid(parent:Sprite) {
			theGridInstance = this; 
			
			tileHolder = new Sprite();
			gridHolder = new Sprite();
			measureHolder = new Sprite();
			addChild(gridHolder);
			addChild(tileHolder);
			addChild(measureHolder);
			
			this.displayParent = parent;
			displayParent.addChild(this);
			displayParent.setChildIndex(this, 0);
			
			tilesArray = new Array();
			markerTileArray = new Array();
			var markerTileAllTypesArray:Array = new MarkerTile(1).allTypes;
			for (var i in markerTileAllTypesArray) {
				markerTileArray.push( { type: markerTileAllTypesArray[i],markerTile:null, cords:null } );
			}
			
			currentFileText = new DynamicText("", 2, 2, new TextFormat("Arial", 12, 0x00FF00, true));
			displayParent.addChild(currentFileText);
			
			newGrid();
		}
		
		public static function get instance():IGrid {
			return theGridInstance
		}
		
		
		
		public function get zoomRatios():Array {
			return this.zoomRatiosArray
		}
		
		public function set ratio(newRatio:Number):void {
			this.currentRatio = newRatio;
			var centerGridPoint:Point = gridHolder.globalToLocal(new Point(displayParent.stage.stageWidth / 2, displayParent.stage.stageHeight / 2));
			var scale:ScaleAroundPoint = new ScaleAroundPoint(this, centerGridPoint.x, centerGridPoint.y, currentRatio, currentRatio);
			updateGridLines();
		}
		public function get ratio():Number {
			return this.currentRatio;
		}
		
		public function set tiles(newTiles:Array):void {
			for (var i in newTiles) {
				if (newTiles[i].type == REG_TILE) {
					this.addTile(new Point(newTiles[i].x, newTiles[i].y), newTiles[i].graphic);
				}else if (newTiles[i].type == JUMP_TILE) {
					this.addJumpTile(new Point(newTiles[i].x, newTiles[i].y), newTiles[i].graphic);
				}
			}
		}
		public function get tiles():Array {
			return this.tilesArray;
		}
		public function set markers(newMarkers:Array):void {
			for (var i in newMarkers) {
				this.removeMarkerTile(newMarkers[i].type);
				this.setMarkerTile(newMarkers[i].type, new Point(newMarkers[i].x, newMarkers[i].y));
			}
		}
		public function get markers():Array {
			return this.markerTileArray;
		}
		
		public function set mapRect(newRect:Rectangle):void {
			this.mapRectangle = newRect;
		}
		public function get mapRect():Rectangle {
			return this.mapRectangle;
		}
		
		public function updateGridLines():void {
			gridHolder.graphics.clear();
			var topLeft:Point = this.globalToLocal(new Point(0,0));
			gridHolder.graphics.beginFill(gridBackgroundColor, gridBackgroundAlpha);
			gridHolder.graphics.drawRect(topLeft.x-gridSize, topLeft.y-gridSize, (stage.stageWidth*(1/currentRatio)+(gridSize*2)), (stage.stageHeight*(1/currentRatio))+(gridSize*2));
			gridHolder.graphics.endFill();
			
			if(gridIsShown){
				gridHolder.graphics.lineStyle(gridLineThickness, gridLineColor,gridLineAlpha);
				
				topLeft.x = Math.floor(topLeft.x / gridSize) * gridSize;
				topLeft.y = Math.floor(topLeft.y / gridSize) * gridSize;
				
				var counterX:int;
				var x:int = topLeft.x / gridSize;
				var counterY:int;
				var y:int = topLeft.y / gridSize;
				while (counterX <= Math.ceil((displayParent.stage.stageWidth / gridSize)*(1/currentRatio)) ) {
					gridHolder.graphics.moveTo(x*gridSize, topLeft.y);
					gridHolder.graphics.lineTo(x * gridSize, topLeft.y + Math.ceil((displayParent.stage.stageHeight)*(1/currentRatio))+gridSize);
					counterX++;
					x++;
				}
				while (counterY <= Math.ceil((displayParent.stage.stageHeight / gridSize)*(1/currentRatio)) ) {
					gridHolder.graphics.moveTo(topLeft.x, y * gridSize);
					gridHolder.graphics.lineTo(topLeft.x + Math.ceil((displayParent.stage.stageWidth)*(1/currentRatio))+gridSize, y * gridSize);
					counterY++;
					y++;
				}
				
				
				gridHolder.graphics.lineStyle(gridCordinateThickness, gridCordinateColor, gridCordinateAlpha);
				var convertedPoint:Point = globalToLocal(new Point(0, 0));
				
				var startX:int = convertedPoint.x - (stage.stageWidth / 10);
				var endX:int = convertedPoint.x + (stage.stageWidth * (1 / currentRatio)) + 2 * (stage.stageWidth / 10);
				
				var startY:int = convertedPoint.y - (stage.stageWidth / 10);
				var endY:int = convertedPoint.y + (stage.stageHeight * (1 / currentRatio)) + 2 * (stage.stageWidth / 10);
				
				var cordinatePointsArray:Array = new Array( { x:startX, y: 0 }, { x:endX, y:0 }, { x: 0, y:startY },{ x:  0, y:endY } );
				for (var i:int = 0; i < cordinatePointsArray.length;i+=2 ) {
					gridHolder.graphics.moveTo(cordinatePointsArray[i].x, cordinatePointsArray[i].y);
					gridHolder.graphics.lineTo(cordinatePointsArray[i+1].x, cordinatePointsArray[i+1].y);
				}
			}
			gridHolder.graphics.lineStyle(2, 0xCC0000, 1);
			if(mapRectangle!=null){
				gridHolder.graphics.drawRect(mapRectangle.x * gridSize, mapRectangle.y * gridSize, mapRectangle.width * gridSize, mapRectangle.height * gridSize);
			}
		}
		
		public function addTile(tileCords:Point, type:uint):void {
			var newTile:Tile = new Tile(type);
			
			basicAdd(newTile, tileCords,REG_TILE);
		}
		public function addJumpTile(tileCords:Point, type:uint):void {
			var newJumpTile:JumpTile = new JumpTile(type);
			
			basicAdd(newJumpTile, tileCords,JUMP_TILE);
		}
		private function basicAdd(toBasicAdd:Sprite,tileCords:Point,typeOfAdd:String):void {
			var tilePlacement:Point = new Point(tileCords.x * gridSize, tileCords.y * gridSize);
			
			toBasicAdd.x = tilePlacement.x
			toBasicAdd.y = tilePlacement.y;
			
			tileHolder.addChild(toBasicAdd);
			tilesArray.push( { tile:toBasicAdd, type:typeOfAdd, cords:tileCords } );
			
			lastTilePlaced = tileCords.clone();
			
			checkSetMapRectangle(tileCords);
		}
		public function removeTile(tileCords:Point):void {
			for (var i in tilesArray) {
				if (tilesArray[i].cords.equals(tileCords)) {
					tileHolder.removeChild(tilesArray[i].tile);
					tilesArray[i].tile = null;
					tilesArray.splice(i, 1);
					checkSetMapRectangle(tileCords,true);
					break;
				}
			}
		}
		public function removeJumpTile(tileCords:Point):void {
			removeTile(tileCords);
		}
		
		private function checkSetMapRectangle(tileCords:Point,deleted:Boolean=false):void {
			// ;D
			if (mapRectangle == null) {
				mapRectangle = new Rectangle(tileCords.x, tileCords.y,1,1);
			}
			if (deleted) {
				mapRectangle = null;
				for (var i in tilesArray) {
					checkSetMapRectangle(tilesArray[i].cords);
				}
			}else{
				if (tileCords.x < mapRectangle.x) {
					mapRectangle.width += (mapRectangle.x - tileCords.x);
					mapRectangle.x = tileCords.x;
				}
				if (tileCords.y < mapRectangle.y) {
					mapRectangle.height += (mapRectangle.y - tileCords.y);
					mapRectangle.y = tileCords.y;
				}
				if (tileCords.x > (mapRectangle.x + mapRectangle.width)-1) {
					mapRectangle.width += (tileCords.x - (mapRectangle.width+mapRectangle.x-1));
				}
				if (tileCords.y > (mapRectangle.y + mapRectangle.height)-1) {
					mapRectangle.height += (tileCords.y - (mapRectangle.height+mapRectangle.y-1));
				}
			}
			updateGridLines();
		}
		
		
		public function setMarkerTile(type:uint, tileCords:Point):void {
			var markerTilePlacement:Point = new Point(tileCords.x * gridSize, tileCords.y * gridSize);
			
			var newMarkerTile:DynamicBlock = new MarkerTile(type);
			newMarkerTile.x = markerTilePlacement.x;
			newMarkerTile.y = markerTilePlacement.y;
			tileHolder.addChild(newMarkerTile);
			
			var index:uint = getIndexOfMarkerTileObject(type);
			markerTileArray[index].markerTile = newMarkerTile;
			markerTileArray[index].cords = tileCords.clone();
		}
		public function removeMarkerTile(type:uint):void {
			var index:int = getIndexOfMarkerTileObject(type);
			
			tileHolder.removeChild(markerTileArray[index].markerTile);
			markerTileArray[index].markerTile = null;
			markerTileArray[index].cords = null;
		}
		public function isMarkerTileSet(type:uint):Boolean {
			var index:uint = getIndexOfMarkerTileObject(type);
			
			if (markerTileArray[index].markerTile != null) {
				return true;
			}
			return false
		}
		private function getIndexOfMarkerTileObject(type:uint):int {
			for (var i in markerTileArray) {
				if (markerTileArray[i].type == type) {
					return i
				}
			}
			return -1;
		}
		
		
		public function validateTilePlacement(tileCords:Point):Boolean {
			if (lastTilePlaced != null) {
				if (tileCords.equals(lastTilePlaced)) return false;
			}
			for(var i in tilesArray){
				if (tilesArray[i].cords.equals(tileCords)) {
					return false;
				}
			}
			for (var index in markerTileArray) {
				if (markerTileArray[index].cords != null && markerTileArray[index].cords.equals(tileCords)) {
					return false;
				}
			}
			return true;
		}
		public function getTypeAt(tileCords:Point):uint {
			for (var i in tilesArray) {
				if (tilesArray[i].cords.equals(tileCords)) {
					return tilesArray[i].tile.graphic;
				}
			}
			return null;
		}
		public function getTilePoint(stagePoint:Point):Point {
			var convertedPoint:Point = globalToLocal(stagePoint);
			var tileCords:Point = new Point(Math.floor(convertedPoint.x / gridSize), Math.floor(convertedPoint.y / gridSize));
			return tileCords;
		}
		
		public function startGridMove(event:MouseEvent):void {
			lastGridMovingMousePoint = new Point(event.stageX, event.stageY);
		}
		public function moveGrid(event:MouseEvent):void {
			var mouseMoved:Point = new Point(event.stageX - lastGridMovingMousePoint.x, event.stageY - lastGridMovingMousePoint.y);
			
			this.x += mouseMoved.x;
			this.y += mouseMoved.y;
			
			lastGridMovingMousePoint.x += mouseMoved.x;
			lastGridMovingMousePoint.y += mouseMoved.y;
			
			var thisLeftCorner:Point = getTilePoint(new Point(0, 0));
			
			if (!thisLeftCorner.equals(lastLeftGridDraggedCorner)) {
				lastLeftGridDraggedCorner = thisLeftCorner;
				updateGridLines();
			}
		}
		
		public function newGrid():void {
//DEFAULT==========================
			
			for (var i:int = tilesArray.length - 1; i >= 0; i--) {
				removeTile(tilesArray[i].cords);
			}
			for (var p:int = markerTileArray.length - 1; p >= 0; p--) {
				if (isMarkerTileSet(markerTileArray[p].type)) {
					removeMarkerTile(markerTileArray[p].type);
				}
				setMarkerTile(markerTileArray[p].type, new Point(p, -1));
			}
			
			lastTilePlaced = null;
			
			this.x = 100;
			this.y = stage.stageHeight - 100;
			this.ratio = 1;
			mapRectangle = null;
			this.file = "Untitled.xml";
		}
		
		
		public function set file(newFile:String):void {
			this.fileName = newFile;
			currentFileText.text = this.fileName;
		}
		public function get file():String {
			return this.fileName;
		}
		
		public function toggleGridLines():void {
			gridIsShown = !gridIsShown;
			updateGridLines();
		}
		
		
		//Midpoint Measure tool
		public function setFirstMidpointMeasure(event:MouseEvent):void {
			measureHolder.graphics.clear();
			this.firstMidpointPoint = getMeasurePoint(new Point(event.stageX, event.stageY));
			drawAnchorMidpoint(firstMidpointPoint, midpointAnchorColor);
			lastStretchPoint = new Point(firstMidpointPoint.x, firstMidpointPoint.y);
		}
		public function moveWithMidpointMeasure(event:MouseEvent):void {
			this.endMidpointPoint= getMeasurePoint(new Point(event.stageX, event.stageY));
			if (!endMidpointPoint.equals(lastStretchPoint)) {
				lastStretchPoint = new Point(endMidpointPoint.x, endMidpointPoint.y);
				measureHolder.graphics.clear();
				drawAnchorMidpoint(firstMidpointPoint, midpointAnchorColor);
				drawAnchorMidpoint(endMidpointPoint, midpointAnchorColor);
				this.midPoint = new Point((firstMidpointPoint.x + endMidpointPoint.x) / 2, (firstMidpointPoint.y + endMidpointPoint.y) / 2);
				drawAnchorMidpoint(midPoint, midpointColor);
			}
		}
		public function endMidpointMeasure(event:MouseEvent):void {
			moveWithMidpointMeasure(event);
		}
		private function getMeasurePoint(stageCords:Point):Point {
			var measurePoint:Point = getTilePoint(stageCords);
			measurePoint.x = (measurePoint.x * gridSize) + gridSize / 2;
			measurePoint.y = (measurePoint.y * gridSize) + gridSize / 2;
			return measurePoint;
		}
		private function drawAnchorMidpoint(point:Point,color:uint):void {
			measureHolder.graphics.lineStyle(midpointAnchorThickness, color);
			measureHolder.graphics.drawRect(point.x - gridSize / 2, point.y - gridSize / 2, gridSize, gridSize);
		}
		
	}
}