@tool
extends GridContainer
@export var items: int = 66

func _ready():
	generate()
	await RenderingServer.frame_post_draw
	if Engine.is_editor_hint(): return
	take_screenshot(Vector2i(1920,1080))

func generate() -> void:
	var cursors: Array[String] = dir_contents("res://addons/awesome_custom_cursor/assets/cursors")
	print(cursors)
	for child in get_children():
		child.queue_free()
	for item in items:
		var texture_rect = TextureRect.new()
		texture_rect.custom_minimum_size = Vector2(56, 56)
		texture_rect.texture = load(cursors.pick_random())
		add_child(texture_rect)

	pass

func dir_contents(path) -> Array[String]:
	var arr: Array[String] = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if file_name.ends_with(".png"):
				arr.append(path + "/" + file_name)
				# print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	
	return arr
func take_screenshot(target_size: Vector2i) -> void:
	var window: Window = get_window()
	var original_size: Vector2i = window.size
	window.size = target_size
	await RenderingServer.frame_post_draw
	var img: Image = get_viewport().get_texture().get_image()
	img.save_png("res://screenshot2.png")
	window.size = original_size
