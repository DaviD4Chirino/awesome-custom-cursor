extends Control

func _ready():
	for cursor_shape in Cursor.Shapes:
		var button = Button.new()
		button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		button.size_flags_vertical = Control.SIZE_EXPAND_FILL

		button.text = cursor_shape
		prints(Cursor.Shapes.keys().find(cursor_shape), cursor_shape)

		button.mouse_default_cursor_shape = Cursor.Shapes.keys().find(cursor_shape)
		$GridContainer.add_child(button)
	pass