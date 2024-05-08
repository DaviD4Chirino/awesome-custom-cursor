@tool
extends GridContainer
@export var items: int = 66

func _ready():
	generate()
	await RenderingServer.frame_post_draw
	var image = get_viewport().get_texture().get_image()
	image.save_png("user://screen_shot.png")

func generate() -> void:
	var cursors: Array[String] = dir_contents("res://addons/awesome_custom_cursor/assets/cursors")
	print(cursors)
	for child in get_children():
		child.queue_free()
	for item in items:
		var texture_rect = TextureRect.new()
		texture_rect.custom_minimum_size = Vector2(500, 500)
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
