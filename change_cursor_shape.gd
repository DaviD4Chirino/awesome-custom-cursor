extends Area2D
enum Shapes {
	CURSOR_ARROW,
	CURSOR_IBEAM,
	CURSOR_POINTING_HAND,
	CURSOR_CROSS,
	CURSOR_WAIT,
	CURSOR_BUSY,
	CURSOR_DRAG,
	CURSOR_DRAGGING,
	CURSOR_CAN_DROP,
	CURSOR_FORBIDDEN,
	CURSOR_VSIZE,
	CURSOR_HSIZE,
	CURSOR_BDIAGSIZE,
	CURSOR_FDIAGSIZE,
	CURSOR_MOVE,
	CURSOR_HSPLIT,
	CURSOR_VSPLIT,
	CURSOR_HELP,
	CURSOR_ZOOM_IN,
	CURSOR_ZOOM_OUT,
	CURSOR_ZOOM_RESET
}
@export var mouse_mode: Input.MouseMode
@export var cursor_shape: Input.CursorShape

func _on_body_entered(body: Node2D) -> void:
	# Cursor.mouse_mode = mouse_mode
	var shape = Cursor.Shapes[Shapes.keys()[cursor_shape]]
	Cursor.shape = shape
