@tool
extends EditorPlugin
const AUTOLOAD: Dictionary = {
	"NAME": "SceneManager",
	"PATH": "res://addons/awesome_scene_manager/autoloads/SceneManager.tscn"
}
const UPDATE_BUTTON_SCENE = preload ("res://addons/awesome_scene_manager/editor/update_button.tscn")
var update_button

func _enter_tree():
	add_autoload_singleton(AUTOLOAD.NAME, AUTOLOAD.PATH)

	update_button = UPDATE_BUTTON_SCENE.instantiate()
	update_button.editor_plugin = self
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, update_button)
	pass

func _exit_tree():
	remove_autoload_singleton(AUTOLOAD.NAME)
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, update_button)
	update_button.queue_free()
