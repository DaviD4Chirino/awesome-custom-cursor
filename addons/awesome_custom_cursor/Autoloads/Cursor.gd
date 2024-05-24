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
	# customs
	CURSOR_ZOOM_IN,
	CURSOR_ZOOM_OUT,
	CURSOR_ZOOM_RESET
}

## Instead of the Input function, use this as it only shows the sprite and never the cursor
@export var mouse_mode: Input.MouseMode: set = set_mouse_mode
@export var shape: Input.CursorShape = Input.CURSOR_ARROW: set = set_shape

@export var sprite: AnimatedSprite2D

@onready var previous_mouse_shape: Input.CursorShape = Input.get_current_cursor_shape()

var current_animation: StringName
var current_frame: int
var current_frame_texture: Texture2D

func _ready():
	if Engine.is_editor_hint(): return
	# Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	sprite.hide()

func _process(_delta: float):
	if Engine.is_editor_hint(): return
	var current_mouse_shape = Input.get_current_cursor_shape()

	if current_mouse_shape != previous_mouse_shape:
		set_shape(current_mouse_shape)
		previous_mouse_shape = current_mouse_shape

	# sprite.global_position = get_global_mouse_position()
	var sprite_frames: SpriteFrames = sprite.sprite_frames
	var current_frame: int = sprite.frame
	Input.set_custom_mouse_cursor(
		sprite_frames.get_frame_texture(sprite.animation, current_frame),
		Input.get_current_cursor_shape(),
		sprite.offset
	)

## Gets the CursorShape in a formatted string without the prefix CURSOR_. Mainly used for changing animations
func get_shape_name() -> StringName:
	return Shapes.keys()[shape].to_lower().trim_prefix("cursor_")

func set_shape(value: Input.CursorShape) -> void:
	if !sprite: return

	shape = value

	if shape <= - 1:
		shape = Input.CURSOR_ARROW

	var anim_name: StringName = get_shape_name()
	var sprite_frames: SpriteFrames = sprite.sprite_frames

	var has_animation: bool = sprite_frames.has_animation(anim_name)

	if has_animation:
		sprite.play(anim_name)
		sprite.offset = get_offset()
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

func get_offset() -> Vector2:
	match shape:
		Input.CURSOR_ARROW, Input.CURSOR_POINTING_HAND, Input.CURSOR_ARROW:
			return Vector2.ZERO

	return current_frame_texture.get_size() * 0.5

func _on_sprite_animation_changed() -> void:
	# print("animation")
	current_animation = sprite.animation
	#TODO: Change the logic from process to here
	pass # Replace with function body.

func _on_sprite_frame_changed() -> void:
	current_frame = sprite.frame

	current_frame_texture = sprite.sprite_frames.get_frame_texture(
		current_animation, current_frame
		)
	print("frame texutre ", current_frame_texture)
	#TODO: Change the logic from process to here
	pass # Replace with function body.
