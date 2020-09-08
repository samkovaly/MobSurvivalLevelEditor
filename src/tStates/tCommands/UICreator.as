package tStates.tCommands{
	/**
	 * ...
	 * @author Xiler
	 */
	
	import fl.core.UIComponent;
	import fl.controls.*;
	import flash.text.TextFormat;
	
	public class  UICreator{
		public static const SKIN_DEFAULT:uint = 1;
		
		//===========================================================================================================================================
		/**
		 * Adds a button to this UI instance with specified parameters.
		 * @param 		skin :  its visual set of graphics null for defalt
		 * @param 		originX :  starting point X
		 * @param 		originY :  starting point Y
		 * @param 		width :  width
		 * @param 		height :  height
		 * 
		 * @param 		label :  text shown on Button
		 * @param 		textFormat :  The textFormat object used on the text of this button
		 * @param 		enabled :  whether it is avable for interactin with the user
		 * @param 		alpha :  alpha of button
		 * @param 		labelPlacement :  where the label is placed Ex/ ButtonLabelPlacement.LEFT
		 * @param 		tabEnabled :  specifies whether this is avable for tab
		 * @param 		butttonMode :  sets whether cursor shows a hand while hovering over it
		 * @param 		doubleClickEnabled :  specifies whether the object receives doubleClick events
		 * @param 		emphasized :  whether or not a border is drawn around object, when it is in its up state
		 * @param 		toggle :  sets if button is toggleable
		 * @param 		mouseEnabled :  specifies whether this receives mouse events
		 * @param  	mouseChildren :  specifies whether this object's children receives mouse events
		 * @param 		rotation :  specifies the starting rotation on the button
		 * @param 		scaleX :  specifies the starting scaleX of this button
		 * @param 		slaceY :  specifies the starting scaleY of this button
		*/
		public static function makeButton(originX:Number, originY:Number, width:Number, height:Number,skin:uint=SKIN_DEFAULT, ...otherProperties):Button {
			var newButton:Button = new Button();
			newButton.x = originX;
			newButton.y = originY;
			newButton.width = width;
			newButton.height = height;
			
			
			newButton.label = otherProperties[0]
			
			newButton.setStyle("textFormat", otherProperties[1]);
			return newButton;
		}
		//===========================================================================================================================================
		/**
		 * Adds a TileList to this UI instance with specified parameters.
		 * @param 		skin :  its visual set of graphics null for defalt
		 * @param 		originX :  starting point X
		 * @param 		originY :  starting point Y
		 * @param 		width :  width
		 * @param 		height :  height
		 * 
		 * @param			listArray :  The array that holds objects to be added to the TileList (object properties must have atleast "source" and maybe "label")
		 * @param			imagePadding :  spacing between images in tileList and the border
		 * @param			direction :  the direction of the scrollBar Ex/ ScrollBarDirection.VERTICAL;
		 * @param			columnWidth :  Sets the width that is applied to a column in the list, in pixels.
		 * @param			rowHeight :  Sets the height that is applied to each row in the list, in pixels.
		 * @param			allowMultipleSelection :  Indicates whether more than one list item can be selected at a time
		 * @param			alpha :  alpha of TileList
		 * @param 		butttonMode :  sets whether cursor shows a hand while hovering over it
		 * @param 		doubleClickEnabled :  specifies whether the object receives doubleClick events
		 * @param 		enabled :  whether it is avable for interactin with the user
		 * @param 		mouseEnabled :  specifies whether this receives mouse events
		 * @param  		mouseChildren :  specifies whether this object's children receives mouse events
		 * @param			selectable :  Sets a Boolean value that indicates whether the items in the list can be selected
		 * @param			selectedIndex :  Sets the index of the item that is selected in a single-selection list
		 * @param 		tabEnabled :  specifies whether this is avable for tab
		*/
		public static function makeTileList(originX:Number, originY:Number, width:Number, height:Number,skin:uint=SKIN_DEFAULT, ... otherProperties):TileList {
			var newTileList:TileList = new TileList();
			newTileList.x = originX;
			newTileList.y = originY;
			newTileList.width = width;
			newTileList.height = height;
			
			for (var i in otherProperties[0]) {
				newTileList.addItem( otherProperties[0][i] );
			}
			newTileList.setRendererStyle("imagePadding", otherProperties[1]);
			newTileList.direction = otherProperties[2]
			newTileList.columnWidth = otherProperties[3];
			newTileList.rowHeight = otherProperties[4];
			
			
			return newTileList;
		}
		//===========================================================================================================================================
		/**
		 * Adds a ComboBox to this UI instance with specified parameters.
		 * @param 		skin :  its visual set of graphics null for defalt
		 * @param 		originX :  starting point X
		 * @param 		originY :  starting point Y
		 * @param 		width :  width
		 * @param 		height :  height
		 * 
		 * @param		listArray :  The array that holds objects to be added to the ComboBoc (object must have atleast "label" property)
		 * @param		selectedIndex :  Sets the index of the item that is selected in a single-selection list
		 * @param		scrollMovement :  Sets the pixil movement of the scroller in the combobox when the arrow is clicked
		 * @param		alpha :  alpha of TileList
		 * @param 		doubleClickEnabled :  specifies whether the object receives doubleClick events
		 * @param		editable :  Sets a Boolean value that indicates whether the ComboBox component is editable or read-only.
		 * @param 		enabled :  whether it is avable for interactin with the user
		 * @param 		mouseEnabled :  specifies whether this receives mouse events
		 * @param  	mouseChildren :  specifies whether this object's children receives mouse events
		 * @param		prompt :  Sets the prompt (the starting displayerd text Ex/ Select one...)
		 * @param 		tabEnabled :  specifies whether this is avable for tab
		 * @param 		butttonMode :  sets whether cursor shows a hand while hovering over it
		*/
		public static function makeComboBox(originX:Number, originY:Number, width:Number, height:Number,skin:uint=SKIN_DEFAULT, ... otherProperties):ComboBox {
			var newComboBox:ComboBox = new ComboBox();
			newComboBox.x = originX;
			newComboBox.y = originY;
			newComboBox.width = width;
			newComboBox.height = height;
			
			for (var i in otherProperties[0]) {
				newComboBox.addItem( otherProperties[0][i] );
			}
			newComboBox.selectedIndex = otherProperties[1];
			newComboBox.dropdown.verticalLineScrollSize = otherProperties[2];
			return newComboBox;
		}
		//===========================================================================================================================================
		/**
		 * Adds a CheckBox to this UI instance with specified parameters.
		 * @param 		skin :  its visual set of graphics null for defalt
		 * @param 		originX :  starting point X
		 * @param 		originY :  starting point Y
		 * @param 		width :  width (null for default)
		 * @param 		height :  height (null for default)
		 * 
		 * @param		label :  the text shown as the label
		 * @param		labelPlacement :  Position of the label in relation to a specified icon Ex/ ButtonLabelPlacement.RIGHT;
		 * @param		selected :  Sets if checkbox is pre-checked
		 * @param		alpha :  alpha of TileList
		 * @param 		doubleClickEnabled :  specifies whether the object receives doubleClick events
		 * @param 		enabled :  whether it is avable for interactin with the user
		 * @param 		mouseEnabled :  specifies whether this receives mouse events
		 * @param  	mouseChildren :  specifies whether this object's children receives mouse events
		 * @param 		tabEnabled :  specifies whether this is avable for tab
		 * @param 		butttonMode :  sets whether cursor shows a hand while hovering over it
		*/
		public static function makeCheckBox(originX:Number, originY:Number, width:Object, height:Object,skin:uint=SKIN_DEFAULT, ... otherProperties):CheckBox {
			var newCheckBox:CheckBox = new CheckBox();
			newCheckBox.x = originX;
			newCheckBox.y = originY;
			// BECAUSE I DON'T KNOW THE DEFAULT CHECK BOX SIZE D:
			if (width != null) newCheckBox.width = Number(width);
			if (height != null) newCheckBox.height = Number(height);
			
			newCheckBox.label = otherProperties[0];
			newCheckBox.labelPlacement = otherProperties[1];
			newCheckBox.selected = otherProperties[2];
			
			return newCheckBox;
		}
		//===========================================================================================================================================
	}
}