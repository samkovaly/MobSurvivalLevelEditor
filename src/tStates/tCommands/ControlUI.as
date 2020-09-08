package tStates.tCommands{
	import fl.controls.Button;
	import fl.controls.CheckBox;
	import fl.controls.ComboBox;
	import fl.controls.TileList;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	
	import tStates.tCommands.tReceivers.DynamicBlock;
	
	public class ControlUI extends Sprite{
		private var commandList:Array;
		private var UIList:Array;
		private var displayParent:Sprite;
		
		public function ControlUI(parent:Sprite) {
			this.displayParent = parent;
			displayParent.addChild(this);
			this.commandList = new Array();
			this.UIList = new Array();
		}
		
		
		public function setButton(text:String, originX:Number, originY:Number, width:Number, height:Number, customFormat:TextFormat, command:ICommand):void {
			this.commandList.push(command);
			var newButton:Button = UICreator.makeButton(originX, originY, width, height, UICreator.SKIN_DEFAULT, text, customFormat);
			this.UIList.push(newButton);
			
			newButton.addEventListener(MouseEvent.CLICK,this.buttonClicked);
			this.addChild(newButton);
		}
		private function buttonClicked(event:MouseEvent) {
			processSingleInteraction(event);
		}
		
		public function setCheckBox(originX:Number, originY:Number, label:String, labelPlacement:String, selected:Boolean, command:ICommand){
			this.commandList.push(command);
			var newCheckBox:CheckBox = UICreator.makeCheckBox(originX, originY, null, null, UICreator.SKIN_DEFAULT, label, labelPlacement, selected);
			if (command is DisplayUICommandClicked) {
				this.commandList[commandList.length - 1].setRefraneUI(newCheckBox);
			}
			this.UIList.push(newCheckBox);
			
			newCheckBox.addEventListener(Event.CHANGE, checkBoxChanged);
			this.addChild(newCheckBox);
		}
		private function checkBoxChanged(event:Event) {
			processSingleInteraction(event);
		}
		
		
		private function processSingleInteraction(event:Event) {
			for (var i:int = 0; i < UIList.length; i++) {
				if (UIList[i] == event.target){
					this.commandList[i].execute();
					break;
				}
			}
		}
		
		
		
		
		
		
		public function setTileList(originX:Number, originY:Number, width:Number, height:Number, objectArray:Array,
		imagePadding:int, direction:String, columnWidth:Number, rowHeight:Number):void {
			var newTileList:TileList = UICreator.makeTileList(originX, originY, width, height,UICreator.SKIN_DEFAULT, objectArray, imagePadding, direction, columnWidth, rowHeight);
			this.UIList.push(newTileList);
			this.commandList.push(null)
			
			newTileList.addEventListener(MouseEvent.CLICK, tileListClicked);
			this.addChild(newTileList);
		}
		private function tileListClicked(event:MouseEvent) {
			if (event.currentTarget.selectedItem.type == "tile" || event.currentTarget.selectedItem.type == "jumpTile") event.currentTarget.selectedItem.command.changeTile(event.currentTarget.selectedItem.source.graphic);
			event.currentTarget.selectedItem.command.execute();
		}
		
		
		public function setComboBox(originX:Number, originY:Number, width:Number, height:Number, objectArray:Array,
		selectedIndex:int, verticalLineScroll:Number,command:ICommand) {
			this.commandList.push(command);
			var newComboBox:ComboBox = UICreator.makeComboBox(originX, originY, width, height,UICreator.SKIN_DEFAULT, objectArray, selectedIndex, verticalLineScroll);
			this.UIList.push(newComboBox);
			
			newComboBox.addEventListener(Event.CHANGE, comboBoxChanged);
			this.addChild(newComboBox);
		}
		private function comboBoxChanged(event:Event) {
			for (var i:int = 0; i < UIList.length; i++){
				if (UIList[i] === event.target) {
					this.commandList[i].changeRatio(UIList[i].selectedItem.ratio);
					this.commandList[i].execute();
					break;
				}
			}
		}
		
		public function getAllUI():Array {
			return UIList;
		}
	}
}