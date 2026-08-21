extends Node2D
func _input(event):
	if event.is_action_released('ui_accept'):
		take_screenshot(Vector2i(1920,1080))
		
func take_screenshot(target_size: Vector2i) -> void:
	var window: Window = get_window()
	var original_size: Vector2i = window.size
	window.size = target_size
	await RenderingServer.frame_post_draw
	var img: Image = get_viewport().get_texture().get_image()
	img.save_png("res://screenshot2.png")
	window.size = original_size
