package tStates.tCommands.tReceivers{
	import flash.geom.Point;
	import flash.filesystem.File;
	import flash.geom.Rectangle;
	import flash.net.FileFilter;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	import flash.events.Event;
	import flash.xml.XMLNode;
	/**
	 * ...
	 * @author Xiler
	 */
	
	public class FileOperator{
		//Data
		private var tileArray:Array;
		private var markerArray:Array;
		private var xmlData:XML;
		
		//other classes
		private var grid:IGrid;
		
		private var fileFilter:FileFilter;
		private var file:File;
		private var fileStream:FileStream;
		
		//Boleans
		private var hasCurrentFile:Boolean = false;
		
		public function FileOperator(grid:IGrid) {
			this.grid = grid;
			this.file = File.desktopDirectory;
			this.fileStream = new FileStream();
			this.fileFilter = new FileFilter("XML", "*.xml");
			
			tileArray = new Array();
			markerArray = new Array();
		}
		
		public function load():void {
			file.browseForOpen("HI", [fileFilter]);
			file.addEventListener(Event.SELECT, userSelectedFileToLoad);
		}
		private function userSelectedFileToLoad(event:Event):void {
			file.removeEventListener(Event.SELECT, userSelectedFileToLoad);
			fileStream.open(file, FileMode.READ);
			parseXMLData(XML(fileStream.readUTFBytes(fileStream.bytesAvailable)));
			
			fileStream.close();
			hasCurrentFile = true;
			grid.file = file.name;
		}
		
		
		
		public function newFile():void {
			this.save();
			hasCurrentFile = false;
			grid.newGrid();
		}
		
		
		
		public function saveAs():void {
			inputTileArray(grid.tiles);
			inputMarkerArray(grid.markers);
			
			file.save(createXMLData());
			file.addEventListener(Event.COMPLETE, completedSave);
		}
		private function completedSave(event:Event):void {
			hasCurrentFile = true;
			grid.file = file.name;
		}
		
		
		
		public function save():void {
			if (hasCurrentFile) {
				inputTileArray(grid.tiles);
				inputMarkerArray(grid.markers);
				
				fileStream.open(file, FileMode.WRITE);
				fileStream.writeUTFBytes(createXMLData());
				fileStream.close();
			}else {
				saveAs();
			}
		}
		
		
		private function inputTileArray(tileArray:Array):void {
			this.tileArray = new Array();
			
			for (var i in tileArray) {
				this.tileArray.push( { type:tileArray[i].type, graphic: tileArray[i].tile.graphic, x: tileArray[i].cords.x, y: tileArray[i].cords.y } );
			}
		}
		private function inputMarkerArray(markerArray:Array):void {
			this.markerArray = new Array();
			
			for (var i in markerArray) {
				this.markerArray.push( { type: markerArray[i].type, x: markerArray[i].cords.x, y: markerArray[i].cords.y } );
			}
		}
		
		private function createXMLData():String {
			var outputText:String= "<?xml version = '1.0' encoding = 'utf-8' ?>\n"
			xmlData=<data/>
			for each (var tileObject:Object in tileArray) {
				xmlData.appendChild( <tile type = {tileObject.type} graphic = { tileObject.graphic }	x = {tileObject.x } y = { tileObject.y } > </tile> );
			}
			for each (var markerObject:Object in markerArray) {
				xmlData.appendChild(<marker type={markerObject.type} x={markerObject.x} y={markerObject.y} > </marker>);
			}
			var mapRect:Rectangle = grid.mapRect;
			xmlData.appendChild(<mapRect x={mapRect.x} y={mapRect.y} width={mapRect.width} height={mapRect.height} > </mapRect>);
			outputText = outputText.concat(xmlData.toString());
			return outputText;
		}
		private function parseXMLData(xml:XML):void {
			this.tileArray = new Array();
			this.markerArray = new Array();
			
			for each (var tileNode:XML in xml.tile) {
				tileArray.push( { type: String(tileNode.@type), graphic: Number(tileNode.@graphic), x: Number(tileNode.@x), y: Number(tileNode.@y) } );
			}
			for each (var markerNode:XML in xml.marker) {
				markerArray.push( { type: Number(markerNode.@type), x: Number(markerNode.@x), y: Number(markerNode.@y) } );
			}
			grid.newGrid();
			grid.tiles = tileArray;
			grid.markers = markerArray;
			var mapRectNode:XML = xml.mapRect[0];
			grid.mapRect = new Rectangle(int(mapRectNode.@x), int(mapRectNode.@y), int(mapRectNode.@width), int(mapRectNode.@height));
		}
	}
}