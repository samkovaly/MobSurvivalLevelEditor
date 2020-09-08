package tStates.tCommands.tReceivers{
	/**
	 * ...
	 * @author Xiler
	 */
	import flash.display.Sprite;
	
	import fl.core.UIComponent;
	import fl.controls.Button;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	
	import flash.events.Event;
	
	public class PasswordProtector extends Sprite {
		private var target:Sprite;
		private var passwordForInput:String;
		
		private var staticText:TextField;
		private var input:TextField;
		private var enterButton:Button;
		private const staticTextFormat:TextFormat = new TextFormat(null, 16, 0x0000FF, true);
		
		public function PasswordProtector(target:Sprite,password:String,locX:Number,locY:Number):void {
			this.target = target;
			this.password = password;
			setLocation(locX, locY);
			buildinput();
		}
		
		public function setLocation(locX:Number, locY:Number):void {
			this.x = locX;
			this.y = locY;
		}
		
		public function set password(password:String):void {
			this.passwordForInput = password;
		}
		
		private function buildinput() {
			staticText = new TextField();
			staticText.defaultTextFormat = staticTextFormat;
			staticText.selectable = false;
			staticText.autoSize = TextFieldAutoSize.LEFT;
			staticText.text = "Password:";
			
			input = new TextField();
			input.displayAsPassword = true;
			input.type = TextFieldType.INPUT;
			input.border = true;
			input.maxChars = 10;
			input.x = staticText.x + staticText.width + 10;
			input.width = 140;
			input.height = 20;
			target.stage.focus = input;
			
			
			enterButton = new Button();
			enterButton.label = "Enter";
			enterButton.width = 50;
			enterButton.height = 20;
			enterButton.x = input.x + input.width + 10;
			
			addChild(staticText);
			addChild(input);
			addChild(enterButton);
			
			enterButton.addEventListener(MouseEvent.CLICK, validatePassword);
			target.stage.addEventListener(KeyboardEvent.KEY_DOWN, validateKeyboardEnter);
		}
		
		private function validateKeyboardEnter(e:KeyboardEvent):void{
			if(e.keyCode==Keyboard.ENTER) validatePassword();
		}
		
		private function validatePassword(e:MouseEvent=null):void {
			if (input.text == this.passwordForInput) {
				cleanUp();
			}
		}
		
		private function cleanUp():void {
			input.removeEventListener(MouseEvent.CLICK, validatePassword);
			target.stage.removeEventListener(KeyboardEvent.KEY_DOWN, validateKeyboardEnter);
			this.dispatchEvent( new Event(Event.COMPLETE));
		}
	}	
}



