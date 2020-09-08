package tStates.tCommands.tReceivers{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat
	
	/**
	 * ...
	 * @author Xiler
	 */
	public class DynamicText extends TextField {
		public function DynamicText(defaultText:String, originX :Number, originY:Number, customFormat:TextFormat) {
			text = defaultText;
			autoSize = TextFieldAutoSize.LEFT;
			x = originX;
			y = originY;
			defaultTextFormat = customFormat;
			border = true;
			borderColor = Number(customFormat.color);
			selectable = false;
		}
	}
	
}