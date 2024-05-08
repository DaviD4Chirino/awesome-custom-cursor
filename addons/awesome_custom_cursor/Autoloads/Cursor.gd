extends Node2D
# You can set a custom cursor in engine, and add the different shapes programmatically.
# This is a animated sprite that follows the mouse, 
# the benefit is that this can be animated

## Done like this so we can iterate over them
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

## Instead of the Input function, use this as it only shows the sprite and never the cursor
@export var mouse_mode: Input.MouseMode: set = set_mouse_mode
@export var shape: Shapes = Shapes.CURSOR_ARROW: set = set_shape

@export var sprite: AnimatedSprite2D

var previous_mouse_shape: Input.CursorShape

func _ready():
	if Engine.is_editor_hint(): return
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _process(_delta: float):
	if Engine.is_editor_hint(): return
	sprite.global_position = get_global_mouse_position()

	# This was so the control nodes have an easier time changing the shape of the cursor
	# var current_mouse_shape: Input.CursorShape = Input.get_current_cursor_shape()
	# if shape != current_mouse_shape:
	# 	shape = current_mouse_shape as Shapes

## Gets the CursorShape in a formatted string without the prefix CURSOR_. Mainly used for changing animations
func get_shape_name() -> StringName:
	return Shapes.keys()[shape].to_lower().trim_prefix("cursor_")

func set_shape(value: Shapes) -> void:
	if !sprite: return

	shape = value

	if shape <= - 1:
		shape = Shapes.CURSOR_ARROW

	var anim_name: StringName = get_shape_name()
	var sprite_frames: SpriteFrames = sprite.sprite_frames

	var has_animation: bool = sprite_frames.has_animation(anim_name)

	if has_animation:
		sprite.play(anim_name)
		sprite.centered = should_center()
		return
	else:
		push_warning("Animation %s does not exist" % anim_name)

func set_mouse_mode(value: Input.MouseMode) -> void:
	mouse_mode = value

	# basically, when the cursor is hidden it hides the sprite, and it behaves like it was programmed to do.
	# however, to prevent the original cursor to overlap the sprite; we never make the original show by filtering the ones that do
	if (
		mouse_mode == Input.MOUSE_MODE_CAPTURED||
		mouse_mode == Input.MOUSE_MODE_CONFINED_HIDDEN||
		mouse_mode == Input.MOUSE_MODE_HIDDEN
	):
		Input.mouse_mode = mouse_mode

	if mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

	sprite.visible = (
		mouse_mode == Input.MOUSE_MODE_VISIBLE||
		mouse_mode == Input.MOUSE_MODE_CONFINED
	)

func should_center() -> bool:
	match shape:
		Shapes.CURSOR_ARROW, Shapes.CURSOR_POINTING_HAND, Shapes.CURSOR_ARROW:
			return false

	return true