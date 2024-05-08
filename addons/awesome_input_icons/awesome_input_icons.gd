@tool
extends EditorPlugin
const UPDATE_BUTTON_SCENE = preload ("res://addons/awesome_input_icons/editor/update_button.tscn")
var update_button

func _enter_tree():
	
	update_button = UPDATE_BUTTON_SCENE.instantiate()
	update_button.editor_plugin = self
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, update_button)

func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, update_button)
	update_button.queue_free()
	pass
