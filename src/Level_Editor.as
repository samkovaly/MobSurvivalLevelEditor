package{
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.GridFitType;
	import flash.text.TextFormat;
	import tStates.*;
	import tStates.tCommands.*;
	import tStates.tCommands.tReceivers.*;
	
	
	import fl.controls.ScrollBarDirection;
	import fl.controls.ButtonLabelPlacement;
	
	import flash.ui.Mouse;
	
	public class  Level_Editor extends Sprite {
// CONSTANTS 
		private const passwordToEnter:String = "";
		private const fileOperatingButtonFormat:TextFormat = new TextFormat("Arial", 12, 0x0066CC, true);
		private const fileOperatingButtonWidth:int = 62;
		private const fileOperatingButtonSpacing:int = 64;
		
		private const tileListCordinatorBoxSize:uint = 45;
		private const tileListCordinatorScrollBarSize:uint = 15;
		private const tileListCordinatorWidth:uint = tileListCordinatorBoxSize + tileListCordinatorScrollBarSize;
		private const tileListCordinatorInnerPadding:uint = 3;
// Classes
		private var passwordProtector:PasswordProtector;
		private var grid:Grid;
		private var tileListCordinator:TileListCordinator;
		private var fileOperator:FileOperator;
		private var controlUI:ControlUI;
		private var stateWorker:StateWorker;
// DIRECTLY USED COMMANDS
		private var toggleCursorShow:ICommand;
		
		public function Level_Editor() {
			passwordProtector = new PasswordProtector(this, passwordToEnter, 0, 0);
			passwordProtector.setLocation((this.stage.stageWidth / 2) - (passwordProtector.width / 2), 380);
			addChild(passwordProtector);
			
			passwordProtector.addEventListener(Event.COMPLETE, initializeProgram);
		}
		private function initializeProgram(event:Event) {
			removeChild(passwordProtector);
			passwordProtector = null;
//================================================================================================
			grid = new Grid(this);
			tileListCordinator = new TileListCordinator(this);
			fileOperator = new FileOperator(grid);
			controlUI = new ControlUI(this);
			
			stateWorker = new StateWorker();
			
			setChildIndex(tileListCordinator, numChildren - 1);
// UI ===================================================================

// TILE LIST
			var commandsArray:Array = new Commands(1).allTypes;
			var markerTileArray:Array = new MarkerTile(1).allTypes;
			var tileArray:Array = new Tile(1).allTypes;
			var jumpTileArray:Array = new JumpTile(1).allTypes;
			
			var commandCommandsArray:Array = new Array( new DragGridCommandClicked(stateWorker, tileListCordinator), 
				new DeleteCommandClicked(stateWorker, tileListCordinator), new MidpointCommandClicked(stateWorker,tileListCordinator) );
			var markerTileCommandsArray:Array = new Array( new PlayerCommandClicked(stateWorker, tileListCordinator));
			var tileCommandsArray:Array = new Array( new TileCommandClicked(stateWorker, tileListCordinator));
			var jumpTileCommandsArray:Array = new Array( new JumpTileCommandClicked(stateWorker, tileListCordinator));
			
			
			
			var commandsMarkerSourceArray:Array = new Array();
			for (var o in commandsArray) {
				commandsMarkerSourceArray.push({ type:"command", source:new Commands(commandsArray[o]) , command: commandCommandsArray[o]});
			}
			for (var u in markerTileArray) {
				commandsMarkerSourceArray.push( { type:"markerTile", source:new MarkerTile(markerTileArray[u]), command: markerTileCommandsArray[u] } );
			}
			controlUI.setTileList((stage.stageWidth - (tileListCordinatorWidth * 2)) + tileListCordinatorScrollBarSize, 0, tileListCordinatorBoxSize,
				commandsMarkerSourceArray.length*tileListCordinatorBoxSize, commandsMarkerSourceArray, tileListCordinatorInnerPadding,
				ScrollBarDirection.VERTICAL, tileListCordinatorBoxSize, tileListCordinatorBoxSize);
			
			
			var tileSourceArray:Array = new Array();
			for(var p in tileArray){
				tileSourceArray.push( { type:"tile", source:new Tile(tileArray[p]) , command: tileCommandsArray[0]});
			}
			for(var l in jumpTileArray){
				tileSourceArray.push( { type:"jumpTile", source:new JumpTile(jumpTileArray[l]) , command: jumpTileCommandsArray[0]});
			}
			controlUI.setTileList(stage.stageWidth - tileListCordinatorWidth, 0, tileListCordinatorWidth, stage.stageHeight,
				tileSourceArray, tileListCordinatorInnerPadding, ScrollBarDirection.VERTICAL,
				tileListCordinatorBoxSize, tileListCordinatorBoxSize);
			
			
//ZOOM
			var zoomRatios:Array = grid.zoomRatios;
			var sourcedRatioArray:Array = new Array();
			for (var i in zoomRatios) {
				sourcedRatioArray.push( { label:String(zoomRatios[i]).concat("%"), ratio:(zoomRatios[i] / 100) } );
			}
			controlUI.setComboBox(0, stage.stageHeight - 22.5, 60, 22.5, sourcedRatioArray, sourcedRatioArray.length - Math.ceil(sourcedRatioArray.length / 2), 200, new ZoomRatiosCommandClicked(grid));
//BUTTONS
			controlUI.setButton("New", fileOperatingButtonSpacing*0, 25, fileOperatingButtonWidth, 20, fileOperatingButtonFormat, new New(fileOperator));
			controlUI.setButton("Open", fileOperatingButtonSpacing * 1, 25, fileOperatingButtonWidth, 20, fileOperatingButtonFormat, new Load(fileOperator));
			controlUI.setButton("Save As", fileOperatingButtonSpacing*2, 25, fileOperatingButtonWidth, 20, fileOperatingButtonFormat, new SaveAs(fileOperator));
			controlUI.setButton("Save", fileOperatingButtonSpacing * 3, 25, fileOperatingButtonWidth, 20, fileOperatingButtonFormat, new Save(fileOperator));
			
			controlUI.setButton("Undo", fileOperatingButtonSpacing * 0, 50, fileOperatingButtonWidth, 20, fileOperatingButtonFormat, new UndoLastCommand());
			controlUI.setButton("Redo", fileOperatingButtonSpacing * 1, 50, fileOperatingButtonWidth, 20, fileOperatingButtonFormat, new RedoLastCommand());
			
			
//(ALL ABOVE WILL BE HIDDEN WHEN UN-CHECKED) CHECK BOX
			controlUI.setCheckBox(0, stage.stageHeight - 45, "Display UI", ButtonLabelPlacement.RIGHT, true, new DisplayUICommandClicked(controlUI.getAllUI(), tileListCordinator));
			
			
//SHOW GRID
			controlUI.setCheckBox(0, stage.stageHeight - 70, "Display Grid", ButtonLabelPlacement.RIGHT, true, new DisplayGridCommandClicked(grid));
			
//Toggle cursor
			toggleCursorShow = new ToggleCursorShow(tileListCordinator);
			grid.addEventListener(MouseEvent.ROLL_OVER, gridRollToggler);
			grid.addEventListener(MouseEvent.ROLL_OUT, gridRollToggler);
			
			
// STATES
			grid.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownListener);
			
			var starterCommand:ICommand = new DragGridCommandClicked(stateWorker, tileListCordinator);
			starterCommand.execute();
		}
		
		private function mouseDownListener(event:MouseEvent):void {
			stateWorker.mouseDownGrid(event);
			grid.addEventListener(MouseEvent.MOUSE_MOVE, stateWorker.mouseMoveGrid);
			addEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
		}
		private function mouseUpListener(event:MouseEvent):void {
			stateWorker.mouseUpGrid(event);
			grid.removeEventListener(MouseEvent.MOUSE_MOVE, stateWorker.mouseMoveGrid);
			removeEventListener(MouseEvent.MOUSE_UP, mouseUpListener);
		}
		
		
		private function gridRollToggler(event:MouseEvent):void {
			//Should not be doing this :(
			if (event.type == MouseEvent.ROLL_OVER) {
				toggleCursorShow.execute(true);
			}else {
				toggleCursorShow.execute(false);
			}
		}
		
		
	}
}