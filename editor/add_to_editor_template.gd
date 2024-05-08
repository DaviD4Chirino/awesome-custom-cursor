@tool
extends EditorPlugin
#remember to change this
const UPDATE_BUTTON_SCENE = preload ("res://editor/update_button.tscn")
var update_button

func _enter_tree():
	update_button = UPDATE_BUTTON_SCENE.instantiate()
	update_button.editor_plugin = self
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, update_button)

func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, update_button)
	update_button.queue_free()